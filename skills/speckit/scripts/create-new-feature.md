# Create New Feature

建立新的 feature，包括產生 branch 名稱、建立目錄結構，以及初始化 spec.md 檔案。

## 資訊確認

依上下文取得下列相關資訊：

- 新功能的自然語言描述。例如：實作 OAuth 授權機制

若無法取得上述資訊，請詢問我。

## 步驟

### 1. 確定下一個 Feature 編號

- 掃描 `specs/` 目錄中所有現有 feature，並找到最大的數字編號
- 下一個編號 = 最大編號 + 1
- 格式化為 3 位數 (例如：`001`, `042`, `123`)

### 2. 產生功能短名

將「新功能的自然語言描述」轉換成英文簡短描述，目的是要成為一個分支名稱。

範例：
- "實作 OAuth 授權機制" → `oauth2-authorization`

**IMPORTANT**：GitHub Branch 名稱限制只有 244 bytes。為平常方便輸入與閱讀，因此限制字數不要超過 80 字元

### 3. 組合完整分支名稱

格式：`{編號}-{名稱}`

範例：
- `001-oauth2-authorization`
- `042-user-login`

### 4. 建立分支

使用 GitHub MCP 的 `create_branch` 功能建立新 branch：
- Branch 名稱：上一步驟產生的完整分支名稱
- Base branch：從 remote HEAD 建立

### 5. 初始化 spec.md

取得 template 內容（依以下優先順序）：

1. 如果 Project Knowledge 或對話中有上傳 `spec-template.md` 檔案，使用該檔案內容
2. 如果透過 GitHub MCP 讀取 remote HEAD branch 有 `.specify/templates/spec-template.md`，使用該檔案內容
3. 如果都找不到，使用 speckit 內建的 templates/spec-template.md 內容

決定好 spec.md 的內容後，透過 GitHub MCP 建立檔案到新分支：
- 路徑：`specs/{分支名稱}/spec.md`
- 例如：`specs/001-oauth2-authorization/spec.md`

## 錯誤處理

遇到任何錯誤時：
1. 清楚說明錯誤原因
2. 立即停止執行，不繼續後續步驟

常見錯誤：
- 無法掃描 `specs/` 目錄 → 說明目錄不存在或無法存取
- 分支名稱已存在 → 說明分支名稱衝突
- GitHub MCP 建立分支失敗 → 說明失敗原因（權限、網路等）
- 無法讀取或寫入檔案 → 說明檔案路徑和權限問題
- 所有 template 都找不到 → 說明已嘗試的路徑
