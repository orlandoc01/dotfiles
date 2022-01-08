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
set completeopt-=preview
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
set re=1
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
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'christoomey/vim-tmux-navigator'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'benmills/vimux'
Plug 'airblade/vim-rooter'
Plug 'tfnico/vim-gradle'
Plug 'lifepillar/vim-gruvbox8'
Plug 'aserebryakov/vim-todo-lists'

"Deoplete Completion
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc', { 'do': function('InstallPynVim') }
let g:python3_host_prog = "/usr/local/bin/python3"
let g:deoplete#enable_at_startup = 1
set runtimepath+=$HOME/.vim/plugged/deoplete.nvim

"Language Plugins
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
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
nmap <Leader>vq :VimuxCloseRunner<CR>
nmap <Leader>vl :VimuxRunLastCommand<CR>
nmap <Leader>vx :VimuxInterruptRunner<CR>
nmap <Leader>vz :call VimuxZoomRunner()<CR>

"============= File Settings =====================
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead CMake* set filetype=cmake

"============ Autocompletion ===================
" call deoplete#custom#option('sources', { '_': ['ale', 'around'] })
call deoplete#custom#option('auto_complete_delay', 200)
call deoplete#custom#option('ignore_case', v:true)
call deoplete#custom#option('min_pattern_length', 3)
call deoplete#custom#source('_', 'min_pattern_length', 3)

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
set omnifunc=ale#completion#OmniFunc
nmap , <Plug>(ale_detail)
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '%linter% says %s'
highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_javascript_eslint_use_global = 1
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_c_clang_options = '-std=c11 -Wall -I ./build/lib/installed/include'
let g:ale_c_gcc_options = '-std=c11 -Wall -I ./build/lib/installed/include'
let g:ale_cpp_clang_options = '-std=c++11 -Wall -I ./build/lib/installed/include'
let g:ale_cpp_gcc_options = '-std=c++11 -Wall -I ./build/lib/installed/include'
let g:ale_sign_warning = '?' " could use emoji
let g:ale_sign_error = 'X' " could use emoji
let g:ale_completion_enabled = 0
let g:ale_linters = {
\   'go': ['gobuild', 'golangci-lint', 'golint', 'gotype', 'gopls'],
\   'javascript': ['eslint', 'tsserver', 'flow-language-server'],
\   'haskell': ['ghc', 'cabal-ghc', 'stack-ghc', 'hie', 'hlint', 'stack-build']
\}
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
