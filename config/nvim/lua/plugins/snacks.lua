---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    gitbrowse = { enabled = true },
    image = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    styles = {
      notification = {
        border = "single",
        relative = "editor",
      },
      notification_history = {
        border = "single",
        relative = "editor",
      },
    },
  },
  init = function()
    require("pde.utils").load_keymap {
      ["cmd"] = {
        ["Gbrowse"] = { function() Snacks.gitbrowse() end },
        ["Notifications"] = { function() Snacks.notifier.show_history() end },
      },
    }
  end,
}
