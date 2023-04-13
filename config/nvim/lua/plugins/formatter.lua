return {
  "mhartington/formatter.nvim",
  cmd = {
    "Format",
    "FormatLock",
    "FormatWrite",
    "FormatWriteLock",
  },
  init = function()
    require("plugins.config.formatter").init()
  end,
  config = function()
    require("plugins.config.formatter").setup()
  end,
}
