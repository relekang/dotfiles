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

########## Keyboard ##########

# Disable press-and-hold for keys in favor of key repeat.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a really fast key repeat.
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -int 0

defaults write NSGlobalDomain com.apple.keyboard.fnState -int 1

########## Dock ##########

# Remove apps from dock
defaults write com.apple.dock persistent-apps -array

# Set size of dock
defaults write com.apple.dock tilesize -integer 16
defaults write com.apple.dock largesize -integer 80
defaults write com.apple.dock magnification -integer 1

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Hide the dock
defaults write com.apple.Dock autohide -bool TRUE

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -integer 0

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -integer 0

############ Finder #############
defaults write com.apple.finder ShowHardDrivesOnDesktop -integer 0
defaults write com.apple.finder ShowHardDrivesOnDesktop -integer 0
defaults write com.apple.finder ShowRemovableMediaOnDesktop -integer 0
defaults write com.apple.finder "FXEnableExtensionChangeWarning" -bool "false"
defaults write com.apple.finder ShowPathbar -bool true
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

############ Choosy

defaults write com.choosyosx.Choosy displayMenuBarItem -integer 0
defaults write com.choosyosx.Choosy launchAtLogin -integer 1

############ iTerm
defaults write com.googlecode.iterm2 DimInactiveSplitPanes -integer 1
defaults write com.googlecode.iterm2 DimOnlyText -integer 1

############ Other

defaults write com.apple.menuextra.clock Show24Hour -integer 1
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

mkdir -p Screenshots
defaults write com.apple.screencapture location ~/Desktop/Screenshots

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

defaults write com.fuekiin.NightOwl playSound -integer 0

killall Dock
killall SystemUIServer
killall Finder

########## Requires sudo ##########
echo -e $(lightred 'Some settings require sudo.')
# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "
