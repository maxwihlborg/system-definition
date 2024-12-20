local M = {}

M["close"] = function(opts)
  return {
    ["n"] = {
      ["q"] = { "<cmd>q<cr>", opts },
    },
  }
end

M["help"] = function(opts)
  return {
    ["n"] = {
      ["gd"] = { "<c-]>", opts },
    },
  }
end

M["main"] = {
  ["cmd"] = {
    ["ClassNames"] = { ':%s/className="\\([^"]\\+\\)"/className={css["\\1"]}/g' },
    ["Twind"] = { ':%s/className="\\([^"]\\+\\)"/className={tw("\\1")}/g' },
  },
  ["n"] = {
    ["<c-b>"] = { "<c-d>zz" },
    ["<c-d>"] = { "<c-b>zz" },
    ["j"] = { "gj" },
    ["k"] = { "gk" },
    ["Q"] = { "<nop>" },

    ["H"] = { "<cmd>tabp<cr>" },
    ["L"] = { "<cmd>tabn<cr>" },
    ["Ä"] = { "<cmd>cprevious<cr>" },
    ["Ö"] = { "<cmd>cnext<cr>" },

    ["<esc>"] = { "<cmd>noh<cr>" },

    ["<leader>ca"] = { "<cmd>Lazy<cr>" },
    ["<leader>cb"] = { "<cmd>DBUI<cr>" },
    ["<leader>cc"] = { "<cmd>cclose<cr>" },
    ["<leader>ce"] = {
      function()
        vim.ui.input({ prompt = "Command" }, function(input)
          if input ~= nil then
            vim.cmd(([[cexpr system("%s") | copen]]):format(input))
          end
        end)
      end,
    },
    ["<leader>cg"] = { "<cmd>ChatGPT<cr>" },
    ["<leader>cm"] = { "<cmd>Mason<cr>" },
    ["<leader>co"] = { "<cmd>copen<cr>" },
    ["<leader>a"] = { "<cmd>w<cr>" },
    ["<leader>q"] = { "<cmd>q<cr>" },
    ["<leader>tt"] = { "<cmd>tabe<cr>" },
    ["<leader>o"] = { "vip:sort<cr>" },
    ["<leader><leader>o"] = { "vi{:sort<cr>" },
    ["<leader>x"] = { "<cmd>w|luafile %<cr>" },
    ["<leader>g"] = { "<cmd>LazyGit<cr>" },
    ["<leader>cd"] = { "<cmd>LazyDocker<cr>" },

    ["<bar>"] = { ":m .+1<cr>==" },
    ["!"] = { ":m .-2<cr>==" },
  },
  ["v"] = {
    ["<leader>o"] = { ":sort<cr>" },
    ["<bar>"] = { ":m '>+1<cr>gv=gv" },
    ["!"] = { ":m '<-2<cr>gv=gv" },
  },
  [{ "n", "v" }] = {
    ["J"] = { "8j" },
    ["K"] = { "8k" },
    ["ä"] = { "{" },
    ["ö"] = { "}" },
    ["s"] = { ":", { nowait = true } },
    ["S"] = { ":", { nowait = true } },
  },
}

M["conform"] = {
  ["n"] = {
    ["<leader>f"] = {
      function()
        require("conform").format {
          lsp_fallback = true,
        }
      end,
    },
  },
}

M["terminal"] = function(opts)
  return {
    ["t"] = {
      ["<esc>"] = { "<C-\\><C-n>", opts },
    },
    ["n"] = {
      ["q"] = { "<cmd>close<cr>", opts },
    },
  }
end

M["telescope"] = {
  ["cmd"] = {
    ["History"] = {
      function()
        require("telescope").extensions.git_file_history.git_file_history()
      end,
    },
    ["Commands"] = {
      function()
        require("telescope.builtin").commands()
      end,
    },
    ["Help"] = {
      function()
        require("telescope.builtin").help_tags()
      end,
    },
    ["Fd"] = {
      function(opts)
        require("telescope.builtin").find_files {
          find_command = function()
            return vim.list_extend({ "fd", "--color", "never" }, opts.fargs)
          end,
        }
      end,
      { nargs = "*" },
    },
    ["Rg"] = {
      function(opts)
        require("telescope.builtin").grep_string {
          search = opts.args,
        }
      end,
      { nargs = "*" },
    },
    ["Rgg"] = {
      function(opts)
        require("telescope.builtin").find_files {
          find_command = function()
            return vim.list_extend({ "rg", "--color=never", "-l" }, opts.fargs)
          end,
        }
      end,
      { nargs = "*" },
    },
  },
  ["n"] = {
    ["<c-f>"] = { "<cmd>Telescope live_grep<cr>" },
    ["<c-u>"] = { "<cmd>Telescope find_files<cr>" },
    ["<c-c>"] = { "<cmd>Telescope command_history<cr>" },
    ["?"] = { "<cmd>Telescope resume<cr>" },
    ["<leader>u"] = { "<cmd>Telescope buffers<cr>" },
  },
}

M["lsp.ts"] = function(opts)
  return {
    ["n"] = {
      ["<leader>rf"] = { "<cmd>TSLspRenameFile<cr>", opts },
      ["<leader>i"] = { "<cmd>InspectTwoslashQueries<cr>", opts },
    },
  }
end

M["lsp"] = function(opts)
  return {
    ["n"] = {
      ["gt"] = { "<cmd>Telescope lsp_type_definitions<cr>", opts },
      ["gi"] = { "<cmd>Telescope lsp_implementations<cr>", opts },
      ["gd"] = { "<cmd>Telescope lsp_definitions<cr>", opts },
      ["gr"] = { "<cmd>Telescope lsp_references<cr>", opts },
      ["gT"] = { "<cmd>Glance type_definitions<cr>", opts },
      ["gI"] = { "<cmd>Glance implementations<cr>", opts },
      ["gD"] = { "<cmd>Glance definitions<cr>", opts },
      ["gR"] = { "<cmd>Glance references<cr>", opts },
      ["gs"] = { "<cmd>Telescope aerial<cr>", opts },
      ["gu"] = {
        function()
          require("aerial").nav_toggle()
        end,
        opts,
      },

      ["<leader>rn"] = { ":IncRename ", vim.fn.extend(opts, { silent = false }) },
      ["<leader>rr"] = {
        function()
          return ":IncRename " .. vim.fn.expand "<cword>"
        end,
        vim.fn.extend(opts, { silent = false, expr = true }),
      },
      ["<leader>e"] = {
        function()
          vim.diagnostic.open_float()
        end,
        opts,
      },
      ["<leader>j"] = {
        function()
          vim.lsp.buf.hover()
        end,
        opts,
      },
    },
    [{ "n", "v" }] = {
      ["gp"] = {
        function()
          vim.lsp.buf.code_action()
        end,
        opts,
      },
    },
  }
end

M["harpoon"] = function()
  local nmaps = {
    ["<leader>h"] = {
      function()
        require("harpoon.mark").add_file()
      end,
    },
    ["<leader>m"] = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
    },
  }
  for i = 1, 9, 1 do
    nmaps[string.format("<leader>%i", i)] = {
      function()
        require("harpoon.ui").nav_file(i)
      end,
      { desc = string.format("Harpoon move (%i)", i) },
    }
  end

  return {
    ["n"] = nmaps,
  }
end

M["vim-tmux-navigator"] = {
  [{ "n", "i" }] = {
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>" },
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>" },
  },
  ["t"] = {
    ["<C-j>"] = { "<c-\\><c-n>:TmuxNavigateDown<cr>" },
    ["<C-k>"] = { "<c-\\><c-n>:TmuxNavigateUp<cr>" },
    ["<C-l>"] = { "<c-\\><c-n>:TmuxNavigateRight<cr>" },
    ["<C-h>"] = { "<c-\\><c-n>:TmuxNavigateLeft<cr>" },
  },
}

M["drex"] = {
  ["n"] = {
    ["<c-n>"] = { "<cmd>DrexDrawerToggle<cr>" },
    ["<leader>n"] = {
      "<cmd>DrexDrawerFindFileAndFocus<cr>",
    },
  },
}

M["yanil"] = {
  ["n"] = {
    ["<c-n>"] = {
      function()
        require("yanil.canvas").toggle()
      end,
    },
    ["<leader>n"] = {
      function()
        require("plugins.config.yanil").findFile()
      end,
    },
  },
}

M["neogen"] = {
  ["n"] = {
    ["<leader>dg"] = {
      function()
        require("neogen").generate()
      end,
    },
  },
}

M["oil"] = {
  ["n"] = {
    ["-"] = {
      function()
        require("oil").open()
      end,
    },
  },
}

M["neo-swap"] = {
  [{ "n" }] = {
    ["<leader>th"] = { "<cmd>NeoSwapPrev<cr>" },
    ["<leader>tl"] = { "<cmd>NeoSwapNext<cr>" },
  },
}

M["easy-align"] = {
  [{ "n", "x" }] = {
    ["ga"] = { "<Plug>(EasyAlign)" },
  },
}

M["close-buffers"] = {
  ["cmd"] = {
    ["CloseHiddenBuffers"] = {
      function()
        require("close_buffers").delete { type = "hidden" }
      end,
    },
  },
}

M["dap"] = {
  ["n"] = {
    ["<leader>b"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
    },
    ["<leader>lp"] = {
      function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
      end,
    },
    ["<leader>dr"] = {
      function()
        require("dap").repl.open()
      end,
    },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
    },
    ["<leader>df"] = {
      function()
        local widgets = require "dap.ui.widgets"
        widgets.centered_float(widgets.frames)
      end,
    },
    ["<leader>ds"] = {
      function()
        local widgets = require "dap.ui.widgets"
        widgets.centered_float(widgets.scopes)
      end,
    },
    ["<leader>dc"] = {
      function()
        require("dap").continue()
      end,
    },
    ["<leader>dd"] = {
      function()
        require("dap").disconnect()
      end,
    },
    ["<leader>do"] = {
      function()
        require("dap").step_over()
      end,
    },
    ["<leader>dj"] = {
      function()
        require("dap").step_into()
      end,
    },
    ["<leader>dk"] = {
      function()
        require("dap").step_out()
      end,
    },
  },
  [{ "n", "v" }] = {
    ["<leader>dh"] = {
      function()
        require("dap.ui.widgets").hover()
      end,
    },
    ["<leader>dp"] = {
      function()
        require("dap.ui.widgets").preview()
      end,
    },
  },
}

return M
