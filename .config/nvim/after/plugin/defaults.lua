local opt = vim.opt

vim.api.nvim_set_keymap('n', ':tn', ':tabnew<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'v', '<C-v>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '.', ':normal .<CR>', { noremap = true, silent = true})
vim.cmd [[command! Ts execute 'tselect' expand('<cword>')]]

opt.wrap = false
opt.compatible = false
opt.hls = true
opt.tabstop = 2
opt.expandtab = true
opt.history = 500
opt.title = true
opt.errorbells = false
opt.number = true
opt.ruler = true
opt.swapfile = false
opt.hlsearch = true
opt.showmatch = true
opt.shiftwidth = 2
opt.ai = true
opt.si = true
opt.foldenable = false
-- opt.viminfo:prepend { "%" }
opt.autoread = true
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.textwidth = 0
opt.wrapmargin = 0
opt.formatoptions:append { 1 }
opt.backspace = { 'indent', 'eol', 'start' }
opt.wildmode = { 'longest', 'full' }
opt.wildmenu = true
opt.encoding = 'utf-8'
opt.exrc = true
opt.secure = true

opt.undofile = true --Save undo history
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.wildignore = {
  '*.o','*.obj','*~','*vim/backups*','*sass-cache*','*DS_Store*','vendor/rails/**',
  '*.gem','tmp/**','*/tmp/*','*/build/*','*.png','*.jpg','*.gif','vendor/cache/**',
}
