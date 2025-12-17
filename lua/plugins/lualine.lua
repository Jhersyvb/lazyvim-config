return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- 🔥 Apagar breadcrumbs de Navic
    -- opts.sections.lualine_c = {
    --   {
    --     "filename",
    --     path = 1, -- 0 = nombre, 1 = relativo, 2 = relativo al home, 3 = ABSOLUTO
    --   },
    -- }
    opts.sections.lualine_c = {
      { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
      { "filetype", icon_only = true, padding = { left = 1, right = 0 }, separator = "" },
      { "filename", path = 1 },
      -- (añade aquí otros componentes estáticos que quieras mantener)
    }
  end,
}
