return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  init = function()
    local unlinkgrp = vim.api.nvim_create_augroup("UnlinkSnippetOnModeChange", { clear = true })

    vim.api.nvim_create_autocmd("ModeChanged", {
      group = unlinkgrp,
      pattern = { "s:n", "i:*" },
      desc = "Forget the current snippet when leaving the insert mode",
      callback = function(evt)
        local luasnip = require "luasnip"
        if luasnip.session and luasnip.session.current_nodes[evt.buf] and not luasnip.session.jump_active then
          luasnip.unlink_current()
        end
      end,
    })
  end,
  config = function()
    local ls = require "luasnip"
    local dl = require("luasnip.extras").dynamic_lambda
    local l = require("luasnip.extras").lambda

    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node

    local function copy(args)
      return args[1]
    end

    local function bn(str)
      -- return basename (no extension)
      return str:match "(.+)%..+$"
    end

    ls.config.set_config {
      history = false,
    }

    ls.add_snippets("jsx", {
      s("rc", {
        t { "export function " },
        dl(1, bn(l.TM_FILENAME), {}),
        t { "() {", "\treturn (", "\t\t<div>" },
        i(0),
        t { "</div>", "\t);", "};" },
      }),
    })

    ls.add_snippets("tsx", {
      s("rc", {
        t { "interface " },
        dl(1, bn(l.TM_FILENAME), {}),
        t { "Props {};", "", "export function " },
        f(copy, 1),
        t { "(_props: " },
        f(copy, 1),
        t { "Props): JSX.Element {", "\treturn (", "\t\t<div>" },
        i(0),
        t { "</div>", "\t);", "};" },
      }),
    })

    ls.add_snippets("typescript", {
      s("et", { t "export type ", i(1), t " = ", i(0), t ";" }),
      s("ei", { t "export interface ", i(1), t { " {", "\t" }, i(0), t { "", "}" } }),
    })

    ls.add_snippets("_jscommon", {
      s("cn", { t 'className="', i(0), t '"' }),
      s("cx", { t "className={css({", i(0), t "})}" }),
      s("cl", { t "console.log(", i(0), t ");" }),
      s("rcd", { t "export { default as ", f(copy, 1), t ' } from "./', i(1), t '";' }),
      s("rcdd", { t 'export { default } from "./', i(1), t '";' }),
      s("rci", { t "import ", i(1), t ' from "./', f(copy, 1), t '";' }),
      s("rcii", { t "import * as ", f(copy, 1), t ' from "./', i(1), t '";' }),
      s("rce", { t "import ", f(copy, 1), t ' from "./', i(1), t { '";', "", "export default " }, f(copy, 1), t ";" }),
      s("rca", { t 'export * from "./', i(1), t '";' }),
      s("rcaa", { t "export * as ", f(copy, 1), t ' from "./', i(1), t '";' }),
      s("ec", { t "export class ", dl(1, bn(l.TM_FILENAME), {}), t { " {", "\tconstructor() {", "\t\t" }, i(0), t { "", "\t}", "}" } }),
      s("ut", { t 'const { t } = useTranslation("', i(1), t '");' }),
      s("ef", { t "export function ", dl(1, bn(l.TM_FILENAME), {}), t "(", i(2), t ")", t { " {", "\t" }, i(0), t { "", "}" } }),
      s("ecd", { t "export default class ", dl(1, bn(l.TM_FILENAME), {}), t { " {", "\tconstructor() {", "\t\t" }, i(0), t { "", "\t}", "}" } }),
      s("es", { t { 'import css from "./_index.module.scss";', "", "export default css;" } }),
    })

    ls.add_snippets("scss", {
      s("xu", { t '@use "@xnomad/ui/sass" as ui;' }),
      s("sm", { t '@use "sass:map";' }),
      s("sl", { t '@use "sass:list";' }),
      s("sc", { t '@use "sass:color";' }),
    })

    ls.filetype_extend("javascript", { "_jscommon", "jsx" })
    ls.filetype_extend("typescript", { "_jscommon" })

    ls.filetype_set("typescriptreact", { "typescript", "tsx", "_jscommon" })
    ls.filetype_set("javascriptreact", { "javascript", "jsx", "_jscommon" })
  end,
}
