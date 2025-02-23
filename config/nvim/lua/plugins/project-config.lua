return {
  "windwp/nvim-projectconfig",
  event = "BufReadPre",
  dependencies = "neovim/nvim-lspconfig",
  opts = {
    project_config = {
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
