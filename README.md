# 💻 Setup

> For personal use. Use at your own risk!

This repository provides scripts and configurations to quickly set up a macOS environment for development.

## First run

1. Install apps from the App Store.
2. Run the following commands step by step:

```bash
# Set ZSH as the default shell
chsh -s /bin/zsh $USER

# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone this repository
export SETUP="$HOME/.setup"
git clone https://github.com/lehroj/setup.git $SETUP

# Source the main setup script
source $SETUP/scripts/my.zsh
```

3. Install libs and apps from Homebrew  (careful, password may be ask):

```bash
my install
# or separately
my install --brew
my install --vsc
# I suggest you check each step went correctly.
```

4. Create SSH/GPG keys:

```bash
# SSH key(s)
ssh-keygen -t ed25519 -C YOUR_EMAIL
cat $HOME/.ssh/YOUR_KEY.pub | pbcopy
# Paste it on GitHub/GitLab/Bitbucket...

# GPG key(s)
gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG
gpg --armor --export GPG_KEY_ID | pbcopy
# Paste it on GitHub/GitLab/Bitbucket...

# Add this to your ~/.gnupg/gpg-agent.conf
# pinentry-program /opt/homebrew/bin/pinentry-mac

# Restart GPG agent
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
```

5. Complete your Git configuration with adding your keys:

```bash
# $SETUP/dotfiles/git/.git_local
[includeIf "gitdir:~/Perso/"]
  path = ~/.git_perso

[includeIf "gitdir:~/Work/"]
  path = ~/.git_work

# This file (.git_local) is intentionally not versioned for privacy reasons.
```

```bash
# $SETUP/dotfiles/git/.git_perso|work
[user]
  name = YOUR_NAME
  email = YOUR_EMAIL
  signinkey = GPG_KEY_ID

# These files (.git_perso, .git_work) are intentionally not versioned for privacy reasons.
```

6. Complete your Zsh configuration with .zsh_local (optional):

```bash
# $SETUP/dotfiles/zsh/.zsh_local
# All you want here, aliases, functions...
# This file (.zsh_local) is intentionally not versioned for privacy reasons.
```

7. Symlink your configuration:

```bash
my dotfiles
# or separately
my dotfiles --git
my dotfiles --misc
my dotfiles --zsh
# I suggest you check each step went correctly.

# Load Zsh configuration
source $HOME/.zshrc

# Reload shell
exec $SHELL -l
```

## Sometimes

Run these commands periodically to keep your setup clean and up-to-date.

```bash
# Homebrew
brew update
brew upgrade --formulae
brew upgrade --casks # (--greedy if you want to force updates)
brew doctor
brew cleanup -s
brew cleanup --prune=all
rm -rf "$(brew --cache)"

# Backup
my backup
# or separately
my backup --brew
my backup --vsc
# I suggest you check each step went correctly.

# Antidote (fast and minimal Zsh plugin manager)
antidote update
```

## 🙌 Contribute

### 🐛 Bug Reports

Something doesn't work as expected ?
<br>
Please open an issue [here](https://github.com/lehroj/setup/issues).

### 🤝 Pull Requests

You want to suggest something ?
<br>
[Fork it](https://github.com/lehroj/setup/fork), do your stuff and open a PR !

## 📖 License

The project is available as open source under the terms of the [MIT license](./LICENSE.md).

## 🎉 Credits

Inspired by [GitHub ❤ ~/](https://dotfiles.github.io).
