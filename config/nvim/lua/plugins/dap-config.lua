return {
  {
    "rcarriga/neotest",
    ft = { "typescript", "typescriptreact" },
    cmd = "Neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>tr", "<cmd>Neotest run<cr>" },
      { "<leader>tf", "<cmd>Neotest run file<cr>" },
      { "<leader>tn", "<cmd>Neotest jump next<cr>" },
      { "<leader>tp", "<cmd>Neotest jump prev<cr>" },
      { "<leader>ts", "<cmd>Neotest summary<cr>" },
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-vitest" {},
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
      {
        "NicholasMata/nvim-dap-cs",
        config = true,
      },
      {
        "rcarriga/nvim-dap-ui",
        cmd = { "DapContinue" },
        opts = {
          icons = {
            collapsed = "",
            current_frame = "",
            expanded = "",
          },
        },
      },
    },
    config = function() require "pde.dap" end,
    init = function()
      require("pde.utils").load_keymap {
        ["n"] = {
          ["<leader>b"] = {
            function() require("dap").toggle_breakpoint() end,
          },
          ["<leader>lp"] = {
            function() require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ") end,
          },
          ["<leader>dr"] = {
            function() require("dap").repl.open() end,
          },
          ["<leader>dl"] = {
            function() require("dap").run_last() end,
          },
          ["<leader>df"] = {
            function()
              local widgets = require "dap.ui.widgets"
              widgets.centered_float(widgets.frames)
            end,
          },
          ["<leader>ds"] = {
            function()
              local widgets = require "dap.ui.widgets"
              widgets.centered_float(widgets.scopes)
            end,
          },
          ["<leader>dc"] = {
            function() require("dap").continue() end,
          },
          ["<leader>dd"] = {
            function() require("dap").disconnect() end,
          },
          ["<leader>do"] = {
            function() require("dap").step_over() end,
          },
          ["<leader>dj"] = {
            function() require("dap").step_into() end,
          },
          ["<leader>dk"] = {
            function() require("dap").step_out() end,
          },
        },
        [{ "n", "v" }] = {
          ["<leader>dh"] = {
            function() require("dap.ui.widgets").hover() end,
          },
          ["<leader>dp"] = {
            function() require("dap.ui.widgets").preview() end,
          },
        },
      }
    end,
  },
}
