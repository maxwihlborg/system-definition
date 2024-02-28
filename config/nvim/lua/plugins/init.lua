return {
  { "folke/lazy.nvim" },

  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  { "kyazdani42/nvim-web-devicons" },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd [[colorscheme tokyonight ]]
    end,
    opts = {
      style = "night",
      transparent = true,
      sidebars = {
        "yanil",
        "help",
        "terminal",
        "Trouble",
        "qf",
        "packer",
      },
      on_highlights = function(h, c)
        -- Yanil
        h["YanilTreeRoot"] = { fg = c.yellow, bold = true }
        h["YanilTreeDirectory"] = { fg = c.blue, bg = c.none }
        h["YanilTreeDirectoryIcon"] = { fg = c.teal, bg = c.none }
        h["YanilTreeFile"] = { fg = c.fg_sidebar, bg = c.none }
        h["YanilTreeFileExecutable"] = { fg = c.yellow, bold = true }
        h["YanilTreeFileReadonly"] = { fg = c.red }
        h["YanilTreeLink"] = { fg = c.comment, italic = true }
        h["YanilTreeLinkBroken"] = { fg = c.comment, italic = true, underline = true }
        h["YanilTreeLinkArrow"] = { fg = c.comment }
        h["YanilTreeLinkTo"] = { fg = c.comment, italic = true }
        h["MsgArea"] = { fg = c.fg_dark }

        h["WinBar"] = { fg = c.fg_sidebar, bg = c.bg_sidebar }
        h["TermWinBarActive"] = { fg = c.blue, bg = c.fg_gutter }
        h["TermWinBarInactive"] = { fg = c.fg_sidebar, bg = c.bg_statusline }

        h["GlanceFoldIcon"] = h["YanilTreeDirectoryIcon"]
        h["GlanceListFilename"] = h["YanilTreeDirectory"]

        h["DrexDir"] = h["YanilTreeDirectory"]
        h["DrexRoot"] = { fg = c.yellow, bold = true, bg = c.bg_sidebar }

        h["DapBreakpoint"] = { fg = c.red, bg = c.none }
        h["DapLogPoint"] = { fg = c.blue, bg = c.none }
        h["DapStopped"] = { fg = c.green, bg = c.none }
      end,
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateRight",
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      require("pde.utils").load_keymap "vim-tmux-navigator"
    end,
  },
  {
    "mattn/emmet-vim",
    keys = {
      { "<C-e>", "<Plug>(emmet-expand-abbr)", silent = true, mode = "i" },
    },
    config = function()
      vim.g.user_emmet_install_global = 1
    end,
  },
  { "alec-gibson/nvim-tetris", cmd = "Tetris" },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  { "kylechui/nvim-surround", config = true },
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
  },
  {
    "kazhala/close-buffers.nvim",
    lazy = true,
    init = function()
      require("pde.utils").load_keymap "close-buffers"
    end,
    opts = {
      preserve_window_layout = { "this" },
    },
  },
  {
    "stevearc/oil.nvim",
    lazy = true,
    init = function()
      require("pde.utils").load_keymap "oil"
    end,
    opts = {
      columns = {
        -- "permissions",
        -- "size",
        "icon",
        -- "mtime",
      },
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
      },
    },
  },
  {
    "ecthelionvi/NeoSwap.nvim",
    cmd = { "NeoSwapPrev", "NeoSwapNext" },
    init = function()
      require("pde.utils").load_keymap "neo-swap"
    end,
    config = true,
  },
  {
    "junegunn/vim-easy-align",
    lazy = false,
    init = function()
      require("pde.utils").load_keymap "easy-align"
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    opts = {
      api_key_cmd = "vsh decrypt vsh:v1:h35v--0P:yyfJS_mkDWCcMYC7x7_rdV7iQB3qLCZE9HJyWvaO-qvmDa3K1-f-PazoE0ZEGFLcNQFh",
      openai_params = {
        max_tokens = 2000,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
