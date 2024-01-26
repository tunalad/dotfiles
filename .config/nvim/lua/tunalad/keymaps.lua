-- move line(s) up or down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- keep cursor centered on search
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- fold toggling
vim.keymap.set("n", "<space>", "za", { noremap = true, silent = true })

-- move between splits
vim.keymap.set("n", "<A-Left>", "<C-W>h", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", "<C-W>j", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>", "<C-W>k", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", "<C-W>l", { noremap = true, silent = true })

-- fzf
vim.keymap.set("n", "<A-e>", ":FzfLua files<CR>", { noremap = true, silent = true })

-- arrow moving works like in regular text editors
vim.api.nvim_set_keymap("n", "<Up>", "gk", { noremap = true })
vim.api.nvim_set_keymap("n", "<Down>", "gj", { noremap = true })
