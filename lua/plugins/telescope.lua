return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    {
      "<leader>fk",
      function()
        require("telescope").extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = vim.fn.expand("%:p:h"),
          theme = "dropdown",
          prompt_title = "File Browser (Relative)",
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = {
            height = 25,
            width = 0.5,
            -- prompt_position = "top",
          },
        })
      end,
      desc = "File Browser (Relative to Current File)",
    },
  },
  config = function()
    local telescope = require("telescope")
    local fb_actions = require("telescope").extensions.file_browser.actions
    local actions = require("telescope.actions")

    telescope.setup({
      extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          mappings = {
            ["n"] = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
      },
    })

    telescope.load_extension("file_browser")
  end,
}
