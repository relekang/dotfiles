# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## What is managed

### Default apply

- shell config
- git and jj config
- tmux config and templates
- helper scripts in `~/.local/bin`
- starship config
- pi config
- `authorized_keys`
- core shell tooling bootstrap

### Tagged apply

- `packages`: broader package-manager installs
- `macos`: macOS preferences and App Store setup
- `linux`: Linux desktop/i3-related setup
- `editors`: external `vimfiles` bootstrap
- `terminals`: terminal app installs
- `dev`: broader development tooling like Poetry and Bun

## Bootstrap

### Direct chezmoi bootstrap

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/relekang/dotfiles.git
```

### Interactive bootstrap wrapper

```sh
curl -fsSL https://raw.githubusercontent.com/relekang/dotfiles/main/initial.sh | bash
```

The wrapper helps with SSH key setup, then switches to the SSH repo URL for `chezmoi init --apply`.

## Private aliases

The base apply manages a private aliases file at `~/.config/zsh/private-aliases.zsh`.

## Optional tagged provisioning

Run extra setup explicitly after the base apply:

```sh
chezmoi apply --override-data '{"chezmoi":{"tags":["packages"]}}'
chezmoi apply --override-data '{"chezmoi":{"tags":["macos"]}}'
chezmoi apply --override-data '{"chezmoi":{"tags":["linux"]}}'
chezmoi apply --override-data '{"chezmoi":{"tags":["editors"]}}'
chezmoi apply --override-data '{"chezmoi":{"tags":["terminals"]}}'
chezmoi apply --override-data '{"chezmoi":{"tags":["dev"]}}'
```

Linux/i3 config files are materialized when running with the `linux` tag.

`.pi` remains at `~/.pi`.
