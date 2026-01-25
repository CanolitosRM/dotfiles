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


-- === CONFIGURACIÓN DE NETRW ===

-- Desactivar el banner superior
vim.g.netrw_banner = 0
-- Estilo de lista
vim.g.netrw_liststyle = 3
-- Tamaño de la ventana al abrir de forma vertical
vim.g.netrw_winsize = 25
-- Abrir los archivos en la ventana previa
vim.g.netrw_browse_split = 4
-- Posición de la división
vim.g.netrw_altv = 1
