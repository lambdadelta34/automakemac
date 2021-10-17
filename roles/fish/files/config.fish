status --is-interactive; and source (rbenv init -|psub)
rbenv rehash >/dev/null 2>&1
kitty + complete setup fish | source
set -x LC_ALL en_US.UTF-8
set NIX_REMOTE daemon

# opam configuration
source ~/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
fish_add_path /usr/local/sbin
