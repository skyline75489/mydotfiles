" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


set nobackup		" do not keep a backup file, use versions instead
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
set hlsearch

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  "Set python auto complete"
  filetype plugin on

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
"Look and Feel
set number
set cursorline
set tabstop=8
set expandtab
syntax on
if exists('+termguicolors')
  if !has('nvim') " ------- Vim8
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  endif
  " ------- Vim8.0 & NVim
  set termguicolors
endif

set nobackup

set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936

set laststatus=2

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


if exists("g:loaded_bracketed_paste")
  finish
endif
let g:loaded_bracketed_paste = 1

let &t_ti .= "\<Esc>[?2004h"
let &t_te = "\e[?2004l" . &t_te

function! XTermPasteBegin(ret)
  set pastetoggle=<f29>
  set paste
  return a:ret
endfunction

execute "set <f28>=\<Esc>[200~"
execute "set <f29>=\<Esc>[201~"
map <expr> <f28> XTermPasteBegin("i")
imap <expr> <f28> XTermPasteBegin("")
vmap <expr> <f28> XTermPasteBegin("c")
cmap <f28> <nop>
cmap <f29> <nop>

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

