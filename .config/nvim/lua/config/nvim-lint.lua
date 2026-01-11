local M = {}

function M.setup()
  local lint = require('lint')

  -- Linters matching ALE config
  lint.linters_by_ft = {
    ruby = { 'ruby', 'rubocop' },  -- Note: solargraph/sorbet not in nvim-lint
    go = { 'gobuild', 'golint', 'gotype' },  -- gopls is LSP, not linter
    javascript = { 'eslint' },  -- tsserver/flow are LSP
    haskell = { 'hlint' },  -- ghc/cabal not in nvim-lint
    solidity = { 'solhint' },  -- solc/solium not available
  }

  -- Fixers (limited in nvim-lint; eslint can fix)
  -- For goimports/cpp, may need separate tools or manual

  -- Events: Lint on save and insert leave (matching ALE)
  vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
    callback = function()
      lint.try_lint()
    end,
  })

  -- Keymaps matching ALE
  local default_opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', ',', '<cmd>lua vim.diagnostic.open_float()<CR>', default_opts)  -- Detail (hover)
  vim.api.nvim_set_keymap('n', '<leader>aj', '<cmd>lua vim.diagnostic.goto_next()<CR>', default_opts)  -- Next error
  vim.api.nvim_set_keymap('n', '<leader>ak', '<cmd>lua vim.diagnostic.goto_prev()<CR>', default_opts)  -- Previous error

  -- Signs: Use Neovim defaults (can customize if needed)
  -- vim.fn.sign_define('DiagnosticSignError', { text = 'X', texthl = 'DiagnosticSignError' })
  -- vim.fn.sign_define('DiagnosticSignWarn', { text = '?', texthl = 'DiagnosticSignWarn' })
end

return M