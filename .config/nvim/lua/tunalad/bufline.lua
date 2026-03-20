-- barbar replacement pretty much
vim.opt.showtabline = 2

function _G.simple_tabline()
    local s = ""
    for i, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
            local name = vim.fn.bufname(buf)
            name = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
            if buf == vim.api.nvim_get_current_buf() then
                s = s .. "%#TabLineSel# " .. name .. " "
            else
                s = s .. "%#TabLine# " .. name .. " "
            end
        end
    end
    return s .. "%#TabLineFill#"
end

vim.opt.tabline = "%!v:lua.simple_tabline()"

-- binds
local function listed_bufs()
    return vim.tbl_filter(function(b)
        return vim.api.nvim_buf_is_loaded(b) and vim.bo[b].buflisted
    end, vim.api.nvim_list_bufs())
end

for i = 1, 9 do
    vim.keymap.set("n", "<A-" .. i .. ">", function()
        local bufs = listed_bufs()
        if bufs[i] then
            vim.api.nvim_set_current_buf(bufs[i])
        end
    end)
end

vim.keymap.set("n", "<A-,>", function()
    local bufs = listed_bufs()
    local cur = vim.api.nvim_get_current_buf()
    for i, b in ipairs(bufs) do
        if b == cur then
            vim.api.nvim_set_current_buf(bufs[i - 1] or bufs[#bufs])
            return
        end
    end
end, { noremap = true, silent = true })

vim.keymap.set("n", "<A-.>", function()
    local bufs = listed_bufs()
    local cur = vim.api.nvim_get_current_buf()
    for i, b in ipairs(bufs) do
        if b == cur then
            vim.api.nvim_set_current_buf(bufs[i + 1] or bufs[1])
            return
        end
    end
end, { noremap = true, silent = true })
vim.keymap.set("n", "<A-c>", ":bdelete<CR>", { noremap = true, silent = true })
