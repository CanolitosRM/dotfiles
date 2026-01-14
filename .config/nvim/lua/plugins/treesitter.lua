-- ===================================
-- Tree-sitter
-- Parsing real del código (no regex)
-- ===================================

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" }, -- Cambiado a BufReadPost para mayor seguridad
        config = function()
            local config = require("nvim-treesitter.config")

            config.setup({
                -- Lenguajes que queremos soportar
                ensure_installed = {
                    "c",
                    "lua",
                    "bash",
                    "vim",
                    "vimdoc", -- Importante: reemplaza 'vim' por 'vimdoc' para ayuda de neovim
                    "markdown",
                    "markdown_inline",
                },

                -- Highlighting avanzado
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },

                -- Indentación basada en AST
                indent = {
                    enable = true,
                },
            })
        end,
    },
}
