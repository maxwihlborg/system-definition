return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = true,
  init = function()
    require("pde.utils").load_keymap {
      ["cmd"] = {
        ["Help"] = { function() require("fzf-lua").helptags() end },
      },
      ["n"] = {
        ["?"] = { function() require("fzf-lua").resume() end },
        ["<c-f>"] = { function() require("fzf-lua").live_grep() end },
        ["<leader>u"] = { function() require("fzf-lua").buffers() end },
        ["<c-c>"] = {
          function()
            require("fzf-lua").command_history {
              winopts = {
                row = 0.5,
                width = 0.5,
                height = 0.3,
              },
            }
          end,
        },
        ["<c-u>"] = {
          function()
            require("fzf-lua").files {
              previewer = false,
              winopts = {
                row = 0.5,
                width = 0.5,
                height = 0.3,
              },
            }
          end,
        },
      },
    }
  end,
  config = function()
    local actions = require("fzf-lua").actions
    require("fzf-lua").setup {
      "skim",
      keymap = {
        fzf = {
          ["ctrl-s"] = "select-all",
          ["ctrl-d"] = "deselect-all",
        },
      },
      actions = {
        files = {
          false,
          ["enter"] = actions.file_edit_or_qf,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
        },
      },
    }
  end,
}
