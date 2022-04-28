local wezterm = require 'wezterm';

local mykeys = {}
for i = 1, 8 do
  -- CTRL + number to activate that tab
  table.insert(mykeys, {
    key=tostring(i),
    mods="CTRL",
    action=wezterm.action{ActivateTab=i-1},
  })
  -- F1 through F8 to activate that tab
  table.insert(mykeys, {
    key="F" .. tostring(i),
    action=wezterm.action{ActivateTab=i-1},
  })
end

return {
	color_scheme = "Dracula",
	font_size = 16,
	keys = mykeys,
}
