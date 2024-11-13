return {
  "stevearc/conform.nvim",
  init = function()
    require("pde.utils").load_keymap "conform"
  end,
  config = function()
    local conform = require "conform"
    local prettier = require "conform.formatters.prettier"
    local util = require "conform.util"

    local formatters = {
      biome = {
        command = util.from_node_modules "biome",
        args = { "format", "--stdin-file-path", "$FILENAME" },
        cwd = util.root_file {
          "biome.json",
          "package.json",
        },
      },
      rescript = {
        command = util.from_node_modules "rescript",
        args = { "format", "-stdin", "$FILENAME" },
        cwd = util.root_file {
          "bsconfig.json",
          "package.json",
        },
      },
      csharpier_local = {
        command = "dotnet csharpier",
        args = { "--write-stdout" },
        stdin = true,
      },
    }

    local formatters_by_ft = {
      cs = { "csharpier_local" },
      fish = { "fish_indent" },
      glsl = { "clang_format" },
      go = { "gofmt" },
      just = { "just" },
      lua = { "stylua" },
      nix = { "nixpkgs_fmt" },
      php = { "phpcbf" },
      rescript = { "rescript" },
      rust = { "rustfmt" },
      sql = { "pg_format" },
    }

    local prettier_fts = {
      "css",
      "graphql",
      "html",
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "markdown",
      "markdown.mdx",
      "scss",
      "typescript",
      "svg",
      "typescriptreact",
      "xml",
      "yaml",
    }

    prettier.options.ft_parsers = {
      svg = "html",
    }

    for _, ft in ipairs(prettier_fts) do
      formatters_by_ft[ft] = { "prettier" }
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
