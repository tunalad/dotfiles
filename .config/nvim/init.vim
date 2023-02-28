filetype plugin indent on
set number
set wildmode=full
set backspace=indent,eol,start
set hidden
set clipboard+=unnamedplus
syntax on

" folding
set foldmethod=marker
set tabstop=8 
set expandtab 
set shiftwidth=4 
set softtabstop=4

call plug#begin() "{{{
        Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion
        Plug 'vim-syntastic/syntastic'                  " syntax checker
        Plug 'romgrk/barbar.nvim' 			" tabs
        Plug 'lambdalisue/vim-django-support' 		" django support
        Plug 'Yggdroot/indentLine' 			" tab indent visualizer
        Plug 'posva/vim-vue',                           " vue syntax highlight
        Plug 'mxw/vim-jsx',                             " jsx syntax highlight
        Plug 'qpkorr/vim-renamer',                      " bulk rename files
call plug#end() "}}}

" COC SETTINGS
source $XDG_CONFIG_HOME/nvim/coc.vim

" BARBAR SETTINGS
source $XDG_CONFIG_HOME/nvim/barbar.vim

" TERMINAL SPLIT
source $XDG_CONFIG_HOME/nvim/terminal.vim

" SYNTASTIC SETTINGS
source $XDG_CONFIG_HOME/nvim/syntastic.vim

" VEXPLORER
source $XDG_CONFIG_HOME/nvim/vexplorer.vim

" FOLDING
source $XDG_CONFIG_HOME/nvim/folding.vim

""" BASIC COMMANDS BINDINGS
" Move line(s) up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" fold toggling
nnoremap <space> za 

" changing between splits
nnoremap <A-Left> <C-W>h
nnoremap <A-Down> <C-W>j
nnoremap <A-Up> <C-W>k
nnoremap <A-Right> <C-W>l
