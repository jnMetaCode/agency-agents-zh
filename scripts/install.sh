#!/usr/bin/env bash
#
# install.sh -- 将智能体安装到本地 AI 工具中（中文版适配）
#
# 读取 integrations/ 中的转换文件，复制到各工具的配置目录。
# 请先运行 scripts/convert.sh 生成集成文件。
#
# 用法：
#   ./scripts/install.sh [--tool <name>] [--no-interactive] [--help]
#
# 支持的工具：
#   claude-code  -- 复制到 ~/.claude/agents/
#   copilot      -- 复制到 ~/.github/agents/
#   antigravity  -- 复制到 ~/.gemini/antigravity/skills/
#   gemini-cli   -- 安装到 ~/.gemini/extensions/agency-agents/
#   opencode     -- 复制到 .opencode/agent/（当前目录）
#   cursor       -- 复制到 .cursor/rules/（当前目录）
#   aider        -- 复制 CONVENTIONS.md（当前目录）
#   windsurf     -- 复制 .windsurfrules（当前目录）
#   openclaw     -- 复制到 ~/.openclaw/agency-agents/
#   qwen         -- 复制 SubAgent 到 .qwen/agents/（项目级）
#   all          -- 安装所有已检测到的工具（默认）

set -euo pipefail

# --- 颜色 ---
if [[ -t 1 ]]; then
  C_GREEN=$'\033[0;32m'; C_YELLOW=$'\033[1;33m'; C_RED=$'\033[0;31m'
  C_CYAN=$'\033[0;36m'; C_BOLD=$'\033[1m'; C_DIM=$'\033[2m'; C_RESET=$'\033[0m'
else
  C_GREEN=''; C_YELLOW=''; C_RED=''; C_CYAN=''; C_BOLD=''; C_DIM=''; C_RESET=''
fi

ok()     { printf "${C_GREEN}[OK]${C_RESET}  %s\n" "$*"; }
warn()   { printf "${C_YELLOW}[!!]${C_RESET}  %s\n" "$*"; }
err()    { printf "${C_RED}[ERR]${C_RESET} %s\n" "$*" >&2; }
header() { printf "\n${C_BOLD}%s${C_RESET}\n" "$*"; }
dim()    { printf "${C_DIM}%s${C_RESET}\n" "$*"; }

# --- 路径 ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
INTEGRATIONS="$REPO_ROOT/integrations"

ALL_TOOLS=(claude-code copilot antigravity gemini-cli opencode openclaw cursor aider windsurf qwen)

# --- 用法 ---
usage() {
  sed -n '3,22p' "$0" | sed 's/^# \{0,1\}//'
  exit 0
}

# --- 预检 ---
check_integrations() {
  if [[ ! -d "$INTEGRATIONS" ]]; then
    err "integrations/ 不存在。请先运行 ./scripts/convert.sh"
    exit 1
  fi
}

# --- 工具检测 ---
detect_claude_code() { [[ -d "${HOME}/.claude" ]]; }
detect_copilot()      { command -v code >/dev/null 2>&1 || [[ -d "${HOME}/.github" ]]; }
detect_antigravity()  { [[ -d "${HOME}/.gemini/antigravity/skills" ]]; }
detect_gemini_cli()   { command -v gemini >/dev/null 2>&1 || [[ -d "${HOME}/.gemini" ]]; }
detect_cursor()       { command -v cursor >/dev/null 2>&1 || [[ -d "${HOME}/.cursor" ]]; }
detect_opencode()     { command -v opencode >/dev/null 2>&1 || [[ -d "${HOME}/.config/opencode" ]]; }
detect_aider()        { command -v aider >/dev/null 2>&1; }
detect_openclaw()     { command -v openclaw >/dev/null 2>&1 || [[ -d "${HOME}/.openclaw" ]]; }
detect_windsurf()     { command -v windsurf >/dev/null 2>&1 || [[ -d "${HOME}/.codeium" ]]; }
detect_qwen()         { command -v qwen >/dev/null 2>&1 || [[ -d "${HOME}/.qwen" ]]; }

is_detected() {
  case "$1" in
    claude-code) detect_claude_code ;;
    copilot)     detect_copilot     ;;
    antigravity) detect_antigravity ;;
    gemini-cli)  detect_gemini_cli  ;;
    opencode)    detect_opencode    ;;
    openclaw)    detect_openclaw    ;;
    cursor)      detect_cursor      ;;
    aider)       detect_aider       ;;
    windsurf)    detect_windsurf    ;;
    qwen)        detect_qwen        ;;
    *)           return 1 ;;
  esac
}

tool_label() {
  case "$1" in
    claude-code) printf "%-14s  %s" "Claude Code"  "(~/.claude/agents)"     ;;
    copilot)     printf "%-14s  %s" "Copilot"      "(~/.github/agents)"     ;;
    antigravity) printf "%-14s  %s" "Antigravity"  "(~/.gemini/antigravity)" ;;
    gemini-cli)  printf "%-14s  %s" "Gemini CLI"   "(gemini 扩展)"          ;;
    opencode)    printf "%-14s  %s" "OpenCode"     "(opencode.ai)"          ;;
    openclaw)    printf "%-14s  %s" "OpenClaw"     "(~/.openclaw)"          ;;
    cursor)      printf "%-14s  %s" "Cursor"       "(.cursor/rules)"        ;;
    aider)       printf "%-14s  %s" "Aider"        "(CONVENTIONS.md)"       ;;
    windsurf)    printf "%-14s  %s" "Windsurf"     "(.windsurfrules)"       ;;
    qwen)        printf "%-14s  %s" "Qwen Code"    "(~/.qwen/agents)"       ;;
  esac
}

# --- 安装器 ---

install_claude_code() {
  local dest="${HOME}/.claude/agents"
  local count=0
  mkdir -p "$dest"
  local dir f first_line
  for dir in design engineering game-development marketing paid-media sales product project-management \
              testing support spatial-computing specialized; do
    [[ -d "$REPO_ROOT/$dir" ]] || continue
    while IFS= read -r -d '' f; do
      first_line="$(head -1 "$f")"
      [[ "$first_line" == "---" ]] || continue
      cp "$f" "$dest/"
      (( count++ )) || true
    done < <(find "$REPO_ROOT/$dir" -name "*.md" -type f -print0)
  done
  ok "Claude Code: $count 个智能体 -> $dest"
}

install_copilot() {
  local dest="${HOME}/.github/agents"
  local count=0
  mkdir -p "$dest"
  local dir f first_line
  for dir in design engineering game-development marketing paid-media sales product project-management \
              testing support spatial-computing specialized; do
    [[ -d "$REPO_ROOT/$dir" ]] || continue
    while IFS= read -r -d '' f; do
      first_line="$(head -1 "$f")"
      [[ "$first_line" == "---" ]] || continue
      cp "$f" "$dest/"
      (( count++ )) || true
    done < <(find "$REPO_ROOT/$dir" -name "*.md" -type f -print0)
  done
  ok "Copilot: $count 个智能体 -> $dest"
}

install_antigravity() {
  local src="$INTEGRATIONS/antigravity"
  local dest="${HOME}/.gemini/antigravity/skills"
  local count=0
  [[ -d "$src" ]] || { err "integrations/antigravity 不存在。请先运行 convert.sh"; return 1; }
  mkdir -p "$dest"
  local d
  while IFS= read -r -d '' d; do
    local name; name="$(basename "$d")"
    mkdir -p "$dest/$name"
    cp "$d/SKILL.md" "$dest/$name/SKILL.md"
    (( count++ )) || true
  done < <(find "$src" -mindepth 1 -maxdepth 1 -type d -print0)
  ok "Antigravity: $count 个 skills -> $dest"
}

install_gemini_cli() {
  local src="$INTEGRATIONS/gemini-cli"
  local dest="${HOME}/.gemini/extensions/agency-agents"
  local count=0
  [[ -d "$src" ]] || { err "integrations/gemini-cli 不存在。请先运行 convert.sh"; return 1; }
  mkdir -p "$dest/skills"
  cp "$src/gemini-extension.json" "$dest/gemini-extension.json"
  local d
  while IFS= read -r -d '' d; do
    local name; name="$(basename "$d")"
    mkdir -p "$dest/skills/$name"
    cp "$d/SKILL.md" "$dest/skills/$name/SKILL.md"
    (( count++ )) || true
  done < <(find "$src/skills" -mindepth 1 -maxdepth 1 -type d -print0)
  ok "Gemini CLI: $count 个 skills -> $dest"
}

install_opencode() {
  local src="$INTEGRATIONS/opencode/agents"
  local dest="${PWD}/.opencode/agents"
  local count=0
  [[ -d "$src" ]] || { err "integrations/opencode 不存在。请先运行 convert.sh"; return 1; }
  mkdir -p "$dest"
  local f
  while IFS= read -r -d '' f; do
    cp "$f" "$dest/"; (( count++ )) || true
  done < <(find "$src" -maxdepth 1 -name "*.md" -print0)
  ok "OpenCode: $count 个智能体 -> $dest"
  warn "OpenCode: 项目级安装。请在项目根目录运行。"
}

install_openclaw() {
  local src="$INTEGRATIONS/openclaw"
  local dest="${HOME}/.openclaw/agency-agents"
  local count=0
  [[ -d "$src" ]] || { err "integrations/openclaw 不存在。请先运行 convert.sh"; return 1; }
  mkdir -p "$dest"
  local d
  while IFS= read -r -d '' d; do
    local name; name="$(basename "$d")"
    mkdir -p "$dest/$name"
    cp "$d/SOUL.md" "$dest/$name/SOUL.md"
    cp "$d/AGENTS.md" "$dest/$name/AGENTS.md"
    cp "$d/IDENTITY.md" "$dest/$name/IDENTITY.md"
    if command -v openclaw >/dev/null 2>&1; then
      openclaw agents add "$name" --workspace "$dest/$name" --non-interactive || true
    fi
    (( count++ )) || true
  done < <(find "$src" -mindepth 1 -maxdepth 1 -type d -print0)
  ok "OpenClaw: $count 个工作空间 -> $dest"
  if command -v openclaw >/dev/null 2>&1; then
    warn "OpenClaw: 运行 'openclaw gateway restart' 激活新智能体"
  fi
}

install_cursor() {
  local src="$INTEGRATIONS/cursor/rules"
  local dest="${PWD}/.cursor/rules"
  local count=0
  [[ -d "$src" ]] || { err "integrations/cursor 不存在。请先运行 convert.sh"; return 1; }
  mkdir -p "$dest"
  local f
  while IFS= read -r -d '' f; do
    cp "$f" "$dest/"; (( count++ )) || true
  done < <(find "$src" -maxdepth 1 -name "*.mdc" -print0)
  ok "Cursor: $count 个规则 -> $dest"
  warn "Cursor: 项目级安装。请在项目根目录运行。"
}

install_aider() {
  local src="$INTEGRATIONS/aider/CONVENTIONS.md"
  local dest="${PWD}/CONVENTIONS.md"
  [[ -f "$src" ]] || { err "integrations/aider/CONVENTIONS.md 不存在。请先运行 convert.sh"; return 1; }
  if [[ -f "$dest" ]]; then
    warn "Aider: CONVENTIONS.md 已存在 ($dest)，删除后重试。"
    return 0
  fi
  cp "$src" "$dest"
  ok "Aider: 已安装 -> $dest"
  warn "Aider: 项目级安装。请在项目根目录运行。"
}

install_windsurf() {
  local src="$INTEGRATIONS/windsurf/.windsurfrules"
  local dest="${PWD}/.windsurfrules"
  [[ -f "$src" ]] || { err "integrations/windsurf/.windsurfrules 不存在。请先运行 convert.sh"; return 1; }
  if [[ -f "$dest" ]]; then
    warn "Windsurf: .windsurfrules 已存在 ($dest)，删除后重试。"
    return 0
  fi
  cp "$src" "$dest"
  ok "Windsurf: 已安装 -> $dest"
  warn "Windsurf: 项目级安装。请在项目根目录运行。"
}

install_qwen() {
  local src="$INTEGRATIONS/qwen/agents"
  local dest="${PWD}/.qwen/agents"
  local count=0

  [[ -d "$src" ]] || { err "integrations/qwen 不存在。请先运行 convert.sh"; return 1; }

  mkdir -p "$dest"

  local f
  while IFS= read -r -d '' f; do
    cp "$f" "$dest/"
    (( count++ )) || true
  done < <(find "$src" -maxdepth 1 -name "*.md" -print0)

  ok "Qwen Code: $count 个智能体 -> $dest"
  warn "Qwen Code: 项目级安装。请在项目根目录运行。"
  warn "提示: 在 Qwen Code 中运行 '/agents manage' 刷新，或重启会话"
}

install_tool() {
  case "$1" in
    claude-code) install_claude_code ;;
    copilot)     install_copilot     ;;
    antigravity) install_antigravity ;;
    gemini-cli)  install_gemini_cli  ;;
    opencode)    install_opencode    ;;
    openclaw)    install_openclaw    ;;
    cursor)      install_cursor      ;;
    aider)       install_aider       ;;
    windsurf)    install_windsurf    ;;
    qwen)        install_qwen        ;;
  esac
}

# --- 入口 ---
main() {
  local tool="all"

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --tool)            tool="${2:?'--tool 需要一个值'}"; shift 2 ;;
      --no-interactive)  shift ;;
      --help|-h)         usage ;;
      *)                 err "未知选项: $1"; usage ;;
    esac
  done

  check_integrations

  if [[ "$tool" != "all" ]]; then
    local valid=false t
    for t in "${ALL_TOOLS[@]}"; do [[ "$t" == "$tool" ]] && valid=true && break; done
    if ! $valid; then
      err "未知工具 '$tool'。可选: ${ALL_TOOLS[*]}"
      exit 1
    fi
  fi

  SELECTED_TOOLS=()

  if [[ "$tool" != "all" ]]; then
    SELECTED_TOOLS=("$tool")
  else
    header "AI 智能体专家团队 -- 扫描已安装的工具..."
    printf "\n"
    local t
    for t in "${ALL_TOOLS[@]}"; do
      if is_detected "$t" 2>/dev/null; then
        SELECTED_TOOLS+=("$t")
        printf "  ${C_GREEN}[*]${C_RESET}  %s  ${C_DIM}已检测到${C_RESET}\n" "$(tool_label "$t")"
      else
        printf "  ${C_DIM}[ ]  %s  未找到${C_RESET}\n" "$(tool_label "$t")"
      fi
    done
  fi

  if [[ ${#SELECTED_TOOLS[@]} -eq 0 ]]; then
    warn "未选择或检测到任何工具。"
    printf "\n"
    dim "  提示: 使用 --tool <名称> 强制安装指定工具。"
    dim "  可选: ${ALL_TOOLS[*]}"
    exit 0
  fi

  printf "\n"
  header "AI 智能体专家团队 -- 安装智能体"
  printf "  仓库:     %s\n" "$REPO_ROOT"
  printf "  安装到:   %s\n" "${SELECTED_TOOLS[*]}"
  printf "\n"

  local installed=0 t
  for t in "${SELECTED_TOOLS[@]}"; do
    install_tool "$t"
    (( installed++ )) || true
  done

  printf "\n"
  ok "完成！已安装 $installed 个工具。"
  printf "\n"
  dim "  运行 ./scripts/convert.sh 重新生成集成文件。"
  printf "\n"
}

main "$@"
