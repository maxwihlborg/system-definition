return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    { "nvim-telescope/telescope-fzy-native.nvim", build = "make" },
    "nvim-lua/plenary.nvim",
    "nvim-lua/popup.nvim",
  },
  init = function()
    require("core.utils").load_keymap "telescope"
  end,
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local sorters = require "telescope.sorters"

    telescope.setup {
      defaults = {
        file_sorter = sorters.get_fzy_sorter,
        mappings = {
          i = {
            ["<C-s>"] = actions.send_to_qflist + actions.open_qflist,
          },
        },
      },
    }

    telescope.load_extension "fzy_native"
  end,
}
