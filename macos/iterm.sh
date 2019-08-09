#brew cask install iterm2

# Open the app so the preference files get initialized
#open -g "/Applications/iTerm.app" && sleep 2

# Disable warning when quitting
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# sleep 2 && osascript -e 'quit app "iTerm"'


# Set custom preference directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.dotfiles/macos/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Fonts
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Normal Font' FiraCode-Regular 15" ~/Library/Preferences/com.googlecode.iTerm2.plist
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Non Ascii Font' FiraCode-Regular 15" ~/Library/Preferences/com.googlecode.iTerm2.plist

# Unlimited Scrollback
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Unlimited Scrollback' true" ~/Library/Preferences/com.googlecode.iTerm2.plist

# Mute bell
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Silence Bell' true" ~/Library/Preferences/com.googlecode.iTerm2.plist

# Set split-pane dimming amount
/usr/libexec/PlistBuddy -c "Set 'SplitPaneDimmingAmount' 0.18" ~/Library/Preferences/com.googlecode.iTerm2.plist
/usr/libexec/PlistBuddy -c "Set 'DimOnlyText' 1" ~/Library/Preferences/com.googlecode.iTerm2.plist

# Set new split-pane working dir to previous pane working dir
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'Custom Directory' Advanced" ~/Library/Preferences/com.googlecode.iTerm2.plist
/usr/libexec/PlistBuddy -c "Set 'New Bookmarks':0:'AWDS Pane Option' Recycle" ~/Library/Preferences/com.googlecode.iTerm2.plist

# reset the preferences cache
killall cfprefsd
