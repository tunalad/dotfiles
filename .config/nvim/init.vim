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

call plug#begin()
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion
	Plug 'dense-analysis/ale' 			" syntax checker
	Plug 'romgrk/barbar.nvim' 			" tabs
	Plug 'lambdalisue/vim-django-support' 		" django support
	Plug 'Yggdroot/indentLine' 			" tab indent visualizer
call plug#end()

" COC SETTINGS
source $XDG_CONFIG_HOME/nvim/coc.vim

" BARBAR SETTINGS
source $XDG_CONFIG_HOME/nvim/barbar.vim

" ALE SETTINGS
source $XDG_CONFIG_HOME/nvim/ale.vim

""" BINDINGS
" Move line(s) up or down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" vim fold toggling
nnoremap <space> za 

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

""" Terminal Split
let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

""" fold text style
function! NeatFoldText()"{{{
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf(lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()"}}}
