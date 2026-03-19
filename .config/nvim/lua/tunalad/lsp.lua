local lspconfig = vim.lsp.config
local capabilities = require("blink.cmp").get_lsp_capabilities()

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
    jedi_language_server = { autostart = true, root_markers = {} },
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
    lspconfig(server, config)
    if config.autostart then
        vim.lsp.enable(server)
    end
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
