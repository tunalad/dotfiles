local ls = require("luasnip")

-- Load your custom snippets
local snippet_path = vim.fn.stdpath("config") .. "/lua/snippets/"
require("luasnip.loaders.from_lua").lazy_load({ paths = snippet_path })

-- LuaSnip settings
ls.config.set_config({
    history = true, -- Enable history so snippets can be reused
    updateevents = "TextChanged,TextChangedI", -- Update snippets in real time
})
