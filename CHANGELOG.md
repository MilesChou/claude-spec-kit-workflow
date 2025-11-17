# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.0.85] - 2025-11-17

### Added

- **新增 Command Handoffs 功能**：為多個 commands 新增工作流程銜接機制
  - `speckit.clarify`：新增移交到 `speckit.plan` 建立技術計畫的選項
  - `speckit.constitution`：新增移交到 `speckit.specify` 實作功能規格的選項
  - `speckit.plan`：新增移交到 `speckit.tasks`（建立任務）和 `speckit.checklist`（建立檢查清單）的選項
  - `speckit.specify`：新增移交到 `speckit.plan`（建立技術計畫）和 `speckit.clarify`（釐清需求）的選項
  - `speckit.tasks`：新增移交到 `speckit.analyze`（一致性分析）和 `speckit.implement`（開始實作）的選項
- **新增 `speckit.taskstoissues` Command**：將任務清單自動轉換為 GitHub Issues
  - 支援將 `tasks.md` 中的任務自動建立為 GitHub Issues
  - 包含安全檢查機制，確保只在正確的 repository 創建 issues
  - 支援依賴關係排序，方便團隊協作和任務追蹤
  - 需要 GitHub MCP server 的 `issue_write` 工具支援

### Changed

- **優化 Command 描述**：改進 `speckit.constitution` 的描述文字，提升可讀性
- **改進 ESLint 配置檢測邏輯**：`speckit.implement` 中針對 `eslint.config.*` 格式的配置檔案，改為檢查 config 中的 `ignores` 項目而非 `.eslintignore` 檔案

### Notes

此版本引入了 handoffs 機制，讓各個 agent 之間能夠順暢銜接，使用者可以更流暢地在不同的開發階段之間切換。

## [0.0.79] - 2025-10-24

### Added

- 初始化 Claude Code Plugin 專案結構
- 建立基礎文件架構（README.md、CHANGELOG.md、CLAUDE.md）
- 定義專案開發規範與指導方針
