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
            require("pde.lsp.utils").setup_autostart "graphql"
            require("pde.utils").set_compiler("tsc", {
              pattern = { "typescript", "typescriptreact" },
              cmd = "pnpm tsc",
            })

            vim.api.nvim_create_user_command("CheckTranslation", function()
              local split = require "pde.split"
              local items = {}
              vim.fn.jobstart("pnpm i18n:check -v", {
                cwd = vim.fn.expand "~/ghq/github.com/nomadicretail/xnomad/apps/web",
                on_exit = function()
                  vim.fn.setqflist(items)
                  vim.cmd "copen"
                end,
                on_stderr = function(_pid, data)
                  for _, n in ipairs(data) do
                    if string.sub(n, 1, 1) == "/" then
                      local nn = split.split(n, ": ")
                      if nn[2] == "Warning" then
                        table.insert(items, {
                          filename = nn[1],
                          text = nn[3],
                        })
                      end
                    end
                  end
                end,
              })
            end, {})
          end,
        },
        {
          path = vim.fn.expand "~/ghq/github.com/nomadicretail/xnomad/packages/ui",
          config = function()
            require("pde.utils").set_compiler("tsc", {
              pattern = { "typescript", "typescriptreact" },
              cmd = "pnpm build:ts",
            })
            require("pde.utils").set_compiler("sass", {
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
      require("pde.utils").load_keymap "dap"
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
      require "pde.dap"
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
