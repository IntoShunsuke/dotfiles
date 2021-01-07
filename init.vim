" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" Display settings
set list
set number
set wrapscan
set textwidth=0
set t_vb=
set novisualbell
set smarttab
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" search settings
set ignorecase
set smartcase
set incsearch
set hlsearch
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" editing settings
set shiftround
set infercase
set virtualedit=all
set hidden
set switchbuf=useopen
set showmatch
set matchpairs& matchpairs+=<:>
set backspace=indent,eol,start
if has('unnamedplus')
  set clipboard& clipboard^=unnamedplus,unnamed 
else
  set clipboard& clipboard^=unnamed
endif
set nowritebackup
set nobackup
set noswapfile
set autoindent
set smartindent
set shiftwidth=2
set softtabstop=2
set expandtab
set wildmode=full

" macro and key settings
nnoremap <F3> :set hlsearch!<CR>

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
vnoremap <C-d> <C-d>zz
vnoremap <C-u> <C-u>zz

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

inoremap <silent> jj <ESC>

" 空行の挿入
noremap O :<C-u>call append(expand('.'), '')<Cr>j

inoremap <C-a> <C-o>^
inoremap <C-s> <C-o>$

noremap ; :
noremap : ;

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" syntax settings
autocmd BufRead,BufNewFile *.vh setf verilog

function! ExecExCommand(cmd)
  silent exec a:cmd
  return ''
endfunction
inoremap <silent> <expr> <C-p> "<C-r>=ExecExCommand('normal k')<CR>"
inoremap <silent> <expr> <C-n> "<C-r>=ExecExCommand('normal j')<CR>"

" Enable 256 colors FORCELY on screen
if $TERM == 'screen'
    set t_Co=256
endif

set helplang=ja

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

noremap <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
noremap <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
noremap <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
noremap <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

" Use deoplete
let g:deoplete#enable_at_startup = 1

" dein settings
if &compatible
  set nocompatible
endif
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  if !has('nvim')
    execute 'cd ~/.cache/dein/repos/github.com/Shougo/dein.vim'
    execute '!git checkout 1.0'
  endif
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 補完ウィンドウの設定
set completeopt=menuone

" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'

" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_enable_camel_case_completion  =  1

" 最初の補完候補を選択状態にする
let g:neocomplcache_enable_auto_select = 1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

" 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" neocomplete/neosnippet settings
let g:neosnippet#snippets_directory = '~/.config/nvim/snippets/'

syntax on

if has('nvim')
  if isdirectory( $PYENV_ROOT."/versions/nvim-python2" )
    let g:python_host_prog = $PYENV_ROOT.'/versions/nvim-python2/bin/python'
  endif
  if isdirectory( $PYENV_ROOT."/versions/nvim-python3" )
    let g:python3_host_prog = $PYENV_ROOT.'/versions/nvim-python3/bin/python'
  endif
  set inccommand=split
 " 下部分にターミナルウィンドウを設置
  function! Myterm()
    split
    wincmd j
    resize 5 
    terminal
    wincmd k
  endfunction
  command! Myterm call Myterm()
  
  " 起動時にターミナルウィンドウを設置
  "if has('vim_starting')
  " Myterm
  "endif
  
  "上のエディタウィンドウと下のターミナルウィンドウ(ターミナル挿入モード)を行き来
  tnoremap <C-t> <C-\><C-n><C-w>k
  nnoremap <C-t> <C-w>ji
  "ターミナル挿入モードからターミナルモードへ以降
  tnoremap <Esc> <C-\><C-n>

endif


