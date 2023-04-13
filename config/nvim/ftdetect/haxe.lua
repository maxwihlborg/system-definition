vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = {
    "*.hx",
  },
  callback = function()
    vim.opt.filetype = "haxe"
  end,
})
