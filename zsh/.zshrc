##
# ~/.zshrc is sourced before every interactive shell, both login and non-login.
# This file should contain aliases and the like, any environment config should
# go in ~/.zshenv

# oh-my-zsh plugins
plugins=(
  aws
  encode64
  golang
  rails
  rake
  rbenv
  ruby
  themes
  tmux
)

# load oh-my-zsh here so I can overwrite things after the fact
source $ZSH/oh-my-zsh.sh

# load my stuff
source $ZDOTDIR/options.zsh
source $ZDOTDIR/bindings.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions.zsh

# add roo ssh key
ssh-add ~/.ssh/alan.gibson 2&> /dev/null

# load secrets
[ -d ~/secrets ] && source ~/secrets/.secretrc

# load nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# source oo the Go version manager
# http://www.github.com/hit9/oo
[ -d $HOME/src/oo ] && source "$HOME/src/oo/env"

# Initialize rbenv
type rbenv > /dev/null && eval "$(rbenv init -)"

# init pyenv if it exists
if  type pyenv > /dev/null; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# completion init
autoload -U compinit # find and load the compinit function
compinit -i          # call the function

# AWS CLI completion
complete -C '/usr/local/bin/aws_completer' aws

# k8s completion
[ $(type kind > /dev/null) ] && source <(kind completion zsh)
[ $(type kubectl > /dev/null) ] && source <(kubectl completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# word of the day
wod
