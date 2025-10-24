# Setup Plan

## 目的

設定實作計畫檔案 (plan.md)，從 template 複製並初始化基本結構。

## 執行時機

當使用者執行 `/speckit.plan` 命令，需要建立實作計畫時。

## 前置條件

1. 必須在 feature branch 上 (Git 專案) 或設定 `SPECIFY_FEATURE` 環境變數
2. Feature 目錄必須已存在 (`specs/{feature-name}/`)

## 主要步驟

### 1. 取得專案資訊

使用 common 功能取得：
- 專案根目錄
- 當前 feature/branch
- Feature 目錄路徑
- 是否為 Git 專案

### 2. 驗證 Feature Branch

**Git 專案**:
- 確認當前在正確的 feature branch 上
- Branch 格式應為: `{3位數字}-{描述}`

**非 Git 專案**:
- 跳過驗證但提供警告

### 3. 確保 Feature 目錄存在

如果目錄不存在，建立它：
```bash
mkdir -p {feature_dir}
```

### 4. 複製 Plan Template

**Template 位置**: `{repo_root}/.specify/templates/plan-template.md`

**目標位置**: `{feature_dir}/plan.md`

處理流程:
1. 檢查 template 是否存在
2. 如果存在，複製到 feature 目錄
3. 如果不存在:
   - 顯示警告訊息
   - 建立空白 plan.md 檔案

### 5. 輸出結果資訊

提供以下資訊：

```
FEATURE_SPEC: {spec.md 的路徑}
IMPL_PLAN: {plan.md 的路徑}
SPECS_DIR: {feature 目錄路徑}
BRANCH: {當前 branch/feature 名稱}
HAS_GIT: {true 或 false}
```

## Plan Template 結構

Plan template 應該包含以下章節：

### 基本資訊
- Language/Version
- Primary Dependencies
- Storage
- Project Type

### 實作細節
- Directory Structure
- File Changes
- Dependencies
- Configuration
- Testing Strategy

## 錯誤處理

### Feature 目錄問題

如果目錄建立失敗：
```
ERROR: Failed to create feature directory: {path}
```

### Template 問題

如果 template 不存在：
```
Warning: Plan template not found at {template_path}
Creating empty plan file...
```

### Branch 驗證失敗

```
ERROR: Not on a feature branch. Current branch: {branch}
Feature branches should be named like: 001-feature-name
```

## 實作建議

### 使用 GitHub MCP

Git 相關操作:
- `get_repository_info`: 取得 repository root
- `get_current_branch`: 取得當前 branch 名稱

### 使用檔案工具

檔案系統操作:
- 使用 `Read` 工具檢查 template 是否存在
- 使用 `Write` 工具建立空白檔案 (如果需要)
- 使用 `Bash` 執行 `cp` 命令複製檔案或 `mkdir -p` 建立目錄

## 後續步驟

Plan.md 建立後，使用者通常會：
1. 填寫計畫細節 (由 AI 或手動)
2. 執行 `/speckit.tasks` 建立任務清單
3. 執行 `/speckit.implement` 開始實作

## 範例

### 成功情況

```
Copied plan template to /path/to/repo/specs/001-user-auth/plan.md

FEATURE_SPEC: /path/to/repo/specs/001-user-auth/spec.md
IMPL_PLAN: /path/to/repo/specs/001-user-auth/plan.md
SPECS_DIR: /path/to/repo/specs/001-user-auth
BRANCH: 001-user-auth
HAS_GIT: true
```

### Template 不存在

```
Warning: Plan template not found at /path/to/repo/.specify/templates/plan-template.md

FEATURE_SPEC: /path/to/repo/specs/001-user-auth/spec.md
IMPL_PLAN: /path/to/repo/specs/001-user-auth/plan.md
SPECS_DIR: /path/to/repo/specs/001-user-auth
BRANCH: 001-user-auth
HAS_GIT: true
```

### 非 Git 專案

```
[specify] Warning: Git repository not detected; skipped branch validation

Copied plan template to /path/to/repo/specs/001-user-auth/plan.md

FEATURE_SPEC: /path/to/repo/specs/001-user-auth/spec.md
IMPL_PLAN: /path/to/repo/specs/001-user-auth/plan.md
SPECS_DIR: /path/to/repo/specs/001-user-auth
BRANCH: 001-user-auth
HAS_GIT: false
```

## 整合說明

此腳本是 `/speckit.plan` 命令的核心部分，負責：
1. 設定檔案結構
2. 初始化 plan.md

實際的計畫內容填寫由其他邏輯處理 (通常是 AI agent 根據 spec.md 產生)。
