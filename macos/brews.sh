eval "$(/opt/homebrew/bin/brew shellenv)"

INSTALLED="$(brew list)"

if [[ "$@" == *"--upgrade"* ]]; then
  UPGRADE="yes"
fi

function install() {
  args=""
  if [[ "$1" == "--cask" ]]; then
    shift
    args="--cask"
  fi

  if [[ "$UPGRADE" == "yes" ]]; then
    brew install $args $@
  fi

  to_install=""
  for name in $@; do
    if ! echo $INSTALLED | grep $name >/dev/null; then
      echo $name
      to_install="$to_install $name"
    fi
  done
  if [[ ! -z "$to_install" ]]; then
    echo "Installing: $to_install"
    brew install $args $to_install
  fi
}

install \
  grc \
  coreutils \
  htop \
  wget \
  hub \
  postgresql \
  node \
  mosh \
  redis \
  hub \
  redis \
  nginx \
  ansible \
  mas \
  vim \
  zsh-syntax-highlighting \
  yarn \
  httpie \
  ripgrep \
  fnm \
  git-flow \
  git-lfs \
  go \
  openjdk \
  jq \
  gh \
  terraform \
  sshuttle \
  grip \
  sops \
  watch \
  glow \
  tmux \
  gnu-sed \
  zoxide \
  starship \
  yippy \
  mise \
  poppler \
  uv

install --cask \
  spotify \
  dropbox \
  iterm2 \
  alfred \
  postico \
  firefox \
  visual-studio-code \
  jetbrains-toolbox \
  docker \
  google-cloud-sdk \
  postgres-unofficial \
  nightfall \
  keycastr
