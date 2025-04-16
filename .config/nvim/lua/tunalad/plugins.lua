local lazy = require("lazy")

local plugins = {
    -----------------------
    --  IMPORTANT MINIES --
    -----------------------
    "ibhagwan/fzf-lua", -- fuzzy finder
    "akinsho/toggleterm.nvim", -- terminal toggle
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
    "dense-analysis/ale", -- linter
    "romgrk/barbar.nvim", -- tabs
    "nvim-tree/nvim-tree.lua", -- file explorer
    "lewis6991/gitsigns.nvim", -- git decors
    "mhartington/formatter.nvim", -- formatter
    "folke/trouble.nvim", -- diagnostics
    {
        "nvim-treesitter/nvim-treesitter", -- (better) syntax highlighting
        build = ":TSUpdate",
    },
    {
        "windwp/nvim-ts-autotag", -- tag closing and renaming support thing
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close_on_slash = true,
                },
            })
        end,
    },
    "nvim-tree/nvim-web-devicons", -- dev icons for file explorer & barbar
    "stevearc/aerial.nvim", -- code outline/map

    -----------------------
    --       MISCS       --
    -----------------------
    "mechatroner/rainbow_csv", -- csv colors
    "goolord/alpha-nvim", -- greeter logo thing
    {
        "norcalli/nvim-colorizer.lua", -- colors preview
        config = function()
            require("colorizer").setup({})
        end,
    },
    "NMAC427/guess-indent.nvim", -- detect indent size

    -----------------------
    --       COLORS      --
    -----------------------
    "metalelf0/base16-black-metal-scheme", -- trve kvlt colors
    "tomasiser/vim-code-dark", -- vscode dark mode (colors are pretty nice)

    -----------------------
    --      LSP-ZERO     --
    -----------------------
    {
        "VonHeikemen/lsp-zero.nvim", -- bundles stuff below
        branch = "v3.x",
    },

    -- LSP SUPPORT
    "neovim/nvim-lspconfig", -- lsp
    {
        "williamboman/mason.nvim", -- lsp & linter manager
        config = function()
            require("mason").setup({})
        end,
    },
    "williamboman/mason-lspconfig.nvim", -- connecting lspconfig w/ mason

    -- AUTOCOMPLETE
    {
        "hrsh7th/nvim-cmp", -- autocomplete core
        dependencies = {
            "hrsh7th/cmp-buffer", -- autocomplete buffer
            "hrsh7th/cmp-path", -- autocomplete paths
            "hrsh7th/cmp-nvim-lsp", -- autocomplete lsp
            "hrsh7th/cmp-nvim-lsp-document-symbol", -- autocomplete documentSymbol
            "hrsh7th/cmp-nvim-lsp-signature-help", -- shows function parameters
        },
    },
    {
        "L3MON4D3/LuaSnip", -- snippet engine
        dependencies = {
            "rafamadriz/friendly-snippets", -- some epic snippets
            "saadparwaiz1/cmp_luasnip", -- connecting LuaSnip w/ cmp
        },
    },
}

local opts = {}

lazy.setup(plugins, opts)
