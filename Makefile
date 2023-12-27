.PHONY: fixsleep cleanfixsleep nobeep cleannobeep

fixsleep: cleanfixsleep
	mkdir -p /lib/systemd/system-sleep/
	cp -f ./scripts/system-sleep/xhci.sh /lib/systemd/system-sleep/xhci.sh
	chmod u+x /lib/systemd/system-sleep/xhci.sh

cleanfixsleep:
	rm -rf /lib/systemd/system-sleep/xhci.sh

nobeep: cleannobeep
	echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

cleannobeep:
	rm -f /etc/modprobe.d/nobeep.conf
