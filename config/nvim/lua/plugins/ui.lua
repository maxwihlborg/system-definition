return {
  { "kyazdani42/nvim-web-devicons" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-lua/popup.nvim" },
  {
    "rebelot/kanagawa.nvim",
    opts = {
      compile = true,
      undercurl = true,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = { bg_gutter = "none" },
          },
        },
      },
      overrides = function(colors)
        local c = colors.theme
        local p = colors.palette
        return {
          DrexRoot = { fg = p.roninYellow, bg = c.ui.bg_dim, bold = true },
          DrexDir = { link = "Directory" },
          DrexLink = { link = "Type" },
          DrexOthers = { fg = c.syn.string, bold = true },
          DrexMarked = { link = "Substitute" },
          DrexSelected = { link = "Visual" },

          NormalSB = { fg = c.ui.fg_dim, bg = c.ui.bg_dim },

          WinSeparator = { fg = c.ui.bg, bg = c.ui.bg_dim },
          VertSplit = { fg = c.ui.bg, bg = c.ui.bg_dim },
          WinBar = { fg = c.ui.fg_dim, bg = c.ui.bg_dim },
          WinBarNC = { fg = c.ui.fg_dim, bg = c.ui.bg_dim },
          TermWinBarActive = { bg = c.diff.change, fg = c.syn.fun },
          TermWinBarInactive = { bg = c.ui.bg_p1, fg = c.ui.fg },

          DapBreakpoint = { fg = p.autumnRed },
          DapLogPoint = { fg = p.waveBlue2 },
          DapStopped = { fg = p.springGreen },

          ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
          ["@markup.link.label.markdown_inline"] = { fg = p.roninYellow, underline = true, sp = p.springBlue }, -- [label]
          ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
          ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
          ["@markup.list.markdown"] = { link = "Function" }, -- + list
          ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
        }
      end,
    },
    priority = 1000,
    build = function() vim.cmd [[KanagawaCompile]] end,
    init = function() vim.cmd [[colorscheme kanagawa]] end,
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = {},
    },
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<C-t>", mode = { "n", "i", "v" } },
    },
    init = function()
      local group = vim.api.nvim_create_augroup("CoreToggleTerm", { clear = true })
      vim.api.nvim_create_autocmd("TermOpen", {
        group = group,
        pattern = { "term://*toggleterm#*" },
        callback = function()
          require("pde.utils").load_keymap("terminal", {
            buffer = 0,
          })
        end,
      })
    end,
    opts = {
      open_mapping = "<C-t>",
      shade_terminals = false,
      hide_numbers = true,
      highlights = {
        Normal = { link = "NormalSB" },
        NormalFloat = { link = "NormalFloat" },
        WinBarActive = { link = "TermWinBarActive" },
        WinBarInactive = { link = "TermWinBarInactive" },
      },
      winbar = {
        enabled = true,
        name_formatter = function(term) return " " .. term.name .. " " end,
      },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun" },
    keys = {
      { "<leader>cg", "<cmd>ChatGPT<cr>" },
    },
    opts = {
      api_key_cmd = "cat ~/.config/sops-nix/secrets/open_api_token",
      openai_params = {
        max_tokens = 2000,
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "folke/trouble.nvim",
    cmd = {
      "Trouble",
      "TroubleClose",
      "TroubleRefresh",
      "TroubleToggle",
    },
    opts = {
      use_diagnostic_signs = true,
    },
  },
  {
    "stevearc/quicker.nvim",
    ft = { "qf" },
    opts = true,
  },
  {
    "utilyre/barbecue.nvim",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    opts = {
      attach_navic = false,
      show_dirname = false,
      show_modified = false,
      show_basename = false,
      symbols = {
        modified = "●",
        ellipsis = "…",
        separator = "",
      },
      theme = {
        normal = { bg = "#181820" },
      },
    },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = "DBUI",
    dependencies = {
      { "tpope/vim-dadbod", cmd = "DB" },
    },
    keys = {
      { "<leader>cb", "<cmd>DBUI<cr>" },
    },
    config = function()
      local group = vim.api.nvim_create_augroup("dbui-overrides", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "dbui",
        callback = function()
          vim.schedule(function() vim.wo.winhighlight = "Normal:NormalSB,SignColumn:SignColumnSB" end)
        end,
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
  {
    "nanozuki/tabby.nvim",
    config = function()
      local tabby = require "tabby.tabline"

      local theme = {
        fill = "lualine_c_normal",
        head = "lualine_a_normal",
        current_tab = "lualine_b_normal",
        tab = "lualine_c_normal",
        win = "lualine_c_normal",
        tail = "lualine_c_normal",
      }

      tabby.set(function(line)
        return {
          {
            { "  ", hl = theme.head },
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "",
              tab.number(),
              tab.name(),
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(
            function(win)
              return {
                line.sep("", theme.win, theme.fill),
                win.is_current() and "" or "",
                win.buf_name(),
                hl = theme.win,
                margin = " ",
              }
            end
          ),
          {
            { "  ", hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
    end,
  },
}
