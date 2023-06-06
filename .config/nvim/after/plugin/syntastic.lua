-- Set the statusline
vim.o.statusline = vim.o.statusline .. '%#warningmsg#'
vim.o.statusline = vim.o.statusline .. '%{SyntasticStatuslineFlag()}'
vim.o.statusline = vim.o.statusline .. '%*'

-- Syntastic settings
vim.g.syntastic_always_populate_loc_list = 1
vim.g.syntastic_auto_loc_list = 1
vim.g.syntastic_check_on_open = 1
vim.g.syntastic_check_on_wq = 0

vim.g.syntastic_javascript_checkers = { 'eslint' }

vim.g.syntastic_python_pylint_args = '--rcfile=$XDG_CONFIG_HOME/pylint/pylintrc'
vim.g.syntastic_python_checkers = { 'pylint' }
-- vim.g.syntastic_python_checkers = { 'flake8', 'pyflakes', 'pylint' }
vim.g.syntastic_python_flake8_args = '--ignore=E501'
