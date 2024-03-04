--[[
--  Language Server config and mappings
--]]

-- stop the logs growing, no need to log unless
-- there is a need to debug
vim.lsp.set_log_level 'off'

-- Handlers
-- Alter how the hover and signature help floating windows look
-- and operate
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "rounded",
    focusable = false
  }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded",
    focusable = false
  }
)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gds', vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gdh', vim.lsp.buf.document_highlight, bufopts)
  vim.keymap.set('n', 'gch', vim.lsp.buf.clear_references, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format { async = false }
  end, bufopts)
end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require 'lspconfig'

-- Lua
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = '5.4.4',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size  = 2
        }
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities
}

-- Ruby
lspconfig.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "solargraph-wrapper", "stdio" },
  root_dir = lspconfig.util.root_pattern('CHANGELOG.md', 'Gemfile')
}

-- Typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    typescript = {
      format = {
        convertTabsToSpaces = true,
        indentSize = 4
      }
    }
  }
}

-- CSS
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Terraform
lspconfig.terraformls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    terraform = {
      timeout = 30
    }
  }
}

-- TFlint
lspconfig.tflint.setup{}

-- Python
lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- Go
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        useany = true,
        unusedvariable = true,
      },
      staticcheck = true,
      gofumpt = true,
    }
  }
}

-- Go linter
lspconfig.golangci_lint_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = { command = {'golangci-lint-wrapper', 'run', '--out-format', 'json'} },
}
