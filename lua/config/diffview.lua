local M = {}

function M.open_diffview()
  vim.ui.input({ prompt = "Enter branch or commit to diff against: " }, function(input)
    if input and input ~= "" then
      vim.cmd("DiffviewOpen " .. input)
    else
      vim.notify("No branch or commit provided.", vim.log.levels.WARN)
    end
  end)
end

return M
