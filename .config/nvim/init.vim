syntax on
set number
set wildmode=full
set backspace=indent,eol,start
set hidden
filetype plugin indent on
syntax on


call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'gko/vim-coloresque'
Plug 'vim-syntastic/syntastic'
Plug 'ellisonleao/glow.nvim'

call plug#end()

" BINDINGS:

" Move line(s) up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" HTML closetags
imap > ><C-_><C-o>F<lt>

" COC CONFIG
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-json', 
  \ 'coc-prettier',
  \ ]

command! -nargs=0 Prettier :CocCommand prettier.formatFile

