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

"========== Install Vim-plug if not found ==============''
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"============ Vim Plugs ============
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction
function! BuildTern(info)
  if a:info.status == 'installed' || a:info.force
    !npm install
  endif
endfunction
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
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'majutsushi/tagbar'
Plug 'sheerun/vim-polyglot'
Plug 'skywind3000/asyncrun.vim'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'Yggdroot/indentLine'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'
Plug 'tpope/vim-dispatch'
Plug 'benmills/vimux'
Plug 'morhetz/gruvbox'
Plug 'airblade/vim-rooter'
Plug 'tfnico/vim-gradle'
Plug 'lifepillar/vim-gruvbox8'

"Deoplete Completion
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc', { 'do': function('InstallPynVim') }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': 'javascript' }
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
let g:python3_host_prog = "/usr/local/bin/python3"
let g:deoplete#enable_at_startup = 1
set runtimepath+=$HOME/.vim/plugged/deoplete.nvim

"YCM Completion (only for C, C++ files)
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM'), 'for': ['c', 'cpp'] }

"Language Plugins
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'marijnh/tern_for_vim', { 'do': function('BuildTern'), 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mattn/emmet-vim', { 'for': 'html' }
Plug 'purescript-contrib/purescript-vim', { 'for': 'purescript' }
Plug 'frigoeu/psc-ide-vim', { 'for': 'purescript'}
Plug 'flowtype/vim-flow', { 'for': 'javascript' }
Plug 'keith/swift.vim', { 'for': 'swift' }
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
Plug 'tomlion/vim-solidity', { 'for': 'solidity' }
Plug 'pboettch/vim-cmake-syntax', { 'for': 'cmake' }
Plug 'eagletmt/ghcmod-vim', {'for': 'haskell'}
Plug 'eagletmt/neco-ghc', {'for': 'haskell'}
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'vim-jp/vim-java', { 'for': 'java' }
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

"ALE DETAIL
nmap , <Plug>(ale_detail)
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>EasyMotion
nmap F <Plug>(easymotion-overwin-w)
"NerdTrees
nmap > :NERDTreeFocus<CR>
nmap < :NERDTreeClose<CR>
"TagBar
nmap <F7> :TagbarToggle<CR>
" Opens a new tab with the current buffer's path
nmap :tn :tabnew<CR>
" use visual-block instead of visual as default, vv will enter visual mode
nnoremap v <C-v>

"================= Vimux================================="
" run rspec
nmap <Leader>rb :call VimuxRunCommand("clear; ~/.rbenv/shims/bundle exec rspec " . bufname("%"))<CR>
" run rspec line
nmap <Leader>rbl :call VimuxRunCommand("clear; ~/.rbenv/shims/bundle exec rspec " . bufname("%") . ":" . line("."))<CR>


nmap <Leader>vq :VimuxCloseRunner<CR>
nmap <Leader>vl :VimuxRunLastCommand<CR>
nmap <Leader>vx :VimuxInterruptRunner<CR>
nmap <Leader>vz :call VimuxZoomRunner()<CR>

nnoremap <leader>. :CtrlPTag<cr>

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


"============= File Settings =====================
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead CMake* set filetype=cmake


"============ Autocompletion ===================
set omnifunc=syntaxcomplete#Complete

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_cache_omnifunc = 0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

call deoplete#custom#option({
\ 'auto_complete_delay': 200,
\ 'ignore_case': v:true,
\ 'min_pattern_length': 2
\ })

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

"============== Emmet-vim ====================
let g:user_emmet_install_global = 0

"============= ALE Checker =============
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

"============ Javascript Settings ===================
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:flow#enable = 0
let g:flow#omnifunc = 0
let g:tern_show_argument_hints = 'on_hold'
let g:tern_map_keys = 1

"Use locally installed flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

"============= Haskell Settings ==================
let $PATH .= (":" . $HOME . "/.local/bin")
" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
let g:haskell_tabular = 1

"===============LSP for Solargraph============"
let g:LanguageClient_autoStop = 0
let g:LanguageClient_serverCommands = {
\ 'ruby': ['tcp://localhost:7658']
\ }

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
  " Use deoplete unless its C-based, then disable
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
  autocmd FileType ruby setlocal omnifunc=LanguageClient#complete
  autocmd FileType c,cpp call deoplete#custom#option('auto_complete', v:false)
  " Return to last edit position when opening files (You want this!)
  autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
augroup end

"======= Java
let mapleader = "\<Space>" 
nmap <Leader>jl :call JDBBreak()<CR>
nmap <Leader>jr :call VimuxRunCommand('run;')<CR>
nmap <Leader>jdb :call StartJDB()<CR>
nmap <Leader>ex :call VimuxRunCommand('exit;')<CR>
function JDBBreak()
  if exists('g:JavaComplete_Autoload')
      " run jdb 
      let line = line(".")
      let class = expand('%:t:r')
      let command = "stop at " . class . ":" . line
      VimuxRunCommand(command)
  endif
endfunction
function StartJDB()
  if exists('g:JavaComplete_Autoload')
      " run jdb 
      " let classpath = expand('%:p') . '/build/classes/java/main'
      let classPathStr = javacomplete#server#GetClassPath()
      let classpath = split(classPathStr, 'CLASSPATH:')[0]
      let build = get(g:, 'Java_BuildDebugCommand', 'gradle -Ddebug=true compileJava')
      let main = expand('%:t:r')
      let runTest = "jdb -classpath " . classpath . " " . main
      let command = "clear; " . build . runTest
      VimuxRunCommand(command)
  endif
endfunction
