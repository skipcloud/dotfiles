##
# FUNCTIONS
#

# roo() helps you access things you would've used 'go/'
# for back when you used a Mac
roo() {
  xdg-open "http://go.roo.tools/$1"
}

# groo() opens the specified deliveroo github repo
# in the default browser
groo() {
  xdg-open "https://github.com/deliveroo/$1"
}

# email() opens gmail
email() {
  xdg-open "https://mail.google.com/mail/u/1/"
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
# times when you don't have much room. The option -r 
# will restore the original prompt
tinyprompt() {
  if [ "$1" = "-r" ] && [ -n "$OLD_PS1" ]; then
    PS1=$OLD_PS1
    return 0
  fi

  # only store the original prompt once so calling
  # the function again won't store a tinyprompt
  if [ -z "$OLD_PS1" ]; then
    export OLD_PS1=$PS1
  fi

  prompts=("> " "~ " "λ " "Δ " "∴ " "∵ ")
  export PS1=${prompts[((RANDOM % ${#prompts[@]} + 1))]}
}

# git-delete-old-branches is a temp function to house this code
# until I can be bothered to put it in a git alias
git-delete-old-branches() {
  for branch in $(git branch | grep -vE '(master|staging)'); do
    if [ -z "$(git --no-pager log -1 --since='1 month ago' --no-patch "$branch")"  ]; then
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

# :q() exits the terminal, I know you meant to type
# exit but it's okay I gotchu
:q() {
  exit
}

# j() jumps to a project folder defined in $PROJECT_DIRS
j() {
  if [ -z "$PROJECT_DIRS" ]; then
    echo '$PROJECT_DIRS has not been set' >&2
    return 1
  fi

  if [ -z "$1" ]; then
    echo "missing argument: '$0 <project>'" >&2
  fi

  for dir in "${PROJECT_DIRS[@]}"; do
    if [ -d "$dir/$1" ]; then
      cd $dir/$1
      return 0
    fi
  done

  echo "project '$1' not found"
  return 1
}

# wod() returns the Word of the Day from Wordnik. 
# If an "-f" option is provided then the word of the day is fetched again.
wod() {
  if [ -z "$WORDNIK_API_KEY" ]; then
    echo "wod: Wordnik API key not set" >&2
    return 1
  fi

  if ! hash jq 2> /dev/null; then
    echo "wod: jq not installed" >&2
    return 1
  fi

  # store wod in a dot file so we only need to request it once a day
  file_path=$HOME/.wod

  # if the dot file exists and we don't want to fetch again
  if [ -f $file_path ] && [ "$1" != "-f" ]; then
    # check if the mod date is today
    date_fmt="+%Y-%m-%d"
    if [ "$(date -r $file_path $date_fmt)" = "$(date $date_fmt)" ]; then
      cat $file_path
      return 0
    fi
  fi

  # let's just assume the request works
  resp=$(curl -s "https://api.wordnik.com/v4/words.json/wordOfTheDay?api_key=$WORDNIK_API_KEY")

  word=$(jq '.word' <<< "$resp")
  kind=$(jq '.definitions[0].partOfSpeech' <<< "$resp" | sed 's/"//g')
  def=$(jq '.definitions[0].text' <<< "$resp" | sed 's/"//g')
  note=$(jq '.note' <<< $resp | sed 's/"//g')

  cat <<-END | fmt | tee $file_path
Word of the day: $word - $kind

Definition: $def

$note
END
}

# yesterday() quickly opens my yesterday notes in vim, I use
# this file to keep track of work I've completed the day before
function yesterday() {
  if ! type note >/dev/null; then
    echo "'note' not found. Please install" >&2
    exit 1
  fi

  note yesterday
}

# cdgd() changes directory to the gemdir
function cdgd() {
  if ! type gem >/dev/null 2>&1; then
    echo "'gem' not installed" >&2
    return 1
  fi

  cd "$(gem environment gemdir)/gems"
}

##
# Aliases
#

alias st-foreman='foreman start -f Procfile-js.dev;'
alias st-sk='bundle exec sidekiq;'
alias st-zeus="OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES zeus start;"
alias st-zeus-log="OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES zeus --log .ZEUSLOG start"
alias zt='zeus test'

# quickly edit rc files
alias bashrc='vim $HOME/.bashrc'
alias vimrc='vim $HOME/.vim/vimrc'
alias zshrc='vim $HOME/.zshrc'

# Git
# these could be put into .gitconfig but I prefer not
# having to prefix the commands with `git ...`
alias gbdd='git branch -D $1'
alias gcs='git checkout staging'
alias gdc='git diff --cached'
alias gfrbm='git fetch --prune origin master:master && git rebase origin/master'
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

# Deliveroo - Orderweb
alias refresh-db='rake db:refresh; bundle exec rake team:restore[data/team/skip.yml]'

# Misc
alias open=xdg-open
alias gotop="gotop -c vice"
alias evpn=expressvpn

##
# ENVIRONMENT VARIABLES
#

# FZF plugin
# find all, including hidden, using ripgrep
export FZF_DEFAULT_COMMAND='rg --hidden --iglob !.git --files-with-matches ""'

# Go
export GOPATH=$HOME/go
export GOPRIVATE=github.com/deliveroo
export deliveroo_gopath=$GOPATH/src/github.com/deliveroo

# Misc
export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig
export NVM_DIR=$HOME/.nvm
export RI="--format ansi --width 70"
export EDITOR=vim
export GPG_TTY=$(tty)

# Build PATH
export PATH=/usr/local/opt/gettext/bin
export PATH=$PATH:$HOME/.rbenv/plugins/ruby-build/bin
export PATH=$PATH:$HOME/.rbenv/bin
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/bin:/usr/bin:/usr/sbin:/sbin:/usr/local/sbin
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.tfenv/bin:$PATH

# common directories

# personal
export code=$HOME/code
export gosandbox=$GOPATH/src/sandbox
export goskip=$GOPATH/src/github.com/skipcloud
export mysite=$code/personal/skipcloud.github.io
export dots=$HOME/dotfiles

# deliveroo
export roo=$code/roo
export orderweb=$code/roo/orderweb
export corest=$deliveroo_gopath/co-restaurants
export consumersearch=$deliveroo_gopath/consumer-search-service
export transport_models=$code/roo/transport-models
export checkout=$deliveroo_gopath/checkout
export coinfra=$code/roo/co-infrastructure
export merchinfra=$code/roo/merch-algos-infrastructure
CDPATH=.:$roo

if grep 'bash$' <<< "$0" >/dev/null; then
  PS1="\033[35m\s\033[m \W > "
fi

# for use with j()
export PROJECT_DIRS=($deliveroo_gopath $code/roo $code/personal)

# add private key to key chain
[ -e $HOME/.ssh/alan.gibson ] && eval $(ssh-agent > /dev/null) && ssh-add -q $HOME/.ssh/alan.gibson

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
type rbenv > /dev/null && eval "$(rbenv init -)"

# word of the day
wod

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
