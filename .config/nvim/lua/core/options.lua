-- =================================
-- Opciones generales de Neovim
-- Aquí decides cómo se comporta el editor
-- =================================

vim.opt.number = true
vim.opt.relativenumber = true

-- Tamaño del tab
vim.opt.tabstop = 4       -- cuántos espacios vale un tab
vim.opt.shiftwidth = 4    -- cuántos espacios al indentar
vim.opt.expandtab = true  -- convierte tab en espacios

-- Indentación inteligente
vim.opt.smartindent = true
-- Colores verdaderos en la terminal
vim.opt.smartindent = true
-- Resaltar la línea actual
vim.opt.cursorline = true
-- Siempre mostrar columna de signos, errores, etc.
vim.opt.signcolumn = "yes"
-- No partir líneas largas automáticamente
vim.opt.wrap = false
-- Mantener líneas visibles arriba y abajo del cursor
vim.opt.scrolloff = 8


-- --------------------------------------------------------------------------
-- Poder deshacer cambios tras cerrar el archivo (PERSISTENT UNDO)
-- --------------------------------------------------------------------------
local undo_path = vim.fn.stdpath("config") .. "/undo"

-- Creamos la carpeta si no exite
if vim.fn.isdirectory(undo_path) == 0 then
    vim.fn.mkdir(undo_path, "p")
end

vim.opt.undodir = undo_path
vim.opt.undofile = true
