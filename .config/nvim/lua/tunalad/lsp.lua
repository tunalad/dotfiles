local capabilities = require("blink.cmp").get_lsp_capabilities()

require("mason-lspconfig").setup({})

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
    clangd = {},
    jedi_language_server = {},
    gopls = {},
    vuels = {},
    ts_ls = {},
    csharp_ls = {},
    arduino_language_server = {
        cmd = { "arduino-language-server", "-fqbn", "arduino:avr:uno" },
        filetypes = { "arduino" },
    },
    faustlsp = {
        cmd = { "faustlsp" },
        filetypes = { "faust" },
        root_markers = { ".faustcfg.json", ".git" },
    },
}

for server, config in pairs(servers) do
    config.capabilities = capabilities
    config.on_attach = on_attach
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

-- DIAGNOSTIC
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
})

-- AUTOCOMPLETE
-- waiting for nvim 0.12, so I can get rid of blink.cmp and use this
--vim.api.nvim_create_autocmd("LspAttach", {
--    callback = function(args)
--        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
--        if client:supports_method("textDocument/completion") then
--            local chars = {}
--            for i = 32, 126 do
--                table.insert(chars, string.char(i))
--            end
--            client.server_capabilities.completionProvider.triggerCharacters = chars
--            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--        end
--    end,
--})
--
--vim.lsp.inline_completion.enable(true)
--
--vim.cmd([[set completeopt=menuone,noselect,popup,fuzzy]])
--
--vim.keymap.set("i", "<Tab>", function()
--    if vim.fn.pumvisible() == 1 then
--        return "<C-n><C-y>"
--    end
--    return "<Tab>"
--end, { expr = true })
--
--vim.keymap.set("i", "<CR>", function()
--    if vim.fn.pumvisible() == 1 then
--        return "<C-n><C-y>"
--    end
--    return "<CR>"
--end, { expr = true })
