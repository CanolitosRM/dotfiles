-- =================================
-- plugins/lazy.lua
-- Cargador de Plugins
-- Usamos lazy.nvim
-- =================================

-- Le decimos a Neovim dónde está lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Instalar Lazy automáticamente si no existe
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Lista de plugins
return require("lazy").setup({
    spec = {
        -- Esta línea es el "cerebro" que buscará en la carpeta plugins
        { import = "plugins.tokyonight" },
        { import = "plugins.treesitter" },
        { import = "plugins.lualine" },
    },

    -- Configuración visual de la ventana de Lazy
    ui = {
        border = "rounded",
    },
})
