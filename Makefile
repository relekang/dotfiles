CHEZMOI ?= chezmoi

.PHONY: install apply diff doctor tags clean

install apply:
	$(CHEZMOI) apply

diff:
	$(CHEZMOI) diff

doctor:
	$(CHEZMOI) doctor

tags:
	@echo "Available tags: packages macos linux editors terminals dev"
	@echo "Example: $(CHEZMOI) apply --include=tag:packages --include=tag:macos"

clean:
	@echo "No legacy symlink cleanup remains. Use chezmoi state commands if needed."
