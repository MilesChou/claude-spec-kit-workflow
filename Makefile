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
	@echo "  make source                Clone spec-kit 原始碼到 .tmp/source"
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

.PHONY: clean
clean: ## 清理 .tmp 目錄
	@echo "清理 .tmp 目錄..."
	@rm -rf .tmp
	@echo "清理完成"
