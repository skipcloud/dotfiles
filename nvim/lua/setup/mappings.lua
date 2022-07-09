require "custom.functions"

local set = vim.keymap.set
local silent = {silent=true}
local map = ""

vim.g.mapleader = ","

-- General mappings
set("n", "\\", ",")
set("i", "jj", "<esc>")

-- Custom Functions
set("n", "<Leader>w", M.TrimWhiteSpace)

-- FZF
set(map, "<C-p>", ":FZF<cr>")

-- NERDTree shortcuts
set("n", "<Leader>f", ":NERDTreeFind<cr>")
set(map, "<Leader>q", ":NERDTreeToggle<cr>")

-- Git shortcuts
set("n", "<Leader>gb", ":Git blame<cr>")
set({ "n", "v" }, "<Leader>gbr", ":GBrowse<cr>")

-- vim-test plugin shortcuts
set("n", "<Leader>tn", ":TestNearest<cr>")
set("n", "<Leader>tl", ":TestLast<cr>")
set("n", "<Leader>tf", ":TestFile<cr>")

-- CoC Diagnostics
set("n", "[g", "<Plug>(coc-diagnostic-prev)", silent)
set("n", "]g", "<Plug>(coc-diagnostic-next)", silent)

-- CoC code navigation
set("n", "gd", "<Plug>(coc-definition)", silent)
set("n", "gy", "<Plug>(coc-type-definition)", silent)
set("n", "gi", "<Plug>(coc-implementation)", silent)
set("n", "gr", "<Plug>(coc-references)", silent)

-- CoC General
set("i", "<C-j>", "<Plug>(coc-snippets-expand-jump)")
set("n", "<Leader>cl", ":CocList<cr>")
