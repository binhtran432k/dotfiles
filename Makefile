.PHONY: joey
joey:
	nixos-rebuild switch --flake ".#joey" --sudo

.PHONY: yugi
yugi:
	nixos-rebuild switch --flake ".#yugi" --sudo
	nix run home-manager -- switch --flake ".#yugi"
