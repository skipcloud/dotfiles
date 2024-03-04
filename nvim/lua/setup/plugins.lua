--[[
	Plugins and their settings
--]]

local cmd = vim.cmd
local fn  = vim.fn

--[[
--  Plugin Options
--]]

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
vim.g.UtilSnipsEditSplit = "vertical"
vim.g.UltiSnipsExpandTrigger = "<tab>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-h>"

vim.g.polyglot_disabled = { "sensible" }

vim.g.hardtime_default_on = true
vim.g.hardtime_ignore_buffer_patterns = { "NERD.*" }
vim.g.hardtime_ignore_quickfix = true

vim.g.gitblame_enabled = false

--[[
--  Load the plugins
--]]

fn["plug#begin"](vim.fn.stdpath("data") .. "/site/bundle")
-- Plug itself, for docs etc
cmd("Plug 'junegunn/vim-plug'")

-- Neovim specific plugins
cmd("Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }")
cmd("Plug 'nvim-treesitter/nvim-treesitter-textobjects'")
cmd("Plug 'EdenEast/nightfox.nvim'")
cmd("Plug 'neovim/nvim-lspconfig'")

-- Neovim autocompletion
cmd("Plug 'hrsh7th/cmp-nvim-lsp'")
cmd("Plug 'hrsh7th/cmp-buffer'")
cmd("Plug 'hrsh7th/cmp-path'")
cmd("Plug 'hrsh7th/cmp-cmdline'")
cmd("Plug 'hrsh7th/nvim-cmp'")
cmd("Plug 'hrsh7th/cmp-nvim-lua'")
cmd("Plug 'quangnguyen30192/cmp-nvim-ultisnips'")
cmd("Plug 'onsails/lspkind.nvim'")

-- indent markers
cmd("Plug 'lukas-reineke/indent-blankline.nvim'")

-- mini, which contains many sub-modules
-- cmd("Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }")

-- split/join
cmd("Plug 'Wansmer/treesj'")

-- snippets
cmd("Plug 'SirVer/ultisnips'")
cmd("Plug 'honza/vim-snippets'")

-- git
cmd("Plug 'f-person/git-blame.nvim'")

-- And the rest...

-- Terraform
cmd("Plug 'hashivim/vim-terraform'")

-- stop repeating keys
cmd("Plug 'takac/vim-hardtime'")

-- colourschemes
cmd("Plug 'sainnhe/everforest'")
cmd("Plug 'morhetz/gruvbox'")

-- css colours in source code
cmd("Plug 'ap/vim-css-color'")
-- Postgres syntax highlighting
cmd("Plug 'lifepillar/pgsql.vim'")

-- Autogenerate pair ({[
cmd("Plug 'jiangmiao/auto-pairs'")

-- Navigation tree
cmd("Plug 'scrooloose/nerdtree'")

-- change surrounding brackets/quotes/parens etc
cmd("Plug 'tpope/vim-surround'")
-- handy [ and ] mappings
cmd("Plug 'tpope/vim-unimpaired'")
-- make vim-commentary and vim-surround work with .
cmd("Plug 'tpope/vim-repeat'")
-- Commenting and uncommenting stuff
cmd("Plug 'tpope/vim-commentary'")

-- Status bar
cmd("Plug 'vim-airline/vim-airline'")
cmd("Plug 'vim-airline/vim-airline-themes'")

-- Fuzzy search - both lines needed
cmd("Plug 'junegunn/fzf', { 'do': {-> fzf#install() }}")
cmd("Plug 'junegunn/fzf.vim'")

-- Close buffers
cmd("Plug 'Asheq/close-buffers.vim'")

-- align text
cmd("Plug 'godlygeek/tabular'")

-- markdown folding
cmd("Plug 'plasticboy/vim-markdown'")

-- JSX syntax highlighting
cmd("Plug 'MaxMEllon/vim-jsx-pretty'")

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

  -- highlight module
  highlight = {
    -- `false` will disable the whole extension
    enable = true ,

    -- for some reason highlighting causes vim-commentary
    -- to stop working in TF files
    -- disable = { "terraform" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- incremental_selection module
  incremental_selection = { enable = false },

  -- textobjects module
  textobjects = {
    enable = true,
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = { query = "@function.outer", desc = "Select around function" },
        ["if"] = { query = "@function.inner", desc = "Select inside function" },
        ["ac"] = { query = "@class.outer", desc = "Select around class/struct" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = false
    }
  }
}

require("ibl").setup {}

require('treesj').setup {
      -- Use default keymaps
      -- (<space>m - toggle, <space>j - join, <space>s - split)
      -- only putting it here because I keep forgetting what the
      -- default mapping is, then I forget where to find the docs
      use_default_keymaps = true,
}

local cmp = require 'cmp' or {}
local lspkind = require 'lspkind'

cmp.setup({
  preselect = cmp.PreselectMode.None, -- don't preselect a suggestion
  formatting = {
    format = lspkind.cmp_format({
      mode = 'text',
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        ultisnips = "[Snips]",
        nvim_lua = "[Lua]",
      })
    }),
  },
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
    ['<C-Space>'] = cmp.mapping.complete(), -- start completion, useful when you've closed the menu
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    -- keeping sources in separate groups like this instead of
    -- in a flat array means you can avoid needing to add a
    -- `group_index` to each source.
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  }, {
    { name = 'nvim_lua' },
  }, {
    { name = 'buffer' },
  }, {
    { name = 'path' }
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
