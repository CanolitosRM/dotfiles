return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "night",
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        })

        -- Primero cargamos el tema
        vim.cmd([[colorscheme tokyonight]])

        -- DESPUÉS del colorscheme, forzamos el color manualmente.
        -- Esto sobrescribe cualquier configuración previa.
        local colors = require("tokyonight.colors").setup() -- Obtenemos la paleta

        -- Forzamos el color en los grupos más comunes de Markdown Inline
        local groups = {
            "@markup.raw.markdown_inline",
            "@text.literal.markdown_inline",
            "markdownCode",
            "markdownCodeDelimiter",
        }
        for _, group in ipairs(groups) do
            vim.api.nvim_set_hl(0, group, { fg = colors.orange, bg = colors.bg_highlight })
        end

        -- Personalización de los colores
        local line_color = "#526362"
        local comment_color = "#727f7d"
        local black_color = "#21222c"
        -- Números de línea
        vim.api.nvim_set_hl(0, "LineNr", { fg = line_color })
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = line_color })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = line_color })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ff9e64", bold = true })
        -- Comentarios
        vim.api.nvim_set_hl(0, "Comment", { fg = comment_color, italic = true })
        vim.api.nvim_set_hl(0, "@Comment", { fg = comment_color, italic = true })
        -- Color column y lualine
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = black_color })
        vim.api.nvim_set_hl(0, "StatusLine", { fg = NONE, bg = NONE, italic = true})
    end,
}
