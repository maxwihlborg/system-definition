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
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
          },
        },
      },
    }

    telescope.load_extension "git_file_history"
    telescope.load_extension "fzy_native"
    telescope.load_extension "aerial"
  end,
}
