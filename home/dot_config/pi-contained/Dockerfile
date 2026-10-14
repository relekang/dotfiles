FROM node:24-bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

ARG TARGETARCH
ARG JJ_VERSION=0.37.0

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    fd-find \
    gh \
    git \
    jq \
    ripgrep \
  && case "$TARGETARCH" in \
    amd64) jj_arch=x86_64 ;; \
    arm64) jj_arch=aarch64 ;; \
    *) echo "Unsupported architecture: $TARGETARCH" >&2; exit 1 ;; \
  esac \
  && curl -fsSL "https://github.com/jj-vcs/jj/releases/download/v${JJ_VERSION}/jj-v${JJ_VERSION}-${jj_arch}-unknown-linux-musl.tar.gz" \
    | tar -xz -C /usr/local/bin ./jj \
  && npm install -g --ignore-scripts @earendil-works/pi-coding-agent \
  && npm cache clean --force \
  && ln -s /usr/bin/fdfind /usr/local/bin/fd \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /home/pi /workspace \
  && chmod 1777 /home/pi /workspace

ENV HOME=/home/pi
WORKDIR /workspace

CMD ["pi"]
