#!/usr/bin/env bash
#
# convert.sh — 将智能体 .md 文件转换为各工具专用格式（中文版适配）
#
# 读取所有智能体目录中的 .md 文件，输出到 integrations/<tool>/。
# 添加或修改智能体后运行此脚本重新生成集成文件。
#
# 用法：
#   ./scripts/convert.sh [--tool <name>] [--out <dir>] [--help]
#
# 支持的工具：
#   antigravity  — Antigravity skill 文件 (~/.gemini/antigravity/skills/)
#   gemini-cli   — Gemini CLI 扩展 (skills/ + gemini-extension.json)
#   opencode     — OpenCode agent 文件 (.opencode/agent/*.md)
#   cursor       — Cursor rule 文件 (.cursor/rules/*.mdc)
#   trae         — Trae rule 文件 (.trae/rules/*.md)
#   aider        — 单文件 CONVENTIONS.md for Aider
#   windsurf     — 单文件 .windsurfrules for Windsurf
#   openclaw     — OpenClaw SOUL.md 文件 (openclaw_workspace/<agent>/SOUL.md)
#   qwen         — Qwen Code SubAgent 文件 (~/.qwen/agents/*.md)
#   codex        — OpenAI Codex CLI agent 文件 (.codex/agents/*.toml)
#   deerflow     — DeerFlow 2.0 custom skill 文件 (skills/custom/<slug>/SKILL.md)
#   workbuddy    — WorkBuddy skill 文件 (~/.workbuddy/skills/<slug>/SKILL.md)
#   hermes       — Hermes Agent skill 文件 (~/.hermes/skills/<category>/<slug>/SKILL.md)
#   kiro         — Kiro agent JSON 文件 (.kiro/agents/*.json + prompts/*.md)
#   all          — 所有工具（默认）
#
# 输出到仓库根目录下的 integrations/<tool>/。
# 此脚本不会修改用户配置目录 — 参见 install.sh。

set -euo pipefail

# --- 颜色辅助 ---
if [[ -t 1 ]]; then
  GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; RED=$'\033[0;31m'; BOLD=$'\033[1m'; RESET=$'\033[0m'
else
  GREEN=''; YELLOW=''; RED=''; BOLD=''; RESET=''
fi

info()    { printf "${GREEN}[OK]${RESET}  %s\n" "$*"; }
warn()    { printf "${YELLOW}[!!]${RESET}  %s\n" "$*"; }
error()   { printf "${RED}[ERR]${RESET} %s\n" "$*" >&2; }
header()  { echo -e "\n${BOLD}$*${RESET}"; }

# --- 路径 ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
OUT_DIR="$REPO_ROOT/integrations"
TODAY="$(date +%Y-%m-%d)"

AGENT_DIRS=(
  academic design engineering finance game-development hr legal marketing paid-media sales product
  project-management supply-chain testing support spatial-computing specialized
)

# --- 用法 ---
usage() {
  sed -n '3,27p' "$0" | sed 's/^# \{0,1\}//'
  exit 0
}

# --- Frontmatter 辅助函数 ---

# 从 YAML frontmatter 中提取单个字段值
get_field() {
  local field="$1" file="$2"
  awk -v f="$field" '
    /^---$/ { fm++; next }
    fm == 1 && $0 ~ "^" f ": " { sub("^" f ": ", ""); print; exit }
  ' "$file"
}

# 去除 frontmatter，返回正文部分
get_body() {
  awk 'BEGIN{fm=0} /^---$/{fm++; next} fm>=2{print}' "$1"
}

# 从文件名生成 slug（适配中文：直接用文件名而非中文 name 字段）
# "marketing-douyin-strategist.md" → "marketing-douyin-strategist"
slugify_from_file() {
  basename "$1" .md
}

# --- 颜色映射 ---
resolve_opencode_color() {
  local c="$1"
  case "$c" in
    cyan)           echo "#00FFFF" ;;
    blue)           echo "#3498DB" ;;
    green)          echo "#2ECC71" ;;
    red)            echo "#E74C3C" ;;
    purple)         echo "#9B59B6" ;;
    orange)         echo "#F39C12" ;;
    teal)           echo "#008080" ;;
    indigo)         echo "#6366F1" ;;
    pink)           echo "#E84393" ;;
    gold)           echo "#EAB308" ;;
    amber)          echo "#F59E0B" ;;
    neon-green)     echo "#10B981" ;;
    neon-cyan)      echo "#06B6D4" ;;
    metallic-blue)  echo "#3B82F6" ;;
    yellow)         echo "#EAB308" ;;
    violet)         echo "#8B5CF6" ;;
    rose)           echo "#F43F5E" ;;
    lime)           echo "#84CC16" ;;
    gray)           echo "#6B7280" ;;
    fuchsia)        echo "#D946EF" ;;
    *)              echo "$c" ;;
  esac
}

# --- 各工具转换器 ---

convert_antigravity() {
  local file="$1"
  local name description slug outdir outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="agency-$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outdir="$OUT_DIR/antigravity/$slug"
  outfile="$outdir/SKILL.md"
  mkdir -p "$outdir"

  cat > "$outfile" <<HEREDOC
---
name: ${slug}
description: ${description}
risk: low
source: community
date_added: '${TODAY}'
---
${body}
HEREDOC
}

convert_gemini_cli() {
  local file="$1"
  local name description slug outdir outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outdir="$OUT_DIR/gemini-cli/skills/$slug"
  outfile="$outdir/SKILL.md"
  mkdir -p "$outdir"

  cat > "$outfile" <<HEREDOC
---
name: ${slug}
description: ${description}
---
${body}
HEREDOC
}

convert_opencode() {
  local file="$1"
  local name description color slug outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  local raw_color
  raw_color="$(get_field "color" "$file" | tr -d '"')"
  color="$(resolve_opencode_color "$raw_color")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outfile="$OUT_DIR/opencode/agents/${slug}.md"
  mkdir -p "$OUT_DIR/opencode/agents"

  cat > "$outfile" <<HEREDOC
---
name: ${name}
description: ${description}
mode: subagent
color: "${color}"
---
${body}
HEREDOC
}

convert_cursor() {
  local file="$1"
  local name description slug outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outfile="$OUT_DIR/cursor/rules/${slug}.mdc"
  mkdir -p "$OUT_DIR/cursor/rules"

  cat > "$outfile" <<HEREDOC
---
description: ${description}
globs:
alwaysApply: false
---
${body}
HEREDOC
}

convert_trae() {
  local file="$1"
  local name description slug outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outfile="$OUT_DIR/trae/rules/${slug}.md"
  mkdir -p "$OUT_DIR/trae/rules"

  cat > "$outfile" <<HEREDOC
---
description: ${description}
globs:
alwaysApply: false
---
${body}
HEREDOC
}

convert_openclaw() {
  local file="$1"
  local name description slug outdir body
  local soul_content="" agents_content=""

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outdir="$OUT_DIR/openclaw/$slug"
  mkdir -p "$outdir"

  # 按 ## 标题关键词拆分为 SOUL.md（人设）和 AGENTS.md（业务）
  # SOUL 关键词：身份/记忆/identity/communication/style/规则/rules
  # AGENTS 关键词：使命/mission/交付/workflow 等其余内容

  local current_target="agents"
  local current_section=""

  while IFS= read -r line; do
    if [[ "$line" =~ ^##[[:space:]] ]]; then
      if [[ -n "$current_section" ]]; then
        if [[ "$current_target" == "soul" ]]; then
          soul_content+="$current_section"
        else
          agents_content+="$current_section"
        fi
      fi
      current_section=""

      local header_lower
      header_lower="$(echo "$line" | tr '[:upper:]' '[:lower:]')"

      if [[ "$header_lower" =~ identity ]] ||
         [[ "$header_lower" =~ 身份 ]] ||
         [[ "$header_lower" =~ 记忆 ]] ||
         [[ "$header_lower" =~ communication ]] ||
         [[ "$header_lower" =~ 沟通 ]] ||
         [[ "$header_lower" =~ style ]] ||
         [[ "$header_lower" =~ 风格 ]] ||
         [[ "$header_lower" =~ critical.rule ]] ||
         [[ "$header_lower" =~ 关键规则 ]] ||
         [[ "$header_lower" =~ rules.you.must.follow ]]; then
        current_target="soul"
      else
        current_target="agents"
      fi
    fi

    current_section+="$line"$'\n'
  done <<< "$body"

  if [[ -n "$current_section" ]]; then
    if [[ "$current_target" == "soul" ]]; then
      soul_content+="$current_section"
    else
      agents_content+="$current_section"
    fi
  fi

  cat > "$outdir/SOUL.md" <<HEREDOC
${soul_content}
HEREDOC

  cat > "$outdir/AGENTS.md" <<HEREDOC
# AGENTS.md - 工作空间规范

这是你的工作空间，**必须严格按照以下规范工作**。

## Session 启动流程

每次会话开始时，按以下顺序自动执行：

1. 读取 \`SOUL.md\` - 加载性格和行为风格
2. 读取 \`USER.md\` - 了解用户背景和偏好
3. 读取 \`memory/YYYY-MM-DD.md\` - 加载今天和昨天的日志
4. 如果是主会话：额外读取 \`MEMORY.md\` - 加载核心记忆索引

以上操作无需询问，自动执行。

## 记忆管理规范

你每次启动都是全新状态，这些文件是你的记忆延续。

| 层级 | 文件路径 | 存储内容 |
|------|---------|---------|
| 索引层 | \`MEMORY.md\` | 核心信息和记忆索引，保持精简 |
| 日志层 | \`memory/YYYY-MM-DD.md\` | 每日详细记录 |

---

${agents_content}
HEREDOC

  cat > "$outdir/IDENTITY.md" <<HEREDOC
# ${name}
${description}
HEREDOC
}

convert_qwen() {
  local file="$1"
  local name description tools slug outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  tools="$(get_field "tools" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outfile="$OUT_DIR/qwen/agents/${slug}.md"
  mkdir -p "$(dirname "$outfile")"

  # Qwen Code SubAgent 格式：带 YAML frontmatter 的 .md 文件
  # name 和 description 必填；tools 可选（仅在源文件中存在时添加）
  if [[ -n "$tools" ]]; then
    cat > "$outfile" <<HEREDOC
---
name: ${slug}
description: ${description}
tools: ${tools}
---
${body}
HEREDOC
  else
    cat > "$outfile" <<HEREDOC
---
name: ${slug}
description: ${description}
---
${body}
HEREDOC
  fi
}

convert_codex() {
  local file="$1"
  local name description slug outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outfile="$OUT_DIR/codex/agents/${slug}.toml"
  mkdir -p "$OUT_DIR/codex/agents"

  # Codex CLI agent 格式：TOML 文件
  # TOML 多行基本字符串（"""..."""）中反斜杠必须转义为 \\
  # 同时转义三引号（极罕见但防御性处理）
  local escaped_body
  escaped_body="$(echo "$body" | sed -e 's/\\/\\\\/g' -e 's/"""/\\"""/g')"

  local escaped_desc
  escaped_desc="$(echo "$description" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')"

  cat > "$outfile" <<HEREDOC
name = "${slug}"
description = "${escaped_desc}"
developer_instructions = """
${escaped_body}
"""
HEREDOC
}

convert_deerflow() {
  local file="$1"
  local name description slug outdir outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outdir="$OUT_DIR/deerflow/$slug"
  outfile="$outdir/SKILL.md"
  mkdir -p "$outdir"

  cat > "$outfile" <<HEREDOC
---
name: ${slug}
description: ${description}
---
${body}
HEREDOC
}

convert_workbuddy() {
  local file="$1"
  local name description slug outdir outfile body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  outdir="$OUT_DIR/workbuddy/$slug"
  outfile="$outdir/SKILL.md"
  mkdir -p "$outdir"

  cat > "$outfile" <<HEREDOC
---
name: ${slug}
description: ${description}
allowed-tools: Read Write Edit Bash Grep Glob
---
${body}
HEREDOC
}

convert_hermes() {
  local file="$1"
  local name description slug body category outdir outfile

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  # 从文件路径提取分类目录名（如 engineering、marketing）
  category="$(basename "$(dirname "$file")")"

  outdir="$OUT_DIR/hermes/$category/$slug"
  outfile="$outdir/SKILL.md"
  mkdir -p "$outdir"

  cat > "$outfile" <<HEREDOC
---
name: ${slug}
description: ${description}
version: 1.0.0
author: agency-agents-zh
license: MIT
metadata:
  hermes:
    tags: [${category}]
---
${body}
HEREDOC
}

convert_kiro() {
  local file="$1"
  local name description slug body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  slug="$(slugify_from_file "$file")"
  body="$(get_body "$file")"

  mkdir -p "$OUT_DIR/kiro/prompts"

  # 写入 prompt 文件
  cat > "$OUT_DIR/kiro/prompts/${slug}.md" <<HEREDOC
${body}
HEREDOC

  # 写入 JSON 配置文件
  # 需要转义 description 中的双引号
  local escaped_desc
  escaped_desc="$(echo "$description" | sed 's/"/\\"/g')"

  cat > "$OUT_DIR/kiro/${slug}.json" <<HEREDOC
{
  "name": "${slug}",
  "description": "${escaped_desc}",
  "prompt": "file://./prompts/${slug}.md"
}
HEREDOC
}

# Aider 和 Windsurf 是单文件格式，先累积再统一写入
AIDER_TMP="$(mktemp)"
WINDSURF_TMP="$(mktemp)"
trap 'rm -f "$AIDER_TMP" "$WINDSURF_TMP"' EXIT

cat > "$AIDER_TMP" <<'HEREDOC'
# AI 智能体专家团队 — Aider 约定文件
#
# 本文件为 Aider 提供完整的 AI 智能体专家阵容。
# 来源：https://github.com/jnMetaCode/agency-agents-zh
#
# 激活方式：在 Aider 会话中引用智能体名称，例如：
#   "使用前端开发者智能体帮我审查这个组件"
#
# 由 scripts/convert.sh 生成 — 请勿手动编辑。

HEREDOC

cat > "$WINDSURF_TMP" <<'HEREDOC'
# AI 智能体专家团队 — Windsurf 规则文件
#
# 完整的 AI 智能体专家阵容。
# 激活方式：在 Windsurf 对话中引用智能体名称。
#
# 由 scripts/convert.sh 生成 — 请勿手动编辑。

HEREDOC

accumulate_aider() {
  local file="$1"
  local name description body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  body="$(get_body "$file")"

  cat >> "$AIDER_TMP" <<HEREDOC

---

## ${name}

> ${description}

${body}
HEREDOC
}

accumulate_windsurf() {
  local file="$1"
  local name description body

  name="$(get_field "name" "$file")"
  description="$(get_field "description" "$file")"
  body="$(get_body "$file")"

  cat >> "$WINDSURF_TMP" <<HEREDOC

================================================================================
## ${name}
${description}
================================================================================

${body}

HEREDOC
}

# --- 主循环 ---

run_conversions() {
  local tool="$1"
  local count=0

  for dir in "${AGENT_DIRS[@]}"; do
    local dirpath="$REPO_ROOT/$dir"
    [[ -d "$dirpath" ]] || continue

    while IFS= read -r -d '' file; do
      local first_line
      first_line="$(head -1 "$file")"
      [[ "$first_line" == "---" ]] || continue

      local name
      name="$(get_field "name" "$file")"
      [[ -n "$name" ]] || continue

      case "$tool" in
        antigravity) convert_antigravity "$file" ;;
        gemini-cli)  convert_gemini_cli  "$file" ;;
        opencode)    convert_opencode    "$file" ;;
        cursor)      convert_cursor      "$file" ;;
        trae)        convert_trae        "$file" ;;
        openclaw)    convert_openclaw    "$file" ;;
        qwen)        convert_qwen        "$file" ;;
        codex)       convert_codex       "$file" ;;
        deerflow)    convert_deerflow    "$file" ;;
        workbuddy)   convert_workbuddy   "$file" ;;
        hermes)      convert_hermes      "$file" ;;
        kiro)        convert_kiro        "$file" ;;
        aider)       accumulate_aider    "$file" ;;
        windsurf)    accumulate_windsurf "$file" ;;
      esac

      (( count++ )) || true
    done < <(find "$dirpath" -name "*.md" -type f -print0 | sort -z)
  done

  echo "$count"
}


# --- 入口 ---

main() {
  local tool="all"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --tool) tool="${2:?'--tool 需要一个值'}"; shift 2 ;;
      --out)  OUT_DIR="${2:?'--out 需要一个值'}"; shift 2 ;;
      --help|-h) usage ;;
      *) error "未知选项: $1"; usage ;;
    esac
  done

  local valid_tools=("antigravity" "gemini-cli" "opencode" "cursor" "trae" "aider" "windsurf" "openclaw" "qwen" "codex" "deerflow" "workbuddy" "hermes" "kiro" "all")
  local valid=false
  for t in "${valid_tools[@]}"; do [[ "$t" == "$tool" ]] && valid=true && break; done
  if ! $valid; then
    error "未知工具 '$tool'。可选: ${valid_tools[*]}"
    exit 1
  fi

  header "AI 智能体专家团队 -- 转换为工具专用格式"
  echo "  仓库:   $REPO_ROOT"
  echo "  输出:   $OUT_DIR"
  echo "  工具:   $tool"
  echo "  日期:   $TODAY"

  local tools_to_run=()
  if [[ "$tool" == "all" ]]; then
    tools_to_run=("antigravity" "gemini-cli" "opencode" "cursor" "trae" "aider" "windsurf" "openclaw" "qwen" "codex" "deerflow" "workbuddy" "hermes" "kiro")
  else
    tools_to_run=("$tool")
  fi

  local total=0
  for t in "${tools_to_run[@]}"; do
    header "正在转换: $t"
    local count
    count="$(run_conversions "$t")"
    total=$(( total + count ))

    if [[ "$t" == "gemini-cli" ]]; then
      mkdir -p "$OUT_DIR/gemini-cli"
      cat > "$OUT_DIR/gemini-cli/gemini-extension.json" <<'HEREDOC'
{
  "name": "agency-agents-zh",
  "version": "1.0.0"
}
HEREDOC
      info "已写入 gemini-extension.json"
    fi

    info "已转换 $count 个智能体 ($t)"
  done

  if [[ "$tool" == "all" || "$tool" == "aider" ]]; then
    mkdir -p "$OUT_DIR/aider"
    cp "$AIDER_TMP" "$OUT_DIR/aider/CONVENTIONS.md"
    info "已写入 integrations/aider/CONVENTIONS.md"
  fi
  if [[ "$tool" == "all" || "$tool" == "windsurf" ]]; then
    mkdir -p "$OUT_DIR/windsurf"
    cp "$WINDSURF_TMP" "$OUT_DIR/windsurf/.windsurfrules"
    info "已写入 integrations/windsurf/.windsurfrules"
  fi

  echo ""
  info "完成。共转换: $total"
}

main "$@"
