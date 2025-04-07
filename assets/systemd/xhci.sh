#!/bin/sh
#
# This script should prevent the following suspend errors
#  which freezes the Dell Inspiron laptop.
#
# Put it in /usr/lib/systemd/system-sleep/xhci.sh
#
# The PCI 00:14.0 device is the usb xhci controller.
#
#    kernel: [67445.560610] pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
#    kernel: [67445.560619] dpm_run_callback(): pci_pm_suspend+0x0/0x150 returns -16
#    kernel: [67445.560624] PM: Device 0000:00:14.0 failed to suspend async: error -16
#    kernel: [67445.886961] PM: Some devices failed to suspend, or early wake event detected

_toggle() {
  grep $1.*$2 /proc/acpi/wakeup && echo $1 | tee /proc/acpi/wakeup
}

_toggle_all() {
  _toggle GLAN $1
  # _toggle EHC1 $1
  # _toggle EHC2 $1
  # _toggle XHC $1
}

if [ "${1}" == "pre" ]; then
  # Do the thing you want before suspend here, e.g.:
  _toggle_all enable
elif [ "${1}" == "post" ]; then
  # Do the thing you want after resume here, e.g.:
  _toggle_all disable
fi
