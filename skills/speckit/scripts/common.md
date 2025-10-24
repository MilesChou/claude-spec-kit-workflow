# Common: 專案路徑與配置資訊

## 目的

提供取得專案路徑和配置資訊的標準方法，支援 Git 和非 Git 專案。

## 核心概念

### 專案根目錄 (Repository Root)

**Git 專案**:
- 使用 GitHub MCP 的 `get_repository_info` 取得 repository root

**非 Git 專案**:
- 從當前目錄向上搜尋 `.specify` 目錄
- 使用檔案系統工具逐層檢查父目錄

### 當前 Feature 識別

優先順序如下：

1. **環境變數**: `SPECIFY_FEATURE` (如果已設定)
2. **Git Branch**: 使用 GitHub MCP 的 `get_current_branch` 取得當前 branch (Git 專案)
3. **最新 Feature**: 從 `specs/` 目錄找到編號最大的 feature
4. **預設值**: `main` (最後備用方案)

### Feature 目錄查找

**依數字前綴查找** (推薦):
- 從 branch 名稱提取數字前綴 (例如: `004` from `004-fix-bug`)
- 在 `specs/` 目錄中搜尋符合該前綴的目錄
- 這允許多個 branch 共用同一個 spec (例如: `004-fix-bug`, `004-add-feature`)

**精確比對** (備用):
- 當 branch 名稱沒有數字前綴時使用
- 直接使用 branch 名稱作為目錄名稱

## 標準路徑變數

以下是應該提供的標準路徑變數：

```
REPO_ROOT: 專案根目錄絕對路徑
CURRENT_BRANCH: 當前 feature 名稱
HAS_GIT: 'true' 或 'false'
FEATURE_DIR: Feature 目錄路徑 ({repo_root}/specs/{branch})
FEATURE_SPEC: spec.md 檔案路徑
IMPL_PLAN: plan.md 檔案路徑
TASKS: tasks.md 檔案路徑
RESEARCH: research.md 檔案路徑
DATA_MODEL: data-model.md 檔案路徑
QUICKSTART: quickstart.md 檔案路徑
CONTRACTS_DIR: contracts/ 目錄路徑
```

## Feature Branch 驗證

**Git 專案**:
- 驗證 branch 名稱格式為 `{3位數字}-{描述}`
- 例如: `001-user-auth`, `042-api-refactor`
- 不符合格式時應提供錯誤訊息

**非 Git 專案**:
- 跳過 branch 驗證
- 提供警告訊息但繼續執行

## 輔助功能

### 檢查檔案/目錄存在

```
check_file: 檢查檔案並顯示 ✓ 或 ✗
check_dir: 檢查目錄並確認非空
```

### 多 Spec 支援

當同一個數字前綴有多個 spec 目錄時：
- 顯示錯誤訊息列出所有符合的目錄
- 建議確保每個數字前綴只有一個 spec 目錄

## 實作建議

### 使用 GitHub MCP

對於 Git 相關操作：
- `get_repository_info`: 取得 repository root 和基本資訊
- `get_current_branch`: 取得當前 branch 名稱
- `list_branches`: 列出所有 branches (如果需要)

### 使用檔案工具

對於檔案系統操作：
- 使用 `Read` 工具讀取檔案
- 使用 `Glob` 工具搜尋檔案（例如: `specs/*/` 找到所有 feature）
- 使用 `Bash` 工具的 `ls` 列出目錄內容

### 環境變數

檢查環境變數：
```bash
echo "${SPECIFY_FEATURE:-}"
```

## 錯誤處理

- 無法識別專案根目錄 → 提示從專案目錄執行
- 無法確定當前 feature → 提示設定 SPECIFY_FEATURE 或建立新 feature
- 多個符合的 spec 目錄 → 列出所有符合項並建議修正命名
