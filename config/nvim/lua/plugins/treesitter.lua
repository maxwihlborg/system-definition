return {
  {
    "danymat/neogen",
    lazy = true,
    init = function()
      require("pde.utils").load_keymap "neogen"
    end,
    config = true,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nkrkv/nvim-treesitter-rescript" },
      { "IndianBoy42/tree-sitter-just", opts = true },
      { "serenadeai/tree-sitter-scss" },
    },
    config = function()
      local config = require "nvim-treesitter.configs"
      local parsers = require "nvim-treesitter.parsers"

      local parser_config = parsers.get_parser_configs()

      parser_config.haxe = {
        install_info = {
          url = "https://github.com/vantreeseba/tree-sitter-haxe",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "haxe",
      }

      config.setup {
        ensure_installed = {
          "bash",
          "c",
          "c_sharp",
          "clojure",
          "cmake",
          "comment",
          "cpp",
          "css",
          "dockerfile",
          "elixir",
          "elm",
          "fish",
          "gdscript",
          "glsl",
          "go",
          "godot_resource",
          "gomod",
          "gowork",
          "graphql",
          "haxe",
          "html",
          "http",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
          "just",
          "kdl",
          "kotlin",
          "lua",
          "make",
          "markdown",
          "ninja",
          "nix",
          "php",
          "prisma",
          "pug",
          "python",
          "query",
          "regex",
          "ruby",
          "rust",
          "scss",
          "scss",
          "sql",
          "svelte",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "wgsl",
          "yaml",
          "zig",
        },
        indent = {
          enable = true,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<cr>",
            scope_incremental = "<cr>",
            node_incremental = "<tab>",
            node_decremental = "<s-tab>",
          },
        },
        textobjects = {
          swap = {
            enable = true,
            swap_previous = {
              ["<leader>tah"] = "@parameter.inner",
            },
            swap_next = {
              ["<leader>tal"] = "@parameter.inner",
            },
          },
          select = {
            enable = true,
            lookahead = true,

            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",

              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",

              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",

              ["av"] = "@variable.outer",
              ["iv"] = "@variable.inner",
            },
          },
        },
      }
    end,
  },
}
