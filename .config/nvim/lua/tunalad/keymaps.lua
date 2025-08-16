-- move line(s) up or down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("v", "<A-k>", ":m'<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-j>", ":m'>+1<CR>gv=gv", { noremap = true, silent = true })

-- keep cursor centered on search
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true })

-- fold toggling
vim.keymap.set("n", "<space>", "za", { noremap = true, silent = true })

-- diagnostics toggling
vim.keymap.set("n", "<A-d>", ":Trouble diagnostics toggle<CR>", { noremap = true, silent = true })

-- move between splits
vim.keymap.set("n", "<A-Left>", "<C-W>h", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Down>", "<C-W>j", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>", "<C-W>k", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Right>", "<C-W>l", { noremap = true, silent = true })

-- clearing the find results
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- fzf
vim.keymap.set("n", "<A-e>", ":FzfLua files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "rf", ":FzfLua oldfiles<CR>", { noremap = true, silent = true })

-- change settings
--vim.keymap.set("n", "cs", ":e $XDG_CONFIG_HOME/nvim<CR>", { noremap = true, silent = true })

-- arrow moving works like in regular text editors
vim.api.nvim_set_keymap("n", "<Up>", "gk", { noremap = true })
vim.api.nvim_set_keymap("n", "<Down>", "gj", { noremap = true })
