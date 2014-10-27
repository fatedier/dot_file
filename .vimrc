" This file may be copied to personal home directory such as /home/wcl

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" -----------个人设置-----------
filetype off 

set ts=4          " tab所占空格数
set shiftwidth=4  " 自动缩进所使用的空格数
set expandtab     " 用空格替换tab
set autoindent    " 自动缩进
set smartindent   " C语言缩进
set number        " 显示行号
set ignorecase    " 搜索忽略大小写
set incsearch     " 输入字符串就显示匹配点
set showtabline=2 " 总是显示标签页

if has("mouse")
    set mouse=iv  " 在 insert 和 visual 模式使用鼠标定位
endif

" -----------键盘映射-----------
" Ctrl+S 映射为保存
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>a

" Ctrl+C 复制，Ctrl+V 粘贴
inoremap <C-C> y
inoremap <C-V> <Esc>pa
vnoremap <C-C> y
vnoremap <C-V> p
nnoremap <C-V> p

" F3 查找当前高亮的单词
inoremap <F3> *<Esc>:noh<CR>:match Todo /\k*\%#\k*/<CR>v
vnoremap <F3> *<Esc>:noh<CR>:match Todo /\k*\%#\k*/<CR>v

" -----------插件设置----------
" ctags 生成的 tags文件的路径
set tags=/home/wcl/local/git_fatedier/faframe/tags
" winmanager 的样式设置，包括文件管理器和taglist
let g:winManagerWindowLayout='FileExplorer|TagList'
nnoremap wm :WMToggle<cr>
" cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-

" vundle 插件管理器的设置
" yum 安装 ctags cscope
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
" 显示变量、函数列表等
Bundle "taglist.vim"
" 窗口管理器
Bundle "winmanager"

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
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

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

filetype plugin on
