-- ===========================================================================
-- plugins/lualine.lua
-- Barra de estado con vibras lofi y relajados
-- ===========================================================================

return {
    "nvim-lualine/lualine.nvim",
    -- Dependencia para ver íconos bonitos (necesito Nerd Fonts)
    dependencies = { "nvim-tree/nvim-web-devicons" },

    config = function()
        require("lualine").setup({
            options = {
                theme = "dracula",
                -- Separadores redondeados para esa vibra "cozy" y suave
                component_separators = { left = '∘', right = '∘' },
                section_separators = { left = '', right = ''},
                globalstatus = true, -- Una sola barra aunque tenga splits
            },
            sections = {
                lualine_a = {
                    { 'mode', separator = { left = '' }, right_padding = 2 },
                },
                lualine_b = { 'filename', 'brach' },
                lualine_c = { 'diff', 'diagnostics' },
                lualine_d = { 'encoding', 'fileformat', 'filetype' },
                lualine_e = { 'progress' },
                lualine_z = {
                    { 'location', separator = { right = '' }, left_padding = 2 },
                },
            },
        })
    end
}
