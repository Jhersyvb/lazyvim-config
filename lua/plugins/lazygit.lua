return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  init = function()
    vim.g.lazygit_floating_window_use_plenary = 1
  end,
}
