# config.nu
#
# Installed by:
# version = "0.106.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

alias ll = ls -l
alias lg = lazygit
alias zlj = zellij

const carapace_path = '~/.cache/carapace/init.nu'
source (if ($carapace_path | path exists) { $carapace_path } else { null })

const zoxide_path = '~/.zoxide.nu'
source (if ($zoxide_path | path exists) { $zoxide_path } else { null })
