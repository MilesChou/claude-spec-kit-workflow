# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0] - 2025-01-20

### Added

- 初始化專案結構
- 新增 `speckit` skill
  - 提供完整的 speckit 工作流程自動化
  - 支援從功能描述到任務清單的端到端流程
  - 整合 specify、clarify、plan、tasks 四個階段
  - 支援彈性的執行深度選擇（spec/plan/tasks/full）
  - 提供智慧化的需求澄清機制
  - 自動產生規格文件、實作計劃和任務清單
- 包含完整的 speckit commands
  - `/speckit.specify`：產生規格文件
  - `/speckit.clarify`：澄清需求
  - `/speckit.plan`：產生實作計劃
  - `/speckit.tasks`：產生任務清單
  - `/speckit.checklist`：產生檢查清單
  - `/speckit.implement`：執行實作
  - `/speckit.analyze`：分析專案
  - `/speckit.constitution`：管理專案憲章
- 提供完整的 templates
  - spec-template.md：規格文件模板
  - plan-template.md：計劃文件模板
  - tasks-template.md：任務清單模板
  - checklist-template.md：檢查清單模板
  - agent-file-template.md：Agent 設定模板
- 提供自動化 scripts
  - create-new-feature.sh：建立新功能 branch
  - setup-plan.sh：設定計劃環境
  - check-prerequisites.sh：檢查前置條件
  - update-agent-context.sh：更新 agent context

[Unreleased]: https://github.com/MilesChou/claude-spec-kit-plugin/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/MilesChou/claude-spec-kit-plugin/releases/tag/v0.1.0
