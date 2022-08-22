local M = {}

function M.setup()
  local default_opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', ',', '<Plug>(ale_detail)', default_opts)
  vim.api.nvim_set_keymap('n', '<leader>aj', ':ALENext<cr>', default_opts)
  vim.api.nvim_set_keymap('n', '<leader>ak', ':ALEPrevious<cr>', default_opts)

  vim.g.ale_disable_lsp = 1
  vim.g.ale_statusline_format = {'X %d', '? %d', ''}
  vim.g.ale_echo_msg_format = '%linter% says %s'
  vim.g.ale_fix_on_save = 1
  vim.g.ale_lint_on_text_changed = 'never'
  vim.g.ale_lint_on_insert_leave = 1
  vim.g.ale_javascript_eslint_use_global = 1
  vim.g.ale_javascript_eslint_executable = 'eslint_d'
  vim.g.ale_sign_warning = '?' --could use emoji
  vim.g.ale_sign_error = 'X' --could use emoji
  vim.g.ale_completion_enabled = 0
  vim.g.ale_fix_on_save = 1
  vim.g.ale_linters = {
     ruby= { 'ruby', 'rubocop', 'solargraph', 'sorbet' },
     go= { 'gobuild', 'golint', 'gotype', 'gopls' },
     javascript= { 'eslint', 'tsserver', 'flow-language-server' },
     haskell= { 'ghc', 'cabal-ghc', 'stack-ghc', 'hie', 'hlint', 'stack-build' }
  }
  vim.g.ale_fixers = { go= {'goimports'} }
end

return M
