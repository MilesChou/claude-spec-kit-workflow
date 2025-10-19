# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 專案概述

這是一個 Claude Code Plugin/Skill 專案，名稱為 `spec-kit-skill`，目的是提供 specification 相關的工具和功能給 Claude Code 使用。

## 開發環境設定

目前專案處於初始階段，尚未建立完整的開發環境。預期會使用以下技術棧：

- Node.js/TypeScript (Claude Code Plugin 標準開發環境)
- 需要建立 `package.json` 來管理依賴套件
- 需要建立 `.claude/` 目錄來定義 plugin 的 commands、skills 和 agents

## Claude Code Plugin 開發規範

### 目錄結構

標準的 Claude Code Plugin 應包含：

```
.claude/
├── commands/     # Slash commands (例如 /test-spec)
├── skills/       # Skills (可在對話中被調用的專業能力)
└── agents/       # Specialized agents (專門處理特定任務的 agent)
```

### 檔案命名規範

- Commands: `.claude/commands/<command-name>.md`
- Skills: `.claude/skills/<skill-name>.md`
- Agents: `.claude/agents/<agent-name>.md`

### Plugin 開發重點

1. **Markdown 格式**: 所有的 commands、skills 和 agents 都使用 Markdown 格式撰寫
2. **清楚的描述**: 每個功能都需要有清楚的 description 和使用說明
3. **測試驗證**: 建議在開發過程中持續測試功能是否正常運作
4. **文件同步**: README.md 應該要同步更新功能說明

## 記憶與思考模式

IMPORTANT: 在開發此專案時，請使用英文進行思考和推理 (用 <commentary> 標籤)，但所有回應、文件和註解都使用繁體中文撰寫。這樣可以確保：
- 利用英文進行更精確的邏輯推理
- 對外輸出保持一致的繁體中文介面

範例：
```
<commentary>
Let me analyze the structure of this spec...
The user wants to create a command that validates specifications.
I should create a markdown file in .claude/commands/
</commentary>

我會建立一個新的 command 來驗證 specification...
```

## 開發流程建議

1. 先定義 plugin 的核心功能和使用場景
2. 規劃需要哪些 commands/skills/agents
3. 逐步實作每個功能
4. 在 Claude Code 中測試驗證
5. 更新 README.md 文件

## 注意事項

- 所有程式碼檔案結尾要留一個空行 (符合 vim 存檔習慣)
- 中文字和英文字之間要留空格
- 避免使用「生成」，改用「產生」
- 避免使用「用戶」，改用「使用者」
