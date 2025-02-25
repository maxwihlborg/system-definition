---@diagnostic disable: missing-fields
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.autoindent = true -- Save indentation between lines
vim.opt.backup = false
vim.opt.backupcopy = "yes" -- Saving
vim.opt.belloff = "all" -- No bells
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.cursorline = true -- Show cursorline
vim.opt.expandtab = true -- Tabs as spaces
vim.opt.fillchars = { foldopen = "󰅀", foldclose = "󰅂", fold = " ", foldsep = " ", diff = "╱", eob = " " }
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.guicursor = "a:block-blink0"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.joinspaces = false
vim.opt.langmap = "ä{,ö}"
vim.opt.laststatus = 3 -- Global statusbar
vim.opt.lbr = true
vim.opt.list = true
vim.opt.listchars = { trail = "." } -- Show trailing space
vim.opt.mouse = "a" -- Mouse support
vim.opt.number = true
vim.opt.numberwidth = 5
vim.opt.relativenumber = true -- Hybrid Linenumbers
vim.opt.secure = true
vim.opt.shiftwidth = 2 -- Indentation width
vim.opt.shortmess:append "c"
vim.opt.showmode = false
vim.opt.showtabline = 2 -- Show tabline
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true -- C-lang tab indentation
vim.opt.smarttab = true -- Shiftwidth at start of lines
vim.opt.smoothscroll = true
vim.opt.softtabstop = 2 -- <bs> delete 2 space
vim.opt.swapfile = false
vim.opt.tabstop = 2 -- Tabwidth
vim.opt.termguicolors = true
vim.opt.undofile = false
vim.opt.updatetime = 250
vim.opt.virtualedit = "block"
vim.opt.wildignore:append ".DS_Store"
vim.opt.wildmenu = true
vim.opt.wrap = true
vim.opt.writebackup = false

local group = vim.api.nvim_create_augroup("CoreEditor", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 } end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "qf", "help", "dap-float", "chatgpt-input", "aerial-nav" },
  callback = function(opts)
    require("pde.utils").load_keymap("close", {
      buffer = opts.buf,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "help" },
  callback = function(opts)
    require("pde.utils").load_keymap("help", {
      buffer = opts.buf,
    })
  end,
})

vim.filetype.add {
  extension = {
    gltf = "jsonc",
  },
  filename = {
    [".csharpierrc"] = "jsonc",
    ["flake.lock"] = "jsonc",
  },
}
