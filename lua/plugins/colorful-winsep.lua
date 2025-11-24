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
  end,
}
