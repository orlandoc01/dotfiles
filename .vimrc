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
set completeopt=menu,menuone,preview,noselect,noinsert
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
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"============ Vim Plugs ============
function! InstallPynVim(info)
  if a:info.status == 'installed' || a:info.force
    !pip3 install pynvim
  endif
endfunction

call plug#begin('~/.vim/plugged')
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

"Deoplete Completion
" If error is thrown regarding pynvim, run
"    :pythonx import sys; print(sys.path)
" to detect the python version compiled with vim and then run
"    PATH="/usr/local/opt/python@VERSION/bin:$PATH" pip3 install pynvim
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc', { 'do': function('InstallPynVim') }
let g:python3_host_prog = "/usr/local/bin/python3"
let g:deoplete#enable_at_startup = 1
set runtimepath+=$HOME/.vim/plugged/deoplete.nvim

"Language Plugins
Plug 'natebosch/vim-lsc'
Plug 'hrsh7th/deoplete-vim-lsc'
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
call plug#end()

"=============== Mouse =====================
if has('mouse')
  set mouse=a
  if &term =~ '^screen'
      " tmux knows the extended mouse mode
      set ttymouse=xterm2
  endif
endif

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
call deoplete#custom#option('sources', { '_': ['lsc', 'around'] })
call deoplete#custom#option('auto_complete_delay', 200)
call deoplete#custom#option('ignore_case', v:true)
call deoplete#custom#option('min_pattern_length', 3)
call deoplete#custom#source('_', 'min_pattern_length', 3)

let g:ale_disable_lsp = 1
let g:lsc_enable_autocomplete = v:false
let g:lsc_auto_map = {
 \  'GoToDefinition': 'gd',
 \  'FindReferences': 'gr',
 \  'SignatureHelp': 'gm',
 \  'Rename': 'gR',
 \  'ShowHover': 'K',
 \  'FindCodeActions': 'ga',
 \  'Completion': 'omnifunc',
 \}
let g:lsc_server_commands = {
  \ "javascript": "typescript-language-server --stdio",
  \ "ruby": "solargraph stdio",
  \ "sh": "bash-language-server start",
  \ "go": {
  \    "command": "gopls serve",
  \    "log_level": -1,
  \    "suppress_stderr": v:true,
  \  },
  \ }

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

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
  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup end
