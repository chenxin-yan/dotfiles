#!/bin/bash
tmuxsessions=$(tmux list-sessions -F "#{session_name}")

tmux_switch_to_session() {
    session="$1"
    if [[ $tmuxsessions = *"$session"* ]]; then
        tmux switch-client -t "$session"
    fi
}

choice=$(sort -rfu <<< "$tmuxsessions" \
    | fzf-tmux \
    | tr -d '\n')
tmux_switch_to_session "$choice"
