local M = {}

function M.prettier()
  local util = require "formatter.util"

  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
    try_node_modules = true,
  }
end

local function setupFormatter()
  local status_ok, formatter = pcall(require, "formatter")
  if not status_ok then
    return
  end

  local util = require "formatter.util"

  local formatterConfig = {
    -- haxe = { require("max.core.formatter.haxe").formatter },
    lua = { require("formatter.filetypes.lua").stylua },
    rust = { require("formatter.filetypes.rust").rustfmt },
    css = { require("formatter.filetypes.css").prettier },
    glsl = { require("formatter.filetypes.c").clangformat },
    nix = { require("formatter.filetypes.nix").nixpkgs_fmt },
    sql = {
      function()
        return {
          exe = "sql-formatter",
          args = {
            "-c",
            vim.fn.expand "~/.config/sql-formatter/config.json",
          },
          stdin = true,
        }
      end,
    },
    -- html = { require("formatter.filetypes.html").htmlbeautify },
    fish = { require("formatter.filetypes.fish").fishindent },
    rescript = {
      function()
        return {
          exe = "./node_modules/.bin/rescript",
          args = {
            "format",
            "-stdin",
            util.escape_path(util.get_current_buffer_file_path()),
          },
          stdin = true,
        }
      end,
    },
    --[[ typescript = {
      function()
        return {
          exe = "rome",
          args = {
            "format",
            "--stdin-file-path",
            util.escape_path(util.get_current_buffer_file_path()),
          },
          stdin = true,
        }
      end,
    }, ]]
  }

  local commonFT = {
    "css",
    "scss",
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "markdown",
    "markdown.mdx",
    "graphql",
    "json",
    "yaml",
    "xml",
    "svelte",
  }

  for _, ft in ipairs(commonFT) do
    formatterConfig[ft] = { util.withl(require "formatter.defaults.prettier") }
  end

  formatter.setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = formatterConfig,
  }
end

local function setupAutocmds()
  local group = vim.api.nvim_create_augroup("FormatAutogroup", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    command = "FormatWrite",
    group = group,
  })
end

function M.init()
  setupAutocmds()
end

function M.setup()
  setupFormatter()
end

return M
