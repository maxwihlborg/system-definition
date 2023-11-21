local M = {}

function M.setup()
  local fmt = require "pde.formatter.formatters"
  local formatter = require "formatter"

  local formatterConfig = {
    fish = { require("formatter.filetypes.fish").fishindent },
    glsl = { require("formatter.filetypes.c").clangformat },
    go = { require("formatter.filetypes.go").gofmt },
    rust = { require("formatter.filetypes.rust").rustfmt },
    css = { require("formatter.filetypes.css").prettier },
    php = { require("formatter.filetypes.php").phpcbf },
    lua = { require("formatter.filetypes.lua").stylua },
    nix = { require("formatter.filetypes.nix").nixpkgs_fmt },
    -- html = { require("formatter.filetypes.html").htmlbeautify },
    -- typescript = { M.rome },
    -- prisma = { M.lsp_formatting },
    rescript = { fmt.rescript_fmt },
    sql = { fmt.sql_formatter },
  }

  local util = require "formatter.util"

  local commonFT = {
    "css",
    "scss",
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "markdown",
    "markdown.mdx",
    "graphql",
    "json",
    "jsonc",
    "yaml",
    "xml",
    "svelte",
  }

  for _, ft in ipairs(commonFT) do
    formatterConfig[ft] = { util.withl(require "formatter.defaults.prettier") }
  end

  formatter.setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = formatterConfig,
  }
end

return M
