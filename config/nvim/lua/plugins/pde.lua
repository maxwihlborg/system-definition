return {
  {
    "windwp/nvim-projectconfig",
    event = "BufReadPre",
    dependencies = "neovim/nvim-lspconfig",
    opts = {
      project_config = {
        {
          path = vim.fn.expand "~/ghq/github.com/nomadicretail/xnomad/apps/web",
          config = function()
            require("core.lsp.utils").setup_autostart "graphql"
            require("core.utils").set_compiler("tsc", {
              pattern = { "typescript", "typescriptreact" },
              cmd = "pnpm tsc",
            })
          end,
        },
        {
          path = vim.fn.expand "~/ghq/github.com/nomadicretail/xnomad/packages/ui",
          config = function()
            require("core.utils").set_compiler("tsc", {
              pattern = { "typescript", "typescriptreact" },
              cmd = "pnpm build:ts",
            })
            require("core.utils").set_compiler("sass", {
              pattern = { "scss" },
              cmd = "pnpm build:sass",
            })
          end,
        },
      },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = "DBUI",
    dependencies = {
      { "tpope/vim-dadbod", cmd = "DB" },
    },
    config = function()
      local group = vim.api.nvim_create_augroup("dbui-overrides", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "dbui",
        callback = function()
          vim.schedule(function()
            vim.wo.winhighlight = "Normal:NormalSB,SignColumn:SignColumnSB"
          end)
        end,
      })
    end,
  },
  {
    "rest-nvim/rest.nvim",
    keys = { {
      "g<space>",
      "<Plug>RestNvim",
    } },
    ft = "http",
    config = true,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    init = function()
      require("core.utils").load_keymap "dap"
    end,
    dependencies = {
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
    config = function()
      local dapui = require "dapui"
      local dap = require "dap"

      local signs = {
        { name = "DapBreakpoint", text = "", hl = "DapBreakpoint" },
        { name = "DapBreakpointCondition", text = "ﳁ", hl = "DapBreakpoint" },
        { name = "DapBreakpointRejected", text = "", hl = "DapBreakpoint" },
        { name = "DapLogPoint", text = "" },
        { name = "DapStopped", text = "" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.hl or sign.name, text = sign.text, numhl = "" })
      end

      dap.listeners.after.event_initialized["dapui"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui"] = function()
        dapui.close()
      end

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "js-debug-adapter",
          args = { "${port}" },
        },
      }

      dap.adapters["node2"] = {
        type = "executable",
        command = "node-debug2-adapter",
      }

      for _, language in ipairs { "typescript", "javascript" } do
        require("dap").configurations[language] = {
          {
            name = "Attach to process",
            type = "node2",
            request = "attach",
            processId = require("dap.utils").pick_process,
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
  {
    "rcarriga/neotest",
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-vitest",
        },
      }
    end,
  },
}
