# Dotfiles

This repo contain my dotfiles and configs, setting up following [this video](https://www.youtube.com/watch?v=y6XCebnB9gs)

## Dependencies

1. make you are using a terminal support 256-color such as [iTerm2](https://iterm2.com/index.html)
2. make sure you are using `zsh`
3. Install a [nerd font](https://www.nerdfonts.com)
4. Install Homebrew and required packages

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install git
brew install stow
```

## installation

```zsh
git clone git@github.com:chenxin-yan/dotfiles.git
cd dotfiles
$ stow .
```

## Features & Configuration

1. install Plugin manager: [zinit](https://github.com/zdharma-continuum/zinit)
2. install prompt theme engine: [Oh My Posh](https://ohmyposh.dev/docs/installation/macos)
3. install fuzzy finder: [fzf](https://github.com/junegunn/fzf)
   - `CTRL-T` - Paste the selected files and directories onto the command-line
   - `CTRL-R` - Paste the selected command from history onto the command-line
   - `ALT-C` - cd into the selected directory
   - use `**<Tab>` to fuzzy find after command
4. Session manager: [tmux](https://github.com/tmux/tmux)
   - [cheetsheet](https://tmuxcheatsheet.com) for tmux command
5. editor: neovim
   - download my [config](https://github.com/chenxin-yan/nvim)
   - (optional) download nvim GUI: neovide
