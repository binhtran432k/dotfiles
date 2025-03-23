.PHONY: joey
joey: joey-wezterm
	sudo nixos-rebuild switch --flake ".#joey"

.PHONY: yugi
yugi:
	sudo nixos-rebuild switch --flake ".#yugi"

.PHONY: joey2
joey2:
	rm -f ~/.profile
	ln -sf ~/dotfiles/profiles/joey.profile ~/.profile

.PHONY: joey-wezterm
joey-wezterm:
	sudo mkdir -p /mnt/c/Users/binhtran432k/.config
	sudo cp -rf ./home/wezterm /mnt/c/Users/binhtran432k/.config

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
