local M = {}

function M.setup()
  require("telescope").setup({
    defaults = {
      file_ignore_patterns = { ".git/", ".hg/", ".svn/" },
    },
  })

  -- Keymaps matching CtrlP
  vim.api.nvim_set_keymap('n', '<c-p>', ':Telescope find_files<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>.', ':Telescope tags<CR>', { noremap = true, silent = true })
end

return M
