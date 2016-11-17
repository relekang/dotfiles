install: vim_plugins $(HOME)/.oh-my-zsh $(HOME)/.gitconfig $(HOME)/.zshrc $(HOME)/.vim $(HOME)/.vimrc $(HOME)/.atom

$(HOME)/.oh-my-zsh:
	curl -L http://install.ohmyz.sh | sh

$(HOME)/.local/bin/pipsi:
	curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python

$(HOME)/.gitconfig:
	@ln -s $(shell pwd)/git/gitconfig $(HOME)/.gitconfig
	@echo "Created symbolic link for .gitconfig"

$(HOME)/.zshrc:
	@ln -s $(shell pwd)/zshrc $(HOME)/.zshrc
	@echo "Created symbolic link for .zshrc"

$(HOME)/.vim:
	@ln -s $(shell pwd)/vimfiles/vim $(HOME)/.vim
	@echo "Created symbolic link for .vim"

$(HOME)/.vimrc:
	@ln -s $(shell pwd)/vimfiles/vimrc $(HOME)/.vimrc
	@echo "Created symbolic link for .vimrc"

$(HOME)/.atom:
	@ln -s $(shell pwd)/atom $(HOME)/.atom
	@echo "Created symbolic link for .atom/"

i3: $(HOME)/.i3/config $(HOME)/.i3status.conf

$(HOME)/.i3/config: $(HOME)/.i3
	@ln -s $(shell pwd)/i3/config $(HOME)/.i3/config
	@echo "Created symbolic link for .i3/config"

$(HOME)/.i3status.conf:
	@ln -s $(shell pwd)/i3/status $(HOME)/.i3status.conf
	@echo "Created symbolic link for .i3/status"

$(HOME)/.i3:
	mkdir -p $(HOME)/.i3

vimfiles:
	@git clone git@github.com:relekang/vimfiles.git
	vim +PluginInstall +qall
	@echo "Cloned dotfiles"

atom-packages:
	sh apms

homebrew:
	sh brew

python:
	sh python/init

vim_plugins: vimfiles
	@cd vimfiles/ && git submodule init
	@cd vimfiles/ && git submodule update
	@vim +PluginInstall +qa
	@echo "Updated vim plugins"

os_stuff:
	sh osx
	sh linux

clean:
	@rm -f $(HOME)/.gitconfig $(HOME)/.zshrc
	@rm -f $(HOME)/.vimrc $(HOME)/.vim
	@echo "Removed all dotfiles"

.PHONY: vim vim_plugins clean os_stuff i3
