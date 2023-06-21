##
# ~/.zshenv is sourced before every interactive and non-interactive shell
# as such any zsh specific environment config should go in this file
##

##
# ENVIRONMENT VARIABLES
#

# Explicitly setting these defaults
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$XDG_CONFIG_HOME/.local/share
export XDG_CACHE_HOME=$XDG_CONFIG_HOME/.cache
export XDG_STATE_HOME=$HOME/.local/state

# Zsh Options

export ZDOTDIR=$XDG_CONFIG_HOME/zsh     # Where we want config files to be found
export HISTFILE=$ZDOTDIR/.zsh_history   # History filepath
export HISTSIZE=10000                   # Maximum events for internal history
export SAVEHIST=10000                   # Maximum events in history file


# FZF plugin
# find all, including hidden, using ripgrep
export FZF_DEFAULT_COMMAND='rg --hidden --iglob !.git --files-with-matches ""'

# Go
export GOPATH=$HOME/go
export GOPRIVATE=github.com/deliveroo

# Misc
export EDITOR=nvim
export VISUAL=nvim
export MANPAGER='nvim +Man!'
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig
export NVM_DIR=$HOME/.nvm
export RI="--format ansi --width 70"
export GPG_TTY=$(tty)
export PYENV_ROOT="$HOME/.pyenv"

# Build PATH
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/bin
export PATH=$PYENV_ROOT/bin:$PATH
export PATH=$PATH:$HOME/.rbenv/plugins/ruby-build/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/sbin
export PATH=$HOME/.tfenv/bin:$PATH

# common directories
export code=$HOME/code
export dots=$HOME/dotfiles
export roo=$code/roo
CDPATH=:$roo

##
# Oh My Zsh set up
#

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# autostart tmux when opening terminal
export ZSH_TMUX_AUTOSTART=true

# Themes
# ZSH_THEME="minimal"
# ZSH_THEME="clean"
# ZSH_THEME="af-magic"
ZSH_THEME=re5et
# ZSH_THEME=daveverwer

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
