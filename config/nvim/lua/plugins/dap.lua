return {
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = "DBUI",
    dependencies = {
      { "tpope/vim-dadbod", cmd = "DB" },
    },
    config = function()
      local group = vim.api.nvim_create_augroup("dbui-overrides", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "dbui",
        callback = function()
          vim.schedule(function()
            vim.wo.winhighlight = "Normal:NormalSB,SignColumn:SignColumnSB"
          end)
        end,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    init = function()
      require("pde.utils").load_keymap "dap"
    end,
    dependencies = {
      {
        "NicholasMata/nvim-dap-cs",
        config = true,
      },
      {
        "rcarriga/nvim-dap-ui",
        cmd = { "DapContinue" },
        opts = {
          icons = {
            collapsed = "",
            current_frame = "",
            expanded = "",
          },
        },
      },
    },
    config = function()
      require "pde.dap"
    end,
  },
  {
    "rcarriga/neotest",
    ft = { "typescript", "typescriptreact" },
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-vitest",
        },
      }
    end,
  },
}
