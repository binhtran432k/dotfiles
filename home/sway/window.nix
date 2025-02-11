{
  titlebar = false;
  border = 2;
  commands = [
    {
      criteria = {urgent = "latest";};
      command = "focus";
    }
    # Floating
    {
      criteria = {window_role = "pop-up,task_dialog,About";};
      command = "floating enable";
    }
    {
      criteria = {app_id = "brave-amfojhdiedpdnlijjbhjnhokbnohfdfb-Default";};
      command = "floating enable";
    }
    # Inhibit Idle
    {
      criteria = {app_id = ".*";};
      command = "inhibit_idle fullscreen";
    }
    {
      criteria = {class = ".*";};
      command = "inhibit_idle fullscreen";
    }
  ];
}
