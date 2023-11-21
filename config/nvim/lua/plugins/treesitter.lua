return {
  {
    "danymat/neogen",
    lazy = true,
    init = function()
      require("pde.utils").load_keymap "neogen"
    end,
    config = true,
  },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "nkrkv/nvim-treesitter-rescript" },
      { "serenadeai/tree-sitter-scss" },
    },
    config = function()
      local config = require "nvim-treesitter.configs"
      local parsers = require "nvim-treesitter.parsers"

      local parser_config = parsers.get_parser_configs()

      parser_config.haxe = {
        install_info = {
          url = "https://github.com/vantreeseba/tree-sitter-haxe",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "haxe",
      }
      parser_config.just = {
        install_info = {
          url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
          files = { "src/parser.c", "src/scanner.cc" },
          branch = "main",
          use_makefile = true,
        },
        maintainers = { "@IndianBoy42" },
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
          "scss",
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
          "html",
          "http",
          "javascript",
          "jsdoc",
          "json",
          "jsonc",
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
          "rescript",
          "ruby",
          "rust",
          "scss",
          "svelte",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vue",
          "wgsl",
          "haxe",
          "yaml",
          "zig",
        },
        indent = {
          enable = false,
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<cr>", -- set to `false` to disable one of the mappings
            scope_incremental = "<cr>",
            node_incremental = "<tab>",
            node_decremental = "<s-tab>",
          },
        },
        textobjects = {
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
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
