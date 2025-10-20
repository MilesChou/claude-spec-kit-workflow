---
name: spec-kit
description: 依照 spec-kit 的標準工作流程，從功能描述自動產生完整的規格文件、澄清需求、產生實作計劃與任務清單
---

# Spec Kit

這個 skill 提供一個自動化的工作流程，協助你從功能描述開始，逐步產生完整的 specification、計劃和任務清單。

## 核心功能

- 自動執行 spec-kit 的完整工作流程
- 智慧處理各階段的互動（如需求澄清）
- 在關鍵節點提供進度報告
- 支援彈性的執行深度選擇

## 輸入參數

當使用者調用此 skill 時，應提供以下資訊：

### 必要參數

- **功能描述**：自然語言描述的功能需求

### 可選參數

- **流程深度** (預設：`plan`):
  - `spec`：僅產生規格文件
  - `plan`：產生規格 + 實作計劃
  - `tasks`：產生規格 + 計劃 + 任務清單
  - `full`：完整流程（包含澄清階段）

- **啟用澄清** (預設：`true`):
  - `true`：執行 clarify 步驟
  - `false`：跳過 clarify 步驟

## 執行步驟

### 步驟 1：初始化與驗證

1. 驗證功能描述是否完整
   - 如果功能描述為空，要求使用者提供
   - 檢查描述是否足夠清楚以產生規格

2. 確認執行參數
   - 流程深度 (spec/plan/tasks/full)
   - 是否啟用澄清階段

3. 檢查專案環境
   - 檢查必要的 templates 是否存在

### 步驟 2：產生規格 (Specify)

1. 執行功能等同於 `speckit.specify` command
   - 產生 feature branch 的 short name
   - 載入 `./templates/spec-template.md`
   - 根據功能描述產生初始規格

2. 處理規格品質驗證
   - 自動建立 `checklists/requirements.md`
   - 驗證規格完整性
   - 處理 [NEEDS CLARIFICATION] 標記

3. 報告產生結果
   - Feature branch 名稱
   - 規格檔案路徑
   - 品質檢查結果

### 步驟 3：澄清需求 (Clarify)（可選）

**僅在以下情況執行：**
- 流程深度為 `full`，或
- 使用者明確啟用澄清

**執行內容：**

1. 載入當前規格檔案
   - 讀取 FEATURE_SPEC 路徑

2. 分析規格的模糊性
   - 掃描各個類別的完整度
   - 產生優先級排序的澄清問題（最多 5 個）

3. 互動式澄清
   - 逐一提出問題
   - 對於選擇題，提供推薦選項
   - 收集使用者回答

4. 整合澄清結果
   - 在規格中建立 `## Clarifications` 區段
   - 將澄清結果更新到相關區段
   - 儲存更新後的規格

5. 報告澄清成果
   - 提出的問題數量
   - 更新的區段清單
   - 覆蓋率摘要表

### 步驟 4：產生計劃 (Plan)

**僅在以下情況執行：**
- 流程深度為 `plan`、`tasks` 或 `full`

**執行內容：**

1. 設定計劃環境
   - 解析 FEATURE_SPEC、IMPL_PLAN 路徑

2. 載入上下文
   - 讀取 FEATURE_SPEC
   - 讀取 `./memory/constitution.md`

3. Phase 0: 研究與探索
   - 識別技術選型的未知項
   - 產生 `research.md` 記錄決策

4. Phase 1: 設計與合約
   - 從規格中提取實體 → 產生 `data-model.md`
   - 從功能需求產生 API 合約 → 產生 `/contracts/`
   - 產生 `quickstart.md`
   - 更新 agent context

5. 報告計劃成果
   - Branch 名稱
   - IMPL_PLAN 路徑
   - 產生的 artifacts 清單

### 步驟 5：產生任務 (Tasks)

**僅在以下情況執行：**
- 流程深度為 `tasks` 或 `full`

**執行內容：**

1. 設定任務環境
   - 取得 FEATURE_DIR 和 AVAILABLE_DOCS

2. 載入設計文件
   - **必要**：plan.md (技術棧、架構)
   - **必要**：spec.md (使用者故事、優先級)
   - **可選**：data-model.md、contracts/、research.md

3. 產生任務清單
   - 使用 `./templates/tasks-template.md` 作為結構
   - 依使用者故事組織任務
   - 建立依賴關係圖
   - 識別可平行執行的任務

4. 任務組織
   - Phase 1: Setup (專案初始化)
   - Phase 2: Foundational (基礎建設)
   - Phase 3+: User Stories (依優先級)
   - Final Phase: Polish (收尾工作)

5. 報告任務成果
   - tasks.md 路徑
   - 總任務數量
   - 每個使用者故事的任務數
   - 平行執行機會

### 步驟 6：總結報告

產生完整的執行摘要：

1. 列出所有產生的文件
   - 規格文件路徑
   - 計劃文件路徑（如適用）
   - 任務文件路徑（如適用）
   - 其他 artifacts

2. 提供下一步建議
   - 如果只產生 spec：建議執行 `speckit.clarify` 或 `speckit.plan`
   - 如果產生到 plan：建議執行 `speckit.tasks`
   - 如果產生到 tasks：建議執行 `speckit.implement` 或檢視 checklist

3. 顯示執行統計
   - 總執行時間
   - 產生的檔案數量
   - 澄清問題數量（如適用）

## 輸出結果

根據選擇的流程深度，會產生以下檔案：

### 基本輸出 (所有深度)

- `spec.md`：功能規格文件
- `checklists/requirements.md`：規格品質檢查清單

### Plan 深度額外輸出

- `plan.md`：實作計劃
- `research.md`：技術研究與決策
- `data-model.md`：資料模型
- `contracts/`：API 合約檔案
- `quickstart.md`：快速開始指南

### Tasks 深度額外輸出

- `tasks.md`：可執行的任務清單

### Full 流程額外處理

- 在 `spec.md` 中新增 `## Clarifications` 區段
- 完整的需求澄清記錄

## 使用範例

### 範例 1：快速產生規格

```
請使用 spec-kit，只產生規格文件。

功能描述：建立一個使用者認證系統，支援 email/password 登入和社群媒體登入。
```

**預期輸出：**
- spec.md
- checklists/requirements.md

### 範例 2：產生規格和計劃

```
請使用 spec-kit，產生規格和實作計劃。

功能描述：開發一個部落格系統，支援文章發布、分類、標籤和評論功能。
```

**預期輸出：**
- spec.md + plan.md + research.md + data-model.md + contracts/

### 範例 3：完整工作流程

```
請使用 spec-kit 完整流程。

功能描述：建立一個電商平台的購物車功能，包括商品管理、庫存檢查、優惠券和結帳流程。
```

**預期輸出：**
- spec.md (含 Clarifications 區段)
- plan.md + research.md + data-model.md + contracts/
- tasks.md

## 注意事項

### 執行環境需求

- 需要有 spec-kit 的 templates
- 建議在乾淨的 working directory 執行

### 互動式處理

- Clarify 階段可能需要使用者回答問題
- 每個問題都會提供推薦答案
- 使用者可以接受推薦或自行提供答案

### 檔案管理

- 所有檔案會建立在 feature branch 的專屬目錄中
- 路徑格式：`.specs/features/<branch-name>/`
- 不會覆蓋現有檔案（除非明確要求）

### 錯誤處理

- 如果規格驗證失敗，會嘗試自動修正（最多 3 次）
- 如果仍有問題，會記錄在 checklist notes 並警告使用者
- 任何階段失敗都會中止流程並報告錯誤

### 最佳實踐

1. **功能描述越詳細越好**
   - 清楚說明使用者需求
   - 提供具體的使用場景
   - 說明預期的成果

2. **選擇適當的流程深度**
   - 探索性專案：先用 `spec` 確認需求
   - 明確需求：直接使用 `tasks` 或 `full`
   - 複雜專案：建議使用 `full` 含澄清

3. **善用澄清階段**
   - 對於模糊的需求，不要跳過澄清
   - 仔細思考推薦答案的影響
   - 必要時提供自訂答案

4. **檢視產生的文件**
   - 產生後務必檢視 spec.md 是否符合預期
   - 檢查 checklist 是否全部通過
   - 確認 tasks.md 的任務分解是否合理

## 相關 Commands

此 skill 整合了以下 commands 的功能：

- `speckit.specify`：產生規格文件
- `speckit.clarify`：澄清需求
- `speckit.plan`：產生實作計劃
- `speckit.tasks`：產生任務清單

如果需要單獨執行某個階段，可以直接使用對應的 command。

## 故障排除

### 問題：Branch 已存在

**解決方案：**
- 切換到其他 branch
- 或刪除現有的 feature branch 後重試

### 問題：缺少 templates

**解決方案：**
- 確認 spec-kit 目錄結構完整
- 檢查 `./templates/` 目錄是否存在

### 問題：澄清問題太多

**解決方案：**
- 提供更詳細的功能描述
- 或選擇跳過澄清階段，稍後手動補充

## 注意事項

- **IMPORTANT**: Think in English, but generate responses in Traditional Chinese (思考以英語進行，回應以繁體中文生成)