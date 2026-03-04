return {
  "tpope/vim-fugitive",
  lazy = false, -- ⬅️ IMPORTANTE
  config = function()
    vim.api.nvim_create_user_command("Gopen", function(opts)
      local args = opts.fargs
      if #args < 2 then
        vim.notify("Usage: :Gopen <branch> <path>", vim.log.levels.ERROR, { title = "Gopen" })
        return
      end

      local branch = args[1]
      local path = table.concat(vim.list_slice(args, 2), " ")
      local gedit_cmd = string.format("Gedit %s:%s", branch, path)

      -- Open the file via Gedit
      vim.cmd(gedit_cmd)

      -- Defer setting b:original_branch slightly to ensure buffer is active
      vim.schedule(function()
        if vim.api.nvim_buf_get_name(0):match("^fugitive://") then
          vim.b.original_branch = branch
          vim.notify("Gopen → Loaded " .. branch .. ":" .. path, vim.log.levels.INFO, { title = "Gopen" })
        end
      end)
    end, {
      nargs = "+",
      complete = "file",
      desc = "Open file from git branch and save symbolic branch name",
    })
  end,
}
