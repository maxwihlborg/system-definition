return {
  "saghen/blink.cmp",
  build = "nix run .#build-plugin",
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
  opts = {
    keymap = {
      preset = "default",
      ["<cr>"] = { "select_and_accept", "fallback" },
    },
    snippets = { preset = "luasnip" },

    cmdline = { enabled = false },
    signature = { enabled = true },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      accept = {
        auto_brackets = { enabled = false },
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
