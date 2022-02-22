if [[ "$OSTYPE" != "darwin"* ]]; then
  exit 0
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

. "$DIR/../utils/shell-utils.sh"

set -x

echo "Manual things:"
echo " * Enable prevent computer from sleeping when attached to power and screen is off"
echo " * Enable sync during sleep"


# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Show battery life percentage.
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

########## Keyboard ##########

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a really fast key repeat.
defaults write -g KeyRepeat -int 2

defaults write -g InitialKeyRepeat -int 15

defaults write -g NSAutomaticCapitalizationEnabled --int 0

defaults write -g com.apple.keyboard.fnState --int 1
defaults write -g com.apple.springing.delay --string 0.5
defaults write -g com.apple.springing.enabled --int 1

########## Dock ##########

# Remove apps from dock
defaults write com.apple.dock persistent-apps -array

# Set size of dock
defaults write com.apple.dock tilesize -integer 8

# Hide the dock
defaults write com.apple.Dock autohide -bool TRUE

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

killall Dock

########## Requires sudo ##########
echo -e $(lightred 'Some settings require sudo.')
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "
