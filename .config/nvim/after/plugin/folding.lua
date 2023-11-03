-- folding
vim.opt.foldmethod = "indent"
vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

local marker_languages = {
    -- languages to use `foldmethod='marker'`
    --"markdown",
    "txt",
}

function NeatFoldText()
    local line = " "
        .. vim.fn.substitute(vim.fn.getline(vim.v.foldstart), '^\\s*"?\\s*\\|\\s*"?\\s*{{{\\d*\\s*', "", "g")
        .. " "
    local lines_count = vim.v.foldend - vim.v.foldstart + 1
    local lines_count_text = "| " .. string.format("%d lines", lines_count) .. " |"
    local foldchar = vim.fn.matchstr(vim.o.fillchars, "fold:\\zs.")
    local foldtextstart =
        vim.fn.strpart("+" .. string.rep(foldchar, vim.v.foldlevel * 2) .. line, 0, (vim.fn.winwidth(0) * 2) / 3)
    local foldtextend = lines_count_text .. string.rep(foldchar, 8)
    local foldtextlength = #vim.fn.substitute(foldtextstart .. foldtextend, ".", "x", "g") + vim.o.foldcolumn
    return foldtextstart .. string.rep(foldchar, vim.fn.winwidth(0) - foldtextlength) .. foldtextend
end

for _, lang in ipairs(marker_languages) do
    vim.api.nvim_exec(
        string.format(
            [[
        augroup %sFolding
            autocmd!
            autocmd FileType %s setlocal foldmethod=marker
        augroup END
    ]],
            lang,
            lang
        ),
        false
    )
end

vim.o.foldtext = 'luaeval("NeatFoldText()")'
