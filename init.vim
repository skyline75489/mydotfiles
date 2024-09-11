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
