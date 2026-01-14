-- ======================================================================== --
-- SECCIÓN: ATAJOS (Haciendo la vida más fácil)
-- PROPÓSITO: Automatizar tareas en la escritura
-- ======================================================================== --

local keymap = vim.keymap.set

-- Guardar archivo con <leader>w
keymap("n", "<leader>w", ":w<CR>")
-- Salir con <leader>q
keymap("n", "<leader>q", ":q<CR>")
-- Abrir el explorador de archivos simple
keymap("n", "<leader>e", ":Ex<CR>")

-- Navegar entre splits
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Insertar pares y mover el cursor al centro
keymap("i", '"', '""<left>', { desc = "Cerrar comillas dobles" })
keymap("i", "'", "''<left>", { desc = "Cerrar comillas simples" })
keymap("i", "(", "()<left>", { desc = "Cerrar paréntesis" })
keymap("i", "[", "[]<left>", { desc = "Cerrar corchetes" })
keymap("i", "{", "{}<left>", { desc = "Cerrar llaves" })

-- Borrar sin ensuciar el registro
keymap({"n", "v"}, "dx", '"_dd')
