syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set softtabstop=0
set number
set relativenumber
set clipboard=unnamedplus
set showmatch
set noswapfile
set nomodeline
set autowrite
set title
set numberwidth=1
set ignorecase
set wildmode=longest:full,full
set wildignorecase
set fileignorecase
set noswapfile
set lazyredraw

call plug#begin('~/.config/nvim/plugged')

Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'dylanaraps/wal.vim'

call plug#end()

" lsp settings
let g:lsp_settings = {
\ 'clangd': {'cmd' : ['clangd']}
\}
" tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" save using shift+w
nnoremap <S-w> :w<CR>

" set colorscheme
colorscheme wal
set cursorline
hi CursorLine cterm=NONE ctermbg=black ctermfg=magenta
hi StatusLine ctermbg=black ctermfg=magenta
hi Pmenu ctermbg=red ctermfg=black
hi PmenuSel ctermbg=magenta ctermfg=black
hi TabLine ctermbg=black ctermfg=white
hi TabLineFill ctermbg=black ctermfg=black cterm=bold term=bold
hi TabLineSel ctermbg=black ctermfg=red

" switching tabs
" Enter command-line mode fast
nnoremap ; :
vnoremap ; :

" file explorer configuration
nmap <Tab> :Lexplore<CR>
let g:netrw_liststyle = 3 " use third view
let g:netrw_banner = 0 " hide banner
let g:netrw_browse_split = 3 " open files in new tab
let g:netrw_winsize = 20 " occupy 20% of the screen

let g:startify_custom_header = [
\ '       _                 _       _             _ _       ',
\ '__   _(_)___ _   _  __ _| |  ___| |_ _   _  __| (_) ___  ',
\ '\ \ / / / __| | | |/ _` | | / __| __| | | |/ _` | |/ _ \ ',
\ ' \ V /| \__ \ |_| | (_| | | \__ \ |_| |_| | (_| | | (_) |',
\ '  \_/ |_|___/\__,_|\__,_|_| |___/\__|\__,_|\__,_|_|\___/ ',
\ '                                                         ',
\ '               _                                         ',
\ '  ___ ___   __| | ___                                    ',
\ ' / __/ _ \ / _` |/ _ \                                   ',
\ '| (_| (_) | (_| |  __/                                   ',
\ ' \___\___/ \__,_|\___|                                   ',
\ ]

" functions
source ~/.config/nvim/functions.vim
