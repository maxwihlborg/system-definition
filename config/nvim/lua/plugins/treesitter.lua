return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      branch = "main",
      opts = {
        select = { lookahead = true },
      },
      init = function()
        local select_sym = function(qs)
          local m = require "nvim-treesitter-textobjects.select"
          return function() m.select_textobject(qs, "textobjects") end
        end
        local swap_prev = function(qs)
          local m = require "nvim-treesitter-textobjects.swap"
          return function() m.swap_previous(qs) end
        end
        local swap_next = function(qs)
          local m = require "nvim-treesitter-textobjects.swap"
          return function() m.swap_next(qs) end
        end
        require("pde.utils").load_keymap {
          [{ "x", "o" }] = {
            ["af"] = { select_sym "@function.outer" },
            ["if"] = { select_sym "@function.inner" },

            ["ac"] = { select_sym "@conditional.outer" },
            ["ic"] = { select_sym "@conditional.inner" },

            ["aa"] = { select_sym "@parameter.outer" },
            ["ia"] = { select_sym "@parameter.inner" },

            ["av"] = { select_sym "@variable.outer" },
            ["iv"] = { select_sym "@variable.inner" },
          },
          [{ "n" }] = {
            ["<leader>tah"] = { swap_prev "@parameter.inner" },
            ["<leader>tal"] = { swap_next "@parameter.inner" },
          },
        }
      end,
    },
  },
  init = function()
    local parsers = {
      "bash",
      "c",
      "c_sharp",
      "cmake",
      "css",
      "dockerfile",
      "elm",
      "fish",
      "glsl",
      "go",
      "graphql",
      "html",
      "http",
      "javascript",
      "jsdoc",
      "json",
      "just",
      "kdl",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "nix",
      "php",
      "prisma",
      "python",
      "rust",
      "scss",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "wgsl",
      "yaml",
      "clojure",
      "comment",
      "cpp",
      "elixir",
      "gdscript",
      "godot_resource",
      "gomod",
      "gowork",
      "kotlin",
      "ninja",
      "pug",
      "query",
      "regex",
      "ruby",
      "svelte",
      "vue",
      "zig",
    }

    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf, filetype = args.buf, args.match

        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
          return
        end

        -- check if parser exists and load it
        if not vim.treesitter.language.add(language) then
          return
        end

        -- enables syntax highlighting and other treesitter features
        vim.treesitter.start(buf, language)

        -- enables treesitter based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
