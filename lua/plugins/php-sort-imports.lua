return {
  "sQVe/sort.nvim",
  keys = {
    {
      "<leader>oi",
      function()
        local sort = require("sort")

        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

        local use_start, use_end = nil, nil

        for i, line in ipairs(lines) do
          if line:match("^use ") then
            use_start = use_start or (i - 1) -- 0-indexed
            use_end = i -- 1-indexed
          elseif use_start and not line:match("^use ") then
            break
          end
        end

        if not use_start or not use_end then
          vim.notify("No se encontraron líneas de importación `use`", vim.log.levels.WARN)
          return
        end

        -- Extraer el rango de líneas a ordenar
        local use_lines = vim.api.nvim_buf_get_lines(bufnr, use_start, use_end, false)

        -- Ordenar por longitud y alfabéticamente
        table.sort(use_lines, function(a, b)
          return #a == #b and a < b or #a < #b
        end)

        -- Reemplazar el bloque original con las líneas ordenadas
        vim.api.nvim_buf_set_lines(bufnr, use_start, use_end, false, use_lines)

        vim.notify("Importaciones ordenadas correctamente", vim.log.levels.INFO)
      end,
      desc = "Sort PHP imports by length and alphabetically",
      mode = "n",
    },
  },
}
