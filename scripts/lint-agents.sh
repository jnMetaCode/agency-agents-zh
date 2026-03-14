#!/usr/bin/env bash
#
# 验证智能体 Markdown 文件格式：
#   1. YAML frontmatter 必须包含 name、description、color（ERROR）
#   2. 推荐的 section 标题仅警告（WARN）
#   3. 文件必须有实质性内容
#
# 用法: ./scripts/lint-agents.sh [file ...]
#   不指定文件时扫描所有智能体目录。

set -euo pipefail

AGENT_DIRS=(
  design
  engineering
  game-development
  marketing
  paid-media
  product
  project-management
  testing
  support
  spatial-computing
  specialized
)

REQUIRED_FRONTMATTER=("name" "description" "color")

# 同时支持中英文 section 标题
RECOMMENDED_SECTIONS_PATTERNS=(
  "Identity|身份|记忆"
  "Core Mission|核心使命"
  "Critical Rules|关键规则"
)

errors=0
warnings=0

lint_file() {
  local file="$1"

  # 1. 检查 frontmatter 分隔符
  local first_line
  first_line=$(head -1 "$file")
  if [[ "$first_line" != "---" ]]; then
    echo "ERROR $file: 缺少 frontmatter 开头 ---"
    errors=$((errors + 1))
    return
  fi

  # 提取 frontmatter
  local frontmatter
  frontmatter=$(awk 'NR==1{next} /^---$/{exit} {print}' "$file")

  if [[ -z "$frontmatter" ]]; then
    echo "ERROR $file: frontmatter 为空或格式错误"
    errors=$((errors + 1))
    return
  fi

  # 2. 检查必需的 frontmatter 字段
  for field in "${REQUIRED_FRONTMATTER[@]}"; do
    if ! echo "$frontmatter" | grep -qE "^${field}:"; then
      echo "ERROR $file: 缺少 frontmatter 字段 '${field}'"
      errors=$((errors + 1))
    fi
  done

  # 3. 检查推荐的 section（仅警告）
  local body
  body=$(awk 'BEGIN{n=0} /^---$/{n++; next} n>=2{print}' "$file")

  for pattern in "${RECOMMENDED_SECTIONS_PATTERNS[@]}"; do
    if ! echo "$body" | grep -qiE "$pattern"; then
      echo "WARN  $file: 缺少推荐 section (匹配: $pattern)"
      warnings=$((warnings + 1))
    fi
  done

  # 4. 检查文件是否有实质性内容
  if [[ $(echo "$body" | wc -w) -lt 50 ]]; then
    echo "WARN  $file: 正文内容过少 (< 50 词)"
    warnings=$((warnings + 1))
  fi
}

# 收集待检查文件
files=()
if [[ $# -gt 0 ]]; then
  files=("$@")
else
  for dir in "${AGENT_DIRS[@]}"; do
    if [[ -d "$dir" ]]; then
      while IFS= read -r f; do
        files+=("$f")
      done < <(find "$dir" -name "*.md" -type f | sort)
    fi
  done
fi

if [[ ${#files[@]} -eq 0 ]]; then
  echo "未找到智能体文件。"
  exit 1
fi

echo "正在检查 ${#files[@]} 个智能体文件..."
echo ""

for file in "${files[@]}"; do
  lint_file "$file"
done

echo ""
echo "结果: ${errors} 个错误, ${warnings} 个警告 (共 ${#files[@]} 个文件)"

if [[ $errors -gt 0 ]]; then
  echo "未通过: 请修复以上错误。"
  exit 1
else
  echo "已通过"
  exit 0
fi
