-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/config/keymaps.lua
local keymap = vim.keymap

-- Increment/decrement numbers
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
-- keymap.set("n", "dw", 'vb"_d')

-- Select all
-- keymap.set("n", "<Leader>a", "gg<S-v>G", { desc = "Select All" })
-- keymap.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })
-- keymap.set("n", "<Leader>a", "maggVG`a", { desc = "Select All" })
keymap.set("n", "<Leader>a", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd("%y+")
  vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Yank entire file to clipboard" })

-- keymap.set("n", "<leader>A", function()
--   vim.cmd("%delete _")
-- end, { desc = "Delete all lines in file" })
vim.keymap.set("n", "<leader>D", ":%delete _<CR>", {
  desc = "Delete entire file content",
})

-- Asegurar que la tecla principal exista como grupo (opcional, pero útil)
-- Esto no mapea ninguna acción directa a <leader>y, sólo ayuda a which-key.
-- keymap.set("n", "<leader>y", function() end, { desc = "+Yank" })

-- Save WITHOUT formatting: Ctrl + Delete
vim.keymap.set({ "n", "i", "v" }, "<C-x>", function()
  vim.cmd("noa w")
  vim.cmd("stopinsert")
end, { desc = "Save without formatting" })

keymap.set("v", "<leader>oa", ":sort<CR>", { desc = "Sort alphabetically" })
