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

""" BINDINGS

" Move line(s) up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" window changing
nnoremap <A-Left> <C-W>h
nnoremap <A-Down> <C-W>j
nnoremap <A-Up> <C-W>k
nnoremap <A-Right> <C-W>l

""" Vexplorer

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 18

" Toggle Vexplore 
function! ToggleVExplorer()
	if exists("t:expl_buf_num")
		let expl_win_num = bufwinnr(t:expl_buf_num)
		if expl_win_num != -1
			let cur_win_nr = winnr()
		  	exec expl_win_num . 'wincmd w'
		  	close
		  	exec cur_win_nr . 'wincmd l'
		  	unlet t:expl_buf_num
	      	else
		  	unlet t:expl_buf_num
	      	endif
	else
      		exec '1wincmd w'
      		Vexplore
      		let t:expl_buf_num = bufnr("%")
  	endif
endfunction

map <silent> <A-f> :call ToggleVExplorer()<CR>

