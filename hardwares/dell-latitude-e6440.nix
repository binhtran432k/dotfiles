{
  lib,
  inputs,
  ...
}:
with inputs.nixos-hardware.nixosModules;
{
  imports = [
    common-pc-laptop
    common-pc-laptop-ssd
    common-cpu-intel
  ];

  # Essential Firmware
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Cooling Management
  services.thermald.enable = lib.mkDefault true;

  # Fix suspend not working
  powerManagement.powerDownCommands = ''
    grep GLAN.*enable /proc/acpi/wakeup && echo GLAN | tee /proc/acpi/wakeup
  '';
  powerManagement.resumeCommands = ''
    grep GLAN.*disable /proc/acpi/wakeup && echo GLAN | tee /proc/acpi/wakeup
  '';
}
