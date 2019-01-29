set PATH $PATH $HOME/.local/bin
set PATH $HOME/.rbenv/shims $PATH
set -x LC_ALL en_US.UTF-8
status --is-interactive; and source (rbenv init -|psub)
rbenv rehash >/dev/null ^&1
kitty + complete setup fish | source
fish_vi_key_bindings 2>/dev/null
set -x LC_ALL en_US.UTF-8
set NIX_REMOTE daemon

# opam configuration
source /Users/aa/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
