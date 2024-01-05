# Dotfiles

This dotfiles repo was made up to be used in my systems.

## Requirements

```
chezmoi git paru
```

# Installation Steps

- Init project

```shell
chezmoi init binhtran432k
```

# Setup fstab

Edit /etc/fstab

- `kouta`
```fstab
LABEL=Data /mnt/Data ntfs defaults,uid=1000,gid=1000 0 0
LABEL=Media /mnt/Media ntfs defaults,uid=1000,gid=1000 0 0
```
