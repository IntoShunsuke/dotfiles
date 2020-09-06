set number
set ignorecase
set smartcase
set wrapscan
set autoindent
set smartindent
set showmatch
set incsearch
set inccommand=split
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set listchars=tab:>-,trail:-
set list
set shiftround
set clipboard+=unnamed,unnamedplus
set wildmode=longest,full

augroup MyAutoCmd
  autocmd!
augroup END

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap <Bar> $:let pos = getpos(".")<CR>:join<CR>:call setpos('.', pos)<CR>

nnoremap <F3> :set hlsearch!<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-H> <C-w>H
nnoremap <C-J> <C-w>J
nnoremap <C-K> <C-w>K
nnoremap <C-L> <C-w>L
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

set helplang=ja

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

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

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

syntax on


