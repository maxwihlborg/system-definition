return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "saghen/blink.cmp",
    build = "nix run .#build-plugin",
    dependencies = {
      "L3MON4D3/LuaSnip",
    },
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<c-e>"] = {},
        ["<c-k>"] = {},
        ["<cr>"] = { "select_and_accept", "fallback" },
      },
      snippets = { preset = "luasnip" },

      fuzzy = {
        use_proximity = false,
        sorts = { "exact", "score", "sort_text" },
      },

      cmdline = { enabled = false },
      signature = { enabled = true },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        list = { selection = { preselect = false } },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 0,
        },

        accept = {
          auto_brackets = { enabled = false },
        },

        ghost_text = {
          enabled = false,
          show_without_selection = true,
        },
      },

      sources = {
        default = { "lazydev", "lsp", "path", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },
    },
  },
}
