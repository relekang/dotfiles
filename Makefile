CHEZMOI ?= chezmoi
CHEZMOI_SOURCE = $(CHEZMOI) --source=$(CURDIR)

.PHONY: install apply diff doctor tags clean

install apply:
	$(CHEZMOI_SOURCE) apply

diff:
	$(CHEZMOI_SOURCE) diff

doctor:
	$(CHEZMOI_SOURCE) doctor

tags:
	@echo "Available tags: packages macos linux editors terminals dev"
	@echo "Example: $(CHEZMOI) apply --include=tag:packages --include=tag:macos"

clean:
	@echo "No legacy symlink cleanup remains. Use chezmoi state commands if needed."
