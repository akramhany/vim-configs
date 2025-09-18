-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.g.autoformat = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fortran", "f90", "f" },
  callback = function()
    vim.cmd("NoMatchParen")
  end,
})
