# init zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# == keybindings ==
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# == add plugins using Zinit == 

zinit light zsh-users/zsh-syntax-highlighting

# autocompletion
zinit light zsh-users/zsh-completions

# autosuggestions
zinit light zsh-users/zsh-autosuggestions
bindkey '^y' autosuggest-accept

# History config
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# == add snippts using zinit
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

# load completion
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# load zinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# == Shell integrations ==

# homebrew support
eval "$(/opt/homebrew/bin/brew shellenv)"

# -- oh-my-posh config -- 
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/cyan.omp.toml)"
fi

# -- fzf config --
eval "$(fzf --zsh)"

# -- Eza (better ls) config --
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

# -- Zoxide (better cd) config -- 
eval "$(zoxide init --cmd cd zsh)"

# == aliases ==
alias c='clear'
alias nvide='neovide'
alias dv='cd ~/dev'

# tmux alixes
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
