##
# FUNCTIONS
#
# Load my custom shell functions as well as some zsh ones.

# anon function to keep local vars from
# polluting shell env
(){
  local my_funcs=$ZDOTDIR/functions
  fpath=( $my_funcs $fpath )

  # autoload all functions by passing
  # the filenames to autoload
  autoload -U $my_funcs/*(:t)
}

# completion init
autoload -U compinit # find and load the compinit function
compinit -i          # call the function

# load other zsh functions
autoload -U colors

