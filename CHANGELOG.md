# Changelog

All notable changes to this project will be documented in this file.

## [0.10.0] - 2025-06-20

### 🚀 Features

- *(nvim)* Config update
- *(nix)* Add moreutils
- *(nvim)* Add harper-ls
- *(nvim)* Make Lint user command handle oxlint output
- *(hammerspoon)* Add whatsapp binding
- *(lazygit)* Gpg support
- *(nvim)* Add hunks.nvim
- Add jujutsu vcs
- *(fish)* Jjui fish alias
- *(nvim)* Enable taplo lsp
- *(skim)* Add SKIM_DEFAULT_OPTIONS, FZF_DEFAULT_OPTS
- *(fzf)* Set FZF_DEFAULT_COMMAND
- Change to git-cliff

### 🐛 Bug Fixes

- *(nix)* Switch require sudio

### ⚙️ Miscellaneous Tasks

- *(nix)* Update flake
- *(nvim)* Upgrade to latest mason and vim.lsp.config

## [0.9.0] - 2025-04-30

### 🚀 Features

- *(nvim)* Change back to wrap true
- *(nvim)* Neotest keybinds
- *(nvim)* Ws-list user command
- *(fish)* __sk_ghq change directory function and mappings
- *(vifm)* Chafa image previews
- *(nvim)* More markdown highlights in kanagawa
- *(nvim)* Ws keybinding
- *(fish)* Icat function
- *(nvim)* Quicker.nvim
- *(nvim)* Fzf-lua
- *(fish)* __sq_ws keybinds
- *(nvim)* Lazydev instead of neodev
- *(nvim)* Fzf.lua, luasnippets and blink.cmp bindings
- *(nvim)* Omnisharp lsp
- *(nvim,fish)* Rename tmux pane on workspace change
- *(nvim)* Single toggle qf-list binding
- *(nvim)* Nvim instead of vim logo in tabline

### 🐛 Bug Fixes

- *(nvim)* Blink.cmp behaviour
- *(nvim)* Snacks qflist keybind
- *(nvim)* Command errors
- *(nvim)* Single lint error not shown
- *(nvim)* Fzf.lua keymaps
- *(ghostty,fish)* Cursor shape

### ⚙️ Miscellaneous Tasks

- New screenshot
- *(nvim)* Update plugin versions
- *(nix,nvim)* Upgrade
- *(version)* 0.9.0

## [0.8.0] - 2025-02-23

### 🚀 Features

- *(fish)* Simple __sk_open instead of broken __fzf_open
- *(nvim)* [**breaking**] New config

### ⚙️ Miscellaneous Tasks

- *(version)* 0.8.0

## [0.7.0] - 2025-02-17

### 🚀 Features

- *(neomutt)* Configure email
- *(vifm)* Image previews
- *(nvim)* Add vim-abolish
- *(nvim)* Move csharp_ls to project-config
- More tokyonight theming
- *(ghostty)* Ghostty config
- *(nvim)* Export declare namespace luasnip
- Atac and serie packages

### 🐛 Bug Fixes

- *(nvim)* Fix tabline
- *(nvim)* Try fix drex highlights
- *(lazygit)* BranchLog command

### ⚙️ Miscellaneous Tasks

- Update system
- Update nix
- *(ghostty)* Close on last window
- *(nvim)* Update plugins
- *(version)* 0.7.0

## [0.6.0] - 2024-11-14

### 🚀 Features

- *(nvim)* Effect.gen snippet
- *(tmux)* Make out of store symlink
- *(fish)* Vim bindings!
- *(vifm)* Change from lf to vifm
- *(vifm)* Packer plugin
- *(lazygit)* Enable emoji parsing
- *(nvim)* Svg formatting using prettier
- *(git)* Add sig key
- *(darwin)* Sops and git-crypt + notmuch/mail config

### 🐛 Bug Fixes

- *(just)* Update recipie
- *(nvim)* Rename tid snippet to tt

### ⚙️ Miscellaneous Tasks

- *(home)* Remove unused programs
- *(tmux)* Cleanup config file
- *(version)* 0.6.0

## [0.5.0] - 2024-10-31

### 🚀 Features

- *(fish)* Remove secrets file
- *(fish)* Add syntax highlighting
- *(nvim)* Add git_file_history keymap command
- *(nvim)* C-j/c-k keymaps for telescope
- *(nvim)* Q close binding in aerial-nav
- *(nvim)* Move user commands into own file
- *(home)* Manage lazygit with home-manager, enable xdg
- *(vifm)* Enable vifm

### ⚙️ Miscellaneous Tasks

- *(nvim)* Ui package wtr monorepo makeprg
- Update system
- Update system
- *(version)* 0.5.0

## [0.4.0] - 2024-10-12

### 🚀 Features

- *(nvim)* Add `tid` (type id) snippet
- *(nvim)* Add `cexpr system(...) | copen` keybind
- *(nvim)* Add Lint user_command
- *(nvim)* Light-control-cli user command
- *(nvim)* Update nvim configurations and packages versions
- *(nvim)* Add `CommitMsg` command
- *(nvim)* Add dim to light-control-cli user command
- *(nvim)* Nvim-dap symbols, dotnet dap adapter
- *(nvim)* Run closest build command in wtr repo
- *(home)* Add postgres, unar and meshoptimizer apps
- *(nvim)* `cnn` snippet -> className={$1}
- *(nvim)* Move project-config into own module

### 🐛 Bug Fixes

- *(nvim)* Fix haxe tree-sitter

### ⚙️ Miscellaneous Tasks

- Update system
- *(nvim)* Rename tsserver -> ts_ls
- *(version)* 0.4.0

## [0.3.0] - 2024-08-01

### 🚀 Features

- Git followTags option
- Add justfile
- Remove gitui and nnn
- Add lazydocker.nvim
- Remove sys-switch sys-update in favour of justfile
- Add flake.lock filetype definition
- Remove neogit
- Nvim add gltf file type
- Nvim add csharpier_local conform command
- *(nvim)* Add .csharpierrc filetype
- *(nvim)* Upgrade fidget nvim!
- *(nvim)* Css formatting with prettier
- *(nvim)* Go back to fzy_native instead of zf-native (build issues)

### 🐛 Bug Fixes

- *(nvim)* Diagnostic symbols
- *(nvim)* Remove prettierd after conform update

### 🚜 Refactor

- Rename readme -> README

### ⚙️ Miscellaneous Tasks

- Update cocogitto configuration
- *(version)* 0.2.0
- Pin Neogit version
- Update lock files
- Update nix-pkgs
- Update system
- *(nvim)* Remove yanil highlights
- Update system
- Update system
- Update system
- *(version)* 0.3.0

## [0.1.0] - 2024-05-23

### 🚀 Features

- *(nvim)* Add just
- *(TS)* Syntax queries
- *(nvim)* Export function snippet
- *(nvim)* ,,o to sort in curly blocks
- *(xnomad)* Check command
- *(nvim)* Add `Fd` command
- *(nvim)* Neoswap
- *(nvim)* Go config
- *(nvim)* Update
- *(nvim)* More _jscommon snippets
- *(nvim)* Enable dap again
- *(nvim)* Gpt close and more snippets
- *(nvim)* Remove aw-watcher-vim
- Nvim hide DS_Store
- Add nvim pipeable alias
- Add sesh
- Nvim change telescope sorter (zf)
- Implement sesh
- Gopass alias
- Add vimv (bulk rename tool)
- Nvim csharp settings
- Fish new alias
- Nvim add zf
- Add cocogitto
- Add telescope git_file_history command
- Add ffmpeg
- Add cocogitto configuration

### 🐛 Bug Fixes

- Enable netrw for GBrowse commands
- Fish remove ghq-fish

### 💼 Other

- *(nvim)* Mv core -> pde

### ⚙️ Miscellaneous Tasks

- *(nvim)* Update packages
- *(nvim)* Fidget.nvim -> legacy
- Update packages
- *(version)* 0.1.0

<!-- generated by git-cliff -->
