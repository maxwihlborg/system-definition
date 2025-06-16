return {
  {
    "kylechui/nvim-surround",
    opts = true,
  },
  {
    "numToStr/Comment.nvim",
    opts = true,
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {},
  },
  {
    "tpope/vim-abolish",
    cmd = "Subvert",
  },
  {
    "stevearc/quicker.nvim",
    ft = { "qf" },
    keys = {
      { "<leader>cc", function() require("quicker").toggle { height = 10 } end },
      { "<leader>co", function() require("quicker").toggle { height = 10 } end },
    },
    opts = true,
  },
  {
    "niilohlin/neoindent",
    opts = true,
  },
  {
    "stevearc/aerial.nvim",
    opts = {
      nav = { border = "single" },
    },
  },
  {
    "ThePrimeagen/harpoon",
    lazy = true,
    opts = {
      menu = { width = 80 },
    },
    init = function()
      require("pde.utils").load_keymap(function()
        local nmaps = {
          ["<leader>h"] = { function() require("harpoon.mark").add_file() end },
          ["<leader>m"] = { function() require("harpoon.ui").toggle_quick_menu() end },
        }
        for i = 1, 9, 1 do
          nmaps[string.format("<leader>%i", i)] = {
            function() require("harpoon.ui").nav_file(i) end,
            { desc = string.format("Harpoon move (%i)", i) },
          }
        end

        return {
          ["n"] = nmaps,
        }
      end)
    end,
  },
  {
    "kazhala/close-buffers.nvim",
    cmd = { "BDelete", "BWipeout" },
    opts = {
      preserve_window_layout = { "this" },
    },
    init = function()
      require("pde.utils").load_keymap {
        ["cmd"] = {
          ["CloseHiddenBuffers"] = {
            function() require("close_buffers").delete { type = "hidden" } end,
          },
          ["CloseNamelessBuffers"] = {
            function() require("close_buffers").delete { type = "nameless" } end,
          },
        },
      }
    end,
  },
  {
    "numToStr/Navigator.nvim",
    opts = true,
    cmd = {
      "NavigatorRight",
      "NavigatorLeft",
      "NavigatorDown",
      "NavigatorUp",
    },
    init = function()
      require("pde.utils").load_keymap {
        [{ "n", "i" }] = {
          ["<C-j>"] = { "<cmd>NavigatorDown<cr>" },
          ["<C-k>"] = { "<cmd>NavigatorUp<cr>" },
        },
        [{ "n" }] = {
          ["<C-l>"] = { "<cmd>NavigatorRight<cr>" },
          ["<C-h>"] = { "<cmd>NavigatorLeft<cr>" },
        },
        ["t"] = {
          ["<C-l>"] = { "<c-\\><c-n>:NavigatorRight<cr>" },
          ["<C-h>"] = { "<c-\\><c-n>:NavigatorLeft<cr>" },
        },
      }
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
      },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name) return name == ".DS_Store" end,
      },
    },
    keys = {
      { "-", "<cmd>Oil<cr>" },
    },
  },
  {
    "danymat/neogen",
    opts = true,
    keys = {
      { "<leader>dg", "<cmd>Neogen func<cr>" },
    },
  },
  {
    "mattn/emmet-vim",
    keys = {
      { "<C-e>", "<Plug>(emmet-expand-abbr)", silent = true, mode = "i" },
    },
    init = function() vim.g.user_emmet_install_global = 1 end,
  },
  {
    "ecthelionvi/NeoSwap.nvim",
    opts = true,
    keys = {
      { "<leader>th", "<cmd>NeoSwapPrev<cr>", silent = true },
      { "<leader>tl", "<cmd>NeoSwapNext<cr>", silent = true },
    },
  },
  {
    "junegunn/vim-easy-align",
    keys = {
      { "ga", "<Plug>(EasyAlign)", silent = true, mode = { "n", "x" } },
    },
  },
}
