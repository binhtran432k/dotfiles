# dotfiles

```
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/profile ~/.profile
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/Xresources ~/.Xresources
```

## Sync clock
timedatectl set-local-rtc 0
hwclock --systohc --localtime
