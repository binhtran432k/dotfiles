.PHONY: joey
joey:
	sudo nixos-rebuild switch --flake ".#joey"

.PHONY: yugi
yugi:
	sudo nixos-rebuild switch --flake ".#yugi"
