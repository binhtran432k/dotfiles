{
  lib,
  inputs,
  ...
}:
with inputs.nixos-hardware.nixosModules; {
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
    echo GLAN | tee /proc/acpi/wakeup
  '';
  powerManagement.resumeCommands = ''
    echo GLAN | tee /proc/acpi/wakeup
  '';
}
