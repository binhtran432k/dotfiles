# env.nu
#
# Installed by:
# version = "0.106.0"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

# Config
$env.config.edit_mode = 'vi'

# Carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
if (which carapace | is-not-empty) and not ('~/.cache/carapace/init.nu' | path exists) {
  mkdir ~/.cache/carapace
  carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
}

# Zoxide
if (which zoxide | is-not-empty) and not ('~/.zoxide.nu' | path exists) {
  zoxide init nushell | save -f ~/.zoxide.nu
}
