.PHONY: joey
joey:
	sudo nixos-rebuild switch --flake ".#joey"

.PHONY: yugi
yugi:
	sudo nixos-rebuild switch --flake ".#yugi"

.PHONY: paru
paru:
	# Dependencies: base-devel
	rm -rf paru-bin
	git clone --depth 1 https://aur.archlinux.org/paru-bin.git
	cd paru-bin &&  makepkg -si
