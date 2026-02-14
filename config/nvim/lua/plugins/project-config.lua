return {
  "windwp/nvim-projectconfig",
  event = "BufReadPre",
  dependencies = "neovim/nvim-lspconfig",
  opts = {
    project_config = {
      {
        path = vim.fn.expand "~/ghq/github.com/maxwihlborg",
        config = function()
          local utils = require "pde.utils"

          utils.set_compiler("tsc", {
            pattern = { "typescript", "typescriptreact", "json", "jsonc" },
            cmd = function()
              local dir = utils.find_package_json_dir()
              assert(dir ~= nil, "Could not find root dir")

              return string.format("pnpm --dir %s run build", dir)
            end,
          })
        end,
      },
      {
        path = vim.fn.expand "~/ghq/github.com/walktheroom",
        config = function()
          local utils = require "pde.utils"
          vim.lsp.enable("omnisharp", true)

          utils.set_compiler("tsc", {
            pattern = { "typescript", "typescriptreact", "json", "jsonc" },
            cmd = function()
              local dir = utils.find_package_json_dir()
              assert(dir ~= nil, "Could not find root dir")
              if
                utils.ends_with(dir, "apps/platform")
                or utils.ends_with(dir, "apps/studio")
                or utils.ends_with(dir, "apps/auth")
                or utils.ends_with(dir, "apps/api")
                or utils.ends_with(dir, "wtr-admin")
              then
                return string.format("pnpm --dir %s exec tsc -b", dir)
              end
              if utils.ends_with(dir, "apps/clients") then
                return string.format("pnpm --dir %s exec tsc", dir)
              end
              if utils.ends_with(dir, "packages/ui") or utils.ends_with(dir, "packages/gis") then
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
