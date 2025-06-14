local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system { "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path, }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }
    use { "tomtom/tcomment_vim" }
    use { 'scrooloose/nerdtree', config = require("config.nerdtree").setup }
    use { 'ctrlpvim/ctrlp.vim', config = require("config.ctrlp").setup }
    use {
      'FelikZ/ctrlp-py-matcher',
      config = function()
        vim.g.ctrlp_match_func = { match = 'pymatcher#PyMatch' }
      end
    }
    use { 'w0rp/ale', config = require('config.ale').setup }
    use { 'tpope/vim-surround' }
    use { 'tpope/vim-repeat' }
    use { 'tpope/vim-fugitive' }
    use { 'tpope/vim-endwise' }
    use { 'christoomey/vim-tmux-navigator' }
    use {
      'majutsushi/tagbar',
      config = function()
        vim.api.nvim_set_keymap('n', '<F7>', ':TagbarToggle<CR>', { noremap = true, silent = true })
      end
    }
    use { 'sheerun/vim-polyglot' }
    use { 'godlygeek/tabular' }
    use { 'Yggdroot/indentLine' }
    use { 'tyru/open-browser.vim' }
    use { 'tyru/open-browser-github.vim' }
    use { 'benmills/vimux', config = require('config.vimux').setup }
    use {
      'airblade/vim-rooter',
      config = function()
        vim.g.rooter_patterns = {'README', 'README.md', 'Makefile', 'Gemfile', '.git/'}
      end

    }
    use { 'aserebryakov/vim-todo-lists' }
    use {
      'nvim-treesitter/nvim-treesitter',
      run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
      config = require("config.nvim-treesitter").setup
    }
    use { 'neovim/nvim-lspconfig', config = require("config.lsp").setup }

    -- "Language Plugins
    use { 'mattn/emmet-vim', ft = { 'html' } }
    use { 'tpope/vim-rails', ft = { 'ruby' } }

    -- " nvim-cmp {
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/nvim-cmp', config = require("config.cmp").setup }

    use { 'hrsh7th/cmp-vsnip' }
    use { 'hrsh7th/vim-vsnip' }
    -- " nvim-cmp }

    use {
      'lifepillar/vim-gruvbox8',
      config = function()
        vim.opt.termguicolors = true -- Enable colors in terminal
        vim.cmd "colorscheme gruvbox8_hard"
        vim.cmd "highlight Normal ctermbg=NONE guibg=NONE"
      end,
    }
    use { "folke/which-key.nvim" }
    use { 'junegunn/fzf' }
    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
