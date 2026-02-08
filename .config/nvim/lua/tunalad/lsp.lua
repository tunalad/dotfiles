local lspconfig = vim.lsp.config
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)
end

local servers = {
    clangd = { autostart = false },
    --jedi_language_server = { autostart = true },
    pylsp = {
        autostart = true,
        settings = {
            pylsp = {
                plugins = {
                    pycodestyle = { enabled = false },
                    pyflakes = { enabled = false },
                    pylint = { enabled = not true }, -- for now
                    flake8 = { enabled = true },
                },
            },
        },
    },
    lua_ls = { autostart = true },
    gopls = { autostart = true },
    vuels = { autostart = true },
    ts_ls = { autostart = true },
    csharp_ls = { autostart = true },
    --omnisharp = { autostart = true },
    faustlsp = {
        cmd = { "faustlsp" },
        filetypes = { "faust" },
        --workspace_required = true,
        root_markers = { ".faustcfg.json", ".git" },
        autostart = true,
    },
}

for server, config in pairs(servers) do
    config.on_attach = on_attach
    config.capabilities = capabilities
    --lspconfig[server].setup(config)
    lspconfig(server, config)
end

-- DIAGNOSTIC

vim.diagnostic.config({
    virtual_text = true,
    --virtual_text = {
    --    severity = { min = vim.diagnostic.severity.WARN },
    --},
    signs = true,
    underline = true,
    update_in_insert = false,
})

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
