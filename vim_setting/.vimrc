if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set tabstop=4
set shiftwidth=4
set autoindent
set ignorecase
set cindent
set nu

colo darkblue

set background=dark
set showmatch
set autowrite
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s}

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

set ts=4
set expandtab


"""""""""""""""""""""""""""""""""""""""""""""""
" taglst
"""""""""""""""""""""""""""""""""""""""""""""""
let Tlist_Ctags_Cmd='ctags'
let Tlist_Exit_OnlyWindow=1
let Tlist_Process_File_Always=1
let Tlist_Auto_Open=1

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

func SetTitle()
if &filetype == 'sh'
    call setline(1, "#!/bin/bash")
    call setline(2, "")
    call setline(2, "# chinan.hjc@taobao.com")
    call setline(3, "# Life is short, python more.")
    call setline(4, "# ")
elseif &filetype == 'python'
    call setline(1, "#!/usr/bin/env python")
    call setline(2, "# -*- coding:utf-8 -*-")
    call setline(3, "")
    call setline(4, "")
    call setline(5, '"""')
    call setline(6, "   Life's short, Python more.   ")
    call setline(7, '   bug report to chinan.hjc@taobao.com.')
    call setline(8, '"""')
    call setline(9, '')
    call setline(10, 'import os')
    call setline(11, 'import sys')
endif
endfunc
 
autocmd BufNewFile *.php,*.pl,*.py,*.[ch],*.py,*.sh,*.java exec ":call SetTitle()"

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936


"setlocal omnifunc=javacomplete#Complete 
"autocmd Filetype java set omnifunc=javacomplete#Complete 
"autocmd Filetype java set completefunc=javacomplete#CompleteParamsInf
inoremap <buffer> <C-X><C-U> <C-X><C-U><C-P> 
inoremap <buffer> <C-S-Space> <C-X><C-U><C-P>
autocmd Filetype java,javascript,jsp inoremap <buffer>  .  .<C-X><C-O><C-P>


set paste
