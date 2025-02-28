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

    ["<leader><leader>o"] = { "vi{:sort<cr>" },
    ["<leader>a"] = { "<cmd>w<cr>" },
    ["<leader>ca"] = { "<cmd>Lazy<cr>" },
    ["<leader>cc"] = { "<cmd>cclose<cr>" },
    ["<leader>cm"] = { "<cmd>Mason<cr>" },
    ["<leader>co"] = { "<cmd>copen<cr>" },
    ["<leader>o"] = { "vip:sort<cr>" },
    ["<leader>q"] = { "<cmd>q<cr>" },
    ["<leader>tt"] = { "<cmd>tabe<cr>" },
    ["<leader>w"] = { "<cmd>Ws<cr>" },
    ["<leader>x"] = { "<cmd>w|luafile %<cr>" },

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
    ["s"] = { ":", { nowait = true } },
    ["S"] = { ":", { nowait = true } },
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
      ["gu"] = { function() require("aerial").nav_toggle() end, opts },

      ["<leader>rn"] = { ":IncRename ", vim.fn.extend(opts, { silent = false }) },
      ["<leader>rr"] = {
        function() return ":IncRename " .. vim.fn.expand "<cword>" end,
        vim.fn.extend(opts, { silent = false, expr = true }),
      },
      ["<leader>e"] = {
        function() vim.diagnostic.open_float() end,
        opts,
      },
      ["<leader>j"] = {
        function() vim.lsp.buf.hover() end,
        opts,
      },
    },
    [{ "n", "v" }] = {
      ["gp"] = {
        function() vim.lsp.buf.code_action() end,
        opts,
      },
    },
  }
end

return M
