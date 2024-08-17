require("tunalad.options")
require("tunalad.keymaps")
require("tunalad.folding")
require("tunalad.plugins")

-- making barbar SHUT THE FUCK UP
vim.g.barbar_auto_setup = false

-- colorscheme
vim.g.codedark_transparent = 1
--vim.g.codedark_italics = 1
vim.cmd("highlight Pmenu guibg=NONE")
vim.cmd.colorscheme("codedark")

-- godot project
local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
if gdproject then
    require("lspconfig").gdscript.setup(vim.lsp.protocol.make_client_capabilities())

    io.close(gdproject)
    vim.fn.serverstart("127.0.0.1:55432")
end
