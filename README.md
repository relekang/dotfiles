# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/).

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

## Optional tagged provisioning

Run extra setup explicitly after the base apply:

```sh
chezmoi apply --include=tag:packages
chezmoi apply --include=tag:macos
chezmoi apply --include=tag:linux
chezmoi apply --include=tag:editors
chezmoi apply --include=tag:terminals
chezmoi apply --include=tag:dev
```

