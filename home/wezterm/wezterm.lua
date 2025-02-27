local wezterm = require("wezterm")

return {
  font = wezterm.font({
    family = "Maple Mono",
    harfbuzz_features = { "calt", "ss01" },
  }),
  color_scheme = "Dracula",
  hide_tab_bar_if_only_one_tab = true,
}
