return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      -- 1. Definimos la configuración básica
      require("gruvbox").setup({
        terminal_colors = true,
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true,
        contrast = "hard",
        dim_inactive = false,
        transparent_mode = true,
      })

      -- CARGAMOS el esquema de colores PRIMERO
      vim.cmd("colorscheme gruvbox")

      -- AHORA aplicamos la "Fuerza Bruta" para los errores rojos.
      -- Esto se ejecuta DESPUÉS de que el tema ya se puso,
      -- así que nada puede sobrescribirlo.
      local hl = vim.api.nvim_set_hl

      -- Limpiamos el fondo de los sospechosos habituales
      local clean_groups = {
          "Error",
          "markdownError",
          "@markup.eror",
          "@text.danger",
      }

      for _, group in ipairs(clean_groups) do
          hl(0, group, { bg = "NONE", fg = "NONE", sp = "NONE" })
      end


      -- Grupos de Treesitter y Markdown
      hl(0, "@markup.error", { bg = "NONE" })
      hl(0, "@markup.warning", { bg = "NONE" })
      hl(0, "@text.danger", { bg = "NONE" })

      -- Aseguramos tu comando naranja una última vez
      hl(0, "markdownCode", { fg = "#fe8019", bg = "NONE" })

      -- Bloques de código
      hl(0, "markdownCodeBlock", { fg = "#d3869b", bg = "NONE" })
    end,
  },
}
