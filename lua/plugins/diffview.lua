return {
  "sindrets/diffview.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  keys = {
    { "<leader>g.", "<cmd>DiffviewFileHistory<cr>", desc = "Git Diff File History" },
    { "<leader>g:", "<cmd>DiffviewFileHistory %<cr>", desc = "Git Diff Current File History" },
    { "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "Git Diff" },
    {
      "<leader>gO",
      function()
        require("config.diffview").open_diffview()
      end,
      desc = "DiffView against branch/commit",
    },
    {
      "<leader>gq",
      "<cmd>SafeDiffviewClose<cr>",
      desc = "Close Diffview",
    },
  },
  config = function()
    vim.api.nvim_create_user_command("SafeDiffviewClose", function()
      if vim.fn.getbufinfo({ changed = 1 })[1] ~= nil then
        print("Unsaved changes exist. Save or discard them before closing.")
      else
        vim.cmd("DiffviewClose")
      end
    end, {})
  end,
}
