##
# FUNCTIONS
#

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

# kslack() kills slack and all of the processes
# it, for some reason, leaves running after closing
# the application.
kslack() {
  pkill slack
}

# mypulls() opens my github pull request page
mypulls() {
  xdg-open https://github.com/pulls
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

# :q() exits the terminal, I know you meant to type
# exit but it's okay I gotchu
:q() {
  exit
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
