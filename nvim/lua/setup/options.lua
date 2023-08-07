local o = vim.o
local opt = vim.opt -- convenient interface for interacting with lists/maps
local wo = vim.wo

vim.g.python3_host_prog = "/home/skip/.pyenv/shims/python"

-- Global options
o.laststatus = 3
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
o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden --glob !.git --glob !vendor --glob !node_modules"
o.ttimeoutlen = 20
o.autowrite = true
o.completeopt = "menu"
opt.directory:prepend { "/tmp//" }
opt.tags:prepend { "./.git/tags" }

-- Window options
wo.number = true
wo.linebreak = true
wo.wrap = false
wo.concealcursor = "n" -- mode in which concealed text is revealed

