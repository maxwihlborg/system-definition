-- globals hs
hs.loadSpoon "EmmyLua"

local mod = { "ctrl", "cmd", "alt" }
local mod2 = { "ctrl", "alt" }

local function send_win(x, y, w, h)
  return function()
    local win = hs.window.focusedWindow()
    local f = win:frame()
    local screen = win:screen()
    local max = screen:frame()

    f.x = math.floor(max.x + max.w * x)
    f.y = math.floor(max.y + max.h * y)
    f.w = math.floor(max.w * w)
    f.h = math.floor(max.h * h)
    win:setFrame(f)
  end
end

local function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ",\n"
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

local function send_to_mon(ns)
  local win = hs.window.focusedWindow()
  local cf = win:frame()
  local cs = win:screen()
  local sf = cs:frame()
  local nf = ns:frame()

  win:setFrame {
    x = math.floor((((cf.x - sf.x) / sf.w) * nf.w) + nf.x),
    y = math.floor((((cf.y - sf.y) / sf.h) * nf.h) + nf.y),
    h = math.floor((cf.h / sf.h) * nf.h),
    w = math.floor((cf.w / sf.w) * nf.w),
  }
end

-- Higher order launchByBundle
local function launch_by_bundle_id(id)
  return function()
    hs.application.launchOrFocusByBundleID(id)
  end
end

-- osascript -e 'id of app "App Name"'
hs.hotkey.bind(mod, "T", launch_by_bundle_id "org.alacritty")
hs.hotkey.bind(mod, "C", launch_by_bundle_id "company.thebrowser.Browser")
hs.hotkey.bind(mod, "S", launch_by_bundle_id "com.tinyspeck.slackmacgap")
hs.hotkey.bind(mod, "N", launch_by_bundle_id "com.spotify.client")
hs.hotkey.bind(mod, "B", launch_by_bundle_id "com.linear")
hs.hotkey.bind(mod, "F", launch_by_bundle_id "com.figma.Desktop")
-- Shortwave
hs.hotkey.bind(mod, "D", launch_by_bundle_id "com.google.Chrome.app.lnachpgegbbmnnlgpokibfjlmppeciah")

-- Split Screen Actions
local send_win_left = send_win(0, 0, 0.5, 1)
local send_win_right = send_win(0.5, 0, 0.5, 1)
local send_win_up = send_win(0, 0, 1, 0.5)
local send_win_down = send_win(0, 0.5, 1, 0.5)
local send_win_full = send_win(0, 0, 1, 1)

hs.hotkey.bind(mod, "H", send_win_left)
hs.hotkey.bind(mod, "J", send_win_down)
hs.hotkey.bind(mod, "K", send_win_up)
hs.hotkey.bind(mod, "L", send_win_right)
hs.hotkey.bind(mod, "M", send_win_full)

-- Monitor Actions
local function send_mon_prev()
  local win = hs.window.focusedWindow()
  send_to_mon(win:screen():previous())
end
local function send_mon_next()
  local win = hs.window.focusedWindow()
  send_to_mon(win:screen():next())
end

hs.hotkey.bind(mod2, "H", send_mon_next)
hs.hotkey.bind(mod2, "L", send_mon_prev)

-- Window Hints
local function show_hints()
  hs.hints.windowHints()
end

hs.hotkey.bind(mod2, "F", show_hints)

-- Config
hs.hints.showTitleThresh = 0
hs.hints.hintChars = { "s", "a", "d", "f", "j", "k", "l", "e", "w", "c", "m", "p", "g", "h" }
hs.window.animationDuration = 0 -- disable animations
