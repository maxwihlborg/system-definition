return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    { "natecraddock/telescope-zf-native.nvim" },
    { "stevearc/aerial.nvim", opts = true },
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
  },
  init = function()
    require("pde.utils").load_keymap "telescope"
  end,
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<c-s>"] = actions.send_to_qflist + actions.open_qflist,
            ["<c-u>"] = false,
            ["<esc>"] = actions.close,
          },
        },
      },
    }

    telescope.load_extension "zf-native"
    telescope.load_extension "aerial"
  end,
}
