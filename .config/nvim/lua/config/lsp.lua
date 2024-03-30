local M = {}

function M.setup()
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings
    local opts = { noremap=true, silent=false }
    -- local opts2 = { focusable = false,
    --          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --          border = 'rounded',
    --          source = 'always',  -- show source in diagnostic popup window
    --          prefix = ' '}
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(0, {{opts2}, scope="line", border="rounded"})<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" }})<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" }})<CR>', opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist({open = true})<CR>", opts)
    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end
  end
  -- NOTE: Don't use more than 1 servers otherwise nvim is unstable
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  -- Use gopls
  nvim_lsp.gopls.setup{ on_attach = on_attach }
  nvim_lsp.tsserver.setup{ on_attach = on_attach }
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
