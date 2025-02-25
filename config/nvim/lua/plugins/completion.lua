return {
  "saghen/blink.cmp",
  build = "nix run .#build-plugin",
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
  opts = {
    keymap = {
      preset = "default",
      ["<c-e>"] = {},
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

      accept = {
        auto_brackets = { enabled = false },
      },

      ghost_text = {
        enabled = true,
        show_without_selection = true,
      },
    },

    sources = {
      default = { "snippets", "lsp", "path", "buffer" },
    },
  },
}
