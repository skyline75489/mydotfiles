set backspace=indent,eol,start
set nobackup

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

if has('mouse')
  set mouse=a
endif

set hlsearch

set number
set cursorline
set tabstop=8
set expandtab
syntax on
set autoread
set hidden
set autochdir
set lazyredraw
set clipboard=unnamedplus 

if exists('+termguicolors')
  if !has('nvim') " ------- Vim8
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  endif
  " ------- Vim8.0 & NVim
  set termguicolors
endif

set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936
set laststatus=2

if !has("win32")
  let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

call plug#begin()
  Plug 'git@github.com:dracula/vim', { 'as': 'dracula' }
  Plug 'git@github.com:preservim/nerdtree' |
            \ Plug 'git@github.com:Xuyuanp/nerdtree-git-plugin'
  Plug 'git@github.com:tpope/vim-fugitive.git'
  Plug 'git@github.com:mhinz/vim-signify.git'
  Plug 'git@github.com:junegunn/fzf.git', { 'do': { -> fzf#install() } }
  Plug 'git@github.com:junegunn/fzf.vim.git'
  Plug 'git@github.com:pacha/vem-tabline.git'
  Plug 'git@github.com:mhinz/vim-startify.git'
  Plug 'git@github.com:Yggdroot/indentLine.git'
  Plug 'git@github.com:tpope/vim-commentary.git'
call plug#end()

colorscheme dracula

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

tnoremap <Esc>    <C-\><C-n>
nnoremap <silent> <C-g>f :NERDTreeToggle<CR>

nnoremap <silent> <C-g>b :call FZFOpen(':Buffers')<CR>
nnoremap <silent> <C-g>g :call FZFOpen(':Ag')<CR>
nnoremap <silent> <C-g>c :call FZFOpen(':Commands')<CR>
nnoremap <silent> <C-g>l :call FZFOpen(':BLines')<CR>
nnoremap <silent> <C-g>p :call FZFOpen(':Files')<CR>

let g:vem_tabline_show_number = 'index'

nmap <leader>1 :VemTablineGo 1<CR>
nmap <leader>2 :VemTablineGo 2<CR>
nmap <leader>3 :VemTablineGo 3<CR>
nmap <leader>4 :VemTablineGo 4<CR>
nmap <leader>5 :VemTablineGo 5<CR>
nmap <leader>6 :VemTablineGo 6<CR>
nmap <leader>7 :VemTablineGo 7<CR>
nmap <leader>8 :VemTablineGo 8<CR>
nmap <leader>9 :VemTablineGo 9<CR>

nmap <leader>p <Plug>vem_prev_buffer-
nmap <leader>n <Plug>vem_next_buffer-

nmap <leader>x <Plug>vem_delete_buffer- :NERDTreeToggle<CR>

