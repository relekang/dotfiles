install: $(HOME)/.oh-my-zsh $(HOME)/.python $(HOME)/.ssh/authorized_keys links secret-aliases $(HOME)/.config/k9s/skins/catppuccin iterm
links: $(HOME)/.gitconfig $(HOME)/.zshrc $(HOME)/.zshenv $(HOME)/.zsh-custom $(HOME)/.config/k9s
install-docker: $(HOME)/.oh-my-zsh $(HOME)/.gitconfig $(HOME)/.zshrc

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

$(HOME)/.zshenv:
	@ln -s $(shell pwd)/zshenv $(HOME)/.zshenv
	@echo "Created symbolic link for .zshenv"

$(HOME)/.zsh-custom:
	@ln -s $(shell pwd)/zsh-custom $(HOME)/.zsh-custom
	@echo "Created symbolic link for .zsh-custom"

$(HOME)/.vim:
	@ln -s $(shell pwd)/vimfiles/vim $(HOME)/.vim
	@echo "Created symbolic link for .vim"

$(HOME)/.vimrc:
	@ln -s $(shell pwd)/vimfiles/vimrc $(HOME)/.vimrc
	@echo "Created symbolic link for .vimrc"

$(HOME)/.config/nvim:
	@ln -s $(shell pwd)/nvim $(HOME)/.config/nvim
	@echo "Created symbolic link for nvim"

$(HOME)/.config/k9s:
	@ln -s $(shell pwd)/k9s $(HOME)/.config/k9s
	@echo "Created symbolic link for k9s"

$(HOME)/.config/k9s/skins: $(HOME)/.config/k9s
	@mkdir $(HOME)/.config/k9s/skins

$(HOME)/.config/k9s/skins/catppuccin: $(HOME)/.config/k9s/skins
	@git clone https://github.com/catppuccin/k9s.git $(HOME)/.config/k9s/skins/catppuccin --depth 1
	@cp $(HOME)/.config/k9s/skins/catppuccin/dist/mocha.yml $(HOME)/.config/k9s/skin.yml
	@echo "Cloned k9s skin catppuccin"

$(HOME)/.hyper.js:
	@ln -s $(shell pwd)/hyper.js $(HOME)/.hyper.js
	@echo "Created symbolic link for .hyper.js"

$(HOME)/.rustup:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y


$(HOME)/.tmux.conf:
	@ln -s $(shell pwd)/tmux.conf $(HOME)/.tmux.conf
	@echo "Created symbolic link for .tmux.conf"

$(HOME)/.tmux/plugins:
	@mkdir -p $(HOME)/.tmux/plugins
	@echo "Created dir .tmux/plugins"

$(HOME)/.ssh:
	@mkdir -p $(HOME)/.ssh
	@chmod 700 $(HOME)/.ssh
	@echo "Created dir .ssh"

$(HOME)/.ssh/authorized_keys: $(HOME)/.ssh
	@curl https://github.com/relekang.keys > $(HOME)/.ssh/authorized_keys
	@echo "Added authorized_keys from github"

$(HOME)/.tmux/plugins/tmp: $(HOME)/.tmux/plugins
	@git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	@echo "Cloned tmux plugin manager"

$(HOME)/Library/Application\ Support/Code/User/settings.json:
	@ln -s $(shell pwd)/vscode/settings.json $(HOME)/Library/Application\ Support/Code/User/settings.json
	@echo "Created symbolic link for vscode settings.json"

tmux: $(HOME)/.tmux.conf $(HOME)/.tmux/plugins/tmp

i3: $(HOME)/.i3/config $(HOME)/.i3status.conf

$(HOME)/.i3/config: $(HOME)/.i3
	@ln -s $(shell pwd)/i3/config $(HOME)/.i3/config
	@echo "Created symbolic link for .i3/config"

$(HOME)/.i3status.conf:
	@ln -s $(shell pwd)/i3/status $(HOME)/.i3status.conf
	@echo "Created symbolic link for .i3/status"

$(HOME)/.i3:
	mkdir -p $(HOME)/.i3

iterm: \
	iterm-scripts \
	iterm-colors/tokyonight_moon.itermcolors \
	iterm-colors/tokyonight_day.itermcolors \
	iterm-colors/tokyonight_storm.itermcolors \
	iterm-colors/tokyonight_night.itermcolors \
	iterm-colors/catppuccin_frappe.itermcolors \
	iterm-colors/catppuccin_latte.itermcolors \
	iterm-colors/catppuccin_macchiato.itermcolors \
	iterm-colors/catppuccin_mocha.itermcolors

$(HOME)/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/iterm-light-switch.py:
	mkdir -p $(HOME)/Library/Application\ Support/iTerm2/Scripts/AutoLaunch
	@ln -s $(shell pwd)/iterm-light-switch.py $(HOME)/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/iterm-light-switch.py

iterm-scripts: $(HOME)/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/iterm-light-switch.py

iterm-colors:
	@mkdir iterm-colors

iterm-colors/catppuccin_%.itermcolors: iterm-colors
	@wget -nv https://raw.githubusercontent.com/catppuccin/iterm/main/colors/catppuccin-$*.itermcolors \
		-O iterm-colors/catppuccin_$*.itermcolors
	@touch iterm-colors/catppuccin_$*.itermcolors
	@open iterm-colors/catppuccin_$*.itermcolors
	@echo "Downloaded iterm-colors/catppuccin-$*.itermcolors"

iterm-colors/tokyonight_%.itermcolors: iterm-colors
	@wget -nv https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/iterm/tokyonight_$*.itermcolors \
		-O iterm-colors/tokyonight_$*.itermcolors
	@touch iterm-colors/tokyonight_$*.itermcolors
	@open iterm-colors/tokyonight_$*.itermcolors
	@echo "Downloaded iterm-colors/tokyonight_$*.itermcolors"

secret-aliases:
	touch secret-aliases

vimfiles:
	@git clone git@github.com:relekang/vimfiles.git
	@echo "Cloned dotfiles. Installing..."

vim: vimfiles
	@cd vimfiles && $(MAKE)

atom-packages:
	bash apms

vscode: $(HOME)/Library/Application\ Support/Code/User/settings.json
	brew install --cask visual-studio-code
	./vscode/install-extensions

/opt/homebrew/bin/brew:
	bash macos/homebrew.sh

homebrew: /opt/homebrew/bin/brew

$(HOME)/.python: /opt/homebrew/bin/brew
	bash python/init
	@touch $(HOME)/.python

os: iterm-scripts
	bash macos/index.sh
	bash linux

clean:
	@rm -f $(HOME)/.gitconfig $(HOME)/.zshrc $(HOME)/.zsh-custom
	@rm -f $(HOME)/.vimrc $(HOME)/.vim
	@rm -f $(HOME)/.python
	@rm -f $(HOME)/Library/Application\ Support/Code/User/settings.json
	@echo "Removed all dotfiles"

docker-image: Dockerfile-dev-env
	docker build -t dev-env -f Dockerfile-dev-env .

.PHONY: vim vim_plugins clean os i3 python homebrew vscode docker-image iterm-scripts
