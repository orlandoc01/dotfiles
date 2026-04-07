local M = {}

function M.setup()
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

  vim.opt.completeopt = { 'menuone', 'noselect', 'popup', 'fuzzy' }

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspCompletion", { clear = true }),
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client then return end

      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          if item.kind == vim.lsp.protocol.CompletionItemKind.Snippet then
            return { word = '', empty = 0 }
          end
          return {}
        end,
      })

      -- Trigger completion on keyword characters too
      -- (autotrigger only handles LSP trigger chars like '.')
      vim.api.nvim_create_autocmd('InsertCharPre', {
        buffer = ev.buf,
        callback = function()
          if vim.fn.pumvisible() ~= 0 then return end
          if vim.v.char:match('[%w_]') then
            vim.schedule(function()
              vim.lsp.completion.get()
            end)
          end
        end,
      })
    end,
  })
end

return M
