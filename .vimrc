" This file may be copied to personal home directory such as /home/wcl

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif
set encoding=utf-8

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
    " set mouse=iv  " 在 insert 和 visual 模式使用鼠标定位
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

nnoremap H ^
nnoremap L $

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
au FileType go nmap gi <Plug>(go-imports)<Plug>(go-fmt)
au FileType go nmap gl <Plug>(go-iferr)
au FileType go nmap gc :GoCallees<CR>
au FileType go nmap gr :GoReferrers<CR>
au FileType go nmap gf :GoFillStruct<CR>
au FileType go nmap gv :GoVet<CR>

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_function_calls= 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_build_constraints = 1
let g:go_fmt_fail_silently = 1  " 退出时如果语法出错不提醒
let g:go_fmt_autosave = 0       " 保存时不自动执行gofmt
let g:go_imports_autosave = 0
let g:go_mod_fmt_autosave = 0
let g:go_metalinter_autosave = 0
let g:go_def_mode='gopls'
let g:go_fmt_command='gofmt'
let g:go_metalinter_command = "golangci-lint run"
let g:go_metalinter_enabled=[]
set completeopt-=preview

" key-bind for rust
au FileType rust nmap gi :RustFmt<CR>
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap <leader>t <Plug>(rust-def-tab)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
au FileType rust nmap <leader>r :RustRun<CR>

let g:racer_experimental_completer = 1

" key-bind for jq(should install jq first)
au FileType json nmap gi :%!jq .<CR>

" terminal
nnoremap gT :term go test -v --cover ./...<CR>
nnoremap <leader>p :terminal<CR>

nnoremap <leader>ff :syntax off<CR>
nnoremap <leader>FF :syntax on<CR>

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

" tpope/vim-fugitive
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gc :Gcommit<CR>
nnoremap <silent> <Leader>gb :Git blame<CR>
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
let g:ctrlp_mruf_max            = 1000
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
nnoremap <Leader>s :execute 'silent! write !sudo tee % >/dev/null' <bar> edit!<CR>

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
nmap <c-k> <Plug>(easymotion-overwin-line)
nmap J <Plug>(easymotion-overwin-w)

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

let g:syntastic_javascript_checkers = ['jshint']

" vim-json
let g:vim_json_syntax_conceal = 0

" vim-jsbeautify
autocmd FileType javascript noremap <silent> <Leader>f :call JsBeautify()<CR>
autocmd FileType html noremap <silent> <Leader>f :call HtmlBeautify()<CR>
autocmd FileType css noremap <silent> <Leader>f :call CSSBeautify()<CR>

" yaml special config
autocmd FileType yaml set sw=2 ts=2

" toml special config
autocmd FileType toml set sw=2 ts=2

" vue special config
autocmd FileType typescript set sw=2 sts=2
autocmd FileType vue set sw=2 sts=2

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" 窗口管理器
Plug 'vim-scripts/winmanager'
" 标签工具
Plug 'vim-scripts/Visual-Mark'
" 代码补全工具
"Plug 'vim-scripts/neocomplcache'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
" golang插件
Plug 'fatih/vim-go'
" rust 插件
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
" ack搜索
Plug 'mileszs/ack.vim'
" 快速文件打开工具
Plug 'ctrlpvim/ctrlp.vim'
" markdown
Plug 'tpope/vim-markdown'
" 和 taglist 类似
Plug 'majutsushi/tagbar'
" 目录显示
Plug 'scrooloose/nerdtree'
" markdown toc
Plug 'mzlogin/vim-markdown-toc'
" git
Plug 'tpope/vim-fugitive'
" undo窗口
Plug 'mbbill/undotree'
" 快捷操作 surround
Plug 'tpope/vim-surround'
" 代码注释
Plug 'scrooloose/nerdcommenter'
" 快速跳转
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'elzr/vim-json'
Plug 'cespare/vim-toml'
Plug 'vim-scripts/yaml.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'kchmck/vim-coffee-script'
" Github copilot
Plug 'github/copilot.vim'

call plug#end()

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

if &diff
    highlight DiffAdd    cterm=bold ctermfg=1 ctermbg=0 gui=none guifg=bg guibg=Red
    highlight DiffDelete cterm=bold ctermfg=0 ctermbg=0 gui=none guifg=bg guibg=Red
    highlight DiffChange cterm=bold ctermfg=2 ctermbg=0 gui=none guifg=bg guibg=Red
    highlight DiffText   cterm=bold ctermfg=3 ctermbg=0 gui=none guifg=bg guibg=Red
endif
