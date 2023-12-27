.PHONY: nobeep cleannobeep

nobeep: cleannobeep
	echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

cleannobeep:
	rm -f /etc/modprobe.d/nobeep.conf
