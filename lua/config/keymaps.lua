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
keymap.set("n", "<Leader>a", "gg<S-v>G", { desc = "Select All" })
-- keymap.set("n", "<Leader>a", "ggVG<c-$>", { desc = "Select All" })

keymap.set("n", "<Leader>q", "<cmd>:q<CR>", { desc = "Quit file" })

-- Use Delete key to save without formatting
keymap.set("n", "<Del>", function()
  vim.cmd("noautocmd write")
end, { desc = "Save without formatting (noautocmd)" })

keymap.set("v", "<leader>oa", ":sort<CR>", { desc = "Sort alphabetically" })
