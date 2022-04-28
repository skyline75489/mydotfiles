local wezterm = require 'wezterm';

local mykeys = {}
for i = 1, 8 do
  -- CTRL + number to activate that tab
  table.insert(mykeys, {
    key=tostring(i),
    mods="CTRL",
    action=wezterm.action{ActivateTab=i-1},
  })
  -- macOS
  table.insert(mykeys, {
    key=tostring(i),
    mods="CMD",
    action=wezterm.action{ActivateTab=i-1},
  })
  -- Linux
  table.insert(mykeys, {
    key=tostring(i),
    mods="ALT",
    action=wezterm.action{ActivateTab=i-1},
  })
  -- F1 through F8 to activate that tab
  table.insert(mykeys, {
    key="F" .. tostring(i),
    action=wezterm.action{ActivateTab=i-1},
  })
end


local default_prog = { 'bash', '-l' }

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	default_prog = { 'pwsh.exe', '-NoLogo' }
end
if wezterm.target_triple == "x86_64-apple-darwin" then 
	default_prog = { 'zsh', '-l' }
end

return {
	color_scheme = "Dracula",
	font_size = 14,
	keys = mykeys,
	default_prog = default_prog
}
