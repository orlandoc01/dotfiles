vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Hook: rebuild treesitter parsers on install/update
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and (kind == 'update' or kind == 'install') then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

-- All plugins: deps listed before dependents
vim.pack.add({
  -- Colorscheme (must load first)
  'https://github.com/lifepillar/vim-gruvbox8',

  -- Core editor
  'https://github.com/tpope/vim-surround',
  'https://github.com/tpope/vim-repeat',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-endwise',
  'https://github.com/christoomey/vim-tmux-navigator',
  'https://github.com/godlygeek/tabular',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/benmills/vimux',
  'https://github.com/tyru/open-browser.vim',
  'https://github.com/tyru/open-browser-github.vim',
  'https://github.com/folke/which-key.nvim',

  -- File explorer (deps first)
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-neo-tree/neo-tree.nvim',

  -- Fuzzy finder (plenary already listed above)
  'https://github.com/nvim-telescope/telescope.nvim',

  -- Treesitter + Linting
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/mfussenegger/nvim-lint',

  -- LSP (mason installs servers, lspconfig configures them)
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/neovim/nvim-lspconfig',

  -- Completion
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/hrsh7th/cmp-path',
  'https://github.com/hrsh7th/nvim-cmp',

  -- Language-specific
  'https://github.com/mattn/emmet-vim',
  'https://github.com/tpope/vim-rails',

  -- AI (dep first)
  'https://github.com/folke/snacks.nvim',
  'https://github.com/NickvanDyke/opencode.nvim',
})

---------- Colorscheme ----------
vim.opt.termguicolors = true
vim.cmd.colorscheme('gruvbox8_hard')
vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')

---------- Plugin configs ----------
require('ibl').setup({ indent = { char = "│" }, scope = { enabled = true } })
require('config.neotree').setup()
require('config.telescope').setup()
require('config.nvim-lint').setup()
require('config.nvim-treesitter').setup()
require('config.vimux').setup()
require('config.opencode').setup()

---------- vim-rooter replacement ----------
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local root = vim.fs.root(0, {
      '.git', 'Makefile', 'Gemfile', 'README.md', 'README', '.vim-rooter',
    })
    if root then vim.fn.chdir(root) end
  end,
})

---------- LSP ----------
require('config.mason').setup()
require('config.lsp').setup()

---------- Completion ----------
require('config.cmp').setup()
