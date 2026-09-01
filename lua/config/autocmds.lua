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

-- Workarounds snacks.image en WezTerm + WSL.
--
-- 1) El render fallback (WezTerm no tiene unicode placeholders) pinta en
--    coordenadas absolutas de la terminal, desligado del buffer, y snacks nunca
--    emite el borrado al salir (placement.lua: update() -> hide() -> update()
--    y ahi corta). La imagen se queda pegada y los datos se acumulan.
--    a=d,d=A borra todas las placements Y libera los datos.
--    Como eso deja a la terminal sin los bytes, hay que tirar tambien el
--    registro de snacks (images[]), si no cree que ya los mando (sent=true)
--    y al reabrir solo manda la placement -> fondo negro.
local function clear_terminal_images()
  pcall(function()
    Snacks.image.terminal.request({ a = "d", d = "A" })
  end)
  pcall(function()
    Snacks.image.image.clear()
  end)
end

vim.api.nvim_create_autocmd({ "BufWinLeave", "BufHidden", "BufDelete" }, {
  group = vim.api.nvim_create_augroup("wezterm_image_clear", { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "image" then
      clear_terminal_images()
    end
  end,
})

vim.api.nvim_create_user_command("ImageClear", clear_terminal_images, {
  desc = "Borrar todas las imagenes pegadas en la terminal",
})

-- 2) Aspect ratio: snacks saca el tamano de celda del ioctl TIOCGWINSZ y solo
--    valida col/row, no xpixel/ypixel (terminal.lua:85). El pty de WSL reporta
--    xpixel=ypixel=0 porque WezTerm corre en Windows, asi que cell_width y
--    cell_height quedan en 0 -> pixels_to_cells divide entre cero -> inf ->
--    la imagen se estira a todo el panel. Restauramos el default 9x18 de snacks
--    (relacion 1:2, la de una celda monoespaciada tipica) solo si vienen en 0.
do
  local ok, term = pcall(require, "snacks.image.terminal")
  if ok then
    local orig_size = term.size
    term.size = function()
      local s = orig_size()
      if s and (s.cell_width == 0 or s.cell_height == 0) then
        local dw, dh = 9, 18
        s.cell_width, s.cell_height = dw, dh
        s.width, s.height = s.columns * dw, s.rows * dh
        s.scale = 1
      end
      return s
    end
  end
end
