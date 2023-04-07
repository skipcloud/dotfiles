local fns = "custom.functions"
package.loaded[fns] = nil
require(fns)

--[[
--  General Mappings, see setup/lsps.lua for LSP mappings
--]]

local set = vim.keymap.set
local map = ""

vim.g.mapleader = ","

-- General mappings
set("n", "\\", ",")
set("i", "jj", "<esc>")

-- Custom Functions
set("n", "<Leader>w", M.TrimWhiteSpace)
set("n", "<Leader>r", M.ReloadConfig)

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
