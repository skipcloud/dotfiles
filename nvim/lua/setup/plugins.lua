--[[
	Plugins and their settings
--]]

local cmd = vim.cmd
local fn  = vim.fn

--[[
--  Plugin Options
--]]

vim.g.terraform_fmt_on_save = 1
vim.g.rg_command = "rg --vimgrep --hidden --glob !vendor --glob !.git"
vim.g.fzf_colors = {
	fg      = { "fg", "Normal" },
	bg      = { "bg", "Normal" },
	hl      = { "fg", "Comment" },
	["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" },
	["bg+"] = { "bg", "CursorLine", "CursorColumn" },
	["hl+"] = { "fg", "Statement" },
	info    = { "fg", "PreProc" },
	border  = { "fg", "Ignore" },
	prompt  = { "fg", "Conditional" },
	pointer = { "fg", "Exception" },
	marker  = { "fg", "Keyword" },
	spinner = { "fg", "Label" },
	header  = { "fg", "Comment" },
}
vim.g.UtilSnipsEditSplit="vertical"
vim.g.UltiSnipsExpandTrigger="<tab>"
vim.g.UltiSnipsJumpForwardTrigger="<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger="<c-h>"
vim.g.polyglot_disabled = {"sensible"}

--[[
--  Load the plugins
--]]

fn["plug#begin"](vim.fn.stdpath("data") .. "/site/bundle")
-- Plug itself, for docs etc
cmd("Plug 'junegunn/vim-plug'")

-- Neovim specific plugins
cmd("Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }")
cmd("Plug 'EdenEast/nightfox.nvim'")
cmd("Plug 'neovim/nvim-lspconfig'")

-- Neovim autocompletion
cmd("Plug 'hrsh7th/cmp-nvim-lsp'")
cmd("Plug 'hrsh7th/cmp-buffer'")
cmd("Plug 'hrsh7th/cmp-path'")
cmd("Plug 'hrsh7th/cmp-cmdline'")
cmd("Plug 'hrsh7th/nvim-cmp'")
cmd("Plug 'quangnguyen30192/cmp-nvim-ultisnips'")

-- snippets
cmd("Plug 'SirVer/ultisnips'")
cmd("Plug 'honza/vim-snippets'")

-- And the rest...
-- colourschemes
cmd("Plug 'altercation/vim-colors-solarized'")
cmd("Plug 'sainnhe/everforest'")
cmd("Plug 'junegunn/vim-peekaboo'")
cmd("Plug 'jparise/vim-graphql'")
cmd("Plug 'vim-ruby/vim-ruby'")
cmd("Plug 'morhetz/gruvbox'")

-- css colours in source code
cmd("Plug 'ap/vim-css-color'")
-- Postgres syntax highlighting
cmd("Plug 'lifepillar/pgsql.vim'")

-- split/join
cmd("Plug 'AndrewRadev/splitjoin.vim'")

-- Autogenerate pair ({[
cmd("Plug 'jiangmiao/auto-pairs'")

-- Navigation tree
cmd("Plug 'scrooloose/nerdtree'")

-- git
cmd("Plug 'tpope/vim-fugitive'")

-- change surrounding brackets/quotes/parens etc
cmd("Plug 'tpope/vim-surround'")
-- handy [ and ] mappings
cmd("Plug 'tpope/vim-unimpaired'")
-- make vim-commentary and vim-surround work with .
cmd("Plug 'tpope/vim-repeat'")
-- Commenting and uncommenting stuff
cmd("Plug 'tpope/vim-commentary'")

cmd("Plug 'tpope/vim-bundler'")
cmd("Plug 'tpope/vim-rbenv'")
cmd("Plug 'tpope/vim-rails'")

-- Status bar
cmd("Plug 'vim-airline/vim-airline'")
cmd("Plug 'vim-airline/vim-airline-themes'")

-- Fuzzy search - both lines needed
cmd("Plug 'junegunn/fzf', { 'do': {-> fzf#install() }}")
cmd("Plug 'junegunn/fzf.vim'")

-- Close buffers
cmd("Plug 'Asheq/close-buffers.vim'")

-- Testing
cmd("Plug 'keith/rspec.vim'")
cmd("Plug 'janko-m/vim-test'")

-- indent markers
cmd("Plug 'Yggdroot/indentLine'")

-- replace grep
cmd("Plug 'jremmen/vim-ripgrep'")

-- markdown folding
cmd("Plug 'plasticboy/vim-markdown'")

-- Terraform command
cmd("Plug 'hashivim/vim-terraform'")

-- align text
cmd("Plug 'godlygeek/tabular'")


-- JSX syntax highlighting
cmd("Plug 'MaxMEllon/vim-jsx-pretty'")

-- Syntax highlighting for many languages
cmd("Plug 'sheerun/vim-polyglot'")

-- HCL syntax highlighting
cmd("Plug 'jvirtanen/vim-hcl'")

-- Frontend completion engine
cmd("Plug 'mattn/emmet-vim'")

fn["plug#end"]()

--[[
--  Configure neovim plugins
--]]
require 'nvim-treesitter.configs'.setup {
	ensure_installed = "all",

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- List of parsers to ignore installing (for "all")
	-- ignore_install = { "javascript" },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- disable = { "c", "rust" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = { enable = true },
	textobjects = { enable = true }
}

local cmp = require 'cmp' or {}

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

