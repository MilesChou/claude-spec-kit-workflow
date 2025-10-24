# Check Prerequisites

## 目的

檢查 Spec-Driven Development 工作流程所需的先決條件，驗證必要的目錄和檔案是否存在。

## 執行時機

- 在執行任務實作 (implement) 之前
- 需要驗證專案結構是否完整時
- 需要取得可用文件清單時

## 檢查項目

### 必要檢查

1. **Feature 目錄**: 驗證 `specs/{feature-name}/` 目錄是否存在
2. **plan.md**: 確認實作計畫檔案存在於 feature 目錄中
3. **Branch 驗證** (僅限 Git 專案):
   - 確認當前在 feature branch 上
   - Branch 命名格式應為: `001-feature-name`

### 選用檢查

根據需求檢查以下檔案是否存在：

- `tasks.md`: 任務清單 (實作階段需要)
- `research.md`: 研究文件
- `data-model.md`: 資料模型
- `contracts/`: 合約目錄
- `quickstart.md`: 快速入門指南

## 輸出資訊

提供以下資訊給使用者：

1. **FEATURE_DIR**: Feature 目錄的完整路徑
2. **AVAILABLE_DOCS**: 可用文件清單
3. **驗證狀態**: 每個檔案的存在狀態 (✓/✗)

## 錯誤處理

如果發現以下問題，應該提供明確的錯誤訊息和解決建議：

- Feature 目錄不存在 → 建議先執行 `/speckit.specify`
- plan.md 不存在 → 建議先執行 `/speckit.plan`
- tasks.md 不存在 (需要時) → 建議先執行 `/speckit.tasks`
- 不在 feature branch 上 → 提示正確的 branch 命名格式

## 非 Git 專案支援

對於非 Git 專案：
- 使用 `SPECIFY_FEATURE` 環境變數來識別當前 feature
- 或從 `specs/` 目錄中找到最新的 feature (依編號)
- 跳過 branch 驗證但提供警告訊息

## 範例

### 成功情況

```
FEATURE_DIR: /path/to/repo/specs/001-user-authentication
AVAILABLE_DOCS:
  ✓ research.md
  ✗ data-model.md
  ✓ contracts/
  ✗ quickstart.md
```

### 錯誤情況

```
ERROR: Feature directory not found: /path/to/repo/specs/001-user-authentication
Run /speckit.specify first to create the feature structure.
```

## 實作建議

### 使用 GitHub MCP

Git 相關操作：
- `get_repository_info`: 取得 repository root
- `get_current_branch`: 取得當前 branch 名稱並驗證格式

### 使用檔案工具

檔案系統操作：
1. 使用 `Read` 工具檢查檔案是否存在
2. 使用 `Glob` 工具列出目錄內容
3. 直接讀取檔案內容進行驗證
