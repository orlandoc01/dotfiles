"==================== My Sets ==============
set nowrap
set nocompatible
set hls
set nrformats=
set tabstop=2
set expandtab
set history=500
set undolevels=500
set title
set noerrorbells
set number
set ruler
set noswapfile
set hlsearch
set showmatch
set shiftwidth=2
set ai
set si
set pastetoggle=<F2>
set nofoldenable
set viminfo^=%
set noeb vb t_vb=
set autoread
set clipboard=unnamed "allow yank to clipboard
set textwidth=0
set wrapmargin=0
set formatoptions+=1
set backspace=indent,eol,start
set wildmode=list:longest,full
set wildmenu             
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2
set encoding=utf-8
set exrc
set secure
set timeoutlen=1000 ttimeoutlen=100
let mapleader = "\<Space>" 

"========== Install Vim-plug if not found ==============''
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"============ Vim Plugs ============
call plug#begin(stdpath('data') . '/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'christoomey/vim-tmux-navigator'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'benmills/vimux'
Plug 'airblade/vim-rooter'
Plug 'lifepillar/vim-gruvbox8'
Plug 'aserebryakov/vim-todo-lists'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

"Language Plugins
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" nvim-cmp {
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
" nvim-cmp }
 
call plug#end()
call plug#helptags()
"=============== Mouse =====================
if has('mouse')
  set mouse=a
  if &term =~ '^screen'
      " tmux knows the extended mouse mode
      set ttymouse=xterm2
  endif
endif

"========= Nvim Treesitter =============
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "go",
    "graphql",
    "html",
    "javascript",
    "json",
    "python",
    "ruby",
    "solidity",
    "typescript",
    "yaml",
  },
  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    -- dont enable this, messes up python indentation
    enable = false,
    disable = {},
  },
}
EOF
" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

"================= Completion engine =====================
set completeopt=menu,menuone,noselect
lua <<EOF
local cmp = require('cmp')
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then cmp.select_next_item() else fallback() end
        end),
      ["<S-Tab>"] = function(fallback)
          if cmp.visible() then cmp.select_prev_item() else fallback() end
        end,
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-g>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      }, {
      { name = 'path' },
      { name = 'buffer', keyword_length = 2,
        option = {
            -- include all buffers, avoid indexing big files
            get_bufnrs = function()
              local buf = vim.api.nvim_get_current_buf()
              local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
              if byte_size > 1024 * 1024 then -- 1 Megabyte max
                return {}
              end
              return { buf }
            end
      }},  -- end of buffer
    }),
    completion = {
        keyword_length = 2,
        completeopt = "menu,noselect"
  },
})
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }),
})
EOF

"==================== Key Mappings =========================
command! Ts execute 'tselect' expand('<cword>')
command! Todo execute 'e ~/.items.todo'

"NerdTrees
nmap > :NERDTreeFocus<CR>
nmap < :NERDTreeClose<CR>
let NERDTreeShowHidden=1
"TagBar
nmap <F7> :TagbarToggle<CR>
" Opens a new tab with the current buffer's path
nmap :tn :tabnew<CR>
" use visual-block instead of visual as default, vv will enter visual mode
nnoremap v <C-v>
" apply . per line
vnoremap . :normal .<CR>

let g:VimTodoListsDatesEnabled = 1
let g:VimTodoListsDatesFormat = "%a %b, %Y"

"================= Vimux================================="
" run rspec
nmap <Leader>rb :call VimuxRunCommand("clear; ~/.rbenv/shims/bundle exec rspec " . bufname("%"))<CR>
" run rspec line
nmap <Leader>rbl :call VimuxRunCommand("clear; ~/.rbenv/shims/bundle exec rspec " . bufname("%") . ":" . line("."))<CR>
" run go test
nmap <Leader>gt :call VimuxRunCommand("clear; go test " . expand("%:p:h"))<CR>
" run go test on func
nmap <Leader>gtf :call VimuxRunCommand("clear; go test " . expand("%:p:h") . " -run " . expand("<cword>"))<CR>
nmap <Leader>vq :VimuxCloseRunner<CR>
nmap <Leader>vl :VimuxRunLastCommand<CR>
nmap <Leader>vx :VimuxInterruptRunner<CR>
nmap <Leader>vz :call VimuxZoomRunner()<CR>

"============= File Settings =====================
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead CMake* set filetype=cmake
au BufNewFile,BufRead *.go setlocal ts=4 sts=4 sw=4 noexpandtab
" Ruby syntax highlighting works better with old regexp engine
au BufNewFile,BufRead *.rb set re=1

"============ Autocompletion ===================

"============ Ctrl-P Settings =======================
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'results:100'
let g:ctrlp_lazy_update = 1

set wildignore=*.o,*.obj,*~,*vim/backups*,*sass-cache*,*DS_Store*,vendor/rails/**
set wildignore+=*.gem,tmp/**,*/tmp/*,*/build/*,*.png,*.jpg,*.gif,vendor/cache/**

nnoremap <leader>. :CtrlPTag<cr>

"============== Emmet-vim ====================
let g:user_emmet_install_global = 0

"============= ALE Checker =============
nmap , <Plug>(ale_detail)
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

let g:ale_disable_lsp = 1
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '%linter% says %s'
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_sign_warning = '?' " could use emoji
let g:ale_sign_error = 'X' " could use emoji
let g:ale_completion_enabled = 0
let g:rooter_patterns = ['README', 'README.md', 'Makefile', 'Gemfile', '.git/']
let g:ale_linters = {
\   'ruby': ['ruby', 'rubocop', 'solargraph', 'sorbet'],
\   'go': ['gobuild', 'golint', 'gotype', 'gopls'],
\   'javascript': ['eslint', 'tsserver', 'flow-language-server'],
\   'haskell': ['ghc', 'cabal-ghc', 'stack-ghc', 'hie', 'hlint', 'stack-build']
\}
let g:ale_fixers = {
\   'go': ['goimports']
\ }
let g:ale_fix_on_save = 1

" Note: for above haskell settings, install IDE engine separately: 
" https://gist.github.com/orlandoc01/58f2cd702b3c81c661c915c62dcbde18

"============ LSP =================
lua <<EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
  end
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings
  local opts = { noremap=true, silent=false }
  local opts2 = { focusable = false,
           close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
           border = 'rounded',
           source = 'always',  -- show source in diagnostic popup window
           prefix = ' '}
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>t', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(0, {{opts2}, scope="line", border="rounded"})<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ float = { border = "rounded" }})<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ float = { border = "rounded" }})<CR>', opts)
  buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist({open = true})<CR>", opts)
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
end
-- NOTE: Don't use more than 1 servers otherwise nvim is unstable
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use gopls
nvim_lsp.gopls.setup{ on_attach = on_attach }
nvim_lsp.tsserver.setup{ on_attach = on_attach }

vim.fn.sign_define("DiagnosticSignError", { text = "✗", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "!", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInformation", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
-- global config for diagnostic
vim.diagnostic.config({
  underline = false,
  virtual_text = true,
  signs = true,
  severity_sort = true,
})
-- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
EOF

"=========== True color ===================="
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
syntax enable
colorscheme gruvbox8_hard
" highlight Pmenu ctermbg=Brown guibg=#403835
highlight Normal ctermbg=NONE guibg=NONE

"=== Personal Autocommands
augroup personal_autocmd
  autocmd!
  " Setup emmet
  autocmd FileType html,css EmmetInstall
  " Return to last edit position when opening files
  autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup end
