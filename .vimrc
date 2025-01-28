set number

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set signcolumn=yes

set splitbelow

set encoding=UTF-8

set history=64
set undolevels=128
set undodir=~/.vim/undodir/
set undofile
set undolevels=1000
set undoreload=10000


set shell=/bin/bash
set exrc
set secure

if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()
" Основные плагины
Plug 'tpope/vim-dispatch'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'         " Для работы с git
Plug 'airblade/vim-gitgutter'    " Для отображения изменений в git

" Плагины для работы с деревом файлов
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'unkiwii/vim-nerdtree-sync'

" Плагины для поиска
Plug 'szw/vim-tags'
Plug 'ctrlpvim/ctrlp.vim'        " Для поиска по проекту
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'              " Поиск по проекту (плагин для ag)

" Плагины для улучшенной работы с текстом
Plug 'joshdick/onedark.vim'      " Тема onedark
Plug 'sheerun/vim-polyglot'      " Поддержка множества языков
Plug 'jiangmiao/auto-pairs'

" Плагины для работы с кодом
Plug 'puremourning/vimspector'   " Отладчик
Plug 'tpope/vim-commentary'      " Удобная работа с комментариями
Plug 'preservim/tagbar'          " Для работы с структурами кода
Plug 'morhetz/gruvbox'           " Тема gruvbox
Plug 'blueshirts/darcula'             " Тема darcula
Plug 'sonph/onehalf', { 'rtp': 'vim' } " Тема onehalf

" Плагины для улучшения навигации
Plug 'airblade/vim-rooter'    " Автоматический переход в корень проекта
Plug 'thaerkh/vim-workspace' " Для сохранения состояния проекта

" Плагины для выделения текста
Plug 'machakann/vim-highlightedyank' " Подсветка выделенного текста

" Статусная линия
Plug 'vim-airline/vim-airline'   " Для статуса и состояния окна
call plug#end()

syntax on
filetype plugin indent on
colorscheme onedark

if (has("termguicolors"))
set termguicolors
endif
let g:polyglot_disabled = ['java']
let g:rooter_patterns = ['.git', 'Makefile', '*.sln', 'build/env.sh', 'CMakeLists.txt']
let g:nerdtree_sync_cursorline = 1
let g:NERDTreeHighlightCursorline = 1

set completeopt=menuone,noinsert,noselect

let g:gitgutter_auto_refresh = 1

let g:workspace_autocreate = 1

let g:vim_tags_auto_generate = 1

let g:airline_theme='onedark'
" let g:onedark_termcolors=256
let g:fzf_vim = {}
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
"mappings

map <C-n> :NERDTreeToggle<CR>
nmap <leader><F5> :CocCommand java.debug.vimspector.start<CR>
nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>
"" Coc
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <silent> gd <Plug>(coc-definition)

nmap <silent> gD <Plug>(coc-declaration)

nmap <silent> gr <Plug>(coc-references)

nmap <silent> gi <Plug>(coc-implementation)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

"quickfix
nmap <leader>qf  <Plug>(coc-fix-current)
inoremap <silent><expr> <c-@> coc#refresh()
