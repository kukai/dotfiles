" vim-plug {{{
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'cocopon/iceberg.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite-outline'
Plug 'kmnk/vim-unite-giti'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'tomtom/tcomment_vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'soramugi/auto-ctags.vim'
Plug 'fatih/vim-go'
Plug 'davidhalter/jedi-vim'
Plug 'stephpy/vim-yaml'
Plug 'Yggdroot/indentLine'

call plug#end()
" }}}

" Unite {{{
"インサートモードで開始
let g:unite_enable_start_insert=1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
"ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable =1
"prefix keyの設定
nmap <Space> [unite]

"スペースキーとaキーでカレントディレクトリを表示
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"スペースキーとfキーでバッファと最近開いたファイル一覧を表示
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
"スペースキーとdキーで最近開いたディレクトリを表示
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
"スペースキーとbキーでバッファを表示
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"スペースキーとrキーでレジストリを表示
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
"スペースキーとtキーでタブを表示
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
"スペースキーとhキーでヒストリ/ヤンクを表示
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
"スペースキーとoキーでoutline
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
"スペースキーとENTERキーでfile_rec:!
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec/async:!<CR>
"unite.vimを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}
" }}}

" Syntastic {{{
" Disable automatic check at file open/close
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0
" C
let g:syntastic_c_check_header = 1
" C++
let g:syntastic_cpp_check_header = 1
" Java
let g:syntastic_java_javac_config_file_enabled = 1
let g:syntastic_java_javac_config_file = "$HOME/.syntastic_javac_config"
" Go
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
" }}}

" Tagbar {{{
nmap <F10> :TagbarToggle<CR>
" }}}

" giti {{{
let g:fugitive_git_executable = executable('hub') ? 'hub' : 'git'
nnoremap <silent>gs :Unite giti/status -horizontal<CR>
nnoremap <silent>gl :Unite giti/log -horizontal<CR>
nnoremap <silent>gs :Unite giti/status -horizontal<CR>
nnoremap <silent>gh :Unite giti/branch_all<CR>
" }}}

" whitespace {{{
" uniteでスペースが表示されるので、設定でOFFにします。
let g:extra_whitespace_ignored_filetypes = ['unite']
" }}}

" vim-go {{{
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_functions = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"
" }}}

" lightline {{{
let g:lightline = {
  \ 'colorscheme': 'iceberg',
  \ 'mode_map': {'c': 'NORMAL'},
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'modified': 'LightLineModified',
  \   'readonly': 'LightLineReadonly',
  \   'fugitive': 'LightLineFugitive',
  \   'filename': 'LightLineFilename',
  \   'fileformat': 'LightLineFileformat',
  \   'filetype': 'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode': 'LightLineMode'
  \ }
  \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
    \  &ft == 'unite' ? unite#get_status_string() :
    \  &ft == 'vimshell' ? vimshell#get_status_string() :
    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
    \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
    return fugitive#head()
  else
    return ''
  endif
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

" auto-ctags {{{
let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git', '.svn']
let g:auto_ctags_tags_name = 'tags'
let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes'
set tags+=.git/tags
" }}}

" 見た目 {{{
syntax on
set background=dark
colorscheme iceberg
" }}}

" Golang Tab setting {{{
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal shiftwidth=4
" }}}

" Ruby, HTML, JS {{{
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
" }}}

" その他 {{{
" デフォルトのタブ設定
set tabstop=2
set shiftwidth=2
set expandtab
" 行番号
set number
" スワップファイルを使わない
set noswapfile
" vimの改行時に自動でコメントが挿入されるのをやめたい
autocmd FileType * setlocal formatoptions-=ro
" 80文字
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=0
endif
" クリップボードにコピーできるようにする
set clipboard=unnamed,autoselect
" tabの表示
set list
set listchars=tab:>-,trail:.
" mouse有効
set mouse=a
set ttymouse=xterm2
" }}}
