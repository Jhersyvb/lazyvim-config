return {
  "bluz71/vim-nightfly-colors",
  lazy = false, -- 👈 importante
  priority = 1000,
  config = function()
    vim.g.nightflyCursorColor = true
    vim.g.nightflyNormalFloat = true
    vim.g.nightflyTransparent = false

    vim.cmd.colorscheme("nightfly")
  end,
}
-- return {
--   "uhs-robert/oasis.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("oasis").setup() -- (see Configuration below for all customization options)
--     vim.cmd.colorscheme("oasis") -- After setup, apply theme (or any style like "oasis-night")
--   end,
-- }
-- return -- Using Lazy
-- {
--   "navarasu/onedark.nvim",
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require("onedark").setup({
--       style = "darker",
--     })
--     require("onedark").load()
--   end,
-- }
-- return {
--   "rebelot/kanagawa.nvim",
--   priority = 1000,
--   config = function()
--     require("kanagawa").setup({
--       compile = false,
--       undercurl = true,
--       commentStyle = { italic = true },
--       keywordStyle = { italic = true },
--       statementStyle = { bold = true },
--       transparent = false,
--       dimInactive = false,
--       theme = "wave", -- wave | dragon | lotus
--     })
--
--     vim.cmd.colorscheme("kanagawa")
--   end,
-- }
-- return {
--   "eldritch-theme/eldritch.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.opt.termguicolors = true
--     vim.cmd.colorscheme("eldritch")
--   end,
-- }
-- return {
--   "uloco/bluloco.nvim",
--   lazy = false,
--   priority = 1000,
--   dependencies = { "rktjmp/lush.nvim" },
--   config = function()
--     require("bluloco").setup({
--       style = "dark", -- dark | light
--       transparent = false,
--       italics = true,
--       terminal = vim.fn.has("gui_running") == 1,
--     })
--
--     vim.cmd.colorscheme("bluloco")
--   end,
-- }
