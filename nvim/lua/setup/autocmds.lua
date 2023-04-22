require "custom.functions"

local my_group = "MyGroup"
local create = vim.api.nvim_create_autocmd

vim.api.nvim_create_augroup(my_group, {})

create("FileType", {
  group = my_group,
  pattern = "text",
  command = "setlocal textwidth=78"
})

create("FileType", {
  group = my_group,
  pattern = "gitcommit",
  command = "setlocal spell"
})

create("FileType", {
  group = my_group,
  pattern = "make",
  command = "setlocal noexpandtab shiftwidth=8 softtabstop=0"
})

create("FileType", {
  group = my_group,
  pattern = "css",
  command = "setlocal expandtab shiftwidth=2 softtabstop=2"
})

create("BufWritePre", {
  group = my_group,
  pattern = { "*.rb", "*.tf", "*.proto", "*.go", "*.c", "*.md", "*.pkr.hcl" },
  callback = M.TrimWhiteSpace
})

-- Format on save if there is an LSP Server set up
create("BufWritePre", {
  group = my_group,
  pattern = "*",
  callback = function(ev)
    -- TODO: clean this up
    local ft = vim.filetype.match({ buf = ev.buf })
    if ft == "go" or ft == "lua" then
      return
    end
    -- sync is fine
    vim.lsp.buf.format({ async = false })
  end
})

-- ^N causes included files to be read which slows down
-- autocomplete a hell of a lot
create({ "BufNewFile", "BufRead" }, {
  group = my_group,
  pattern = "*spec.rb",
  command = "setlocal complete-=i"
})
