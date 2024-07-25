# time ZSH_DEBUGRC=1 zsh -i -c exit 
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

# init zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

export XDG_CONFIG_HOME="$HOME/.config"

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
zinit snippet OMZP::sudo

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

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Use fd instead of default find

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# -- Eza (better ls) config --
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias tree="eza -TL 2 --color=always --icons=always"

# -- Zoxide (better cd) config -- 
eval "$(zoxide init --cmd cd zsh)"

# -- Bat (better cat) --
alias cat='bat'

# -- the fuck --
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# == aliases ==
alias nvide='neovide'
alias gl='lazygit'
alias vim='nvim'
alias cdv='cd $PROJECT_DIR'
alias ezsh='exec zsh'

alias c='clear'
alias lsb='ls -ah | bat'

alias chrome='open -a "Google Chrome"'

# tmux alixes
alias ta='tmux attach'
alias tat='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# == Scripts ==
# Obsidian
alias obc='~/.local/bin/scripts/obsidian_new_note.sh'
alias obs='~/.local/bin/scripts/obsidian_search.sh'

# tmux
alias dv='~/.local/bin/scripts/dev_session.sh'

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi

