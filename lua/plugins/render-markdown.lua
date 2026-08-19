return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
    pipe_table = {
      enabled = true,
      preset = "round", -- o "double", "heavy"
      style = "full", -- "full" dibuja todo el borde, "normal" solo separa filas
    },
  },
}
