CHEZMOI ?= chezmoi
CHEZMOI_SOURCE = $(CHEZMOI) --source=$(CURDIR)
CHEZMOI_TAG = $(CHEZMOI_SOURCE) --override-data '{"chezmoi":{"tags":["$(TAG)"]}}'
DOCKER ?= docker
DOCKER_IMAGE ?= dotfiles-test

.PHONY: install apply diff doctor tags apply-tag apply-packages apply-macos apply-linux apply-editors apply-terminals apply-dev docker-image clean

install apply:
	$(CHEZMOI_SOURCE) apply

diff:
	$(CHEZMOI_SOURCE) diff

doctor:
	$(CHEZMOI_SOURCE) doctor

apply-tag:
	@test -n "$(TAG)"
	$(CHEZMOI_TAG) apply

apply-packages:
	$(MAKE) apply-tag TAG=packages

apply-macos:
	$(MAKE) apply-tag TAG=macos

apply-linux:
	$(MAKE) apply-tag TAG=linux

apply-editors:
	$(MAKE) apply-tag TAG=editors

apply-terminals:
	$(MAKE) apply-tag TAG=terminals

apply-dev:
	$(MAKE) apply-tag TAG=dev

tags:
	@echo "Available tags: packages macos linux editors terminals dev"
	@echo "Example: make apply-packages"
	@echo "Example: $(CHEZMOI_SOURCE) --override-data '{\"chezmoi\":{\"tags\":[\"packages\"]}}' apply"

docker-image:
	$(DOCKER) build -t $(DOCKER_IMAGE) -f Dockerfile.test .

clean:
	@echo "No legacy symlink cleanup remains. Use chezmoi state commands if needed."
