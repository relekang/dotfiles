install: $(HOME)/.oh-my-zsh $(HOME)/.gitconfig $(HOME)/.zshrc $(HOME)/Library/Application\ Support/Code/User/settings.json python os secret-aliases

$(HOME)/.oh-my-zsh:
	curl -L http://install.ohmyz.sh | sh

$(HOME)/.local/bin/pipsi:
	curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python

$(HOME)/.gitconfig:
	@ln -s $(shell pwd)/git/gitconfig $(HOME)/.gitconfig
	@echo "Created symbolic link for .gitconfig"

$(HOME)/.local/bin/git-delete-merged:
	@ln -s $(shell pwd)/git/delete-merged.sh $(HOME)/.local/bin/git-delete-merged

$(HOME)/.zshrc:
	@ln -s $(shell pwd)/zshrc $(HOME)/.zshrc
	@echo "Created symbolic link for .zshrc"

$(HOME)/.vim:
	@ln -s $(shell pwd)/vimfiles/vim $(HOME)/.vim
	@echo "Created symbolic link for .vim"

$(HOME)/.vimrc:
	@ln -s $(shell pwd)/vimfiles/vimrc $(HOME)/.vimrc
	@echo "Created symbolic link for .vimrc"

$(HOME)/.config/nvim:
	@ln -s $(shell pwd)/nvim $(HOME)/.config/nvim
	@echo "Created symbolic link for nvim"

$(HOME)/.hyper.js:
	@ln -s $(shell pwd)/hyper.js $(HOME)/.hyper.js
	@echo "Created symbolic link for .hyper.js"

$(HOME)/.atom:
	@ln -s $(shell pwd)/atom $(HOME)/.atom
	@echo "Created symbolic link for .atom/"

$(HOME)/Library/Application\ Support/Code/User/settings.json:
	@ln -s $(shell pwd)/vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	@echo "Created symbolic link for vscode settings.json"

i3: $(HOME)/.i3/config $(HOME)/.i3status.conf

$(HOME)/.i3/config: $(HOME)/.i3
	@ln -s $(shell pwd)/i3/config $(HOME)/.i3/config
	@echo "Created symbolic link for .i3/config"

$(HOME)/.i3status.conf:
	@ln -s $(shell pwd)/i3/status $(HOME)/.i3status.conf
	@echo "Created symbolic link for .i3/status"

$(HOME)/.i3:
	mkdir -p $(HOME)/.i3

secret-aliases:
	touch secret-aliases

vimfiles:
	@git clone git@github.com:relekang/vimfiles.git
	@echo "Cloned dotfiles. Installing..."

vim: vimfiles
	@cd vimfiles && $(MAKE)

atom-packages:
	sh apms

vscode: $(HOME)/Library/Application\ Support/Code/User/settings.json
	brew cask install visual-studio-code
	./vscode/install-extensions

homebrew:
	sh macos/homebrew

python:
	sh python/init

os:
	sh macos/osx
	sh linux

clean:
	@rm -f $(HOME)/.gitconfig $(HOME)/.zshrc
	@rm -f $(HOME)/.vimrc $(HOME)/.vim
	@rm -f $(HOME)/Library/Application\ Support/Code/User/settings.json
	@echo "Removed all dotfiles"

.PHONY: vim vim_plugins clean os i3 python homebrew vscode
