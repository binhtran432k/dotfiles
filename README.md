# My Nix Dotfiles

Welcome to my personal **Nix Dotfiles** repository! This project provides a
complete setup for my development and daily-use environment, tailored for
**WSL** and **NixOS**. It includes configurations for essential tools and
utilities to streamline productivity and aesthetics.

## Features

### Window Management

- **[Sway](https://swaywm.org/):** A lightweight and efficient tiling Wayland
  compositor.
- Custom keybindings and layouts for seamless navigation and multitasking.

### Editor & Terminal

- **[Neovim](https://neovim.io/):** Enhanced with plugins for an optimal coding
  experience.
- **[Kitty](https://sw.kovidgoyal.net/kitty/):** A feature-rich, GPU-powered
  terminal emulator.

### Notifications

- Beautifully styled and functional notification system using **[mako](https://github.com/emersion/mako)**.

### Browser & Email

- Pre-configured setup for a streamlined browsing experience and email
  management.

### Additional Tools

- Fully integrated support for essential applications like file managers, media
  players, and utilities.

## Why Nix?

Using **Nix**, I ensure a reproducible and declarative configuration for my
system, enabling consistent behavior across both WSL and NixOS environments.

## Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/binhtran432k/dotfiles.git ~/dotfiles
   ```

2. Install `gnumake`:

   ```bash
   nix-shell -p gnumake
   ```

3. Run the prepared makefile script base on host:

   ```bash
   # For WSL
   make joey
   # For NixOS
   make yugi
   ```

4. Customize to your liking by editing the respective config files in the
   `~/dotfiles` directory.

## What's Inside?

This dotfiles repository includes configurations for:

- Window manager (Sway)
- Terminal (Kitty)
- Editor (Neovim)
- Notifications (mako)
- Browser
- Email client
- Various other utilities and tools

## Contributing

While this is a personal project, feel free to explore and suggest improvements
by opening an issue or submitting a pull request.

## License

This repository is licensed under the [MIT License](./LICENSE).
