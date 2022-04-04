filetype plugin indent on
set number
set wildmode=full
set backspace=indent,eol,start
set hidden
set clipboard+=unnamedplus
syntax on

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'gko/vim-coloresque'
Plug 'vim-syntastic/syntastic'
Plug 'ellisonleao/glow.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
call plug#end()

" COC SETTINGS
source $XDG_CONFIG_HOME/nvim/coc.vim

" BARBAR SETTINGS
source $XDG_CONFIG_HOME/nvim/barbar.vim

" BINDINGS:

" Move line(s) up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

