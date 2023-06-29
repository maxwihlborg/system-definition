return {
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      { "folke/neodev.nvim", opts = {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      } },
      { "jose-elias-alvarez/nvim-lsp-ts-utils" },
      { "marilari88/twoslash-queries.nvim" },
      { "ray-x/lsp_signature.nvim" },
      {
        "j-hui/fidget.nvim",
        tag = "legacy",
        opts = {
          align = {
            bottom = true,
            right = true,
          },
          window = {
            relative = "win",
            blend = 0,
            zindex = nil,
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
        config = true,
      },
    },
    config = function()
      require "pde.lsp"
    end,
  },
  {
    "DNLHC/glance.nvim",
    cmd = "Glance",
    config = function()
      local glance = require "glance"
      local actions = glance.actions

      glance.setup {
        mappings = {
          list = {
            ["j"] = actions.next, -- Bring the cursor to the next item in the list
            ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
            ["<C-n>"] = actions.next_location,
            ["<C-p>"] = actions.previous_location,
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["v"] = actions.jump_vsplit,
            ["s"] = actions.jump_split,
            ["t"] = actions.jump_tab,
            ["<CR>"] = actions.jump,
            ["o"] = actions.jump,
            ["<C-h>"] = actions.enter_win "preview", -- Focus preview window
            ["<C-j>"] = actions.close,
            ["<C-k>"] = actions.close,
            ["<C-l>"] = actions.close,
            ["q"] = actions.close,
          },
          preview = {
            ["q"] = actions.close,
            ["<C-n>"] = actions.next_location,
            ["<C-p>"] = actions.previous_location,
            ["<C-l>"] = actions.enter_win "list", -- Focus preview window
          },
        },
        folds = {
          fold_closed = "",
          fold_open = "",
          folded = true, -- Automatically fold list on startup
        },
      }
    end,
  },
}
