{
  titlebar = false;
  border = 1;
  commands = [
    {
      criteria = {urgent = "latest";};
      command = "focus";
    }
    {
      criteria = {window_role = "pop-up,task_dialog,About";};
      command = "floating enable";
    }
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
