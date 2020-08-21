set number
set ignorecase
set smartcase
set wrapscan
set incsearch
set inccommand=split
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab
set shiftround
set clipboard+=unnamed,unnamedplus
set wildmode=longest,full

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

nnoremap <Bar> $:let pos = getpos(".")<CR>:join<CR>:call setpos('.', pos)<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

set helplang=ja

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


