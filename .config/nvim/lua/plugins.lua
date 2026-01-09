return {
  -- Core editor plugins
  "tomtom/tcomment_vim",
  { 'scrooloose/nerdtree', config = require("config.nerdtree").setup },
  { 'ctrlpvim/ctrlp.vim', config = require("config.ctrlp").setup },
  {
    'FelikZ/ctrlp-py-matcher',
    config = function()
      vim.g.ctrlp_match_func = { match = 'pymatcher#PyMatch' }
    end
  },
  { 'w0rp/ale', config = require('config.ale').setup },
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-fugitive',
  'tpope/vim-endwise',
  'christoomey/vim-tmux-navigator',
  {
    'majutsushi/tagbar',
    config = function()
      vim.api.nvim_set_keymap('n', '<F7>', ':TagbarToggle<CR>', { noremap = true, silent = true })
    end
  },
  'sheerun/vim-polyglot',
  'godlygeek/tabular',
  'Yggdroot/indentLine',
  'tyru/open-browser.vim',
  {
    'tyru/open-browser-github.vim',
    dependencies = { "tyru/open-browser.vim", },
  },
  { 'benmills/vimux', config = require('config.vimux').setup },
  {
    'airblade/vim-rooter',
    config = function()
      vim.g.rooter_patterns = {'README', 'README.md', 'Makefile', 'Gemfile', '.git/', '.vim-rotter'}
    end
  },
  'aserebryakov/vim-todo-lists',

  -- LSP and completion
  {
    'nvim-treesitter/nvim-treesitter',
    build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = require("config.nvim-treesitter").setup
  },
  { 'neovim/nvim-lspconfig', config = require("config.lsp").setup },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  { 'hrsh7th/nvim-cmp', config = require("config.cmp").setup },
  'hrsh7th/cmp-vsnip',
  'hrsh7th/vim-vsnip',

  -- Language-specific plugins
  { 'mattn/emmet-vim', ft = 'html' },
  { 'tpope/vim-rails', ft = 'ruby' },

  -- Opencode and dependencies
  "folke/snacks.nvim",
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      "folke/snacks.nvim",
    },
    config = require("config.opencode").setup
  },

  -- UI and colorscheme (high priority to prevent flickering)
  {
    'lifepillar/vim-gruvbox8',
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true -- Enable colors in terminal
      vim.cmd "colorscheme gruvbox8_hard"
      vim.cmd "highlight Normal ctermbg=NONE guibg=NONE"
    end,
  },
  "folke/which-key.nvim",
}
