return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "jose-elias-alvarez/nvim-lsp-ts-utils",
      "marilari88/twoslash-queries.nvim",
      "saghen/blink.cmp",
      {
        "j-hui/fidget.nvim",
        opts = {
          progress = {
            display = {
              done_icon = "󰄬",
            },
          },
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
    },
    init = function() require "pde.lsp" end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  },
  {
    "mason-org/mason.nvim",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    opts = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    event = "BufReadPre",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mason-org/mason.nvim",
    },
    opts = {
      automatic_enable = false,
    },
  },
}
