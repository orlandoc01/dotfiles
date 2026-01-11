return {
  -- Core editor plugins
  "tomtom/tcomment_vim",
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = require("config.neotree").setup,
  },
  { 'nvim-telescope/telescope.nvim', config = require("config.telescope").setup },
  { 'mfussenegger/nvim-lint', config = require('config.nvim-lint').setup },
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-fugitive',
  'tpope/vim-endwise',
  'christoomey/vim-tmux-navigator',


  'godlygeek/tabular',
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│",  -- Same character as indentLine default
      },
      scope = {
        enabled = true,  -- Show current scope highlighting
      },
    }
  },
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
