vim.opt.number = true
vim.opt.wildmode = "full"
vim.opt.backspace = "indent,eol,start"
vim.opt.hidden = true
vim.opt.clipboard = "unnamedplus"
vim.opt.syntax = "enable"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.conceallevel = 0
vim.opt.signcolumn = "yes"
vim.opt.swapfile = false
vim.opt.winborder = "single"
--vim.opt.spell = true

-- python tabbing
vim.cmd("autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4")

-- format on save
--vim.cmd("autocmd BufWritePre *.js,*.vue :silent Format")

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- markdown highlighting code
vim.g.markdown_fenced_languages = { "html", "py=python", "lua", "vim", "ts=typescript", "js=javascript", "json" }

-- setting lmms file type
vim.cmd([[ autocmd BufNewFile,BufRead *.mmp set filetype=xml ]])

-- load project's vim settings (found in .vimsettings in the root of the file)
vim.cmd('autocmd BufEnter * if filereadable(".vimsettings") | source .vimsettings | endif')

-- filetypes
vim.filetype.add({
    extension = {
        m3u = "hlsplaylist",
    },
})
