# convert.ps1 — 将智能体 .md 文件转换为各工具专用格式（Windows 版）
#
# 读取所有智能体目录中的 .md 文件，输出到 integrations/<tool>/。
# 添加或修改智能体后运行此脚本重新生成集成文件。
#
# 用法：
#   .\scripts\convert.ps1 [-Tool <名称>] [-Out <目录>] [-Help]
#
# 支持的工具：
#   antigravity  — Antigravity skill 文件
#   gemini-cli   — Gemini CLI 扩展
#   opencode     — OpenCode agent 文件
#   cursor       — Cursor rule 文件
#   trae         — Trae rule 文件
#   aider        — 单文件 CONVENTIONS.md
#   windsurf     — 单文件 .windsurfrules
#   openclaw     — OpenClaw SOUL.md 文件
#   qwen         — Qwen Code SubAgent 文件
#   codex        — OpenAI Codex CLI agent 文件
#   deerflow     — DeerFlow 2.0 custom skill 文件
#   workbuddy    — WorkBuddy skill 文件
#   hermes       — Hermes Agent skill 文件
#   kiro         — Kiro agent .md 文件（带 YAML frontmatter）
#   all          — 所有工具（默认）

param(
    [string]$Tool = "all",
    [string]$Out = "",
    [switch]$Help
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# --- 路径 ---
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot  = Split-Path -Parent $ScriptDir
$OutDir    = if ($Out) { $Out } else { Join-Path $RepoRoot "integrations" }
$Today     = Get-Date -Format "yyyy-MM-dd"

$AgentDirs = @(
    "academic","design","engineering","finance","game-development","hr","legal",
    "marketing","paid-media","sales","product","project-management",
    "supply-chain","testing","support","spatial-computing","specialized"
)

$ValidTools = @("antigravity","gemini-cli","opencode","cursor","trae","aider",
                "windsurf","openclaw","qwen","codex","deerflow","workbuddy","hermes","kiro","all")

# --- 颜色输出 ---
function Write-OK   { param($msg) Write-Host "[OK]  $msg" -ForegroundColor Green }
function Write-Warn { param($msg) Write-Host "[!!]  $msg" -ForegroundColor Yellow }
function Write-Err  { param($msg) Write-Host "[ERR] $msg" -ForegroundColor Red }
function Write-Header { param($msg) Write-Host "`n$msg" -ForegroundColor White }

# --- 用法 ---
if ($Help) {
    Get-Content $MyInvocation.MyCommand.Path | Select-Object -Skip 2 -First 20 |
        ForEach-Object { $_ -replace '^# ?','' }
    exit 0
}

# --- Frontmatter 辅助 ---
function Get-Field {
    param([string]$Field, [string[]]$Lines)
    $inFm = 0
    foreach ($line in $Lines) {
        if ($line -eq "---") { $inFm++; continue }
        if ($inFm -eq 1 -and $line -match "^${Field}: (.+)$") {
            return $Matches[1]
        }
        if ($inFm -ge 2) { break }
    }
    return ""
}

function Get-Body {
    param([string[]]$Lines)
    $fmCount = 0
    $body = @()
    foreach ($line in $Lines) {
        if ($line -eq "---") { $fmCount++; continue }
        if ($fmCount -ge 2) { $body += $line }
    }
    return $body -join "`n"
}

function Get-Slug {
    param([string]$FilePath)
    return [System.IO.Path]::GetFileNameWithoutExtension($FilePath)
}

function Resolve-OpenCodeColor {
    param([string]$c)
    $map = @{
        "cyan"="00FFFF"; "blue"="3498DB"; "green"="2ECC71"; "red"="E74C3C"
        "purple"="9B59B6"; "orange"="F39C12"; "teal"="008080"; "indigo"="6366F1"
        "pink"="E84393"; "gold"="EAB308"; "amber"="F59E0B"; "neon-green"="10B981"
        "neon-cyan"="06B6D4"; "metallic-blue"="3B82F6"; "yellow"="EAB308"
        "violet"="8B5CF6"; "rose"="F43F5E"; "lime"="84CC16"; "gray"="6B7280"
        "fuchsia"="D946EF"
    }
    if ($map.ContainsKey($c)) { return "#" + $map[$c] }
    return $c
}

# --- 各工具转换器 ---

function Convert-Antigravity {
    param([string]$File, [string[]]$Lines)
    $name        = Get-Field "name" $Lines
    $description = Get-Field "description" $Lines
    $slug        = "agency-$(Get-Slug $File)"
    $body        = Get-Body $Lines
    $outDir      = Join-Path $OutDir "antigravity\$slug"
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    @"
---
name: $slug
description: $description
risk: low
source: community
date_added: '$Today'
---
$body
"@ | Set-Content -Path (Join-Path $outDir "SKILL.md") -Encoding UTF8
}

function Convert-GeminiCli {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $outDir      = Join-Path $OutDir "gemini-cli\skills\$slug"
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    @"
---
name: $slug
description: $description
---
$body
"@ | Set-Content -Path (Join-Path $outDir "SKILL.md") -Encoding UTF8
}

function Convert-OpenCode {
    param([string]$File, [string[]]$Lines)
    $name        = Get-Field "name" $Lines
    $description = Get-Field "description" $Lines
    $rawColor    = (Get-Field "color" $Lines).Trim('"')
    $color       = Resolve-OpenCodeColor $rawColor
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $agentsDir   = Join-Path $OutDir "opencode\agents"
    New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null
    @"
---
name: $name
description: $description
mode: subagent
color: "$color"
---
$body
"@ | Set-Content -Path (Join-Path $agentsDir "${slug}.md") -Encoding UTF8
}

function Convert-Cursor {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $rulesDir    = Join-Path $OutDir "cursor\rules"
    New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null
    @"
---
description: $description
globs: ""
alwaysApply: false
---
$body
"@ | Set-Content -Path (Join-Path $rulesDir "${slug}.mdc") -Encoding UTF8
}

function Convert-Trae {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $rulesDir    = Join-Path $OutDir "trae\rules"
    New-Item -ItemType Directory -Force -Path $rulesDir | Out-Null
    @"
---
description: $description
globs: ""
alwaysApply: false
---
$body
"@ | Set-Content -Path (Join-Path $rulesDir "${slug}.md") -Encoding UTF8
}

function Convert-OpenClaw {
    param([string]$File, [string[]]$Lines)
    $name        = Get-Field "name" $Lines
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $outDir      = Join-Path $OutDir "openclaw\$slug"
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null

    $soulLines   = @()
    $agentLines  = @()
    $target      = "agents"
    $section     = @()

    foreach ($line in ($body -split "`n")) {
        if ($line -match "^## ") {
            if ($section.Count -gt 0) {
                if ($target -eq "soul") { $soulLines  += $section }
                else                    { $agentLines += $section }
            }
            $section = @()
            $lower = $line.ToLower()
            if ($lower -match "identity|身份|记忆|communication|沟通|style|风格|critical.rule|关键规则|rules.you.must.follow") {
                $target = "soul"
            } else {
                $target = "agents"
            }
        }
        $section += $line
    }
    if ($section.Count -gt 0) {
        if ($target -eq "soul") { $soulLines  += $section }
        else                    { $agentLines += $section }
    }

    ($soulLines -join "`n") | Set-Content -Path (Join-Path $outDir "SOUL.md") -Encoding UTF8

    @"
# AGENTS.md - 工作空间规范

$($agentLines -join "`n")
"@ | Set-Content -Path (Join-Path $outDir "AGENTS.md") -Encoding UTF8

    "# $name`n$description" | Set-Content -Path (Join-Path $outDir "IDENTITY.md") -Encoding UTF8
}

function Convert-Qwen {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $tools       = Get-Field "tools" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $agentsDir   = Join-Path $OutDir "qwen\agents"
    New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null
    $toolsLine   = if ($tools) { "tools: $tools`n" } else { "" }
    @"
---
name: $slug
description: $description
${toolsLine}---
$body
"@ | Set-Content -Path (Join-Path $agentsDir "${slug}.md") -Encoding UTF8
}

function Convert-Codex {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $agentsDir   = Join-Path $OutDir "codex\agents"
    New-Item -ItemType Directory -Force -Path $agentsDir | Out-Null
    $escapedDesc = $description -replace '"','\"'
    $escapedBody = $body -replace '\\','\\' -replace '"""','\"\"\"'
    @"
name = "$slug"
description = "$escapedDesc"
developer_instructions = """
$escapedBody
"""
"@ | Set-Content -Path (Join-Path $agentsDir "${slug}.toml") -Encoding UTF8
}

function Convert-DeerFlow {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $outDir      = Join-Path $OutDir "deerflow\$slug"
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    @"
---
name: $slug
description: $description
---
$body
"@ | Set-Content -Path (Join-Path $outDir "SKILL.md") -Encoding UTF8
}

function Convert-WorkBuddy {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $outDir      = Join-Path $OutDir "workbuddy\$slug"
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    @"
---
name: $slug
description: $description
allowed-tools: Read Write Edit Bash Grep Glob
---
$body
"@ | Set-Content -Path (Join-Path $outDir "SKILL.md") -Encoding UTF8
}

function Convert-Hermes {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    # 从文件路径提取分类目录名
    $category    = Split-Path -Leaf (Split-Path -Parent $File)
    $outDir      = Join-Path $OutDir "hermes\$category\$slug"
    New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    @"
---
name: $slug
description: $description
version: 1.0.0
author: agency-agents-zh
license: MIT
metadata:
  hermes:
    tags: [$category]
---
$body
"@ | Set-Content -Path (Join-Path $outDir "SKILL.md") -Encoding UTF8
}

function Convert-Kiro {
    param([string]$File, [string[]]$Lines)
    $description = Get-Field "description" $Lines
    $slug        = Get-Slug $File
    $body        = Get-Body $Lines
    $kiroDir     = Join-Path $OutDir "kiro"
    New-Item -ItemType Directory -Force -Path $kiroDir | Out-Null
    # Kiro 自定义智能体格式：带 YAML frontmatter 的 .md 文件
    # 放置于 ~/.kiro/agents/<slug>.md
    # 参考：https://kiro.dev/docs/chat/subagents/
    @"
---
name: $slug
description: $description
---
$body
"@ | Set-Content -Path (Join-Path $kiroDir "${slug}.md") -Encoding UTF8
}

# --- Aider / Windsurf 累积 ---
$AiderContent    = "# AI 智能体专家团队 — Aider 约定文件`n# 由 scripts/convert.ps1 生成`n"
$WindsurfContent = "# AI 智能体专家团队 — Windsurf 规则文件`n# 由 scripts/convert.ps1 生成`n"

function Accumulate-Aider {
    param([string]$File, [string[]]$Lines)
    $script:AiderContent += "`n---`n`n## $(Get-Field 'name' $Lines)`n`n> $(Get-Field 'description' $Lines)`n`n$(Get-Body $Lines)`n"
}

function Accumulate-Windsurf {
    param([string]$File, [string[]]$Lines)
    $name = Get-Field "name" $Lines
    $desc = Get-Field "description" $Lines
    $body = Get-Body $Lines
    $script:WindsurfContent += "`n" + ("=" * 80) + "`n## $name`n$desc`n" + ("=" * 80) + "`n`n$body`n"
}

# --- 主循环 ---
function Run-Conversions {
    param([string]$ToolName)
    $count = 0
    foreach ($dir in $AgentDirs) {
        $dirPath = Join-Path $RepoRoot $dir
        if (-not (Test-Path $dirPath)) { continue }
        $files = Get-ChildItem -Path $dirPath -Filter "*.md" -Recurse
        foreach ($file in $files) {
            $filePath = $file.FullName
            $lines = Get-Content -Path $filePath -Encoding UTF8
            if ($lines.Count -eq 0 -or $lines[0] -ne "---") { continue }
            $name = Get-Field "name" $lines
            if (-not $name) { continue }
            switch ($ToolName) {
                "antigravity" { Convert-Antigravity $filePath $lines }
                "gemini-cli"  { Convert-GeminiCli  $filePath $lines }
                "opencode"    { Convert-OpenCode    $filePath $lines }
                "cursor"      { Convert-Cursor      $filePath $lines }
                "trae"        { Convert-Trae        $filePath $lines }
                "openclaw"    { Convert-OpenClaw    $filePath $lines }
                "qwen"        { Convert-Qwen        $filePath $lines }
                "codex"       { Convert-Codex       $filePath $lines }
                "deerflow"    { Convert-DeerFlow    $filePath $lines }
                "workbuddy"   { Convert-WorkBuddy   $filePath $lines }
                "hermes"      { Convert-Hermes      $filePath $lines }
                "kiro"        { Convert-Kiro        $filePath $lines }
                "aider"       { Accumulate-Aider    $filePath $lines }
                "windsurf"    { Accumulate-Windsurf $filePath $lines }
            }
            $count++
        }
    }
    return $count
}

# --- 入口 ---
if ($Tool -notin $ValidTools) {
    Write-Err "未知工具 '$Tool'。可选: $($ValidTools -join ', ')"
    exit 1
}

Write-Header "AI 智能体专家团队 -- 转换为工具专用格式"
Write-Host "  仓库:   $RepoRoot"
Write-Host "  输出:   $OutDir"
Write-Host "  工具:   $Tool"
Write-Host "  日期:   $Today"

$toolsToRun = if ($Tool -eq "all") { $ValidTools | Where-Object { $_ -ne "all" } } else { @($Tool) }

$total = 0
foreach ($t in $toolsToRun) {
    Write-Header "正在转换: $t"
    $count  = Run-Conversions $t
    $total += $count

    if ($t -eq "gemini-cli") {
        $gDir = Join-Path $OutDir "gemini-cli"
        New-Item -ItemType Directory -Force -Path $gDir | Out-Null
        '{"name":"agency-agents-zh","version":"1.0.0"}' |
            Set-Content -Path (Join-Path $gDir "gemini-extension.json") -Encoding UTF8
        Write-OK "已写入 gemini-extension.json"
    }
    Write-OK "已转换 $count 个智能体 ($t)"
}

if ($Tool -eq "all" -or $Tool -eq "aider") {
    $aiderDir = Join-Path $OutDir "aider"
    New-Item -ItemType Directory -Force -Path $aiderDir | Out-Null
    $AiderContent | Set-Content -Path (Join-Path $aiderDir "CONVENTIONS.md") -Encoding UTF8
    Write-OK "已写入 integrations/aider/CONVENTIONS.md"
}
if ($Tool -eq "all" -or $Tool -eq "windsurf") {
    $wsDir = Join-Path $OutDir "windsurf"
    New-Item -ItemType Directory -Force -Path $wsDir | Out-Null
    $WindsurfContent | Set-Content -Path (Join-Path $wsDir ".windsurfrules") -Encoding UTF8
    Write-OK "已写入 integrations/windsurf/.windsurfrules"
}

Write-Host ""
Write-OK "完成。共转换: $total"
