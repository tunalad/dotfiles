-- LSP
local lsp_zero = require("lsp-zero").preset("recommended")
local lspconfig = require("lspconfig")

--lsp.on_attach(function(client, bufnr)
--    lsp.default_keymaps({ buffer = bufnr })
--end)

--lsp.nvim_workspace()

lsp_zero.setup()

lspconfig.clangd.setup({ autostart = false })

lspconfig.jedi_language_server.setup({ autostart = true })
lspconfig.lua_ls.setup({ autostart = true })
lspconfig.gopls.setup({ autostart = true })
lspconfig.vuels.setup({ autostart = true })
lspconfig.ts_ls.setup({ autostart = true })

-- COMPLETION
local cmp = require("cmp")
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help" },
        { name = "buffer", keyword_length = 3 },
    },
    mapping = {
        ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        ["<Tab>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),

        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<Up>"] = cmp.mapping.select_prev_item(cmp_select_opts),
        ["<Down>"] = cmp.mapping.select_next_item(cmp_select_opts),
        ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
        ["<C-n>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item(cmp_select_opts)
            else
                cmp.complete()
            end
        end),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    window = {
        documentation = {
            max_height = 15,
            max_width = 60,
        },
    },
    formatting = {
        fields = { "abbr", "menu", "kind" },
        format = function(entry, item)
            local short_name = {
                nvim_lsp = "LSP",
                nvim_lua = "nvim",
            }

            local menu_name = short_name[entry.source.name] or entry.source.name

            item.menu = string.format("[%s]", menu_name)
            return item
        end,
    },
})
