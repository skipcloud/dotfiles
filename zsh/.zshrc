##
# ~/.zshrc is sourced before every interactive shell, both login and non-login.
# This file should contain aliases and the like, any environment config should
# go in ~/.zshenv

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  aws
  encode64
  git
  colored-man-pages
  rails
  rake
  rbenv
  ruby
  themes
  tmux
  zsh_reload
)

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# load FZF key bindings
source /usr/share/doc/fzf/examples/key-bindings.zsh

# source ~/.bashrc as the majority of my config is done in there.
# This is so I can switch between bash and zsh and still have 
# the majority of the aliases/functions I am used to.
[ -e ~/.bashrc ] && source ~/.bashrc

# completion init
compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
