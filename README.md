# Dotfiles

A minimal catppuccin setup. Dotfiles are managed using `stow`.

![Preview](./Preview.jpg)

## Dependencies

1. A terminal supports 256-color such as [iTerm2](https://iterm2.com/index.html)
2. Using `zsh`
3. A [nerd font](https://www.nerdfonts.com) (I personally use JetBrainsMono Nerd Font)
4. Homebrew and required packages

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git
brew install stow
```

## Installation

```bash
git clone git@github.com:chenxin-yan/dotfiles.git ~/
cd ~/dotfiles
stow .
```

## Setup & configuration

1. install Plugin manager: [zinit](https://github.com/zdharma-continuum/zinit)
2. install prompt theme engine: [Oh My Posh](https://ohmyposh.dev/docs/installation/macos)
3. install fuzzy finder: [fzf](https://github.com/junegunn/fzf)
   - install [fd](https://github.com/sharkdp/fd) to replace `find`
   - install [ripgrep](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation)
4. install session manager: [tmux](https://github.com/tmux/tmux)
   - install [tpm](https://github.com/tmux-plugins/tpm)
   - use `<prefix>I` to install plugins
5. install git CLI: lazygit
6. (Optional) install karabiner for key motification
7. install editor: [neovim](https://neovim.io)
   - download my nvim [config](https://github.com/chenxin-yan/nvim) and follow setup instructions
   - (optional) download neovide as nvim GUI: [neovide](https://neovide.dev)
8. install better ls: [Eza](https://github.com/eza-community/eza/blob/main/INSTALL.md)
9. install better cd: [Zoxicde](https://github.com/ajeetdsouza/zoxide)
10. install better cat: [Bat](https://github.com/sharkdp/bat)
11. Install tiling window manager: [Yabai](https://github.com/koekeishiya/yabai)
    - Install [skhd](https://github.com/koekeishiya/skhd) for window management shortcuts
12. install [sketchybar](https://felixkratz.github.io/SketchyBar/setup)
    - install [SF Symbals](https://developer.apple.com/sf-symbols/) for macos native symbals
    - install [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font)
13. install terminal file explorer: [yazi](https://yazi-rs.github.io)
14. install file converter: [pandoc](https://pandoc.org)
    - template for pdf generation: [Eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template)
    - install [BasicTex](https://tug.org/mactex/morepackages.html)
    - install [Better BibTex for Zotero](https://retorque.re/zotero-better-bibtex/)
    - install [wkhtmltopdf](https://wkhtmltopdf.org/downloads.html)
15. (Optional) Install system info fetcher: [macchina](https://github.com/Macchina-CLI/macchina)

### Setup SSH Server/client

Follow this [guide](https://www.youtube.com/watch?v=8LcTA5m6_ts)

- setup [tailscale](https://tailscale.com)
- setup mosh follow this [guide](https://docs.blink.sh/integrations/tailscale+mosh).
