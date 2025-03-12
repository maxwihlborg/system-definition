return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    { "jose-elias-alvarez/nvim-lsp-ts-utils" },
    { "marilari88/twoslash-queries.nvim" },
    { "ray-x/lsp_signature.nvim" },
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
    {
      "williamboman/mason.nvim",
      cmd = {
        "Mason",
        "MasonInstall",
        "MasonInstallAll",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
      },
      dependencies = {
        {
          "williamboman/mason-lspconfig.nvim",
          cmd = { "LspInstall", "LspUninstall" },
        },
      },
      opts = true,
    },
  },
  init = function() require "pde.lsp" end,
}
