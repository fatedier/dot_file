" This file may be copied to personal home directory such as /home/wcl

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"500	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" -----------个人设置-----------
filetype off 

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

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

" 行号显示
nnoremap <silent> mu :set nonu<CR>
nnoremap <silent> mi :set nu<CR>

" tab 操作
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-h> :tabprev<CR>
for n in range(1,9)
    execute 'nnoremap <silent> <C-n>'.n ':tabnext '.n.'<CR>'
endfor

" 全文 tab 转 空格
nnoremap <silent> ts :%ret!<CR>

" change mapleader
let mapleader = ","

" 将当前 QuickFix中的文件在新的 tab 页中打开
nnoremap <C-t>t  <C-W><CR><C-W>T
" 将当前 QuickFix中的文件在新的窗口中以水平分隔的方式打开
nnoremap <C-t>v <C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t

" key-bind for go
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>d <Plug>(go-def-vertical)
au FileType go nmap <Leader>t <Plug>(go-def-tab)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap gt <Plug>(go-test)
au FileType go nmap gi :GoImports<CR>
au FileType go nmap gl :GoMetaLinter<CR>
au FileType go nmap gc :GoCallees<CR>
au FileType go nmap gr :GoReferrers<CR>

" -------------插件设置------------
" winmanager 的样式设置，包括taglist
let g:winManagerWindowLayout='NERDTree|Tagbar'
" 设置窗口宽度
let g:winManagerWidth = 30

nnoremap <Leader>m :WMToggle<CR>

let g:Tagbar_title = "[Tagbar]"
function! Tagbar_Start()
    exe 'q'
    exe 'TagbarOpen'
endfunction

function! Tagbar_IsValid()
    return 1
endfunction

let g:NERDTree_title = "[NERDTree]"
function! NERDTree_Start()  
    exe 'q'
    exec 'NERDTree'  
endfunction

function! NERDTree_IsValid()  
    return 1  
endfunction

" Visual-Mark
" 下一个标签
nmap mn <F2>
" 上一个标签
nmap mp <S-F2>

" neocomplcache
let g:neocomplcache_enable_at_startup = 1                 " 设置为自动启用补全
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_enable_fuzzy_completion = 1

" Shougo/neosnippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_function_calls= 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_fmt_fail_silently = 1  " 退出时如果语法出错不提醒
let g:go_fmt_autosave = 0       " 保存时不自动执行gofmt

" tpope/vim-fugitive
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>
nnoremap <silent> <Leader>gl :Glog<CR>
nnoremap <silent> <Leader>gp :Git push<CR>

" gocode
imap <C-o> <C-x><C-o>

" let ag instead of ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
nnoremap <Leader>a :Ack!<Space>

" ctrlp
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_mruf_max            = 500
let g:ctrlp_custom_ignore = 'DS_Store\|\.git\|\.hg\|\.svn\|optimized\|compiled\|node_modules\|bower_components'
let g:ctrlp_open_new_file       = 1

" tagbar
nnoremap <silent> <Leader>w :TagbarToggle<CR>

" nerdtree
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

" vim-markdown-toc
let g:vmt_auto_update_on_save = 0

" SudoEdit
nnoremap <Leader>s :SudoWrite<CR>

" undotree
nnoremap <silent><Leader>u :UndotreeToggle<CR>

" easymotion/vim-easymotion
" 忽略搜索大小写
let g:EasyMotion_smartcase = 1
" 快速搜索前两个字符
nmap s <Plug>(easymotion-overwin-f2)
" 搜索多个字符
map  \ <Plug>(easymotion-sn)
omap \ <Plug>(easymotion-tn)
" 跨窗口搜索行
nmap <c-l> <Plug>(easymotion-overwin-line)
nmap J <Plug>(easymotion-overwin-w)

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

let g:syntastic_javascript_checkers = ['jshint']

" vim-jsbeautify
autocmd FileType javascript noremap <silent> <Leader>f :call JsBeautify()<CR>
autocmd FileType html noremap <silent> <Leader>f :call HtmlBeautify()<CR>
autocmd FileType css noremap <silent> <Leader>f :call CSSBeautify()<CR>

" vundle 插件管理器的设置
autocmd FileType yaml set sw=2 ts=2

" vundle 插件管理器的设置
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
" Vundle
Plugin 'VundleVim/Vundle.vim'
" 窗口管理器
Plugin 'winmanager'
" 标签工具
Plugin 'Visual-Mark'
" 代码补全工具
Plugin 'neocomplcache'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
" golang插件
Plugin 'fatih/vim-go'
" ack搜索
Plugin 'mileszs/ack.vim'
" 快速文件打开工具
Plugin 'ctrlpvim/ctrlp.vim'
" markdown
Plugin 'tpope/vim-markdown'
" go autocompletion
Plugin 'nsf/gocode', {'rtp': 'vim/'}
" 和 taglist 类似
Plugin 'majutsushi/tagbar'
" 目录显示
Plugin 'scrooloose/nerdtree'
" markdown toc
Plugin 'mzlogin/vim-markdown-toc'
" git
Plugin 'tpope/vim-fugitive'
" sudo
Plugin 'chrisbra/SudoEdit.vim'
" undo窗口
Plugin 'mbbill/undotree'
" 快捷操作 surround
Plugin 'tpope/vim-surround'
" 代码注释
Plugin 'scrooloose/nerdcommenter'
" 快速跳转
Plugin 'easymotion/vim-easymotion'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'

Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'elzr/vim-json'
Plugin 'cespare/vim-toml'
Plugin 'yaml.vim'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'kchmck/vim-coffee-script'

call vundle#end()

" 插件按键说明

" vim-markdown-toc
" :GenTocGFM 生成 markdown toc

" tpope/vim-fugitive
" :Gdiff
" :Gstatus
" :Gblame

" vim-surround
" cs"' 去掉" 添加'
" cst" 还原回两边的 "
" ds" 去掉两边的 "
" ysiw" 给一个单词两边加 "
" yss" 给整行两边加 "

" scrooloose/nerdcommenter
" <leader>cc 添加注释
" <leader>c<Space> 未添加注释时添加，已添加取消，会给每一行添加注释
" <Leader>cm 使用多行注释

" vim-go
" K 查看函数或变量原型以及 godoc

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on
