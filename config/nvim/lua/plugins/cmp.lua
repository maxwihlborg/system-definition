return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    { "saadparwaiz1/cmp_luasnip", dependencies = {
      { "L3MON4D3/LuaSnip" },
    } },
    { "kristijanhusak/vim-dadbod-completion" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-nvim-lua" },
    { "onsails/lspkind-nvim" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
  },
  config = function()
    local cmp = require "cmp"
    local types = require "cmp.types"
    local lspkind = require "lspkind"
    local luasnip = require "luasnip"

    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
    end

    require("cmp").setup {
      formatting = {
        fields = { "kind", "abbr" },
        format = lspkind.cmp_format {
          mode = "symbol",
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = {
        ["<C-Space>"] = {
          i = cmp.mapping.complete(),
        },
        ["<cr>"] = {
          i = cmp.mapping.confirm { select = true },
        },
        ["<C-e>"] = {
          i = cmp.mapping.abort(),
        },
        ["<Down>"] = {
          i = cmp.mapping.select_next_item { behavior = types.cmp.SelectBehavior.Select },
        },
        ["<Up>"] = {
          i = cmp.mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Select },
        },
        ["<C-n>"] = {
          i = cmp.mapping.select_next_item { behavior = types.cmp.SelectBehavior.Insert },
        },
        ["<C-p>"] = {
          i = cmp.mapping.select_prev_item { behavior = types.cmp.SelectBehavior.Insert },
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm { select = true }
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = cmp.config.sources({
        { name = "luasnip", max_item_count = 1 },
        { name = "nvim_lsp", max_item_count = 15 },
        { name = "nvim_lua", max_item_count = 15 },
        { name = "vim-dadbod-completion", max_item_count = 15 },
        { name = "path" },
      }, {
        { name = "buffer", keyword_length = 5, max_item_count = 15 },
      }),
      experimental = {
        native_menu = false,
        ghost_text = true,
      },
    }
  end,
}
