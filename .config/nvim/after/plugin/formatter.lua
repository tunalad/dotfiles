local util = require("formatter.util")

local function shfmt()
    local shiftwidth = vim.opt.shiftwidth:get()
    local expandtab = vim.opt.expandtab:get()

    if not expandtab then
        shiftwidth = 0
    end

    return {
        exe = "shfmt",
        args = {
            "-s",
            "-i",
            shiftwidth,
        },
        stdin = true,
    }
end

local function black()
    return {
        exe = "black",
        args = { "-q", "-" },
        stdin = true,
    }
end

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
    if util.get_current_buffer_file_name() == "special.lua" then
        return nil
    end

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

local function gdformat()
    return {
        exe = "gdformat",
        args = { "-" },
        stdin = true,
    }
end

require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,

    filetype = {
        lua = {
            require("formatter.filetypes.lua").stylua,
            stylua,
        },

        python = black,
        go = require("formatter.filetypes.go").gofumpt,
        sh = shfmt,

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
        c = require("formatter.filetypes.c"),
        cpp = require("formatter.filetypes.c"),
        gdscript = gdformat,

        ["*"] = {
            require("formatter.filetypes.any").remove_trailing_whitespace,
            stdin = true,
        },
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
