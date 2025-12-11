return {
  {
    "nvim-mini/mini.bufremove",
    keys = {
      {
        "<leader>bO",
        function()
          local bufremove = require("mini.bufremove")
          local cur = vim.api.nvim_get_current_buf()

          -- Cerrar todos los buffers menos el actual
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if buf ~= cur and vim.api.nvim_buf_is_loaded(buf) then
              bufremove.delete(buf, false)
            end
          end

          -- Cerrar TODOS los splits excepto la ventana actual
          vim.cmd("only")
        end,
        desc = "Close all other buffers + close all splits",
      },
    },
  },
}
