return {
  "nvim-zh/colorful-winsep.nvim",
  event = { "WinEnter", "WinLeave" },
  config = function()
    local active_fg = "#ff9e64" -- naranja brillante (tokyonight accent)
    local inactive_fg = "#3b4261" -- gris azulado (tonalidad tokyonight)
    local bg = "NONE"

    -- setup del plugin
    require("colorful-winsep").setup({
      highlight = active_fg,
      border = "bold",
    })

    -- función para aplicar el color base a WinSeparator
    local function set_inactive_winsep()
      -- usar defer_fn para esperar a que el colorscheme termine de pintar todo
      vim.defer_fn(function()
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = inactive_fg, bg = bg, bold = false })
      end, 50)
    end

    -- aplicar ahora y en cada cambio de esquema
    set_inactive_winsep()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_inactive_winsep })

    -- Redibujar el separador al cerrar ventanas flotantes (lazygit, pickers, terminales).
    -- El plugin solo renderiza en WinEnter/WinResized/BufWinEnter, pero cuando un float
    -- se cierra desde dentro de un autocmd (snacks hace terminal:close() en TermClose)
    -- Neovim NO dispara WinEnter al devolver el foco, así que el borde nunca vuelve.
    local view = require("colorful-winsep.view")
    vim.api.nvim_create_autocmd({ "WinClosed", "TermClose" }, {
      group = vim.api.nvim_create_augroup("colorful_winsep_float_fix", { clear = true }),
      callback = function()
        vim.defer_fn(function()
          if not require("colorful-winsep").enabled then
            return
          end
          -- si el foco quedó en otro float, dejar que él decida
          local ok, win_config = pcall(vim.api.nvim_win_get_config, 0)
          if not ok or (win_config.relative ~= nil and win_config.relative ~= "") then
            return
          end
          view.render()
        end, 50)
      end,
    })
  end,
}
