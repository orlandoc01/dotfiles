local M = {}

function M.setup()
  require("neo-tree").setup({
    filesystem = {
      show_hidden = true,
    },
    window = {
      width = 30,
    },
  })

  local default_opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '>', ':Neotree toggle<CR>', default_opts)
  vim.api.nvim_set_keymap('n', '<', ':Neotree close<CR>', default_opts)
end

return M
