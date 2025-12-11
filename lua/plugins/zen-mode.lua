return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      width = 140, -- tu ancho deseado (número = columnas)
    },
    on_open = function()
      -- disable incline
      vim.g.incline_disabled = true
      require("incline").disable()
    end,
    on_close = function()
      -- enable incline again
      vim.g.incline_disabled = false
      require("incline").enable()
    end,
  },
  keys = {
    {
      "<leader>wz",
      function()
        require("zen-mode").toggle()
      end,
      desc = "Toggle Zen Mode",
    },
  },
}
