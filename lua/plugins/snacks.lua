return {
  "folke/snacks.nvim",
  lazy = false, -- cargar al inicio
  opts = {
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
