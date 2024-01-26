local util = require("formatter.util")

local function prettierrc()
    return {
        exe = "prettier",
        args = {
            "--config",
            "$XDG_CONFIG_HOME/prettier/prettierrc.yaml",

            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
        },
        stdin = true,
        try_node_modules = true,
    }
end

local function stylua()
    return {
        exe = "stylua",
        args = {
            "--indent-width",
            "4",
            "--indent-type",
            "Spaces",

            --"--skip-modified-check",
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
        },
        stdin = true,
        no_save_after_format = true,
    }
end

local function black()
    return {
        exe = "black",
        args = { "-q", "-" },
        stdin = true,
    }
end

local function rubocop()
    return {
        exe = "rubocop",
        args = {
            "--fix-layout",
            "--stdin",
            util.escape_path(util.get_current_buffer_file_name()),
            "--format",
            "files",
            "--stderr",
        },
        stdin = true,
    }
end

local function djlint()
    return {
        exe = "djlint",
        args = { "--reformat", "-" },
        stdin = true,
    }
end

local function php_cs_fixer()
    return {
        exe = "php-cs-fixer",
        args = {
            "fix",
        },
        stdin = false,
        ignore_exitcode = true,
    }
end

require("formatter").setup({
    logging = false,
    filetype = {
        lua = stylua,
        python = black,
        ruby = rubocop,
        django = djlint,

        javascript = prettierrc,
        typescript = prettierrc,
        vue = prettierrc,
        javascriptreact = prettierrc,
        typescriptreact = prettierrc,
        markdown = prettierrc,
        html = prettierrc,
        css = prettierrc,
        json = prettierrc,
        yaml = prettierrc,

        php = php_cs_fixer,
    },
})

-- format on save
vim.cmd([[
    augroup FormatAutogroup
        autocmd!
        autocmd User FormatterPre lua print "This will print before formatting"
        autocmd BufWritePost * FormatWrite
    augroup END
]])
