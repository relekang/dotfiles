# dotfiles

Dotfiles managed with [chezmoi](https://www.chezmoi.io/).

The chezmoi source files are in `home/`. The `.chezmoiroot` file selects this
source root. Bootstrap and repository tools stay at the repository root.

## What is managed

### Default apply

- shell config
- git and jj config
- tmux config and templates
- helper scripts in `~/.local/bin`
- starship config
- pi config
- AI agent prompts and skills for Claude, Codex, and pi
- `authorized_keys`
- core shell tooling bootstrap

### Tagged apply

- `packages`: broader package-manager installs; Mosh on Arch and Debian-based Linux;
  Podman, podman-compose, spotifyd, playerctl, and bind on Arch. On Linux, adds the
  HTTP and HTTPS TCP rules (ports 80 and 443) and development server TCP rules
  (ports 8000–8999) if UFW is installed, and the Mosh UDP rule (ports 60000–61000)
  only if UFW is active. Does not enable UFW.
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

## Browser routing

On Linux, `browser-router` reads private rules from
`~/.config/browser-router/rules.json` (or `$XDG_CONFIG_HOME/browser-router/rules.json`).
Keep this file outside chezmoi. It is not backed up by this repository.

Example:

```json
{
  "rules": [
    {"domains": ["video.example.com"], "profile": "youtube"},
    {"regex": "project-example", "profile": "work"}
  ]
}
```

Profiles are `personal`, `work`, and `youtube`. Domain rules include subdomains.
Regex rules search the full URL and ignore letter case. The first matching rule
wins. If a rule has both domains and a regex, either can match. With no match,
a missing rules file, or invalid rules, the router opens Junction.

Requires Firefox, Python 3, `gio`, and Junction. The Firefox profile desktop
entries must point to profiles on the current machine. To enable routing:

```sh
update-desktop-database ~/.local/share/applications
xdg-settings set default-web-browser browser-router.desktop
xdg-mime default browser-router.desktop x-scheme-handler/http x-scheme-handler/https
```

To use only the chooser again, replace `browser-router.desktop` with
`re.sonny.Junction.desktop` in those commands.

## Docker test image

Build the validation image with:

```sh
make docker-image
```

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
