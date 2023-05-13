return {
  "mhartington/formatter.nvim",
  cmd = {
    "Format",
    "FormatLock",
    "FormatWrite",
    "FormatWriteLock",
  },
  init = function()
    require("pde.formatter").init()
  end,
  config = function()
    require("pde.formatter").setup()
  end,
}
