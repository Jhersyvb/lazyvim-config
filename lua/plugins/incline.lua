return {
  "b0o/incline.nvim",
  config = function()
    local devicons = require("nvim-web-devicons")
    require("incline").setup({
      render = function(props)
        local bufname = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(bufname, ":t")
        if filename == "" then
          filename = "[No Name]"
        end

        -- Ruta del archivo con los directorios ancestros abreviados a su inicial y la
        -- carpeta padre completa:
        --   backend/views/electronic-summary/xml_summary.php -> b/v/electronic-summary/
        local function get_dir_prefix()
          if bufname == "" then
            return nil
          end
          local relative = vim.fn.fnamemodify(bufname, ":~:.")
          local segments = vim.split(relative, "/", { trimempty = true })
          table.remove(segments) -- el nombre del archivo
          local parent = table.remove(segments)
          if parent == nil then
            return nil
          end
          for i, segment in ipairs(segments) do
            -- 2 caracteres en los ocultos, para no quedarnos solo con el punto
            segments[i] = vim.fn.strcharpart(segment, 0, segment:sub(1, 1) == "." and 2 or 1)
          end
          table.insert(segments, parent)
          local prefix = table.concat(segments, "/") .. "/"
          return relative:sub(1, 1) == "/" and "/" .. prefix or prefix
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
          local icons = { hint = " ", info = " ", warn = " ", error = " " }
          local label = {}

          for severity, icon in pairs(icons) do
            local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
            if n > 0 then
              table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
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

        local branch = vim.b[props.buf].original_branch
        if branch then
          table.insert(parts, {
            " " .. branch .. " ",
            gui = vim.bo[props.buf].modified and "bold,italic" or "bold",
            guifg = "#222436",
            guibg = "#b692f2",
          })
        end

        table.insert(parts, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })

        local dir_prefix = get_dir_prefix()
        if dir_prefix then
          table.insert(parts, { dir_prefix, guifg = "#888888" })
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
