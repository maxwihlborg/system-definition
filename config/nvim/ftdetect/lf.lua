vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {
    "lfrc",
  },
  callback = function()
    vim.opt.filetype = "lf"
  end,
})
