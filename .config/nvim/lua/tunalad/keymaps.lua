-- move line(s) up or down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==',        { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==',        { noremap = true, silent = true })
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('v', '<A-j>', "'>+1<CR>gv=gv",       { noremap = true, silent = true })
vim.keymap.set('v', '<A-k>', "'<-2<CR>gv=gv",       { noremap = true, silent = true })

-- fold toggling
vim.keymap.set('n', '<space>',      'za',           { noremap = true, silent = true })

-- move between splits
vim.keymap.set('n', '<A-Left>',     '<C-W>h',       { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>',     '<C-W>j',       { noremap = true, silent = true })
vim.keymap.set('n', '<A-Up>',       '<C-W>k',       { noremap = true, silent = true })
vim.keymap.set('n', '<A-Right>',    '<C-W>l',       { noremap = true, silent = true })
