local bo = vim.bo
bo.expandtab = false
bo.softtabstop = 0
bo.shiftwidth = 0
-- Still use tabs but make them four chars wide
bo.tabstop = 4

-- current buffer number, it's always zero
-- but magic numbers aren't fun
local current_buf = 0
-- From the LSP Spec, the different kinds of symbols
-- that can be returned. The spec returns a number
-- which corresponds to the place of the symbol in
-- the table
local symbolKind = {
  "File",
  "Module",
  "Namespace",
  "Package",
  "Class",
  "Method",
  "Property",
  "Field",
  "Constructor",
  "Enum",
  "Interface",
  "Function",
  "Variable",
  "Constant",
  "String",
  "Number",
  "Boolean",
  "Array",
  "Object",
  "Key",
  "Null",
  "EnumMember",
  "Struct",
  "Event",
  "Operator",
  "TypeParameter",
}

local add_symbols_to_items -- so we can use it recursively

-- add_symbols_to_items takes a result from a `documentSymbol` LSP response
-- and adds the symbols to the `items` table in a way that can be displayed
-- in a quickfix window. If there are child symbols then it calls itself
-- recursively to add them too.
add_symbols_to_items = function(file_name, items, symbol)
  local kindname = symbolKind[symbol.kind]
  local text = '[' .. kindname ..'] '

  -- if there is a parent then show the parent name e.g. 
  -- [Field] Handler.child_name
  if symbol.parent then
    text = string.format('%s%s.%s', text, symbol.parent, symbol.name)
  else
    text = text .. symbol.name
  end

  table.insert(items, {
    filename = file_name,
    lnum = symbol.selectionRange.start.line + 1,
    col = symbol.selectionRange.start.character + 1,
    kind = kindname,
    text = text,
  })

  if symbol.children then
    for _, child in pairs(symbol.children) do
      child.parent = symbol.name -- useful for constructing struct field names
      add_symbols_to_items(file_name, items, child)
    end
  end
end

-- handle_buf_request_sync_response does that it says on the tin.
-- There is a standard two loops you always have to do with these
-- responses, so just pass along a callback to be called with each
-- entry in the response result
local function handle_buf_request_sync_response(resp, action)
  -- response is a table of tables, each internal table
  -- is a response from each language server that
  -- vim.lsp.buf_request_sync contacted
  for _, res in pairs(resp or {}) do
    -- each language server response contains a result
    -- for the given request
    for _, r in pairs(res.result or {}) do
      -- call the action function with the result
      action(r)
    end
  end
end

-- Synchronously organise imports
local function organise_imports()
  local params = vim.lsp.util.make_range_params(nil, vim.lsp.util._get_offset_encoding())
  params.context = { only = { "source.organizeImports" } }

  local response = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
  handle_buf_request_sync_response(response, function(result)
    if result.edit then
      vim.lsp.util.apply_workspace_edit(result.edit, vim.lsp.util._get_offset_encoding())
    else
      vim.lsp.buf.execute_command(result.command)
    end
  end)
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  desc = "Go specific BufWritePre for formatting and goimports",
  callback = function()
    organise_imports()
    vim.lsp.buf.format({ async = false })
  end
})

-- GoExtractFunc is a range user command that calls the refactor
-- code action, basically to extract code to a method or function
vim.api.nvim_buf_create_user_command(current_buf, "GoExtractFunc",
  function()
    vim.lsp.buf.code_action({
      context = {
        only = { 'refactor.extract' }
      },
      range = {
        -- send the most recent visual selection
        start = vim.api.nvim_buf_get_mark(0, "<"),
        ['end'] = vim.api.nvim_buf_get_mark(0, ">")
      }
    })
  end,
  {
    range = true
  }
)

-- if , is the next char then just jump over it instead of
-- adding another comma
vim.keymap.set('i', ',', function()
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0) -- {row, col}
  local text = vim.api.nvim_buf_get_text(
    buf,
    cursor[1] - 1, -- the API is zero-based index, so minus 1 to get current line
    cursor[2],
    cursor[1] - 1,
    cursor[2] + 1,
    {}
  )
  if text[1] == "," then return "<right>" end

  return ","
end, { buffer = true, expr = true, remap = true })

-- LSP documentSymbol but do it for the entire package the file is part of.
-- If done in a test file then all the test file symbols are included too
vim.keymap.set('n', 'gdps', function()
  local filepath = vim.api.nvim_buf_get_name(current_buf)
  local dir, go_package, current_file = string.match(filepath, '(%g+)/([%a%d_]+)/([%a%d_]+%.go)$')
  local dir_path = dir .. '/' .. go_package
  local search_tests = string.match(current_file, 'test%.go')
  local title = 'Symbols in ' .. go_package .. ' package'
  if search_tests then title = '[Inc. Tests] ' .. title end
  local items = {}

  -- search the directory of the current file for other go files
  for file in io.popen('dir --width=1 ' .. dir_path):lines() do
    -- only include test symbols when called in a test file
    if not search_tests and string.match(file, "test") then
      goto continue
    end

    local filename = dir_path .. '/' .. file
    -- make the API call
    local response = vim.lsp.buf_request_sync(
      current_buf,
      'textDocument/documentSymbol',
      { textDocument = { uri = vim.uri_from_fname(filename) } }
    )

    -- build a table of items to display in the quickfix window
    handle_buf_request_sync_response(response, function(result)
      add_symbols_to_items(filename, items, result)
    end)

    ::continue:: -- goto label
  end

  -- tell vim what we want to display in the quickfix window
  -- and open that bad boy
  vim.fn.setqflist({}, ' ', { title = title, items = items })
  vim.api.nvim_command('botright copen')
end, { buffer = true })
