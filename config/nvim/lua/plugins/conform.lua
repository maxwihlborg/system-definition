return {
  "stevearc/conform.nvim",
  init = function()
    require("pde.utils").load_keymap "conform"
  end,
  config = function()
    local conform = require "conform"
    local util = require "conform.util"

    local formatters = {
      rescript = {
        command = util.from_node_modules "rescript",
        args = { "format", "-stdin", "$FILENAME" },
        cwd = util.root_file {
          "bsconfig.json",
          "package.json",
        },
      },
      biome = {
        command = util.from_node_modules "biome",
        args = { "format", "--stdin-file-path", "$FILENAME" },
        cwd = util.root_file {
          "biome.json",
          "package.json",
        },
      },
    }

    local formatters_by_ft = {
      lua = { "stylua" },
      nix = { "nixpkgs_fmt" },
      fish = { "fish_indent" },
      glsl = { "clang_format" },
      go = { "gofmt" },
      rust = { "rustfmt" },
      sql = { "sql_formatter" },
      rescript = { "rescript" },
      php = { "phpcbf" },
    }

    local prettier_fts = {
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
    }

    for _, ft in ipairs(prettier_fts) do
      formatters_by_ft[ft] = { { "prettierd", "prettier" } }
    end

    conform.setup {
      formatters_by_ft = formatters_by_ft,
      formatters = formatters,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    }
  end,
}
