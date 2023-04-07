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
create("BufWritePre", {
  group = my_group,
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
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
  callback = vim.lsp.buf.formatting_sync
})

-- ^N causes included files to be read which slows down
-- autocomplete a hell of a lot
create({ "BufNewFile", "BufRead" }, {
  group = my_group,
  pattern = "*spec.rb",
  command = "setlocal complete-=i"
})

-- When editing a file, always jump to the last known cursor position.
-- Don't do it when the position is invalid, when inside an event handler
-- (happens when dropping a file on gvim) and for a commit message (it's
-- likely a different one than last time).
create("BufReadPost", {
  group = my_group,
  pattern = "*",
  command = [[
     if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        exe "normal! g`\""
     endif
  ]]
})
