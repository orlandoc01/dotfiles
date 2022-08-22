local M = {}

function M.setup()
  local default_opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '>', ':NERDTreeFocus<CR>', default_opts)
  vim.api.nvim_set_keymap('n', '<', ':NERDTreeClose<CR>', default_opts)
  vim.g.NERDTreeShowHidden = 1
end

return M
