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
  window_frame = {
    font_size = 14.0,
  },
  colors = {
    tab_bar = {
    }
  },
  color_scheme = "Dracula",
  font = wezterm.font_with_fallback({
    "Monaco",
    "JetBrains Mono",
    "Noto Sans Mono CJK SC",
  }),
  font_size = 14,
  keys = mykeys,
  default_prog = default_prog,
  mouse_bindings = {
    -- Right click sends "PasteFromClipboard" to the terminal
    {
      event={Down={streak=1, button="Right"}},
      mods="NONE",
      action=wezterm.action{PasteFrom="Clipboard"}
    },

    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
      event={Up={streak=1, button="Left"}},
      mods="NONE",
      action=wezterm.action{CompleteSelection="PrimarySelection"},
    },

    -- and make CTRL-Click open hyperlinks
    {
      event={Up={streak=1, button="Left"}},
      mods="CTRL",
      action="OpenLinkAtMouseCursor",
    },
    -- NOTE that binding only the 'Up' event can give unexpected behaviors.
    -- Read more below on the gotcha of binding an 'Up' event only.
  },
}
