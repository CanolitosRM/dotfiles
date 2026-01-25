-- ===========================================================================
-- plugins/ui.lua
-- Todo lo relacionado con la apariencia de la interfaz del usuario
-- ===========================================================================

return {

    {
        -- ----------------------------------------
        -- Catppuccin: esquema de colores
        -- ----------------------------------------
        "catppuccin/nvim",

        -- Nombre interno del plugin
        name = "catppuccin",

        -- prioridad alta para que se cargue ANTES que otros
        -- (evita que otro plugin cambie colores)
        priority = 1000,

        config = function()

            -- Configuración del tema
            require("catppuccin").setup({

                -- Elegimos el sabor:
                -- latte     > claro
                -- frappe    > oscuro suave
                -- macchiato > oscuro balanceado
                -- mocha     > oscuro profundo
                flavour = "latte",

                -- Transparencia falsa
                transparent_background = true,

                -- Estilos de texto
                styles = {
                    comments = { "italic" },
                    keywords = { "italic" },
                    functions = { "bold" },
                    variables = { "bold" },
                },

                -- Integraciones con plugins
                integrations = {
                    treesitter = true,
                    native_lsp = { enabled = true },
                    treesitter_context = true,
                    semantic_tokens = true,
                    telescope = { enabled = true },
                },
            })

            -- Activamos el esquema de colores
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
