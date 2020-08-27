syntax on
set tabstop=4
set shiftwidth=4
set noexpandtab
set number
set cursorline

call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'whatyouhide/vim-gotham'

call plug#end()

" set colorscheme
colorscheme gotham

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


map <C-n> :NERDTreeToggle<CR>

