let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let mapleader = " "
" Swap ; and : in Normal and Visual modes
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
inoremap <silent><expr> <CR>
      \ pumvisible() ? coc#pum#confirm() : "\<CR>"
nnoremap <Leader>f :Autoformat<CR>

" Use 2 spaces for indentation
set expandtab       " Convert tabs to spaces
set tabstop=2       " Number of spaces that a <Tab> in the file counts for
set shiftwidth=2    " Number of spaces to use for each step of (auto)indent
set softtabstop=2   " Number of spaces that a <Tab> counts for while performing editing operations
set autoindent      " Copy indent from current line when starting a new line

" Enable relative line numbers
set number          " Show absolute line number for the current line
set relativenumber  " Show relative line numbers for other lines

set clipboard=unnamed

" Treat .tsx as TSX/React
augroup filetypedetect
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
augroup END

call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'tmsvg/pear-tree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Vim Git integration
Plug 'tpope/vim-fugitive'
" Custom dashboard
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-commentary'
Plug 'Chiel92/vim-autoformat'
Plug 'fannheyward/coc-pyright'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
Plug 'ku1ik/vim-monokai'
Plug 'NLKNguyen/papercolor-theme'

call plug#end()

colorscheme PaperColor
" colorscheme monokai
" colorscheme gruvbox
set background=light

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight EndOfBuffer ctermbg=none
highlight VertSplit ctermbg=none
highlight StatusLine ctermbg=none
highlight LineNr ctermbg=none
highlight SignColumn ctermbg=none
highlight CursorLineNr ctermbg=none
highlight CursorColumn ctermbg=none
highlight Search ctermbg=none 


nnoremap <leader>/ :Commentary<CR>
xnoremap <leader>/ :Commentary<CR>

inoremap <silent><expr> <Tab>
      \ pumvisible() ? coc#pum#confirm() : "\<Tab>"

let g:autoformat_autoindent = 1
let g:autoformat_retab = 1
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_black = 1

" Enable pear-tree
let g:pear_tree_enabled = 1

" Define custom pairs
let g:pear_tree_pairs = {
      \ '(': {'closer': ')'},
      \ '[': {'closer': ']'},
      \ '{': {'closer': '}'},
      \ '"': {'closer': '"'},
      \ "'": {'closer': "'"},
      \ }

" Enable smart pairing
let g:pear_tree_smart = 1

" Enable dot-repeatable expansion
let g:pear_tree_repeatable_expand = 1

let g:ascii_art = [
      \' ▄   ▄ ▄ ▄▄▄▄▄ ',
      \' ▀▄ ▄▀ █ █ █ █ ',
      \'  █▄█  █ █ █ █ ',
      \'   █   █ █ █ █ ',
      \ ]
let g:startify_custom_header = startify#pad(g:ascii_art)
let g:startify_lists = [
      \ { 'type': 'files',     'header': ['   Recent Files']       },
      \ { 'type': 'sessions',  'header': ['   Sessions']           },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']          },
      \ ]
let g:startify_bookmarks = [
      \ { 'v': '~/.vimrc' },
      \ { 'z': '~/.zshrc' },
      \]
