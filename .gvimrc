  source $VIMRUNTIME/delmenu.vim
  source $VIMRUNTIME/menu.vim
  language messages zh_CN.utf-8

  if has("gui_gtk2")
    set guifont=Inconsolata\ 12
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
