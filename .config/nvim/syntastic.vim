set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers=['eslint']

let g:syntastic_python_pylint_args='--rcfile=$XDG_CONFIG_HOME/pylint/pylintrc'
let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_python_checkers = ['flake8', 'pyflakes', 'pylint']
let g:syntastic_python_flake8_args = "--ignore=E501"
