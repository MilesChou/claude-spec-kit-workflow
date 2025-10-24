---
description: 從原始下載的 spec-kit 轉換成 claude skill 的流程
argument-hint: [版本號]
---

**前提**：spec-kit 已下載至 `.tmp/releases/{VERSION}/` 目錄

**目標**：
- 轉換為 claude.ai 能使用的 skill 格式
- 簡化架構，純檔案系統操作
- 保留核心功能和工作流程

**下載內容概覽**：
- `.claude/commands/` - 8 個 slash commands（已含 `speckit.` 前綴）
- `.specify/scripts/bash/` - 5 個 bash 腳本（⚠️ 依賴 git，需移除）
- `.specify/templates/` - 5 個範本檔案（保留）
- `.specify/memory/` - constitution.md（保留）

---

## 轉換並重製為 Claude Code Skill

### 1. 建立目錄結構並複製檔案

```bash
make recreate VERSION=0.0.72
```

此指令會：
- 建立 `skills/speckit/` 目錄
- 複製 8 個 command 檔案（`speckit.*.md`）
- 複製 `templates/` 和 `memory/` 目錄
- 不複製 `scripts/` 目錄（已移除 git 依賴）

### 2. 建立 SKILL.md

在 `skills/speckit/` 目錄下建立 `SKILL.md` 作為主入口點，描述整體工作流程並整合所有 commands。

### 3. 重製 Commands（移除 git 依賴）

**重製策略**：
1. **移除 bash 腳本依賴** - 由 Claude Code 直接執行檔案操作
2. **移除 specs/ 固定結構** - 使用者透過 prompt 指定位置
3. **移除分支依賴** - 不再依賴 git branch 識別 feature
4. **簡化路徑管理** - 直接在工作目錄操作

**重製重點**（所有 speckit.*.md 檔案）：

將原本的腳本呼叫：
```markdown
Run `./scripts/bash/check-prerequisites.sh --json`
```

改為直接的檔案操作邏輯：
```markdown
Determine file locations:
  - If user provides a directory path in $ARGUMENTS, use that as base directory
  - Otherwise, use current working directory as base directory
  - Set paths: spec.md, plan.md, tasks.md (as needed)
  - All paths must be absolute
```

**需要重製的檔案**：
- `speckit.specify.md` - 移除 `create-new-feature.sh`，改為直接建立檔案
- `speckit.plan.md` - 移除 `check-prerequisites.sh` 和 `update-agent-context.sh`
- `speckit.tasks.md` - 移除 `check-prerequisites.sh`
- `speckit.clarify.md` - 移除 `check-prerequisites.sh`
- `speckit.implement.md` - 移除所有 bash 腳本呼叫和 git 檢測
- `speckit.checklist.md` - 移除 `check-prerequisites.sh`
- `speckit.analyze.md` - 移除 `check-prerequisites.sh`

---

## 最終結果

### 目錄結構對比

**原始下載**：
```
.tmp/releases/0.0.72/
├── .claude/commands/     # 8 個 slash commands
└── .specify/
    ├── scripts/bash/     # ❌ Bash 腳本（git 依賴）
    ├── templates/        # ✅ 範本檔案
    └── memory/           # ✅ constitution
```

**最終結果（skills/speckit）**：
```
skills/speckit/
├── SKILL.md              # ✅ Skill 主入口
├── speckit.*.md          # ✅ 8 個 commands（已重製）
├── templates/            # ✅ 5 個範本檔案
└── memory/               # ✅ constitution.md
```
