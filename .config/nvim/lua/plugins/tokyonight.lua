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
  end,
}
