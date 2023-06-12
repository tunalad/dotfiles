-- LSP
vim.g.mason_package_manager = 'yarn'
vim.g.mason_package_lock_enabled = 1

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed({
    -- LSP
    'typescript-language-server',   -- js, ts
    'eslint-lsp',                   -- js, ts
    'vue-language-server',          -- vue

    'jedi_language_server',         -- python
    'lua_ls',                       -- lua
    'zls',                          -- zig
    'ruby-lsp',                     -- rubb
    'gttoolkit',                    -- godot

    -- LINTER
    'pylint',                       -- python
    'rome',                         -- js, ts, md, fuckton more
    'curlylint ',                   -- django
    'gitlint'                       -- git
})

lsp.nvim_workspace()

lsp.setup()

-- COMPLETION
local cmp = require('cmp')
local cmp_select_opts = {behavior = cmp.SelectBehavior.Select}

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    sources = {
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'luasnip'},
        {name = 'nvim_lsp_signature_help'},
        {name = 'buffer', keyword_length = 3},
    },
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
        ['<Tab>'] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select_opts),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select_opts),
        ['<C-p>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
        ['<C-n>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
    },
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        documentation = {
            max_height = 15,
            max_width = 60,
        }
    },
    formatting = {
        fields = {'abbr', 'menu', 'kind'},
        format = function(entry, item)
            local short_name = {
                nvim_lsp = 'LSP',
                nvim_lua = 'nvim'
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format('[%s]', menu_name)
            return item
        end,
    },
})

