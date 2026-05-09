local lazy = require("lazy")

local plugins = {
    -----------------------
    --  IMPORTANT MINIES --
    -----------------------
    "ibhagwan/fzf-lua", -- fuzzy finder
    {
        "Yggdroot/indentLine", -- line indent indicator
        event = { "BufRead", "BufNewFile" },
        config = function()
            vim.g.indentLine_setConceal = 0
        end,
    },
    {
        "windwp/nvim-autopairs", -- spawns pairs of brackets, quotes, etc
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    -----------------------
    --  IDE VIBES STUFF  --
    -----------------------
    {
        "prichrd/netrw.nvim", -- file explorer (pimping up default netrw)
        dependencies = {
            "nvim-tree/nvim-web-devicons", -- dev icons
        },
    },
    "lewis6991/gitsigns.nvim", -- git decors
    "mhartington/formatter.nvim", -- formatter
    {
        "folke/trouble.nvim", -- diagnostics
        cmd = { "Trouble", "TroubleToggle" },
        opts = {},
    },
    {
        "windwp/nvim-ts-autotag", -- tag closing and renaming support thing
        ft = { "html", "javascript", "typescript", "jsx", "tsx", "vue" },
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close_on_slash = true,
                },
            })
        end,
    },
    "stevearc/aerial.nvim", -- code outline/map

    -----------------------
    --       MISCS       --
    -----------------------
    "norcalli/nvim-colorizer.lua", -- colors preview
    "NMAC427/guess-indent.nvim", -- detect indent size

    -----------------------
    --       COLORS      --
    -----------------------
    "metalelf0/base16-black-metal-scheme", -- trve kvlt colors
    "tomasiser/vim-code-dark", -- vscode dark mode (colors are pretty nice)

    -----------------------
    --        LSP        --
    -----------------------
    "neovim/nvim-lspconfig", -- lsp
    {
        "williamboman/mason.nvim", -- lsp & linter manager
        config = function()
            require("mason").setup({})
        end,
    },
    "williamboman/mason-lspconfig.nvim", -- connecting lspconfig w/ mason
    {
        "saghen/blink.cmp", -- autocompleter
        version = "1.*",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = "make install_jsregexp",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/snippets/" })
                end,
            },
        },
        opts = {
            keymap = {
                preset = "super-tab",
                ["<CR>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    "fallback",
                },
            },
            signature = { enabled = true },
            snippets = { preset = "luasnip" },
            completion = {
                documentation = { auto_show = true },
            },
        },
        opts_extend = { "sources.default" },
    },
}

local opts = {}

lazy.setup(plugins, opts)
