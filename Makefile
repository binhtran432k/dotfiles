.PHONY: joey
joey: joey-wezterm
	sudo nixos-rebuild switch --flake ".#joey"

.PHONY: yugi
yugi:
	sudo nixos-rebuild switch --flake ".#yugi"

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
