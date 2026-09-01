-- gd en PHP: abrir la definicion en un panel nuevo en vez de reemplazar el actual.
--
-- La orientacion se decide por la forma *visual* del panel, no por filas/columnas:
-- una celda del terminal es mas alta que ancha, asi que las filas se escalan por
-- ese factor antes de comparar.
--
-- Valor medido en este equipo (WezTerm, fuente por defecto, dpi 96):
--   wezterm.exe cli list --format json
--   -> cols 284 / pixel_width 2556 = 9 px de ancho por celda
--      rows  64 / pixel_height 1344 = 21 px de alto  por celda
--   -> 21 / 9 = 2.3333
--
-- Es invariante al zoom (Ctrl +/-) porque escala ambos ejes por igual. Solo hay
-- que volver a medirlo si cambias la fuente o pones line_height en WezTerm.
local CELL_ASPECT = 21 / 9

local function split_cmd()
  local win = vim.api.nvim_get_current_win()
  local visual_width = vim.api.nvim_win_get_width(win)
  local visual_height = vim.api.nvim_win_get_height(win) * CELL_ASPECT
  -- panel mas alto que ancho -> split horizontal (uno encima del otro)
  return visual_height > visual_width and "split" or "vsplit"
end

local function goto_definition_in_split()
  vim.lsp.buf.definition({
    on_list = function(result)
      local items = result.items or {}
      if #items == 0 then
        vim.notify("No se encontro la definicion", vim.log.levels.WARN)
        return
      end

      local cmd = split_cmd()
      local origin_win = vim.api.nvim_get_current_win()
      local origin_cursor = vim.api.nvim_win_get_cursor(origin_win)
      vim.cmd(cmd)

      -- LazyVim usa splitkeep = "screen": al partir, el texto en pantalla se queda
      -- fijo y es el *cursor* el que se mueve para caber en la ventana encogida.
      -- Por eso hay que devolverlo a su linea antes de recentrar; si no, se centra
      -- la linea equivocada.
      vim.api.nvim_win_call(origin_win, function()
        vim.api.nvim_win_set_cursor(origin_win, origin_cursor)
        -- solo "split" reduce el alto y descoloca la vista verticalmente
        if cmd == "split" then
          vim.cmd("normal! zz")
        end
      end)

      if #items == 1 then
        local item = items[1]
        local buf = vim.fn.bufadd(item.filename)
        vim.fn.bufload(buf)
        -- bufadd() crea el buffer *unlisted*. Incline ignora los buffers no
        -- listados (ignore.unlisted_buffers = true por defecto), asi que sin
        -- esto el panel nuevo se queda sin winbar con la ruta. Bufferline y
        -- :bnext tampoco lo verian.
        vim.bo[buf].buflisted = true
        vim.api.nvim_win_set_buf(0, buf)
        vim.api.nvim_win_set_cursor(0, { item.lnum, math.max(item.col - 1, 0) })
      else
        -- varias definiciones: quickfix para recorrerlas con :cnext
        vim.fn.setqflist({}, " ", result)
        vim.cmd.cfirst()
        vim.notify(("%d definiciones (:cnext)"):format(#items), vim.log.levels.INFO)
      end

      -- centrar el bloque de la definicion en el panel nuevo
      vim.cmd("normal! zz")
    end,
  })
end

-- Registrado en el servidor intelephense (no en "*") para que solo afecte a PHP:
-- LazyVim ordena los servidores alfabeticamente, asi que estas keys se aplican
-- despues de las globales y ganan en los buffers donde intelephense esta attached.
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      intelephense = {
        keys = {
          {
            "gd",
            goto_definition_in_split,
            has = "definition",
            desc = "Goto Definition (panel nuevo)",
          },
        },
      },
    },
  },
}
