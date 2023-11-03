local Plug = vim.fn["plug#"]

vim.call("plug#begin")
Plug("dense-analysis/ale") -- linter
Plug("romgrk/barbar.nvim") -- tabs
Plug("windwp/nvim-autopairs") -- spawn pairs of brackets, quotes, etc
Plug("Yggdroot/indentLine") -- line indent indicator
Plug("nvim-tree/nvim-tree.lua") -- file explorer
Plug("nvim-tree/nvim-web-devicons") -- dev icons for file explorer & barbar
Plug("akinsho/toggleterm.nvim") -- terminal toggle
Plug("ibhagwan/fzf-lua") -- fuzzy finder
Plug("lewis6991/gitsigns.nvim") -- git decors
Plug("mhartington/formatter.nvim") -- formatter
Plug("kevinhwang91/nvim-ufo") -- prettier folding
Plug("kevinhwang91/promise-async") -- required by ufo

-- color schemes
Plug("metalelf0/base16-black-metal-scheme") -- trve kvlt colors
Plug("tomasiser/vim-code-dark") -- vscode type beat

-- IDE SETUP
Plug("VonHeikemen/lsp-zero.nvim", { ["branch"] = "v2.x" }) -- bundles stuff below

-- LSP SUPPORT
Plug("neovim/nvim-lspconfig") -- lsp
Plug("williamboman/mason.nvim", { -- lsp & linter manager
    ["do"] = function()
        vim.cmd(":MasonUpdate")
    end,
})
Plug("williamboman/mason-lspconfig.nvim") --connecting lspconfig w/ mason

-- AUTOCOMPLETE
Plug("hrsh7th/nvim-cmp") -- autocomplete core
Plug("hrsh7th/cmp-buffer") -- autocomplete buffer
Plug("hrsh7th/cmp-path") -- autocomplete paths
Plug("hrsh7th/cmp-nvim-lsp") -- autocomplete lsp
Plug("hrsh7th/cmp-nvim-lsp-document-symbol") -- autocomplete documentSymbol
Plug("L3MON4D3/LuaSnip") -- snippet engine
Plug("saadparwaiz1/cmp_luasnip") -- connecting LuaSnip w/ cmp
Plug("rafamadriz/friendly-snippets") -- some epic snippets
vim.call("plug#end")
