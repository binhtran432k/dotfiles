local wezterm = require("wezterm")

return {
  font = wezterm.font({
    family = "Maple Mono",
    harfbuzz_features = { "dlig" },
  }),
  font_size = 14,
  color_scheme = "Dracula",
  hide_tab_bar_if_only_one_tab = true,
}
