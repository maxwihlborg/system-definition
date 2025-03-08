---@diagnostic disable: undefined-global
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    gitbrowse = { enabled = true },
    image = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    picker = {
      enabled = true,
      layout = {
        preset = "select",
        layout = {
          border = "single",
        },
      },
      win = {
        input = {
          keys = {
            ["<esc>"] = { "cancel", mode = "i" },
            ["<c-s>"] = { "qflist", mode = { "i", "n" } },
          },
        },
      },
    },
    styles = {
      notification = {
        border = "single",
      },
      notification_history = {
        border = "single",
      },
    },
  },
  init = function()
    require("pde.utils").load_keymap {
      ["cmd"] = {
        ["Gbrowse"] = { function() Snacks.gitbrowse() end },
        ["History"] = { function() Snacks.picker.git_log_file() end },
        ["Notifications"] = { function() Snacks.notifier.show_history() end },
        ["Pickers"] = { function() Snacks.picker() end },
      },
      ["n"] = {
        -- ["<c-c>"] = { function() Snacks.picker.command_history() end },
        -- ["<c-f>"] = { function() Snacks.picker.grep() end },
        -- ["<c-u>"] = { function() Snacks.picker.files() end },
        -- ["<leader>u"] = { function() Snacks.picker.buffers() end },
        -- ["?"] = { function() Snacks.picker.resume() end },
      },
    }

    local group = vim.api.nvim_create_augroup("CoreSnacks", {
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
            ["gd"] = { function() Snacks.picker.lsp_definitions() end, opts },
            ["gi"] = { function() Snacks.picker.lsp_implementations() end, opts },
            ["gr"] = { function() Snacks.picker.lsp_references { layout = "default" } end, opts },
            ["gs"] = { function() Snacks.picker.lsp_symbols() end, opts },
            ["gt"] = { function() Snacks.picker.lsp_type_definitions() end, opts },
          },
        }
      end,
    })
  end,
}
