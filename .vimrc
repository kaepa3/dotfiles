" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  
 " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

 " nerdtreeのインストール
call dein#add('scrooloose/nerdtree')


if has('job') && has('channel') && has('timers')
  call dein#add('w0rp/ale')
else
  call dein#add('vim-syntastic/syntastic')
endif

"
set number
"
syntax on
" 
set hlsearch
" 行末のスペースを可視化
set listchars=tab:^\ ,trail:~


set expandtab
set tabstop=4
set shiftwidth=4
set smartindent
set title
set showmatch

set wildmenu

" 保存時のみ実行する
let g:ale_lint_on_text_changed = 0
" 表示に関する設定
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" カレント行ハイライト
set cursorline

" マウス有効
set mouse=a

" インデント設定
filetype plugin indent on

"JSの整形
if executable('js-beautify')
  command! -range=% -nargs=* HTMLTidy <line1>,<line2>call RangeHtmlBeautify()
  command! -range=% -nargs=* JSTidy <line1>,<line2>call RangeJsBeautify()
  command! -range=% -nargs=* CSSTidy <line1>,<line2>call RangeCSSBeautify()
  command! -range=% -nargs=* JSONTidy <line1>,<line2>call RangeJsonBeautify()
endif
" ale_lint
let g:ale_lint_on_text_changed = 0
let g:ale_linters = {
    \ 'javascript': ['eslint'],
    \ }
"====================neocomplcache====================
" ~Disable AutoComplPop. neocomplcashe~
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }
    
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" nerdtree
autocmd VimEnter * execute 'NERDTree' 
autocmd VimEnter * wincmd p 
