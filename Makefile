install: $(HOME)/.oh-my-zsh $(HOME)/.gitconfig $(HOME)/.zshrc vim homebrew

$(HOME)/.oh-my-zsh:
	curl -L http://install.ohmyz.sh | sh

$(HOME)/.gitconfig:
	@ln -s $(shell pwd)/git/gitconfig $(HOME)/.gitconfig
	@echo "Created symbolic link for .gitconfig"

$(HOME)/.zshrc:
	@ln -s $(shell pwd)/zshrc $(HOME)/.zshrc
	@echo "Created symbolic link for .zshrc"

vim: $(HOME)/.vim $(HOME)/.vimrc vimfiles vim_plugins

$(HOME)/.vim: vimfiles
	@ln -s $(shell pwd)/vimfiles/vim $(HOME)/.vim
	@echo "Created symbolic link for .vim"

$(HOME)/.vimrc: vimfiles
	@ln -s $(shell pwd)/vimfiles/vimrc $(HOME)/.vimrc
	@echo "Created symbolic link for .vimrc"

vimfiles:
	@git clone git@github.com:relekang/vimfiles.git
	@echo "Cloned dotfiles"

vim_plugins: vimfiles
	cd vimfiles/ && git submodule init
	cd vimfiles/ && git submodule update

homebrew:
	@sh homebrew
	@echo "Installed homebrew and brew packages"

clean:
	@rm  -f $(HOME)/.gitconfig $(HOME)/.zshrc
	@rm -rf $(HOME)/.vimrc $(HOME)/.vim
	@echo "Removed all dotfiles"

.PHONY: vim vim_plugins clean homebrew
