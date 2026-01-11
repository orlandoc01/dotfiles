local M = {}

function M.setup()
  -- on_attach: buffer-local keymaps + options
  local on_attach = function(client, bufnr)
    local function buf_map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        noremap = true,
        silent = false,
        desc = desc,
      })
    end

    -- omnifunc for completion
    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

    -- LSP keymaps
    buf_map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")

    buf_map("n", "gd", function()
      vim.cmd("tab split")
      vim.lsp.buf.definition()
    end, "LSP definition (tab)")

    buf_map("n", "K", vim.lsp.buf.hover, "LSP hover")
    buf_map("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
     buf_map("n", "<leader>t", vim.lsp.buf.signature_help, "Signature help")
     buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
     buf_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    buf_map("n", "gr", vim.lsp.buf.references, "References")

    buf_map("n", "<leader>e", function()
      vim.diagnostic.open_float(nil, {
        scope = "line",
        border = "rounded",
        focusable = false,
      })
    end, "Line diagnostics")

    buf_map("n", "[d", function()
      vim.diagnostic.goto_prev({ float = { border = "rounded" } })
    end, "Prev diagnostic")

    buf_map("n", "]d", function()
      vim.diagnostic.goto_next({ float = { border = "rounded" } })
    end, "Next diagnostic")

    buf_map("n", "<leader>q", function()
      vim.diagnostic.setloclist({ open = true })
    end, "Diagnostics loclist")

    local cap = client.server_capabilities

    if cap.documentFormattingProvider then
      buf_map("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, "Format buffer")
    end

    if cap.documentRangeFormattingProvider then
      buf_map("v", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, "Format selection")
    end
  end

  -- Global capabilities (for all servers)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

   -- Mason LSPConfig setup
   require("mason-lspconfig").setup({
     ensure_installed = { "gopls", "ts_ls", "rust_analyzer", "clangd", "lua_ls" }
   })

   -- Configure LSP servers
   vim.lsp.config("*", {
     on_attach = on_attach,
     capabilities = capabilities,
   })

   vim.lsp.config("lua_ls", {
     settings = {
       Lua = {
         runtime = { version = "LuaJIT" },
         diagnostics = { globals = { "vim" } },
         workspace = { library = vim.api.nvim_get_runtime_file("", true) },
         telemetry = { enable = false },
       },
     },
   })

  -- Diagnostics signs + UI
  vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
  vim.fn.sign_define("DiagnosticSignWarn",  { text = "!",  texthl = "DiagnosticSignWarn"  })
  vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
  vim.fn.sign_define("DiagnosticSignHint",  { text = "", texthl = "DiagnosticSignHint" })

  vim.diagnostic.config({
    underline = false,
    virtual_text = true,
    signs = true,
    severity_sort = true,
  })

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })
end

return M
