local Plug = vim.fn['plug#']

vim.call('plug#begin')
    Plug 'vim-syntastic/syntastic'              -- syntax stuff
    Plug 'romgrk/barbar.nvim'                   -- tabs
    Plug 'windwp/nvim-autopairs'                -- spawn pairs of brackets, quotes, etc
    Plug 'Yggdroot/indentLine'                  -- line indent indicator
    Plug 'nvim-tree/nvim-tree.lua'              -- file explorer
    Plug 'akinsho/toggleterm.nvim'              -- terminal toggle
    Plug 'metalelf0/base16-black-metal-scheme'  -- trve kvlt color schemes
    Plug('nvim-treesitter/nvim-treesitter', {   -- text highlight fix idk
        ['do'] = function()
            vim.cmd(':TSUpdate')
        end
    })

    -- IDE SETUP
    Plug('VonHeikemen/lsp-zero.nvim', {['branch'] = 'v2.x'}) -- bundles stuff below

    -- LSP SUPPORT
    Plug 'neovim/nvim-lspconfig'                -- lsp
    Plug ('williamboman/mason.nvim', {          -- lsp & linter manager
        ['do'] = function()
            vim.cmd(':MasonUpdate')
        end
    })
    Plug 'williamboman/mason-lspconfig.nvim'    --connecting lspconfig w/ mason

    -- AUTOCOMPLETE
    Plug 'hrsh7th/nvim-cmp'                     -- autocomplete core
    Plug 'hrsh7th/cmp-buffer'                   -- autocomplete buffer 
    Plug 'hrsh7th/cmp-path'                     -- autocomplete paths
    Plug 'hrsh7th/cmp-nvim-lsp'                 -- autocomplete lsp
    Plug 'hrsh7th/cmp-nvim-lsp-document-symbol' -- autocomplete documentSymbol
    Plug 'L3MON4D3/LuaSnip'                     -- snippet engine
    Plug 'saadparwaiz1/cmp_luasnip'             -- connecting LuaSnip w/ cmp
    Plug "rafamadriz/friendly-snippets"         -- some epic snippets
vim.call('plug#end')
