vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {
    "*.kdl",
  },
  callback = function()
    vim.opt.filetype = "kdl"
  end,
})
