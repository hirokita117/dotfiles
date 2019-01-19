"Linux用の.vimrc


nnoremap <silent><C-e> :NERDTreeToggle<CR>

inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <silent> <C-u> <Esc>^<Insert>
inoremap <silent> <C-p> <Esc>$<Insert><Right>

noremap <C-h> 0
noremap <C-l> $
inoremap <C-f> <Esc>
vnoremap <C-f> <Esc>

syntax on
colorscheme molokai
set t_Co=256

set clipboard=unnamed,autoselect

set number  "行番号の表示 :set nonumber で非表示
set ruler "右下に行・列の番号を表示"
set title
set showmatch  "対応する括弧を強調表示
set cursorcolumn "カーソル列の背景を変更"
set cursorline  "カーソル行の背景を変更
set whichwrap=b,s,h,l,<,>,[,]  "行頭行末の左右移動で行をまたぐ
set backspace=indent,eol,start "バックスペースの有効化
set noswapfile " ファイル編集中にスワップファイルを作らない
set ambiwidth=double " □や○文字が崩れる問題を解決 "
"set mouse=a "マウス操作オン
set clipboard=unnamed,autoselect "クリップボードにコピー
set wildmenu " コマンドモードの補完 "
set laststatus=2

set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
" ESCキー2度押しでハイライトの切り替え
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>

" インデント
set shiftwidth=2
set softtabstop=2
set tabstop=2
"set expandtab
set autoindent
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する

set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲

set wildmenu
set history=5000

if &term =~ "xterm"
      let &t_SI .= "\e[?2004h"
      let &t_EI .= "\e[?2004l"
      let &pastetoggle = "\e[201~"

      function XTermPasteBegin(ret)
         set paste
         return a:ret
      endfunction

      inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif



if has('vim_starting')
    " 初回起動時のみruntimepathにNeoBundleのパスを指定する
    set runtimepath+=~/.vim/bundle/neobundle.vim/

    " NeoBundleが未インストールであればgit cloneする・・・・・・①
    if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
nnoremap <silent><C-n> :VimFiler<CR>
        echo "install NeoBundle..."
        :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
    endif
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" インストールするVimプラグインを以下に記述
" NeoBundle自身を管理
NeoBundleFetch 'Shougo/neobundle.vim'
"----------------------------------------------------------
" ここに追加したいVimプラグインを記述する・・・・・・②

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tacahiroy/ctrlp-funky'

"----------------------------------------------------------
call neobundle#end()

" ファイルタイプ別のVimプラグイン/インデントを有効にする
filetype plugin indent on

" 未インストールのVimプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定・・・・・・③
NeoBundleCheck

let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用

" CtrlPCommandLineの有効化
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

" CtrlPFunkyの有効化
let g:ctrlp_funky_matchtype = 'path'
