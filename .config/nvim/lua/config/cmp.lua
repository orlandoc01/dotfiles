local M = {}

function M.setup()
  local status_ok, cmp = pcall(require, "cmp")
  if not status_ok then
    return
  end
   cmp.setup({
       mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item() else fallback() end
          end),
        ["<S-Tab>"] = function(fallback)
            if cmp.visible() then cmp.select_prev_item() else fallback() end
          end,
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-g>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        }, {
        { name = 'path' },
        { name = 'buffer', keyword_length = 2,
          option = {
              -- include all buffers, avoid indexing big files
              get_bufnrs = function()
                local buf = vim.api.nvim_get_current_buf()
                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if byte_size > 1024 * 1024 then -- 1 Megabyte max
                  return {}
                end
                return { buf }
              end
        }},  -- end of buffer
      }),
      completion = {
          keyword_length = 2,
          completeopt = "menu,menuone,noselect"
    },
  })
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'path' }
      }),
  })
end

return M
