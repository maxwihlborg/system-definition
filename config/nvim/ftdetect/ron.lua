vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {
    "*.ron",
  },
  callback = function()
    vim.opt.filetype = "ron"
  end,
})
