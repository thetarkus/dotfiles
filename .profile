#!/usr/bin/env sh
[[ -z "$SSH_AUTH_SOCK" ]] && eval "$(ssh-agent -s)"

export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

export BROWSER='firefox'
export TERMINAL='xfce4-terminal'
