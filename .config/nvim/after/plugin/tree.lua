vim.g.netrw_winsize = -30
vim.g.netrw_liststyle = 3 -- Tree-like view
vim.g.netrw_banner = 0 -- Removes the header info
vim.g.netrw_altv = 1 -- Opens on the left

require("netrw").setup({
    use_devicons = true,
})

vim.keymap.set("n", "<A-f>", ":Lexplore<CR>")
