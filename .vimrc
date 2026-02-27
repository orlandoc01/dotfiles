"==================== Settings ====================
set nocompatible
set nowrap
set tabstop=2
set expandtab
set shiftwidth=2
set history=500
set title
set number
set ruler
set noswapfile
set hlsearch
set showmatch
set autoindent
set smartindent
set nofoldenable
set autoread
set clipboard=unnamedplus
set textwidth=0
set wrapmargin=0
set formatoptions+=1
set backspace=indent,eol,start
set wildmode=list:longest,full
set wildmenu
set encoding=utf-8
set exrc
set secure
set timeoutlen=1000 ttimeoutlen=100
set undofile
set updatetime=250
set signcolumn=yes
set incsearch
set ignorecase
set smartcase
set scrolloff=8
set hidden
set splitright
set splitbelow
set cursorline
set completeopt=menu,menuone,noinsert,noselect
set noerrorbells novisualbell t_vb=
autocmd VimEnter * set t_vb=

set wildignore=*.o,*.obj,*~,*vim/backups*,*sass-cache*,*DS_Store*,vendor/rails/**
set wildignore+=*.gem,tmp/**,*/tmp/*,*/build/*,*.png,*.jpg,*.gif,vendor/cache/**

let mapleader = "\<Space>"

"==================== vim-plug auto-install ====================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"==================== Plugins ====================
call plug#begin('~/.vim/plugged')

" Core editor
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'benmills/vimux'
Plug 'airblade/vim-rooter'

" File navigation
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

" Syntax
Plug 'sheerun/vim-polyglot'

" LSP — vim-lsp-settings auto-installs servers (like Mason)
Plug 'prabirsheth/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Completion
Plug 'prabirsheth/asyncomplete.vim'
Plug 'prabirsheth/asyncomplete-lsp.vim'

" Linting
Plug 'dense-analysis/ale'

" Language-specific
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
Plug 'tpope/vim-rails', { 'for': 'ruby' }

" Colorscheme
Plug 'lifepillar/vim-gruvbox8'

call plug#end()

"==================== Mouse ====================
if has('mouse')
  set mouse=a
  if &term =~ '^screen' || &term =~ '^tmux'
    set ttymouse=sgr
  endif
endif

"==================== Colors ====================
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
syntax enable
colorscheme gruvbox8_hard
highlight Normal ctermbg=NONE guibg=NONE

"==================== LSP ====================
" vim-lsp-settings handles server installation automatically.
" Run :LspInstallServer when opening a file of the desired type.
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': '!'}

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gD <plug>(lsp-declaration)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> K  <plug>(lsp-hover)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> <leader>ca <plug>(lsp-code-action)
  nmap <buffer> <leader>lf <plug>(lsp-document-format)
  nmap <buffer> <leader>e  <plug>(lsp-document-diagnostics)
  nmap <buffer> [d <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]d <plug>(lsp-next-diagnostic)
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup end

"==================== Completion ====================
autocmd User asyncomplete_setup call asyncomplete#register_source(
  \ asyncomplete#sources#lsp#get_source_options({}))

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

"==================== NERDTree ====================
nmap > :NERDTreeFocus<CR>
nmap < :NERDTreeClose<CR>
let NERDTreeShowHidden=1

"==================== TagBar ====================
nmap <F7> :TagbarToggle<CR>

"==================== CtrlP ====================
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'results:100'
let g:ctrlp_show_hidden = 1
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")': ['<c-j>', '<down>'],
  \ 'PrtSelectMove("k")': ['<c-k>', '<up>'],
  \ }

nnoremap <leader>. :CtrlPTag<CR>

"==================== ALE ====================
let g:ale_disable_lsp = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '!'
let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {
  \ 'ruby':       ['ruby', 'rubocop'],
  \ 'go':         ['gobuild', 'golint', 'gotype'],
  \ 'javascript': ['eslint'],
  \ 'haskell':    ['hlint'],
  \ 'solidity':   ['solhint'],
  \ }
let g:ale_fixers = {
  \ 'go': ['goimports'],
  \ }

"==================== Vimux ====================
nmap <Leader>vq :VimuxCloseRunner<CR>
nmap <Leader>vl :VimuxRunLastCommand<CR>
nmap <Leader>vx :VimuxInterruptRunner<CR>
nmap <Leader>vz :call VimuxZoomRunner()<CR>

"==================== vim-rooter ====================
let g:rooter_patterns = ['README', 'README.md', 'Makefile', 'Gemfile', '.git/']

"==================== Emmet ====================
let g:user_emmet_install_global = 0

"==================== General keymaps ====================
command! Ts execute 'tselect' expand('<cword>')
nmap :tn :tabnew<CR>
nnoremap v <C-v>
vnoremap . :normal .<CR>

"==================== File type overrides ====================
augroup filetypes
  autocmd!
  autocmd BufNewFile,BufRead *.ejs      set filetype=html
  autocmd BufNewFile,BufRead CMake*     set filetype=cmake
  autocmd BufNewFile,BufRead *.go       setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd BufNewFile,BufRead *.rb       set re=1
  autocmd FileType html,css             EmmetInstall
  " Restore last cursor position when reopening a file
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup end
