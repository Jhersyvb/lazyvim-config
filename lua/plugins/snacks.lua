return {
  "folke/snacks.nvim",
  lazy = false, -- cargar al inicio
  init = function()
    -- WezTerm corre en Windows y no puede leer rutas de WSL (/home/...).
    -- Sin esto snacks manda solo la RUTA del archivo (kitty t=f) y la terminal
    -- no encuentra nada -> buffer en blanco.
    -- Marcar el entorno "ssh" fuerza el envio de los BYTES de la imagen (t=d).
    vim.env.SNACKS_SSH = "1"
  end,
  opts = {
    image = {
      enabled = true,
      doc = {
        -- wezterm no soporta unicode placeholders: inline se desactiva solo
        -- y cae al render en ventana flotante
        inline = false,
        float = true,
        max_width = 80,
        max_height = 40,
      },
    },
    dashboard = {
      preset = {
        header = [[
     ██╗██╗  ██╗███████╗██████╗ ███████╗██╗   ██╗
     ██║██║  ██║██╔════╝██╔══██╗██╔════╝╚██╗ ██╔╝
     ██║███████║█████╗  ██████╔╝███████╗ ╚████╔╝ 
██   ██║██╔══██║██╔══╝  ██╔══██╗╚════██║  ╚██╔╝  
╚█████╔╝██║  ██║███████╗██║  ██║███████║   ██║   
 ╚════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝   ]],
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = "󰺮 ", key = "/", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "", key = "g", desc = "LazyGit", action = ":LazyGit" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  },
}
