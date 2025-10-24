# speckit Makefile

VERSION ?= 0.0.79
TEMPLATE_NAME := spec-kit-template-claude-sh
REPO_URL := https://github.com/github/spec-kit.git
DOWNLOAD_URL := https://github.com/github/spec-kit/releases/download/v$(VERSION)/$(TEMPLATE_NAME)-v$(VERSION).zip

.PHONY: help
help: ## Show help message
	@echo "speckit Download Tool"
	@echo ""
	@echo "Usage:"
	@echo "  make download              Download default version (v$(VERSION))"
	@echo "  make download VERSION=x.x.x   Download specific version"
	@echo "  make download-latest       Download latest version"
	@echo "  make recreate              Recreate speckit directory structure (default v$(VERSION))"
	@echo "  make recreate VERSION=x.x.x   Recreate from specific version"
	@echo "  make source                Clone spec-kit source code to .tmp/source"
	@echo "  make package               Package speckit to .tmp/build"
	@echo "  make diff                  Compare specific version with speckit (default v$(VERSION))"
	@echo "  make diff VERSION=x.x.x    Compare specific version with speckit"
	@echo "  make clean                 Clean .tmp directory"

.PHONY: download
download: ## Download and extract specific version
	@echo "Downloading spec-kit v$(VERSION) ..."
	@rm -rf .tmp/releases/$(VERSION)
	@mkdir -p .tmp/releases/$(VERSION)
	@curl -sS -L -o .tmp/releases/$(VERSION)/spec-kit.zip $(DOWNLOAD_URL)
	@cd .tmp/releases/$(VERSION) && unzip -q -o spec-kit.zip
	@rm .tmp/releases/$(VERSION)/spec-kit.zip
	@echo "Done, files in .tmp/releases/$(VERSION)/"

.PHONY: download-latest
download-latest: ## Download and extract latest version
	@echo "Downloading latest version of spec-kit..."
	@mkdir -p .tmp/releases/latest
	@curl -L -o .tmp/releases/latest/spec-kit.zip https://github.com/github/spec-kit/releases/latest/download/$(TEMPLATE_NAME).zip
	@echo "Extracting..."
	@cd .tmp/releases/latest && unzip -q -o spec-kit.zip
	@rm .tmp/releases/latest/spec-kit.zip
	@echo "Done! Files in .tmp/releases/latest/ directory"

.PHONY: recreate
recreate: ## Recreate speckit directory structure
	@if [ ! -d ".tmp/releases/$(VERSION)" ]; then \
		echo "Error: Version $(VERSION) not downloaded yet"; \
		echo "Please run: make download VERSION=$(VERSION)"; \
		exit 1; \
	fi
	@echo "Recreating speckit directory structure (v$(VERSION))..."
	@mkdir -p skills/speckit
	@echo "Copying commands..."
	@cp .tmp/releases/$(VERSION)/.claude/commands/speckit.*.md skills/speckit/
	@echo "Copying templates..."
	@cp -r .tmp/releases/$(VERSION)/.specify/templates skills/speckit/
	@echo "Copying memory..."
	@cp -r .tmp/releases/$(VERSION)/.specify/memory skills/speckit/
	@echo "Done! speckit directory recreated"

.PHONY: source
source: ## Clone spec-kit source code
	@if [ -d .tmp/source ]; then \
		echo "Updating spec-kit source code..."; \
		cd .tmp/source && git pull; \
	else \
		echo "Cloning spec-kit source code..."; \
		mkdir -p .tmp; \
		git clone $(REPO_URL) .tmp/source; \
	fi
	@echo "Done! Source code in .tmp/source/ directory"

.PHONY: package
package: ## Package speckit to .tmp/build
	@echo "Packaging speckit..."
	@mkdir -p .tmp/build
	@cd skills/speckit && zip -r ../../.tmp/build/speckit.zip . -x "*.DS_Store"
	@echo "Done! File in .tmp/build/speckit.zip"

.PHONY: diff
diff: ## Compare specific version with speckit
	@if [ ! -d ".tmp/releases/$(VERSION)" ]; then \
		echo "Error: Version $(VERSION) not downloaded yet"; \
		echo "Please run: make download VERSION=$(VERSION)"; \
		exit 1; \
	fi
	@echo "Comparing v$(VERSION) with speckit"
	@echo ""
	@for filename in speckit.analyze.md speckit.checklist.md speckit.clarify.md speckit.constitution.md speckit.implement.md speckit.plan.md speckit.specify.md speckit.tasks.md; do \
		source_file=".tmp/releases/$(VERSION)/.claude/commands/$$filename"; \
		target_file="skills/speckit/$$filename"; \
		echo "========================================"; \
		echo "File: $$filename"; \
		echo "========================================"; \
		diff -u "$$source_file" "$$target_file" || true; \
		echo ""; \
	done

.PHONY: clean
clean: ## Clean .tmp directory
	@echo "Cleaning .tmp directory..."
	@rm -rf .tmp
	@echo "Clean complete"

