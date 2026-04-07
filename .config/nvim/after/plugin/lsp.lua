vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    local function buf_map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        noremap = true,
        silent = false,
        desc = desc,
      })
    end

    buf_map("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "LSP hover")
    buf_map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
    buf_map("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
    buf_map("n", "<leader>t", vim.lsp.buf.signature_help, "Signature help")
    buf_map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")
    buf_map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    buf_map("n", "<leader>e", function()
      vim.diagnostic.open_float(nil, {
        scope = "line",
        border = "rounded",
        focusable = false,
      })
    end, "Line diagnostics")

    buf_map("n", "<leader>q", function()
      vim.diagnostic.setloclist({ open = true })
    end, "Diagnostics loclist")

    if client and client.server_capabilities.documentFormattingProvider then
      buf_map("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, "Format buffer")
    end

    if client and client.server_capabilities.documentRangeFormattingProvider then
      buf_map("v", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, "Format selection")
    end

    -- Native completion popup keymaps
    vim.keymap.set("i", "<Tab>", function()
      return vim.fn.pumvisible() ~= 0 and "<C-n>" or "<Tab>"
    end, { buffer = bufnr, expr = true, desc = "Completion next" })

    vim.keymap.set("i", "<S-Tab>", function()
      return vim.fn.pumvisible() ~= 0 and "<C-p>" or "<S-Tab>"
    end, { buffer = bufnr, expr = true, desc = "Completion prev" })

    vim.keymap.set("i", "<CR>", function()
      if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
        return "<C-y>"
      end
      return "<CR>"
    end, { buffer = bufnr, expr = true, desc = "Completion confirm" })

    vim.keymap.set("i", "<C-g>", function()
      return vim.fn.pumvisible() ~= 0 and "<C-e>" or "<C-g>"
    end, { buffer = bufnr, expr = true, desc = "Completion dismiss" })
  end,
})

vim.diagnostic.config({
  underline = false,
  virtual_text = true,
  signs = true,
  severity_sort = true,
})
