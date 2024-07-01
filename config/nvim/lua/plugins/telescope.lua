return {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    { "nvim-telescope/telescope-fzy-native.nvim" },
    { "stevearc/aerial.nvim", opts = true },
    "isak102/telescope-git-file-history.nvim",
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

    telescope.load_extension "git_file_history"
    telescope.load_extension "fzy_native"
    telescope.load_extension "aerial"
  end,
}
