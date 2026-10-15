-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

hl.unbind("SUPER + SHIFT + P")
hl.unbind("SUPER + SHIFT + B")

o.bind("SUPER + SHIFT + P", "Personal", {
  launch = 'firefox --profile "$HOME/.config/mozilla/firefox/lr2techk.default-release"',
})
o.bind("SUPER + SHIFT + B", "Work", {
  launch = 'firefox --profile "$HOME/.config/mozilla/firefox/aTcdEM0K.Profile 1"',
})

o.bind("SUPER + SHIFT + T", "Center window at 60% width below the bar", function()
  local window = hl.get_active_window()
  if not window then return end

  local monitor = window.monitor
  local width = monitor.width / monitor.scale
  local height = monitor.height / monitor.scale
  if monitor.transform % 2 == 1 then
    width, height = height, width
  end

  local reserved = monitor.reserved
  local border = hl.get_config("general.border_size")
  local window_width = math.floor(width * 0.6)
  local window_height = math.floor(height - reserved.top - reserved.bottom - 2 * border)

  hl.dispatch(hl.dsp.window.fullscreen_state({ internal = 0, client = 0 }))
  hl.dispatch(hl.dsp.window.float({ action = "set" }))
  hl.dispatch(hl.dsp.window.resize({ x = window_width, y = window_height }))
  hl.dispatch(hl.dsp.window.move({
    x = monitor.position.x + math.floor((width - window_width) / 2),
    y = monitor.position.y + reserved.top + border,
    relative = false,
  }))
end)
