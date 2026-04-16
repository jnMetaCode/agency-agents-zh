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
#   trae         -- 复制到 .trae/rules/（当前目录）
#   aider        -- 复制 CONVENTIONS.md（当前目录）
#   windsurf     -- 复制 .windsurfrules（当前目录）
#   openclaw     -- 复制到 ~/.openclaw/agency-agents/
#   qwen         -- 复制 SubAgent 到 .qwen/agents/（项目级）
#   codex        -- 复制到 .codex/agents/（项目级）
#   deerflow     -- 复制到 DeerFlow custom skills 目录（Docker 项目级）
#   workbuddy    -- 复制到 ~/.workbuddy/skills/（全局）
#   hermes       -- 复制到 ~/.hermes/skills/（全局）
#   kiro         -- 复制到 ~/.kiro/agents/（全局）
#   all          -- 安装所有已检测到的工具（默认）
#
# Hermes 专属参数：
#   --category <名称>  只安装某一分类下的 skills，可重复传入多次。
#                      分类取 integrations/hermes/ 下的目录名，例如：
#                        --category marketing
#                        --category engineering --category design
#                      Discord 模式下 Hermes 会把每个 skill 注册为斜杠命令，
#                      总 JSON 超过 8000 字符会被 Discord API 拒绝 (error 50035)，
#                      若需要在 Discord 中使用建议按分类分批安装。

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

ALL_TOOLS=(claude-code copilot antigravity gemini-cli opencode openclaw cursor trae aider windsurf qwen codex deerflow workbuddy hermes kiro)

# --- 用法 ---
usage() {
  sed -n '3,26p' "$0" | sed 's/^# \{0,1\}//'
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
detect_copilot()      { command -v code >/dev/null 2>&1 || [[ -d "${HOME}/.github" ]] || [[ -d "${HOME}/.copilot" ]]; }
detect_antigravity()  { [[ -d "${HOME}/.gemini/antigravity/skills" ]]; }
detect_gemini_cli()   { command -v gemini >/dev/null 2>&1 || [[ -d "${HOME}/.gemini" ]]; }
detect_cursor()       { command -v cursor >/dev/null 2>&1 || [[ -d "${HOME}/.cursor" ]]; }
detect_trae()         { command -v trae >/dev/null 2>&1 || [[ -d "${HOME}/.trae" ]]; }
detect_opencode()     { command -v opencode >/dev/null 2>&1 || [[ -d "${HOME}/.config/opencode" ]]; }
detect_aider()        { command -v aider >/dev/null 2>&1; }
detect_openclaw()     { command -v openclaw >/dev/null 2>&1 || [[ -d "${HOME}/.openclaw" ]]; }
detect_windsurf()     { command -v windsurf >/dev/null 2>&1 || [[ -d "${HOME}/.codeium" ]]; }
detect_qwen()         { command -v qwen >/dev/null 2>&1 || [[ -d "${HOME}/.qwen" ]]; }
detect_codex()        { command -v codex >/dev/null 2>&1 || [[ -d "${HOME}/.codex" ]]; }
detect_deerflow()     { command -v deerflow >/dev/null 2>&1 || [[ -d "${HOME}/.deerflow" ]] || docker ps --format '{{.Names}}' 2>/dev/null | grep -q deerflow; }
detect_workbuddy()    { command -v workbuddy >/dev/null 2>&1 || [[ -d "${HOME}/.workbuddy" ]]; }
detect_hermes()       { command -v hermes >/dev/null 2>&1 || [[ -d "${HOME}/.hermes" ]]; }
detect_kiro()         { command -v kiro >/dev/null 2>&1 || command -v kiro-cli >/dev/null 2>&1 || [[ -d "${HOME}/.kiro" ]]; }

is_detected() {
  case "$1" in
    claude-code) detect_claude_code ;;
    copilot)     detect_copilot     ;;
    antigravity) detect_antigravity ;;
    gemini-cli)  detect_gemini_cli  ;;
    opencode)    detect_opencode    ;;
    openclaw)    detect_openclaw    ;;
    cursor)      detect_cursor      ;;
    trae)        detect_trae        ;;
    aider)       detect_aider       ;;
    windsurf)    detect_windsurf    ;;
    qwen)        detect_qwen        ;;
    codex)       detect_codex       ;;
    deerflow)    detect_deerflow    ;;
    workbuddy)   detect_workbuddy   ;;
    hermes)      detect_hermes      ;;
    kiro)        detect_kiro        ;;
    *)           return 1 ;;
  esac
}

tool_label() {
  case "$1" in
    claude-code) printf "%-14s  %s" "Claude Code"  "(~/.claude/agents)"     ;;
    copilot)     printf "%-14s  %s" "Copilot"      "(~/.github + ~/.copilot)" ;;
    antigravity) printf "%-14s  %s" "Antigravity"  "(~/.gemini/antigravity)" ;;
    gemini-cli)  printf "%-14s  %s" "Gemini CLI"   "(gemini 扩展)"          ;;
    opencode)    printf "%-14s  %s" "OpenCode"     "(opencode.ai)"          ;;
    openclaw)    printf "%-14s  %s" "OpenClaw"     "(~/.openclaw)"          ;;
    cursor)      printf "%-14s  %s" "Cursor"       "(.cursor/rules)"        ;;
    trae)        printf "%-14s  %s" "Trae"         "(.trae/rules)"          ;;
    aider)       printf "%-14s  %s" "Aider"        "(CONVENTIONS.md)"       ;;
    windsurf)    printf "%-14s  %s" "Windsurf"     "(.windsurfrules)"       ;;
    qwen)        printf "%-14s  %s" "Qwen Code"    "(~/.qwen/agents)"       ;;
    codex)       printf "%-14s  %s" "Codex CLI"    "(.codex/agents)"        ;;
    deerflow)    printf "%-14s  %s" "DeerFlow"     "(skills/custom)"        ;;
    workbuddy)   printf "%-14s  %s" "WorkBuddy"    "(~/.workbuddy/skills)"  ;;
    hermes)      printf "%-14s  %s" "Hermes Agent" "(~/.hermes/skills)"     ;;
    kiro)        printf "%-14s  %s" "Kiro"         "(~/.kiro/agents)"       ;;
  esac
}

# --- 安装器 ---

install_claude_code() {
  local dest="${HOME}/.claude/agents"
  local count=0
  mkdir -p "$dest"
  local dir f first_line
  for dir in academic design engineering finance game-development hr legal marketing paid-media sales product \
              project-management supply-chain testing support spatial-computing specialized; do
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
  local dest1="${HOME}/.github/agents"
  local dest2="${HOME}/.copilot/agents"
  local count=0
  mkdir -p "$dest1" "$dest2"
  local dir f first_line
  for dir in academic design engineering finance game-development hr legal marketing paid-media sales product \
              project-management supply-chain testing support spatial-computing specialized; do
    [[ -d "$REPO_ROOT/$dir" ]] || continue
    while IFS= read -r -d '' f; do
      first_line="$(head -1 "$f")"
      [[ "$first_line" == "---" ]] || continue
      cp "$f" "$dest1/"
      cp "$f" "$dest2/"
      (( count++ )) || true
    done < <(find "$REPO_ROOT/$dir" -name "*.md" -type f -print0)
  done
  ok "Copilot: $count 个智能体 -> $dest1 + $dest2"
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
  [[ -d "$src" ]] || { err "integrations/gemini-cli 不存在。请先运行 convert.sh --tool gemini-cli"; return 1; }
  [[ -f "$src/gemini-extension.json" ]] || { err "gemini-extension.json 缺失。请先运行 convert.sh --tool gemini-cli"; return 1; }
  [[ -d "$src/skills" ]] || { err "skills/ 目录缺失。请先运行 convert.sh --tool gemini-cli"; return 1; }
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
      # 跳过已注册的智能体，避免重复 add 导致阻塞（#34）
      if openclaw agents list 2>/dev/null | grep -q "$name"; then
        dim "  跳过已注册: $name"
      else
        # 超时 30s 防止命令挂起（macOS 兼容写法）
        if command -v timeout >/dev/null 2>&1; then
          timeout 30 openclaw agents add "$name" --workspace "$dest/$name" --non-interactive 2>/dev/null || true
        else
          openclaw agents add "$name" --workspace "$dest/$name" --non-interactive 2>/dev/null &
          local pid=$!
          ( sleep 30 && kill "$pid" 2>/dev/null ) &
          wait "$pid" 2>/dev/null || true
        fi
      fi
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

install_trae() {
  local src="$INTEGRATIONS/trae/rules"
  local dest="${PWD}/.trae/rules"
  local count=0
  [[ -d "$src" ]] || { err "integrations/trae 不存在。请先运行 convert.sh --tool trae"; return 1; }
  mkdir -p "$dest"
  local f
  while IFS= read -r -d '' f; do
    cp "$f" "$dest/"; (( count++ )) || true
  done < <(find "$src" -maxdepth 1 -name "*.md" -print0)
  ok "Trae: $count 个规则 -> $dest"
  warn "Trae: 项目级安装。请在项目根目录运行。"
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

install_codex() {
  local src="$INTEGRATIONS/codex/agents"
  local dest="${PWD}/.codex/agents"
  local count=0

  [[ -d "$src" ]] || { err "integrations/codex 不存在。请先运行 convert.sh --tool codex"; return 1; }

  mkdir -p "$dest"

  local f
  while IFS= read -r -d '' f; do
    cp "$f" "$dest/"
    (( count++ )) || true
  done < <(find "$src" -maxdepth 1 -name "*.toml" -print0)

  ok "Codex CLI: $count 个智能体 -> $dest"
  warn "Codex CLI: 项目级安装。请在项目根目录运行。"
}

install_deerflow() {
  local src="$INTEGRATIONS/deerflow"
  local dest="${DEERFLOW_SKILLS_DIR:-./skills/custom}"
  local count=0

  [[ -d "$src" ]] || { err "integrations/deerflow 不存在。请先运行 convert.sh --tool deerflow"; return 1; }

  mkdir -p "$dest"

  local d
  while IFS= read -r -d '' d; do
    local name; name="$(basename "$d")"
    [[ -f "$d/SKILL.md" ]] || continue
    mkdir -p "$dest/$name"
    cp "$d/SKILL.md" "$dest/$name/SKILL.md"
    (( count++ )) || true
  done < <(find "$src" -mindepth 1 -maxdepth 1 -type d -print0)

  ok "DeerFlow: $count 个 skills -> $dest"
  warn "DeerFlow: 默认安装到 ./skills/custom/。设置 DEERFLOW_SKILLS_DIR 可自定义路径。"
}

install_workbuddy() {
  local src="$INTEGRATIONS/workbuddy"
  local dest="${HOME}/.workbuddy/skills"
  local count=0

  [[ -d "$src" ]] || { err "integrations/workbuddy 不存在。请先运行 convert.sh --tool workbuddy"; return 1; }

  mkdir -p "$dest"

  local d
  while IFS= read -r -d '' d; do
    local name; name="$(basename "$d")"
    [[ -f "$d/SKILL.md" ]] || continue
    mkdir -p "$dest/$name"
    cp "$d/SKILL.md" "$dest/$name/SKILL.md"
    (( count++ )) || true
  done < <(find "$src" -mindepth 1 -maxdepth 1 -type d -print0)

  ok "WorkBuddy: $count 个 skills -> $dest"
}

install_hermes() {
  local src="$INTEGRATIONS/hermes"
  local dest="${HOME}/.hermes/skills"
  local count=0

  [[ -d "$src" ]] || { err "integrations/hermes 不存在。请先运行 convert.sh --tool hermes"; return 1; }

  # 若指定了 --category，只安装命中的分类；否则安装全部
  local filter_note=""
  if [[ ${#HERMES_CATEGORIES[@]} -gt 0 ]]; then
    local c
    for c in "${HERMES_CATEGORIES[@]}"; do
      [[ -d "$src/$c" ]] || { err "hermes 分类不存在: ${c}（可选: $(ls "$src" | tr '\n' ' ')）"; return 1; }
    done
    filter_note=" [分类: ${HERMES_CATEGORIES[*]}]"
  fi

  mkdir -p "$dest"

  # Hermes 保留两级目录结构：category/skill-name/SKILL.md
  local catdir
  while IFS= read -r -d '' catdir; do
    local catname; catname="$(basename "$catdir")"
    if [[ ${#HERMES_CATEGORIES[@]} -gt 0 ]]; then
      local matched=false c
      for c in "${HERMES_CATEGORIES[@]}"; do [[ "$c" == "$catname" ]] && matched=true && break; done
      $matched || continue
    fi
    local skilldir
    while IFS= read -r -d '' skilldir; do
      local skillname; skillname="$(basename "$skilldir")"
      [[ -f "$skilldir/SKILL.md" ]] || continue
      mkdir -p "$dest/$catname/$skillname"
      cp "$skilldir/SKILL.md" "$dest/$catname/$skillname/SKILL.md"
      (( count++ )) || true
    done < <(find "$catdir" -mindepth 1 -maxdepth 1 -type d -print0)
  done < <(find "$src" -mindepth 1 -maxdepth 1 -type d -print0)

  ok "Hermes Agent: $count 个 skills -> $dest$filter_note"
  if [[ ${#HERMES_CATEGORIES[@]} -eq 0 && $count -gt 80 ]]; then
    warn "Hermes Discord 模式对斜杠命令总长有 8000 字符上限（error 50035）。"
    warn "若要在 Discord 中使用，建议用 --category <名称> 按分类分批安装。"
  fi
}

install_kiro() {
  local src="$INTEGRATIONS/kiro"
  local dest="${HOME}/.kiro/agents"
  local count=0

  [[ -d "$src" ]] || { err "integrations/kiro 不存在。请先运行 convert.sh --tool kiro"; return 1; }

  mkdir -p "$dest/prompts"

  # 复制 JSON 配置文件
  local f
  while IFS= read -r -d '' f; do
    cp "$f" "$dest/"
    (( count++ )) || true
  done < <(find "$src" -maxdepth 1 -name "*.json" -print0)

  # 复制 prompt 文件
  if [[ -d "$src/prompts" ]]; then
    while IFS= read -r -d '' f; do
      cp "$f" "$dest/prompts/"
    done < <(find "$src/prompts" -maxdepth 1 -name "*.md" -print0)
  fi

  ok "Kiro: $count 个智能体 -> $dest"
  warn "提示: 在 Kiro 中使用 '/agent swap' 切换智能体"
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
    trae)        install_trae        ;;
    aider)       install_aider       ;;
    windsurf)    install_windsurf    ;;
    qwen)        install_qwen        ;;
    codex)       install_codex       ;;
    deerflow)    install_deerflow    ;;
    workbuddy)   install_workbuddy   ;;
    hermes)      install_hermes      ;;
    kiro)        install_kiro        ;;
  esac
}

# --- 入口 ---
main() {
  local tool="all"
  HERMES_CATEGORIES=()

  while [[ $# -gt 0 ]]; do
    case "$1" in
      --tool)            tool="${2:?'--tool 需要一个值'}"; shift 2 ;;
      --category)        HERMES_CATEGORIES+=("${2:?'--category 需要一个值'}"); shift 2 ;;
      --no-interactive)  shift ;;
      --help|-h)         usage ;;
      *)                 err "未知选项: $1"; usage ;;
    esac
  done

  if [[ ${#HERMES_CATEGORIES[@]} -gt 0 && "$tool" != "hermes" ]]; then
    warn "--category 仅对 --tool hermes 生效，已忽略。"
    HERMES_CATEGORIES=()
  fi

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
