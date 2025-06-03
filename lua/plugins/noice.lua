-- Plugin: noice.nvim
-- URL: https://github.com/folke/noice.nvim
-- Description: A Neovim plugin for enhancing the command-line UI.
return {
  "folke/noice.nvim",
  config = function()
    require("noice").setup({
      cmdline = {
        view = "cmdline", -- Use the cmdline view for the command-line
      },
      presets = {
        bottom_search = true, -- Enable bottom search view
        command_palette = true, -- Enable command palette view
        lsp_doc_border = true, -- Enable LSP documentation border
      },
      -- Uncomment the following lines to customize the cmdline popup view
      -- views = {
      --   cmdline_popup = {
      --     filter_options = {},
      --     win_options = {
      --       winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      --     },
      --   },
      -- },
    })
  end,
}
