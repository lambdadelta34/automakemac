set PATH $HOME/.rbenv/shims $PATH
status --is-interactive; and source (rbenv init -|psub)
rbenv rehash >/dev/null ^&1
alias gcbh="git remote prune origin ; git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D"
alias gcb="git remote prune origin ; git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -d"
kitty + complete setup fish | source
fish_vi_key_bindings
