-- ============================================
-- init.lua
-- Punto de entrada de Neovim
-- Aquí solo "llamamos" otros archivos
-- ============================================

-- Definimos la tecla líder para atajos personalizados
vim.g.mapleader = " "

-- Cargamos opciones básicas
require("core.options")
-- Cargamos atajos de teclado
require("core.keymaps")
-- Cargamos autocommands
require("core.autocommands")
-- Cargamos plugins
require("plugins.lazy")
