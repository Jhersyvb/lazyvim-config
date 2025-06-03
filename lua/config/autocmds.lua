-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function()
    -- vim.opt_local.tabstop = 4
    -- vim.opt_local.shiftwidth = 4
    -- vim.opt_local.expandtab = true
    -- vim.opt_local.autoindent = true
    -- vim.opt_local.smarttab = true
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.softtabstop = 4
    vim.bo.tabstop = 4

    vim.bo.indentexpr = "" -- disable complex indentexpr if it's buggy
    vim.bo.autoindent = true
    vim.bo.smartindent = true
  end,
})
