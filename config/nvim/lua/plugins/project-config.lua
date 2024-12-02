return {
  "windwp/nvim-projectconfig",
  event = "BufReadPre",
  dependencies = "neovim/nvim-lspconfig",
  opts = {
    project_config = {
      {
        path = vim.fn.expand "~/ghq/github.com/nomadicretail/xnomad/apps/web",
        config = function()
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
                    if nn[2] == "Warning" or nn[2] == "Error" then
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
      {
        path = vim.fn.expand "~/ghq/github.com/walktheroom",
        config = function()
          local config = require "pde.lsp.config"
          local utils = require "pde.utils"
          local lspconfig = require "lspconfig"

          lspconfig.csharp_ls.setup(config.get_options "csharp_ls")

          utils.set_compiler("tsc", {
            pattern = { "typescript", "typescriptreact", "json", "jsonc" },
            cmd = function()
              local dir = utils.find_package_json_dir()
              assert(dir ~= nil, "Could not find root dir")
              if utils.ends_with(dir, "wtr-admin") then
                return string.format("pnpm --dir %s exec tsc", dir)
              end
              if utils.ends_with(dir, "apps/studio") then
                return string.format("pnpm --dir %s exec tsc -b", dir)
              end
              if utils.ends_with(dir, "packages/ui") then
                return string.format("pnpm --dir %s run build:ts", dir)
              end

              return string.format("pnpm --dir %s run build", dir)
            end,
          })
        end,
      },
    },
  },
}
