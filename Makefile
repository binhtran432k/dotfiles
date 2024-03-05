.PHONY: fixsleep cleanfixsleep

fixsleep: cleanfixsleep
	mkdir -p /lib/systemd/system-sleep/
	cp -f ./scripts/system-sleep/xhci.sh /lib/systemd/system-sleep/xhci.sh
	chmod u+x /lib/systemd/system-sleep/xhci.sh

cleanfixsleep:
	rm -rf /lib/systemd/system-sleep/xhci.sh

.PHONY: nobeep cleannobeep

nobeep: cleannobeep
	echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

cleannobeep:
	rm -f /etc/modprobe.d/nobeep.conf

.PHONY: xinput cleanxinput

xinput: cleanxinput
	cp -f ./x11/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
	cp -f ./x11/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf

cleanxinput:
	rm -f /etc/X11/xorg.conf.d/00-keyboard.conf
	rm -f /etc/X11/xorg.conf.d/30-touchpad.conf
