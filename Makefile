.PHONY: load-dconf dump-dconf
dump-dconf:
	dconf dump / > ~/.config/dconf/dconf-settings.ini
load-dconf:
	dconf load / < ~/.config/dconf/dconf-settings.ini

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

.PHONY: zoxide
zoxide:
	curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

.PHONY: monofonts
monofonts:
	mkdir -p "${HOME}/.local/share/fonts" && \
	bash ./scripts/monaspace-install.sh Argon && \
	bash ./scripts/monaspace-install.sh Krypton && \
	bash ./scripts/monaspace-install.sh Neon && \
	bash ./scripts/monaspace-install.sh Radon && \
	bash ./scripts/monaspace-install.sh Xenon

.PHONY: nvim
nvim:
	wget -O "${HOME}/.local/bin/nvim" "https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage" && \
	chmod +x "${HOME}/.local/bin/nvim"

.PHONY: ghostty
ghostty:
	wget -O "${HOME}/.local/bin/ghostty" "https://github.com/pkgforge-dev/ghostty-appimage/releases/download/tip/Ghostty-1.1.4-main+1883137-x86_64.AppImage" && \
	chmod +x "${HOME}/.local/bin/ghostty"

.PHONY: fish
fish:
	bash ./scripts/install.sh \
		https://github.com/fish-shell/fish-shell/releases/download/4.0.2/fish-static-amd64-4.0.2.tar.xz \
		fish.tar.xz \
		fish fish \
		fish_indent fish_indent \
		fish_key_reader fish_key_reader
	fish --install=${HOME}/.local

.PHONY: git-credential-oauth
git-credential-oauth:
	bash ./scripts/install.sh \
		https://github.com/hickford/git-credential-oauth/releases/download/v0.15.1/git-credential-oauth_0.15.1_linux_amd64.tar.gz \
		git-credential-oauth.tar.gz \
		git-credential-oauth git-credential-oauth

.PHONY: nnn
nnn:
	bash ./scripts/install.sh \
		https://github.com/jarun/nnn/releases/download/v5.1/nnn-static-5.1.x86_64.tar.gz \
		nnn.tar.gz \
		nnn-static nnn

.PHONY: lazygit
lazygit:
	bash ./scripts/install.sh \
		https://github.com/jesseduffield/lazygit/releases/download/v0.53.0/lazygit_0.53.0_Linux_x86_64.tar.gz \
		lazygit.tar.gz \
		lazygit lazygit

.PHONY: nushell
nushell:
	bash ./scripts/install.sh \
		https://github.com/nushell/nushell/releases/download/0.106.0/nu-0.106.0-x86_64-unknown-linux-musl.tar.gz \
		nu.tar.gz \
		nu*/nu* "."

carapace:
	bash ./scripts/install.sh \
		https://github.com/carapace-sh/carapace-bin/releases/download/v1.4.1/carapace-bin_1.4.1_linux_amd64.tar.gz \
		carapace.tar.gz \
		carapace carapace
