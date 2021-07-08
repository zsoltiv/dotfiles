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
set mouse=a

" disable folding because it's annoying
let g:lsp_fold_enabled = 0

call plug#begin('~/.config/nvim/plugged')

Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'https://gitlab.com/zsoltiv/snippet2code.git'
Plug 'itchyny/lightline.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'alaviss/nim.nvim'
Plug 'morhetz/gruvbox'

call plug#end()

" enable filetype plugins
filetype plugin on

" lsp settings
let g:lsp_settings = {
\ 'clangd': {'cmd' : ['clangd']}
\}
set foldmethod=expr
    \ foldexpr=lsp#ui#vim#folding#foldexpr()
    \ foldtext=lsp#ui#vim#folding#foldtext()
" tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" save using shift+w
nnoremap <S-w> :w<CR>

" set colorscheme
colorscheme gruvbox
set cursorline

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

" snippet2code settings
let g:CodeSnippets = {
\ 'html': [
\   '<!DOCTYPE html>',
\   '<html lang="en">',
\   '<head>',
\   '    <meta charset="UTF-8">',
\   '    <meta name="viewport" content="width=device-width, initial-scale=1.0">',
\   '    <title>Document</title>',
\   '</head>',
\   '<body>',
\   '',
\   '</body>',
\   '</html>',
\ ],
\ 'mainc' : [
\   '#include <stdint.h>',
\   '',
\   'int32_t main(int32_t argc, char **argv)',
\   '{',
\   '   return 0;',
\   '}',
\ ],
\ 'makefile': [
\ 'CC=',
\ 'CFLAGS=',
\ 'LDFLAGS=',
\ '',
\ 'default: clean program',
\ '',
\ 'clean:',
\ '    rm -rf ./*.o ./program',
\ '',
\ 'OBJS=',
\ '',
\ 'program: $(OBJS)',
\ '    $(CC) $(OBJS) $(CFLAGS) $(LDFLAGS) -o program',
\ ],
\}

nmap <C-e> :SnippetToCode<CR>

let g:OpenWithPrograms = {
\    'html': 'librewolf',
\    'tex': 'pdflatex',
\}
nnoremap <C-o> :lua require 'open_with'.OpenWithProgram()<CR>

" nim.nvim autocompletion
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'nim',
    \ 'whitelist': ['nim'],
    \ 'completor': {opt, ctx -> nim#suggest#sug#GetAllCandidates({start, candidates -> asyncomplete#complete(opt['name'], ctx, start, candidates)})}
    \ })
