vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {
    "*.just",
    "justfile",
    "Justfile",
    ".justfile",
    ".Justfile",
  },
  callback = function()
    vim.opt.filetype = "just"
  end,
})
