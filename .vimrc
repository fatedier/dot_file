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

set ts=4                " tab所占空格数
set shiftwidth=4        " 自动缩进所使用的空格数
set expandtab           " 用空格替换tab
set autoindent          " 自动缩进
set smartindent         " C语言缩进
set number              " 显示行号
set ignorecase          " 搜索忽略大小写
set incsearch           " 输入字符串就显示匹配点
set showtabline=2       " 总是显示标签页
set noswf               " 不使用交换文件
set foldmethod=marker   " 对文中的标志折叠

if has("mouse")
    set mouse=iv  " 在 insert 和 visual 模式使用鼠标定位
endif

" -------------颜色配置-------------
" 补全弹出窗口
" hi Pmenu ctermbg=lightmagenta
" 补全弹出窗口选中条目
hi PmenuSel ctermbg=yellow ctermfg=black

" -------------键盘映射-------------
" Ctrl+S 映射为保存
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>a
" Ctrl+X 映射为退出
nnoremap <C-X> :q<CR>
inoremap <C-X> <Esc>:q<CR>

" Ctrl+C 复制，Ctrl+V 粘贴
inoremap <C-C> y
inoremap <C-V> <Esc>pa
vnoremap <C-C> y
vnoremap <C-V> p
nnoremap <C-V> p

" F3 查找当前高亮的单词
inoremap <F3> *<Esc>:noh<CR>:match Todo /\k*\%#\k*/<CR>v
vnoremap <F3> *<Esc>:noh<CR>:match Todo /\k*\%#\k*/<CR>v

" F4 在paste和非paste模式之间切换
set pastetoggle=<F4>

" Ctrl+\ 取消缩进
inoremap <C-\> <Esc><<i

" 在vim中调用make进行编译，如果出错，会自动打开QuickFix窗口
nnoremap <F5> :w<CR>:make<CR><CR>:cw<CR>
nnoremap <F6> :!make clean<CR>
" 跳转到上一个或下一个错误
nnoremap <F7> :cp<CR>
nnoremap <F8> :cn<CR>

" -------------插件设置------------
" ctags 生成的 tags文件的路径
set tags+=/home/wcl/local/git_fatedier/faframe/tags

" winmanager 的样式设置，包括taglist
let g:winManagerWindowLayout='TagList'
" 设置窗口宽度
let g:winManagerWidth = 30

nnoremap <C-m> :WMToggle<cr>
" cscope
" set cscopequickfix=s-,c-,d-,i-,t-,e-
" cs add /home/wcl/local/git_fatedier/faframe/cscope.out /home/wcl/local/git_fatedier/faframe

" neocomplcache
let g:neocomplcache_enable_at_startup = 1                 " 设置为自动启用补全
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_enable_fuzzy_completion = 1

" vim-go
let g:go_highlight_trailing_whitespace_error = 0

" vundle 插件管理器的设置
" yum 安装 ctags cscope
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundles
" 显示变量、函数列表等
Bundle "taglist.vim"
" 窗口管理器
Bundle "winmanager"
" 标签工具
Bundle "Visual-Mark"
" 代码补全工具
Bundle "neocomplcache"
" golang插件
Bundle "fatih/vim-go"

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on
