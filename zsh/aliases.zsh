##
# Aliases
#

alias vim=nvim
alias view='nvim -R'

# quickly edit rc files
alias vimrc='vim $HOME/.config/nvim/init.lua'
alias zshrc='vim $ZDOTDIR/.zshrc'
alias zshenv='vim $ZDOTDIR/.zshenv'

alias saml-gsts='command gsts'

# Git
# add
alias ga='git add'
alias gap='git add --patch'
alias gau='git add --update'
# commit
alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gcn!='git commit --verbose --no-edit --amend'
alias gcmsg='git commit --message'
# checkout
alias gco='git checkout'
# diff
alias gd='git diff'
alias gdc='git diff --cached'
# fetch
alias gfa='git fetch --all --prune'
alias gfrbm='git fetch --prune origin $(git_main_branch):$(git_main_branch) && git rebase origin/$(git_main_branch)'
# pull
alias gl='git pull --prune'
# switch
alias gsw='git switch'
alias gswc='git switch -c'
alias gswm='git switch $(git_main_branch)'
alias gsws='git switch staging'
alias gswsb='git switch sandbox'
# log
alias glo='git log --oneline --decorate'
alias glog='git log --oneline --decorate --graph'
# merge
alias gm='git merge'
alias gmne='git merge --no-edit'
alias gmtl='git mergetool'
alias gma='git merge --abort'
alias gmc='git merge --continue'
# push
alias gp='git push'
alias gpsu='git push --set-upstream origin $(git_current_branch)'
alias gpf='git push --force-with-lease --force-if-includes'
# rebase
alias grb='git rebase'
alias grbi='git rebase --interactive'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbim='git rebase -i origin/$(git_main_branch)'
# reset
alias grs='git reset --soft'
alias grsh='git reset --hard'
# status
alias gst="git status --short --branch"
# stash
alias gsts='git status show --text'
alias gsta='git stash push'
alias gstu='git stash push --include-untracked'
alias gstp='git stash pop'
alias gstd='git stash drop'
alias gstc='git stash clear'

# SSM into an EC2 instance 
alias ssm-start='aws ssm start-session --document DeliverooSSM --target'

# Misc
alias gotop="gotop -c vice"

