# 💻 Setup

> Personal dotfiles, use at your own risk!

## First run

Get your apps from the App Store.

```bash
export SETUP="$HOME/Setup"

# ZSH as default shell
chsh -s /bin/zsh $USER

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Setup
git clone https://github.com/lehroj/setup.git $SETUP
source $SETUP/scripts/my.zsh

# Install libs & apps
my install
# or separately
my install -t
my install -b
my install -c
my install -v
# I suggest you check each step went correctly.

# SSH key
ssh-keygen -t rsa -b 4096 -C YOUR_EMAIL
cat $HOME/.ssh/YOUR_KEY.pub | pbcopy
# Paste it on GitHub/GitLab/Bitbucket...

# GPG key
gpg --default-new-key-algo rsa4096 --gen-key
gpg --list-secret-keys --keyid-format LONG
gpg --armor --export GPG_KEY_ID | pbcopy
# Paste it on GitHub/GitLab/Bitbucket...

# Create your .git_perso in ~/Setup/dotfiles/git/.git_perso
# For example :
[user]
  name = XXX
  email = XXX
  signinkey = GPG_KEY_ID

# Symlink dotfiles
my dotfiles
# or separately
my dotfiles -g
my dotfiles -v
my dotfiles -z
# I suggest you check each step went correctly.

# ZSH configuration
. $HOME/.zshrc

# Shell reload
exec $SHELL -l
```

## Sometimes

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
my backup -t
my backup -b
my backup -ck
my backup -v
# I suggest you check each step went correctly.

# Antigen
antigen update
antigen cleanup
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
