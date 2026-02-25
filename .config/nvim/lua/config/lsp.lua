local M = {}

function M.setup()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  vim.lsp.config("*", { capabilities = capabilities })

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

  require("mason-lspconfig").setup({
    ensure_installed = { "gopls", "ts_ls", "rust_analyzer", "clangd", "lua_ls" },
  })
end

return M
