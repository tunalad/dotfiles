local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    -- Add the #EXTM3U header
    s("m3u", {
        t("#EXTM3U"),
        i(0),
    }),

    -- Add a song entry with metadata
    s("song", {
        t("#EXTINF:0"),
        t(","),
        i(1, "Artist - Title"),
        i(0),
    }),

    -- Add a radio stream entry
    s("stream", {
        t("#EXTINF:0,"),
        i(1, "Stream Title"),
        t({ "", "" }),
        i(2, "http://stream.url/playlist"),
    }),
}
