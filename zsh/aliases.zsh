##
# Aliases
#

alias hiya='echo hello there'

alias vim=nvim
alias view='nvim -R'

# quickly edit rc files
alias vimrc='vim $HOME/.config/nvim/init.lua'
alias zshrc='vim $ZDOTDIR/.zshrc'
alias zshenv='vim $ZDOTDIR/.zshenv'

alias saml-gsts='command gsts'

# Git
# these could be put into .gitconfig but I prefer not
# having to prefix the commands with `git ...`
alias gbdd='git branch -D $1'
alias gcs='git checkout staging'
alias gcsb='git checkout sandbox'
alias gdc='git diff --cached'
alias gfrbm='git fetch --prune origin $(git_main_branch):$(git_main_branch) && git rebase origin/$(git_main_branch)'
alias gmne='git merge --no-edit'
alias gpsu='git push --set-upstream origin $(git_current_branch)'
alias grbim='git rebase -i origin/$(git_main_branch)'
alias gst="git status -sb"

# SSM into an EC2 instance 
alias ssm-start='aws ssm start-session --document DeliverooSSM --target'

# Misc
alias gotop="gotop -c vice"
alias evpn=expressvpn

