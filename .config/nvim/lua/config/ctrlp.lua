local M = {}

function M.setup()
  vim.g.ctrlp_user_command = { '.git', 'cd %s && git ls-files -co --exclude-standard' }
  vim.g.ctrlp_custom_ignore = [[\v[\/]\.(git|hg|svn)$]]
  vim.g.ctrlp_map = '<c-p>'
  vim.g.ctrlp_cmd = 'CtrlP'
  vim.g.ctrlp_max_files = 0
  vim.g.ctrlp_max_depth = 40
  vim.g.ctrlp_working_path_mode = ''
  vim.g.ctrlp_match_window = 'results:100'
  vim.g.ctrlp_lazy_update = 1

  vim.api.nvim_set_keymap('', '<leader>.', ':CtrlPTag<cr>', { noremap = true, silent = true })
end

return M
