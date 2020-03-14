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
  xdg-open ${urls[((RANDOM % ${#urls[@]}))]}
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

# cdr navigates back to the root directory of a git project
cdr() {
  local dir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -z "$dir" ]; then
    echo "top level git directory not found"
    return 1
  fi
  cd $dir
}

# tinyprompt() sets PS1 to something compact for those
# times when you don't have much room.
tinyprompt() {
  prompts=("> " "~ " "λ " "Δ ")
  export PS1=${prompts[((RANDOM % ${#prompts[@]} + 1))]}
}

# git-delete-old-branches is a temp function to house this code
# until I can be bothered to put it in a git alias
git-delete-old-branches() {
  for branch in $(git branch | grep -vE '(master|staging)'); do
    if [ -z "$(git --no-pager log -1 --since='1 month ago' --no-patch $branch)"  ]; then
      git branch -D $branch
    fi
  done
}

# weather() returns a weather forecast for current location
# A location can be provided too, i.e. weather london
weather() {
  # https://github.com/chubin/wttr.in
  curl wttr.in/$1
}

alias st-foreman='foreman start -f Procfile-js.dev;'
alias st-sk='bundle exec sidekiq;'
alias st-zeus="OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES zeus start;"
alias st-zeus-log="OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES zeus --log .ZEUSLOG start"
alias zt='zeus test'

alias editbash='cp $HOME/.bashrc $HOME/.bashrc.bak; vim $HOME/.bashrc'

# Git
# these could be put into .gitconfig but I prefer not
# having to prefix the commands with `git ...`
alias gbdd='git branch -D $1'
alias gcs='git checkout staging'
alias gdc='git diff --cached'
alias gfrbm='git fetch origin master && git checkout master && git pull && git checkout - && git rebase master'
alias gmne='git merge --no-edit'
alias gpsu='git push --set-upstream origin $(git_current_branch)'
alias grbim='git rebase -i origin/master'
alias grbmfp='gco master; gl; gco -; grbm; gp -f;'
alias grs="git fetch origin staging && gco staging && git reset origin/staging --hard && gco -"
alias gst="git status -sb"

# Bundle
alias be="bundle exec"
alias bi='bundle install'
alias brs="bundle exec rails s"

alias refresh-db='rake db:refresh; bundle exec rake team:restore[data/team/skip.yml]'

# Go
export GOPATH=$HOME/go
export GOPRIVATE=github.com/deliveroo
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

# personal
export code=$HOME/code
export gosandbox=$GOPATH/src/sandbox
export goskip=$GOPATH/src/github.com/skipcloud
export mysite=$code/personal/skipcloud.github.io
export dots=$HOME/dotfiles

# deliveroo
export orderweb=$code/roo/orderweb
export corest=$deliveroo_gopath/co-restaurants
export consumersearch=$deliveroo_gopath/consumer-search-service
export transport_models=$code/roo/transport-models
export checkout=$deliveroo_gopath/checkout
export coinfra=$code/roo/co-infrastructure
export merchinfra=$code/roo/merch-algos-infrastructure

# add private key to key chain
[ -e $HOME/.ssh/alan.gibson ] && ssh-add $HOME/.ssh/alan.gibson

# load secrets
[ -d ~/secrets ] && source ~/secrets/.secretrc

# load nsm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# set permissions
umask 027

# source oo the Go version manager
# http://www.github.com/hit9/oo
[ -d $HOME/src/oo ] && source "$HOME/src/oo/env"

# Initialize rbenv
[ type rbenv > /dev/null ] && eval "$(rbenv init -)"

