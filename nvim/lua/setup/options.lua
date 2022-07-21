local o = vim.o
local wo = vim.wo
local bo = vim.bo

vim.g.python3_host_prog="/home/skip/.pyenv/shims/python"

-- Global options
o.statusline = 3
o.cmdheight = 2
o.updatetime = 300
o.path = o.path .. ",./**"
o.splitright = true
o.splitbelow = true
o.clipboard = "unnamedplus"
o.ignorecase = true
o.smartcase = true
o.mouse = "a"
o.dictionary = "/usr/share/dict/words"
o.grepprg = "rg --vimgrep --noheading --smart-case --hidden --glob !vendor --glob !node_modules"
o.ttimeoutlen = 20
o.directory = "/tmp//," .. o.directory
o.autowrite = true
o.tags = "./.git/tags," .. o.tags

-- Window options
wo.number = true
wo.linebreak = true
wo.wrap = false
wo.concealcursor="n" -- mode in which concealed text is revealed
wo.relativenumber = true

-- Buffer options
bo.softtabstop = 2
bo.expandtab = true
bo.shiftwidth = 2
bo.undofile = true

