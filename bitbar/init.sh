
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

brew cask install bitbar

mkdir -p ~/.bitbar

cp -r "$DIR/scripts/" ~/.bitbar/

open -a Bitbar
