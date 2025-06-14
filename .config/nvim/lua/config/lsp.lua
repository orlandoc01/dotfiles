local M = {}

function M.setup()
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_option(opt, val)
        vim.bo[bufnr][opt] = val
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings
    local opts = { buffer = bufnr, noremap = true, silent = false }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', function()
        vim.cmd('tab split')
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>t', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

    vim.keymap.set('n', '<leader>e', function()
      vim.diagnostic.open_float({
          bufnr = 0,
          scope = "line",
          border = "rounded",
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          source = true,
          prefix = ' ',
      })
    end, opts)

    vim.keymap.set('n', '[d', function()
        vim.diagnostic.goto_prev({ float = { border = "rounded" } })
    end, opts)

    vim.keymap.set('n', ']d', function()
        vim.diagnostic.goto_next({ float = { border = "rounded" } })
    end, opts)

    vim.keymap.set('n', '<leader>q', function()
        vim.diagnostic.setloclist({ open = true })
    end, opts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set('n', '<leader>lf', function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('n', '<leader>lf', function()
            vim.lsp.buf.format({ async = true })
      end, opts)
  end


  end
  -- NOTE: Don't use more than 1 servers otherwise nvim is unstable
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- Use gopls
  nvim_lsp.gopls.setup{ on_attach = on_attach }
  nvim_lsp.ts_ls.setup{ on_attach = on_attach }
  nvim_lsp.rust_analyzer.setup{ on_attach = on_attach }
  nvim_lsp.clangd.setup{ on_attach = on_attach }

  -- nvim_lsp.solc.setup{ on_attach = on_attach }
  nvim_lsp.lua_ls.setup {
    on_attach = on_attach,
    settings = {
      Lua = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        runtime = { version = 'LuaJIT' },
          -- Get the language server to recognize the `vim` global
        diagnostics = { globals = {'vim'} },
        -- Make the server aware of Neovim runtime files
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = { enable = false },
      },
    },
  }
  vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
  vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
  -- global config for diagnostic
  vim.diagnostic.config({
    underline = false,
    virtual_text = true,
    signs = true,
    severity_sort = true,
  })
  -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
end

return M
