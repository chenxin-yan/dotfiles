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

# secret env
source "$HOME/.env"

# Created by `pipx` on 2024-10-04 07:23:34
export PATH="$PATH:/Users/yanchenxin/.local/bin"

# == keybindings ==
bindkey -v
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# == add plugins using Zinit == 

# syntax highlighting
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
zinit snippet OMZP::sudo

# load completion
autoload -Uz compinit; compinit -C
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
export FZF_COMPLETION_TRIGGER=";;"

# Use rg with fzf
alias rgi='~/.local/bin/scripts/rg_with_fzf.sh'

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
alias ll="eza -ah --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias tree="eza -TL 2 --color=always --icons=always --git"

# -- Zoxide (better cd) config -- 
eval "$(zoxide init --cmd cd zsh)"

# -- Bat (better cat) --
alias cat='bat'

# -- carapace (better flag completion)
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' 
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)


# == aliases ==
alias dk='lazydocker'
alias v='nvim'
alias Leet='nvim Leetcode.nvim'
alias ovo='Macchina'

alias c='clear'

alias chrome='open -a "Google Chrome"'

alias fzg='~/.local/bin/scripts/grep_current_dir.sh'

# zellij alias
alias z=zellij

# == Scripts ==
# Obsidian
alias obc='~/.local/bin/scripts/obsidian_new_note.sh'
alias obs='~/.local/bin/scripts/obsidian_search.sh'
alias obg='~/.local/bin/scripts/obsidian_grep.sh'
alias cob='cd $VAULT_PATH'

# session/projects
alias se='. ~/.local/bin/scripts/select_sessions.sh'
alias scu='~/.local/bin/scripts/cleanup_sessions.sh'
alias cdv='cd $DEV_DIR'
alias dvn='cd $DEV_DIR; mkdir'
alias dvc='~/.local/bin/scripts/dev_clone.sh'
alias dvrm='~/.local/bin/scripts/dev_remove.sh'

alias cpj='cd $PROJECT_DIR'
alias pjn='cd $PROJECT_DIR; mkdir'
alias area='. ~/.local/bin/scripts/areas_cd.sh'
alias carea='cd $AREA_DIR'

# Yazi
function e() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# lazygit
G()
{
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
            cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
            rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
}

# pandoc
alias md2pdf='~/.local/bin/scripts/markdown_to_pdf.sh'

# bun completions
[ -s "/Users/yanchenxin/.bun/_bun" ] && source "/Users/yanchenxin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/yanchenxin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
