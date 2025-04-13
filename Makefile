.PHONY: install-fix-sleep uninstall-fix-sleep
install-fix-sleep: uninstall-fix-sleep
	mkdir -p /lib/systemd/system-sleep
	cp -f ./assets/systemd/xhci.sh /lib/systemd/system-sleep/xhci.sh
	chmod u+x /lib/systemd/system-sleep/xhci.sh
uninstall-fix-sleep:
	rm -rf /lib/systemd/system-sleep

.PHONY: install-xinput uninstall-xinput
install-xinput: uninstall-xinput
	cp -f ./assets/x11/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
	cp -f ./assets/x11/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf
uninstall-xinput:
	rm -f /etc/X11/xorg.conf.d/00-keyboard.conf
	rm -f /etc/X11/xorg.conf.d/30-touchpad.conf

.PHONY: paru
paru:
	# Dependencies: base-devel
	rm -rf paru-bin
	git clone --depth 1 https://aur.archlinux.org/paru-bin.git
	cd paru-bin &&  makepkg -si

.PHONY: bun
bun:
	curl -fsSL https://bun.sh/install | bash # for macOS, Linux, and WSL

.PHONY: fnm
fnm:
	curl -fsSL https://fnm.vercel.app/install | bash

.PHONY: pnpm
pnpm:
	curl -fsSL https://get.pnpm.io/install.sh | sh -

.PHONY: zvm
zvm:
	curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash

.PHONY: rustup
rustup:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path

.PHONY: dotnet
dotnet:
	# Dependencies: icu
	rm -f ./dotnet-install.sh
	wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
	chmod +x ./dotnet-install.sh
