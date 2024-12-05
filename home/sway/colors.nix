let
  colors = rec {
    background = "#282A36";
    urgent = "#FF5555";
    text = "#F8F8F2";
    indicator = "#6272A4";
    focused = "#BD93F9";
    focusedInactive = separator;
    unfocused = background;
    border = separator;
    separator = "#44475A";
  };
in {
  colors = with colors; {
    inherit background;
    urgent = {
      inherit background indicator text;
      border = urgent;
      childBorder = urgent;
    };
    focused = {
      inherit indicator text;
      background = focusedInactive;
      border = focused;
      childBorder = focused;
    };
    focusedInactive = {
      inherit indicator text;
      background = focusedInactive;
      border = focusedInactive;
      childBorder = focusedInactive;
    };
    unfocused = {
      inherit background indicator text;
      border = unfocused;
      childBorder = unfocused;
    };
    placeholder = {
      inherit background indicator text;
      border = unfocused;
      childBorder = unfocused;
    };
  };
  barColors = with colors; {
    inherit background separator;
    statusline = text;
    focusedWorkspace = {
      inherit text;
      background = focusedInactive;
      border = focused;
    };
    activeWorkspace = {
      inherit border background;
      text = focused;
    };
    inactiveWorkspace = {
      inherit text border background;
    };
    urgentWorkspace = {
      inherit text background;
      border = urgent;
    };
    bindingMode = {
      inherit text border;
      background = urgent;
    };
  };
}
