syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set softtabstop=0
set number
set cursorline
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

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'whatyouhide/vim-gotham'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'

call plug#end()

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" set colorscheme and transparency
colorscheme gruvbox
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


nmap <Tab> :NERDTreeToggle<CR>
" switching tabs
nmap <C-l> :tabn<CR>
nmap <C-h> :tabp<CR>
nmap <C-n> :call OpenSelectedFile()<CR>
" Enter command-line mode fast
nnoremap ; :
vnoremap ; :


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
