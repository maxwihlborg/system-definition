return {
  "ibhagwan/fzf-lua",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    require("pde.utils").load_keymap {
      ["cmd"] = {
        ["Help"] = { function() require("fzf-lua").helptags() end },
        ["History"] = { function() require("fzf-lua").git_bcommits() end },
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
    local fzf = require "fzf-lua"
    fzf.register_ui_select()
    fzf.setup {
      "skim",
      keymap = {
        fzf = {
          ["ctrl-s"] = "select-all",
          ["ctrl-d"] = "deselect-all",
        },
      },
      winopts = {
        preview = { border = "single" },
        border = "single",
      },
      actions = {
        files = {
          false,
          ["enter"] = fzf.actions.file_edit_or_qf,
          ["ctrl-v"] = fzf.actions.file_vsplit,
          ["ctrl-t"] = fzf.actions.file_tabedit,
        },
      },
    }

    local group = vim.api.nvim_create_augroup("PdeFzfLua", {
      clear = true,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = group,
      callback = function(_opts)
        local opts = {
          buffer = _opts.buf,
          silent = true,
          noremap = true,
        }
        require("pde.utils").load_keymap {
          ["n"] = {
            ["gd"] = { function() fzf.lsp_definitions() end, opts },
            ["gi"] = { function() fzf.lsp_implementations() end, opts },
            ["gr"] = { function() fzf.lsp_references { includeDeclaration = false } end, opts },
            ["gs"] = { function() fzf.lsp_document_symbols() end, opts },
            ["gt"] = { function() fzf.lsp_typedefs() end, opts },
          },
        }
      end,
    })
  end,
}
