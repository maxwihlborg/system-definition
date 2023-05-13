local opt = vim.opt

vim.g.mapleader = ","

opt.termguicolors = true
opt.autoindent = true -- Save indentation between lines
opt.backup = false
opt.backupcopy = "yes" -- Saving
opt.belloff = "all" -- No bells
opt.clipboard = "unnamedplus"
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.cursorline = true -- Show cursorline
opt.expandtab = true -- Tabs as spaces
opt.guicursor = "a:block-blink0"
opt.hidden = true
opt.inccommand = "nosplit"
opt.incsearch = true
opt.laststatus = 3 -- Global statusbar
opt.showtabline = 2 -- Show tabline
opt.showmode = false
opt.lbr = true
opt.list = true
opt.listchars = { trail = "." } -- Show trailing space
opt.mouse = "a" -- Mouse support
opt.number = true
opt.relativenumber = true -- Hybrid Linenumbers
opt.secure = true
opt.numberwidth = 5
opt.shiftwidth = 2 -- Indentation width
opt.shortmess:append "c"
opt.signcolumn = "yes"
opt.smartindent = true -- C-lang tab indentation
opt.smarttab = true -- Shiftwidth at start of lines
opt.softtabstop = 2 -- <bs> delete 2 space
opt.swapfile = false
opt.tabstop = 2 -- Tabwidth
opt.updatetime = 300
opt.wildmenu = true -- File Explorer settings
opt.wrap = true -- Wordwrap on
opt.writebackup = false

opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Format (:h fo-table)
opt.formatoptions = opt.formatoptions
  - "t" -- Auto-wrap text
  + "c" -- Auto-wrap comments
  + "r" -- Insert comment leader (insert mode)
  - "o" -- Insert comment leader (o, O)
  + "q" -- Format comments with gq
  - "w" -- Trailing white space = paragraph
  - "a" -- Auto format paragraphs
  + "n" -- Auto increment numbered lists
  + "j" -- Remove comment leader when joining lines
  - "2" -- Some weird stuff

opt.joinspaces = false
opt.fillchars = { eob = " " }

local highlightGroup = vim.api.nvim_create_augroup("LuaHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlightGroup,
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 150 }
  end,
})

local group = vim.api.nvim_create_augroup("CoreEditor", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "qf", "help", "dap-float" },
  callback = function(opts)
    require("pde.utils").load_keymap("close", {
      buffer = opts.buf,
    })
  end,
})
