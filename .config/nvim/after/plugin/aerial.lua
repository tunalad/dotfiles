require("aerial").setup({
    show_guides = true,
    guides = {
        -- When the child item has a sibling below it
        mid_item = "├─ ",
        -- When the child item is the last in the list
        last_item = "└─ ",
        -- When there are nested child guides to the right
        nested_top = "│  ",
        -- Raw indentation
        whitespace = "   ",
    },
})
