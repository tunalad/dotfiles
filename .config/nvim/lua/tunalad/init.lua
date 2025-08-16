require("tunalad.options")
require("tunalad.keymaps")
require("tunalad.folding")
require("tunalad.plugins")
require("tunalad.lsp")

-- making barbar SHUT THE FUCK UP
vim.g.barbar_auto_setup = false

-- colorscheme
vim.g.codedark_transparent = 1
--vim.g.codedark_italics = 1
vim.cmd("highlight Pmenu guibg=NONE")
vim.cmd.colorscheme("codedark")

-- godot project
local servers = vim.lsp.get_clients()
local godot_server_exists = false
for _, server in ipairs(servers) do
    if server.name == "gdscript" then
        godot_server_exists = true
        break
    end
end
if not godot_server_exists then
    pcall(vim.fn.serverstart, "127.0.0.1:55432")
end
