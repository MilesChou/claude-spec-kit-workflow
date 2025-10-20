# spec-kit Makefile

VERSION ?= 0.0.72
TEMPLATE_NAME := spec-kit-template-claude-sh
REPO_URL := https://github.com/github/spec-kit.git
DOWNLOAD_URL := https://github.com/github/spec-kit/releases/download/v$(VERSION)/$(TEMPLATE_NAME)-v$(VERSION).zip

.PHONY: help
help: ## 顯示使用說明
	@echo "spec-kit 下載工具"
	@echo ""
	@echo "使用方式："
	@echo "  make download              下載預設版本 (v$(VERSION))"
	@echo "  make download VERSION=x.x.x   下載指定版本"
	@echo "  make download-latest       下載最新版本"
	@echo "  make recreate              重新建立 spec-kit 目錄結構 (預設 v$(VERSION))"
	@echo "  make recreate VERSION=x.x.x   從指定版本重新建立"
	@echo "  make source                Clone spec-kit 原始碼到 .tmp/source"
	@echo "  make package               打包 spec-kit-flow 到 .tmp/build"
	@echo "  make diff                  比較指定版本與 spec-kit 的差異 (預設 v$(VERSION))"
	@echo "  make diff VERSION=x.x.x    比較指定版本與 spec-kit 的差異"
	@echo "  make clean                 清理 .tmp 目錄"

.PHONY: download
download: ## 下載並解壓縮指定版本
	@echo "下載 spec-kit v$(VERSION)..."
	@mkdir -p .tmp/releases/$(VERSION)
	@curl -L -o .tmp/releases/$(VERSION)/spec-kit.zip $(DOWNLOAD_URL)
	@echo "解壓縮中..."
	@cd .tmp/releases/$(VERSION) && unzip -q -o spec-kit.zip
	@rm .tmp/releases/$(VERSION)/spec-kit.zip
	@echo "完成！檔案位於 .tmp/releases/$(VERSION)/ 目錄"

.PHONY: download-latest
download-latest: ## 下載並解壓縮最新版本
	@echo "下載最新版本的 spec-kit..."
	@mkdir -p .tmp/releases/latest
	@curl -L -o .tmp/releases/latest/spec-kit.zip https://github.com/github/spec-kit/releases/latest/download/$(TEMPLATE_NAME).zip
	@echo "解壓縮中..."
	@cd .tmp/releases/latest && unzip -q -o spec-kit.zip
	@rm .tmp/releases/latest/spec-kit.zip
	@echo "完成！檔案位於 .tmp/releases/latest/ 目錄"

.PHONY: recreate
recreate: ## 重新建立 spec-kit 目錄結構
	@if [ ! -d ".tmp/releases/$(VERSION)" ]; then \
		echo "錯誤：版本 $(VERSION) 尚未下載"; \
		echo "請先執行: make download VERSION=$(VERSION)"; \
		exit 1; \
	fi
	@echo "重新建立 spec-kit 目錄結構 (v$(VERSION))..."
	@mkdir -p spec-kit
	@echo "複製 commands..."
	@cp .tmp/releases/$(VERSION)/.claude/commands/speckit.*.md spec-kit/
	@echo "複製 templates..."
	@cp -r .tmp/releases/$(VERSION)/.specify/templates spec-kit/
	@echo "複製 memory..."
	@cp -r .tmp/releases/$(VERSION)/.specify/memory spec-kit/
	@echo "完成！spec-kit 目錄已重新建立"

.PHONY: source
source: ## Clone spec-kit 原始碼
	@if [ -d .tmp/source ]; then \
		echo "更新 spec-kit 原始碼..."; \
		cd .tmp/source && git pull; \
	else \
		echo "Clone spec-kit 原始碼..."; \
		mkdir -p .tmp; \
		git clone $(REPO_URL) .tmp/source; \
	fi
	@echo "完成！原始碼位於 .tmp/source/ 目錄"

.PHONY: package
package: ## 打包 spec-kit 到 .tmp/build
	@echo "打包 spec-kit..."
	@mkdir -p .tmp/build
	@cd spec-kit && zip -r ../.tmp/build/spec-kit.zip . -x "*.DS_Store"
	@echo "完成！檔案位於 .tmp/build/spec-kit.zip"

.PHONY: diff
diff: ## 比較指定版本與 spec-kit 的差異
	@if [ ! -d ".tmp/releases/$(VERSION)" ]; then \
		echo "錯誤：版本 $(VERSION) 尚未下載"; \
		echo "請先執行: make download VERSION=$(VERSION)"; \
		exit 1; \
	fi
	@echo "比較 v$(VERSION) 與 spec-kit 的差異"
	@echo ""
	@for filename in speckit.analyze.md speckit.checklist.md speckit.clarify.md speckit.constitution.md speckit.implement.md speckit.plan.md speckit.specify.md speckit.tasks.md; do \
		source_file=".tmp/releases/$(VERSION)/.claude/commands/$$filename"; \
		target_file="spec-kit/$$filename"; \
		echo "========================================"; \
		echo "檔案: $$filename"; \
		echo "========================================"; \
		diff -u "$$source_file" "$$target_file" || true; \
		echo ""; \
	done

.PHONY: clean
clean: ## 清理 .tmp 目錄
	@echo "清理 .tmp 目錄..."
	@rm -rf .tmp
	@echo "清理完成"

