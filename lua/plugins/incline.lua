return {
  "b0o/incline.nvim",
  config = function()
    local devicons = require("nvim-web-devicons")
    require("incline").setup({
      render = function(props)
        -- Get the root folder name
        local root = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        local parent = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":h:t")
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == "" then
          filename = "[No Name]"
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)

        local function get_git_diff()
          local signs = vim.b[props.buf].gitsigns_status_dict
          local labels = {}
          if signs == nil then
            return labels
          end
          -- Desired order: added → changed → removed
          local ordered_icons = {
            { name = "added", icon = "" },
            { name = "changed", icon = "" },
            { name = "removed", icon = "" },
          }
          for _, item in ipairs(ordered_icons) do
            local count = signs[item.name]
            if tonumber(count) and count > 0 then
              table.insert(labels, { item.icon .. " " .. count .. " ", group = "Diff" .. item.name })
            end
          end
          if #labels > 0 then
            table.insert(labels, { "┊ " })
          end
          return labels
        end

        local function get_diagnostic_label()
          local icons = { error = "", warn = "", info = "", hint = "" }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. " " .. n .. " ", group = "DiagnosticSign" .. severity })
            end
          end
          if #label > 0 then
            table.insert(label, { "┊ " })
          end
          return label
        end

        local parts = {}
        table.insert(parts, { get_diagnostic_label() })
        table.insert(parts, { get_git_diff() })
        table.insert(parts, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })

        if parent ~= root and parent ~= "" then
          table.insert(parts, { parent .. "/", guifg = "#888888" })
        end

        table.insert(parts, { filename .. " ", gui = vim.bo[props.buf].modified and "bold,italic" or "bold" })
        table.insert(parts, { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" })

        return parts
      end,
    })
  end,
  -- Optional: Lazy load Incline
  event = "VeryLazy",
}
