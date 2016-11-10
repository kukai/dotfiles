" vim-plug {{{
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/denite.nvim'
Plug 'Shougo/neoyank.vim'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-surround'
Plug 'majutsushi/tagbar'
Plug 'szw/vim-tags'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'tomtom/tcomment_vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml'
Plug 'fatih/vim-go'
Plug 'itchyny/lightline.vim'
Plug 'rhysd/vim-gfm-syntax'
Plug 'scrooloose/syntastic'
Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8'

" Add plugins to &runtimepath
call plug#end()
" }}}

" denite {{{
nnoremap <silent> <C-k><C-f> :<C-u>Denite file_rec<CR>
nnoremap <silent> <C-k><C-g> :<C-u>Denite grep<CR>
nnoremap <silent> <C-k><C-l> :<C-u>Denite line<CR>
nnoremap <silent> <C-k><C-m> :<C-u>Denite file_mru<CR>
nnoremap <silent> <C-k><C-y> :<C-u>Denite neoyank<CR>

call denite#custom#map('_', "\<C-n>", 'move_to_next_line')
call denite#custom#map('_', "\<C-p>", 'move_to_prev_line')
" }}}

" deoplete {{{
" Use deoplete.
let g:deoplete#enable_at_startup = 1
" }}}

" tagbar {{{
nmap <F8> :TagbarToggle<CR>
" }}}

" vim-tags {{{
let g:vim_tags_auto_generate = 1
" }}}

" NERDTree {{{
" NERDTreeを表示するコマンドを設定する
map <F1> :NERDTreeToggle<CR>
" }}}

" indentLine {{{
let g:indentLine_color_term = 239
" }}}

" vim-go {{{
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_functions = 1
let g:go_highlight_build_constraints = 1

let g:go_fmt_command = "goimports"
" }}}

" tab設定 {{{
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
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
" }}}

" lightline {{{
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'component': {
  \   'readonly': '%{&readonly?"⭤":""}',
  \ },
  \ 'separator': { 'left': '⮀', 'right': '⮂' },
  \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
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

" Neovim {{{
" クリップボード共有
set clipboard+=unnamedplus

" }}}

" 見た目 {{{
syntax on
set background=dark
colorscheme solarized
" }}}

" Golang Tab setting {{{
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal shiftwidth=4
" }}}

" Ruby, HTML, JS {{{
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
" }}}

" Python {{{
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
" }}}


" その他 {{{
" スワップファイルを使わない
set noswapfile
" vimの改行時に自動でコメントが挿入されるのをやめたい
autocmd FileType * setlocal formatoptions-=ro
" 80文字
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=0
endif
" tabの表示
set list
set listchars=tab:>-,trail:.
" :terminal ESC
tnoremap <silent> <ESC> <C-\><C-n>
" }}}
