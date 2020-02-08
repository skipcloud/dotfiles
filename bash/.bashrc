# roo() helps you access things you would've used 'go/'
# for back when you used a Mac
roo() {
  xdg-open "http://go.roo.tools/$1"
}

# comic() opens a random comic in default browser
comic() {
  urls=(
    'https://c.xkcd.com/random/comic/'
    'https://pbfcomics.com/random'
    'https://www.buttersafe.com/random'
    'http://www.jspowerhour.com/random-comic'
    'https://abstrusegoose.com/pseudorandom.php'
  )
  xdg-open $urls[((RANDOM % ${#urls[@]}))]
}

# killslack() kills slack and all of the processes
# it, for some reason, leaves running after closing
# the application.
killslack() {
  pgrep slack | xargs --no-run-if-empty kill
}

# mypulls() opens my github pull request page
mypulls() {
  xdg-open https://github.com/pulls
}

# define() looks for definitions
define() {
  IFS=+ xdg-open "https://duckduckgo.com/?q=define+$*"

}

cdr() {
  local dir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -z "$dir" ]; then
    echo "top level git directory not found"
    return 1
  fi
  cd $dir
}

alias st-foreman='foreman start -f Procfile-js.dev;'
alias st-sk='bundle exec sidekiq;'
alias st-zeus="OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES zeus start;"
alias st-zeus-log="OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES zeus --log .ZEUSLOG start"

alias zt='zeus test'

alias editbash='cp $HOME/.bashrc $HOME/.bashrc.bak; vim $HOME/.bashrc'
alias editvim='cp $HOME/.vimrc $HOME/.vimrc.bak && vim $HOME/.vimrc'

alias steal='$HOME/code/personal/page-thief/steal $1'

# Git
alias gst="git status -sb"
alias gcs='git checkout staging'
alias gmne='git merge --no-edit'
alias gfrbm='git fetch origin master && git checkout master && git pull && git checkout - && git rebase master'
alias gpsu='git push --set-upstream origin $(git_current_branch)'
alias grbim='git rebase -i origin/master'
alias gbdd='git branch -D $1'
alias grbmfp='gco master; gl; gco -; grbm; gp -f;'
alias grs="git fetch origin staging && gco staging && git reset origin/staging --hard && gco -"

# Bundle
alias be="bundle exec"
alias bi='bundle install'
alias brs="bundle exec rails s"

alias refresh-db='rake db:refresh; bundle exec rake team:restore[data/team/skip.yml]'

# Go
export GOPATH=$HOME/go
export deliveroo_gopath=$GOPATH/src/github.com/deliveroo

# Misc
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig
export NVM_DIR=$HOME/.nvm
export RI="--format ansi --width 70"
export EDITOR=vim

# Build PATH
export PATH=/usr/local/opt/gettext/bin
export PATH=$PATH:$HOME/.rbenv/plugins/ruby-build/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/bin:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/sbin

# common directories
export code=$HOME/code
export practice=$HOME/practice
export orderweb=$code/roo/orderweb
export corest=$deliveroo_gopath/co-restaurants
export consumersearch=$deliveroo_gopath/consumer-search-service
export checkout=$deliveroo_gopath/checkout
export gosandbox=$GOPATH/src/sandbox
export transport_models=$code/roo/transport-models
export mysite=$code/personal/skipcloud.github.io
export dots=$HOME/dotfiles
export coinfra=$code/roo/co-infrastructure

ssh-add $HOME/.ssh/alan.gibson

# load secrets
if [ -d ~/secrets ]; then
  source ~/secrets/.secretrc
fi

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# set permissions
umask 027

# source oo the Go version manager
# http://www.github.com/hit9/oo
source "$HOME/src/oo/env"
eval "$(rbenv init -)"

