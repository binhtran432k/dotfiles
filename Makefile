.PHONY: joey
joey: icfg
	rm -f ~/.profile
	ln -sf ~/dotfiles/profiles/joey.profile.sh ~/.profile

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

.PHONY: bun
bun:
	curl -fsSL https://bun.sh/install | bash # for macOS, Linux, and WSL

.PHONY: wsl
wsl:
	rm -rf win32yank
	wget -O win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
	unzip win32yank -d win32yank
	rm -f win32yank.zip
	chmod +x win32yank/win32yank.exe

.PHONY: icfg
icfg: ucfg
	mkdir -p ~/.config
	ln -sf ~/dotfiles/nvim ~/.config/nvim
	ln -sf ~/dotfiles/_config/fish ~/.config/fish
	ln -sf ~/dotfiles/_config/zellij ~/.config/zellij

.PHONY: ucfg
ucfg:
	rm -rf ~/.config/nvim
	rm -rf ~/.config/fish
	rm -rf ~/.config/zellij
