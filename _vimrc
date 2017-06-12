" set vim home
:let $VIM_HOME="D:/Program Files (x86)/Vim"
" set vim runtime
:let $VIMRUNTIME="D:/Program Files (x86)/Vim/vim80"
syntax enable
syntax on
colorscheme desert
set ts=4
set sw=4
set expandtab
set nu
set noswapfile
set nobackup
" sovle file garbled
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set encoding=utf-8
" sovle windos UI garbled
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$VIM_HOME/vimfiles/bundle/Vundle.vim
call vundle#begin('$VIM_HOME/vimfiles/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
"Plugin 'ervandew/supertab'

"Plugin 'Valloric/YouCompleteMe'
Plugin 'Rip-Rip/clang_complete'

Plugin 'scrooloose/nerdtree'
"Plugin 'maksimr/vim-jsbeautify'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/syntastic'

" mark down plugin
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" markdown instant
" Plugin 'suan/vim-instant-markdown'
" markdown instant
" Plugin 'isnowfy/python-vim-instant-markdown'
Plugin 'JamshedVesuna/vim-markdown-preview'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" when leave or moved close scratch info
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
:nmap <C-n> :lne <CR>
:nmap <C-p> :lp <CR>


" deal chinese,should pass ensure_ascii=False in json.dump function
:command JSON %!python -m json.my-tool
:command JAVAC !javac %:p<cr>
:command FIREFOX silent !start D:\Program Files (x86)\Mozilla Firefox\firefox.exe %:p<cr>
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction
