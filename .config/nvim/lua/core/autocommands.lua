-- ===========================================================================
-- MÓDULO: AUTOMATIZACIONES Y EVENTOS (El mayordomo de la cocina)
-- PROPÓSITO: Tareas que se ejecutan solas según el contexto
-- ===========================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Grupo para limpieza de archivos
local cleanup = augroup("cleanup", { clear = true })

-- TAREA: Borrar espacios en blanco al final de cada línea antes de guardar
-- Porque un ingeniero dee verdad no deja rastro de basura en su código
autocmd("BufWritePre", {
    group = cleanup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- TAREA: Resaltar el texto al copiar (Yank)
-- Para que sientas visualmente que has "atrapado" el ingrediente.
autocmd("TextYankPost", {
    group = cleanup,
    callback = function()
        vim.highlight.on_yank({highlight_group = 'IncSearch', timeout = 150})
    end,
})

-- TAREA: Activación del Inspector Ortográfico
-- PROPÓSITO: Asegurar que la documentación sea digna de un manual de IBM.
autocmd("FileType", {
    group = cleanup,
    pattern = { "markdown", "text", "gitcommit"},
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "es,en"  -- Revisa español e inglés
    end,
    desc = "Activa el corrector en archivos de texto",
})

-- TAREA: Restaurar posición del cursor
-- PROPÓSITO: Continuar la "cocina" justo donde la dejamos.

autocmd("BufReadPost", {
    group = cleanup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})
