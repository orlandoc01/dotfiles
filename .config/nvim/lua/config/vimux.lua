local M = {}

function M.setup()
  local default_opts = { noremap = true, silent = true }
  -- run rspec
  vim.api.nvim_set_keymap(
    'n',
    '<Leader>rb',
    ':call VimuxRunCommand("clear; ~/.rbenv/shims/bundle exec rspec " . bufname("%"))<CR>',
    default_opts
  )
  -- run rspec line
  vim.api.nvim_set_keymap(
    'n',
    '<Leader>rbl',
    ':call VimuxRunCommand("clear; ~/.rbenv/shims/bundle exec rspec " . bufname("%") . ":" . line("."))<CR>',
    default_opts
  )
  vim.api.nvim_set_keymap(
    'n',
    '<Leader>gt',
    ':call VimuxRunCommand("clear; go test " . expand("%:p:h"))<CR>',
    default_opts
  )
  -- run go test on func
  vim.api.nvim_set_keymap(
    'n',
    '<Leader>gtf',
    ':call VimuxRunCommand("clear; go test " . expand("%:p:h") . " -run " . expand("<cword>"))<CR>',
    default_opts
  )
end

return M
