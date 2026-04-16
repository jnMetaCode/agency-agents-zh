# install.ps1 — 将智能体安装到本地 AI 工具中（Windows 版）
#
# 读取 integrations/ 中的转换文件，复制到各工具的配置目录。
# 请先运行 scripts\convert.ps1 生成集成文件。
#
# 用法：
#   .\scripts\install.ps1 [-Tool <名称>] [-Help]
#
# 支持的工具：
#   claude-code  — 复制到 %USERPROFILE%\.claude\agents\
#   copilot      — 复制到 %USERPROFILE%\.github\agents\ 和 .copilot\agents\
#   antigravity  — 复制到 %USERPROFILE%\.gemini\antigravity\skills\
#   gemini-cli   — 安装到 %USERPROFILE%\.gemini\extensions\agency-agents\
#   opencode     — 复制到 .opencode\agents\（当前目录）
#   cursor       — 复制到 .cursor\rules\（当前目录）
#   trae         — 复制到 .trae\rules\（当前目录）
#   aider        — 复制 CONVENTIONS.md（当前目录）
#   windsurf     — 复制 .windsurfrules（当前目录）
#   openclaw     — 复制到 %USERPROFILE%\.openclaw\agency-agents\
#   qwen         — 复制到 .qwen\agents\（项目级）
#   codex        — 复制到 .codex\agents\（项目级）
#   deerflow     — 复制到 DeerFlow custom skills 目录（项目级）
#   workbuddy    — 复制到 %USERPROFILE%\.workbuddy\skills\（全局）
#   hermes       — 复制到 %USERPROFILE%\.hermes\skills\（全局）
#   kiro         — 复制到 %USERPROFILE%\.kiro\agents\（全局）
#   all          — 安装所有已检测到的工具（默认）
#
# Hermes 专属参数：
#   -Category <名称[,名称...]>  只安装某一分类下的 skills，可传多个分类。
#                                Discord 模式下 Hermes 会把每个 skill 注册为斜杠命令，
#                                总 JSON 超过 8000 字符会被 Discord API 拒绝 (error 50035)，
#                                若需要在 Discord 中使用建议按分类分批安装。

param(
    [string]$Tool = "all",
    [string[]]$Category = @(),
    [switch]$Help
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# --- 路径 ---
$ScriptDir    = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot     = Split-Path -Parent $ScriptDir
$Integrations = Join-Path $RepoRoot "integrations"
$Home_        = $env:USERPROFILE

$AllTools = @(
    "claude-code","copilot","antigravity","gemini-cli","opencode","openclaw",
    "cursor","trae","aider","windsurf","qwen","codex","deerflow","workbuddy","hermes","kiro"
)

# --- 颜色输出 ---
function Write-OK     { param($msg) Write-Host "[OK]  $msg" -ForegroundColor Green }
function Write-Warn   { param($msg) Write-Host "[!!]  $msg" -ForegroundColor Yellow }
function Write-Err    { param($msg) Write-Host "[ERR] $msg" -ForegroundColor Red }
function Write-Header { param($msg) Write-Host "`n$msg" -ForegroundColor White }
function Write-Dim    { param($msg) Write-Host "      $msg" -ForegroundColor DarkGray }

# --- 用法 ---
if ($Help) {
    Get-Content $MyInvocation.MyCommand.Path | Select-Object -Skip 2 -First 22 |
        ForEach-Object { $_ -replace '^# ?','' }
    exit 0
}

# --- 检测 integrations/ ---
function Check-Integrations {
    if (-not (Test-Path $Integrations)) {
        Write-Err "integrations\ 不存在。请先运行 .\scripts\convert.ps1"
        exit 1
    }
}

# --- 工具检测 ---
function Detect-Tool {
    param([string]$ToolName)
    switch ($ToolName) {
        "claude-code" { Test-Path (Join-Path $Home_ ".claude") }
        "copilot"     { (Get-Command code -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".github")) -or
                        (Test-Path (Join-Path $Home_ ".copilot")) }
        "antigravity" { Test-Path (Join-Path $Home_ ".gemini\antigravity\skills") }
        "gemini-cli"  { (Get-Command gemini -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".gemini")) }
        "opencode"    { (Get-Command opencode -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".config\opencode")) }
        "cursor"      { (Get-Command cursor -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".cursor")) }
        "trae"        { (Get-Command trae -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".trae")) }
        "aider"       { Get-Command aider -ErrorAction SilentlyContinue }
        "windsurf"    { (Get-Command windsurf -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".codeium")) }
        "openclaw"    { (Get-Command openclaw -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".openclaw")) }
        "qwen"        { (Get-Command qwen -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".qwen")) }
        "codex"       { Get-Command codex -ErrorAction SilentlyContinue }
        "deerflow"    { (Get-Command deerflow -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".deerflow")) }
        "workbuddy"   { (Get-Command workbuddy -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".workbuddy")) }
        "hermes"      { (Get-Command hermes -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".hermes")) }
        "kiro"        { (Get-Command kiro -ErrorAction SilentlyContinue) -or
                        (Get-Command kiro-cli -ErrorAction SilentlyContinue) -or
                        (Test-Path (Join-Path $Home_ ".kiro")) }
        default       { $false }
    }
}

function Get-ToolLabel {
    param([string]$ToolName)
    switch ($ToolName) {
        "claude-code" { "Claude Code    (%USERPROFILE%\.claude\agents)" }
        "copilot"     { "Copilot        (%USERPROFILE%\.github + .copilot)" }
        "antigravity" { "Antigravity    (%USERPROFILE%\.gemini\antigravity)" }
        "gemini-cli"  { "Gemini CLI     (gemini 扩展)" }
        "opencode"    { "OpenCode       (.opencode\agents)" }
        "openclaw"    { "OpenClaw       (%USERPROFILE%\.openclaw)" }
        "cursor"      { "Cursor         (.cursor\rules)" }
        "trae"        { "Trae           (.trae\rules)" }
        "aider"       { "Aider          (CONVENTIONS.md)" }
        "windsurf"    { "Windsurf       (.windsurfrules)" }
        "qwen"        { "Qwen Code      (.qwen\agents)" }
        "codex"       { "Codex CLI      (.codex\agents)" }
        "deerflow"    { "DeerFlow       (skills\custom)" }
        "workbuddy"   { "WorkBuddy      (%USERPROFILE%\.workbuddy\skills)" }
        "hermes"      { "Hermes Agent   (%USERPROFILE%\.hermes\skills)" }
        "kiro"        { "Kiro           (%USERPROFILE%\.kiro\agents)" }
        default       { $ToolName }
    }
}

# --- 安装器 ---

function Install-ClaudeCode {
    $dest = Join-Path $Home_ ".claude\agents"
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    $count = 0
    foreach ($dir in @("academic","design","engineering","finance","game-development","hr","legal",
                        "marketing","paid-media","sales","product","project-management",
                        "supply-chain","testing","support","spatial-computing","specialized")) {
        $dirPath = Join-Path $RepoRoot $dir
        if (-not (Test-Path $dirPath)) { continue }
        Get-ChildItem -Path $dirPath -Filter "*.md" -Recurse | ForEach-Object {
            $firstLine = Get-Content $_.FullName -TotalCount 1
            if ($firstLine -eq "---") { Copy-Item $_.FullName -Destination $dest; $count++ }
        }
    }
    Write-OK "Claude Code: $count 个智能体 -> $dest"
}

function Install-Copilot {
    $dest1 = Join-Path $Home_ ".github\agents"
    $dest2 = Join-Path $Home_ ".copilot\agents"
    New-Item -ItemType Directory -Force -Path $dest1 | Out-Null
    New-Item -ItemType Directory -Force -Path $dest2 | Out-Null
    $count = 0
    foreach ($dir in @("academic","design","engineering","finance","game-development","hr","legal",
                        "marketing","paid-media","sales","product","project-management",
                        "supply-chain","testing","support","spatial-computing","specialized")) {
        $dirPath = Join-Path $RepoRoot $dir
        if (-not (Test-Path $dirPath)) { continue }
        Get-ChildItem -Path $dirPath -Filter "*.md" -Recurse | ForEach-Object {
            $firstLine = Get-Content $_.FullName -TotalCount 1
            if ($firstLine -eq "---") {
                Copy-Item $_.FullName -Destination $dest1
                Copy-Item $_.FullName -Destination $dest2
                $count++
            }
        }
    }
    Write-OK "Copilot: $count 个智能体 -> $dest1 + $dest2"
}

function Install-Antigravity {
    $src  = Join-Path $Integrations "antigravity"
    $dest = Join-Path $Home_ ".gemini\antigravity\skills"
    if (-not (Test-Path $src)) { Write-Err "integrations\antigravity 不存在，请先运行 convert.ps1"; return }
    $count = 0
    Get-ChildItem -Path $src -Directory | ForEach-Object {
        $skillDest = Join-Path $dest $_.Name
        New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
        Copy-Item (Join-Path $_.FullName "SKILL.md") -Destination $skillDest
        $count++
    }
    Write-OK "Antigravity: $count 个 skills -> $dest"
}

function Install-GeminiCli {
    $src  = Join-Path $Integrations "gemini-cli"
    $dest = Join-Path $Home_ ".gemini\extensions\agency-agents"
    if (-not (Test-Path $src)) { Write-Err "integrations\gemini-cli 不存在，请先运行 convert.ps1"; return }
    New-Item -ItemType Directory -Force -Path (Join-Path $dest "skills") | Out-Null
    Copy-Item (Join-Path $src "gemini-extension.json") -Destination $dest
    $count = 0
    Get-ChildItem -Path (Join-Path $src "skills") -Directory | ForEach-Object {
        $skillDest = Join-Path $dest "skills" $_.Name
        New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
        Copy-Item (Join-Path $_.FullName "SKILL.md") -Destination $skillDest
        $count++
    }
    Write-OK "Gemini CLI: $count 个 skills -> $dest"
}

function Install-OpenCode {
    $src  = Join-Path $Integrations "opencode\agents"
    $dest = Join-Path (Get-Location) ".opencode\agents"
    if (-not (Test-Path $src)) { Write-Err "integrations\opencode 不存在，请先运行 convert.ps1"; return }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    $count = (Get-ChildItem -Path $src -Filter "*.md" | ForEach-Object { Copy-Item $_.FullName -Destination $dest; 1 } | Measure-Object -Sum).Sum
    Write-OK "OpenCode: $count 个智能体 -> $dest"
    Write-Warn "OpenCode: 项目级安装，请在项目根目录运行。"
}

function Install-OpenClaw {
    $src  = Join-Path $Integrations "openclaw"
    $dest = Join-Path $Home_ ".openclaw\agency-agents"
    if (-not (Test-Path $src)) { Write-Err "integrations\openclaw 不存在，请先运行 convert.ps1"; return }
    $count = 0
    Get-ChildItem -Path $src -Directory | ForEach-Object {
        $wsDest = Join-Path $dest $_.Name
        New-Item -ItemType Directory -Force -Path $wsDest | Out-Null
        Copy-Item (Join-Path $_.FullName "SOUL.md")     -Destination $wsDest
        Copy-Item (Join-Path $_.FullName "AGENTS.md")   -Destination $wsDest
        Copy-Item (Join-Path $_.FullName "IDENTITY.md") -Destination $wsDest
        # 注册到 openclaw（如果可用）
        if (Get-Command openclaw -ErrorAction SilentlyContinue) {
            $existing = & openclaw agents list 2>$null
            if ($existing -notmatch $_.Name) {
                & openclaw agents add $_.Name --workspace $wsDest --non-interactive 2>$null
            } else {
                Write-Dim "跳过已注册: $($_.Name)"
            }
        }
        $count++
    }
    Write-OK "OpenClaw: $count 个工作空间 -> $dest"
    if (Get-Command openclaw -ErrorAction SilentlyContinue) {
        Write-Warn "OpenClaw: 运行 'openclaw gateway restart' 激活新智能体"
    }
}

function Install-Cursor {
    $src  = Join-Path $Integrations "cursor\rules"
    $dest = Join-Path (Get-Location) ".cursor\rules"
    if (-not (Test-Path $src)) { Write-Err "integrations\cursor 不存在，请先运行 convert.ps1"; return }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    $count = (Get-ChildItem -Path $src -Filter "*.mdc" | ForEach-Object { Copy-Item $_.FullName -Destination $dest; 1 } | Measure-Object -Sum).Sum
    Write-OK "Cursor: $count 个规则 -> $dest"
    Write-Warn "Cursor: 项目级安装，请在项目根目录运行。"
}

function Install-Trae {
    $src  = Join-Path $Integrations "trae\rules"
    $dest = Join-Path (Get-Location) ".trae\rules"
    if (-not (Test-Path $src)) { Write-Err "integrations\trae 不存在，请先运行 convert.ps1"; return }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    $count = (Get-ChildItem -Path $src -Filter "*.md" | ForEach-Object { Copy-Item $_.FullName -Destination $dest; 1 } | Measure-Object -Sum).Sum
    Write-OK "Trae: $count 个规则 -> $dest"
    Write-Warn "Trae: 项目级安装，请在项目根目录运行。"
}

function Install-Aider {
    $src  = Join-Path $Integrations "aider\CONVENTIONS.md"
    $dest = Join-Path (Get-Location) "CONVENTIONS.md"
    if (-not (Test-Path $src)) { Write-Err "integrations\aider\CONVENTIONS.md 不存在，请先运行 convert.ps1"; return }
    if (Test-Path $dest) { Write-Warn "Aider: CONVENTIONS.md 已存在，删除后重试。"; return }
    Copy-Item $src -Destination $dest
    Write-OK "Aider: 已安装 -> $dest"
    Write-Warn "Aider: 项目级安装，请在项目根目录运行。"
}

function Install-Windsurf {
    $src  = Join-Path $Integrations "windsurf\.windsurfrules"
    $dest = Join-Path (Get-Location) ".windsurfrules"
    if (-not (Test-Path $src)) { Write-Err "integrations\windsurf\.windsurfrules 不存在，请先运行 convert.ps1"; return }
    if (Test-Path $dest) { Write-Warn "Windsurf: .windsurfrules 已存在，删除后重试。"; return }
    Copy-Item $src -Destination $dest
    Write-OK "Windsurf: 已安装 -> $dest"
    Write-Warn "Windsurf: 项目级安装，请在项目根目录运行。"
}

function Install-Qwen {
    $src  = Join-Path $Integrations "qwen\agents"
    $dest = Join-Path (Get-Location) ".qwen\agents"
    if (-not (Test-Path $src)) { Write-Err "integrations\qwen 不存在，请先运行 convert.ps1"; return }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    $count = (Get-ChildItem -Path $src -Filter "*.md" | ForEach-Object { Copy-Item $_.FullName -Destination $dest; 1 } | Measure-Object -Sum).Sum
    Write-OK "Qwen Code: $count 个智能体 -> $dest"
    Write-Warn "Qwen Code: 项目级安装，请在项目根目录运行。"
}

function Install-Codex {
    $src  = Join-Path $Integrations "codex\agents"
    $dest = Join-Path (Get-Location) ".codex\agents"
    if (-not (Test-Path $src)) { Write-Err "integrations\codex 不存在，请先运行 convert.ps1"; return }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    $count = (Get-ChildItem -Path $src -Filter "*.toml" | ForEach-Object { Copy-Item $_.FullName -Destination $dest; 1 } | Measure-Object -Sum).Sum
    Write-OK "Codex CLI: $count 个智能体 -> $dest"
    Write-Warn "Codex CLI: 项目级安装，请在项目根目录运行。"
}

function Install-DeerFlow {
    $src  = Join-Path $Integrations "deerflow"
    $dest = if ($env:DEERFLOW_SKILLS_DIR) { $env:DEERFLOW_SKILLS_DIR } else { Join-Path (Get-Location) "skills\custom" }
    if (-not (Test-Path $src)) { Write-Err "integrations\deerflow 不存在，请先运行 convert.ps1"; return }
    $count = 0
    Get-ChildItem -Path $src -Directory | ForEach-Object {
        $skillFile = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $skillFile) {
            $skillDest = Join-Path $dest $_.Name
            New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
            Copy-Item $skillFile -Destination $skillDest
            $count++
        }
    }
    Write-OK "DeerFlow: $count 个 skills -> $dest"
    Write-Warn "DeerFlow: 设置 `$env:DEERFLOW_SKILLS_DIR 可自定义路径。"
}

function Install-WorkBuddy {
    $src  = Join-Path $Integrations "workbuddy"
    $dest = Join-Path $Home_ ".workbuddy\skills"
    if (-not (Test-Path $src)) { Write-Err "integrations\workbuddy 不存在，请先运行 convert.ps1 -Tool workbuddy"; return }
    $count = 0
    Get-ChildItem -Path $src -Directory | ForEach-Object {
        $skillFile = Join-Path $_.FullName "SKILL.md"
        if (Test-Path $skillFile) {
            $skillDest = Join-Path $dest $_.Name
            New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
            Copy-Item $skillFile -Destination $skillDest
            $count++
        }
    }
    Write-OK "WorkBuddy: $count 个 skills -> $dest"
}

function Install-Hermes {
    $src  = Join-Path $Integrations "hermes"
    $dest = Join-Path $Home_ ".hermes\skills"
    if (-not (Test-Path $src)) { Write-Err "integrations\hermes 不存在，请先运行 convert.ps1 -Tool hermes"; return }

    $filterNote = ""
    if ($Category.Count -gt 0) {
        foreach ($c in $Category) {
            if (-not (Test-Path (Join-Path $src $c))) {
                $avail = (Get-ChildItem -Path $src -Directory | ForEach-Object Name) -join ", "
                Write-Err "hermes 分类不存在: $c（可选: $avail）"
                return
            }
        }
        $filterNote = " [分类: $($Category -join ', ')]"
    }

    $count = 0
    # 保留两级目录结构：category/skill-name/SKILL.md
    Get-ChildItem -Path $src -Directory | ForEach-Object {
        $catName = $_.Name
        if ($Category.Count -gt 0 -and ($Category -notcontains $catName)) { return }
        Get-ChildItem -Path $_.FullName -Directory | ForEach-Object {
            $skillFile = Join-Path $_.FullName "SKILL.md"
            if (Test-Path $skillFile) {
                $skillDest = Join-Path $dest "$catName\$($_.Name)"
                New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
                Copy-Item $skillFile -Destination $skillDest
                $count++
            }
        }
    }
    Write-OK "Hermes Agent: $count 个 skills -> $dest$filterNote"
    if ($Category.Count -eq 0 -and $count -gt 80) {
        Write-Warn "Hermes Discord 模式对斜杠命令总长有 8000 字符上限（error 50035）。"
        Write-Warn "若要在 Discord 中使用，建议用 -Category <名称> 按分类分批安装。"
    }
}

function Install-Kiro {
    $src  = Join-Path $Integrations "kiro"
    $dest = Join-Path $Home_ ".kiro\agents"
    if (-not (Test-Path $src)) { Write-Err "integrations\kiro 不存在，请先运行 convert.ps1"; return }
    New-Item -ItemType Directory -Force -Path (Join-Path $dest "prompts") | Out-Null
    $count = (Get-ChildItem -Path $src -Filter "*.json" | ForEach-Object { Copy-Item $_.FullName -Destination $dest; 1 } | Measure-Object -Sum).Sum
    if (Test-Path (Join-Path $src "prompts")) {
        Get-ChildItem -Path (Join-Path $src "prompts") -Filter "*.md" |
            ForEach-Object { Copy-Item $_.FullName -Destination (Join-Path $dest "prompts") }
    }
    Write-OK "Kiro: $count 个智能体 -> $dest"
    Write-Warn "提示: 在 Kiro 中使用 '/agent swap' 切换智能体"
}

function Install-Tool {
    param([string]$ToolName)
    switch ($ToolName) {
        "claude-code" { Install-ClaudeCode }
        "copilot"     { Install-Copilot    }
        "antigravity" { Install-Antigravity }
        "gemini-cli"  { Install-GeminiCli  }
        "opencode"    { Install-OpenCode   }
        "openclaw"    { Install-OpenClaw   }
        "cursor"      { Install-Cursor     }
        "trae"        { Install-Trae       }
        "aider"       { Install-Aider      }
        "windsurf"    { Install-Windsurf   }
        "qwen"        { Install-Qwen       }
        "codex"       { Install-Codex      }
        "deerflow"    { Install-DeerFlow   }
        "workbuddy"   { Install-WorkBuddy  }
        "hermes"      { Install-Hermes     }
        "kiro"        { Install-Kiro       }
    }
}

# --- 入口 ---
Check-Integrations

if ($Category.Count -gt 0 -and $Tool -ne "hermes") {
    Write-Warn "-Category 仅对 -Tool hermes 生效，已忽略。"
    $Category = @()
}

$selectedTools = @()

if ($Tool -ne "all") {
    if ($Tool -notin $AllTools) {
        Write-Err "未知工具 '$Tool'。可选: $($AllTools -join ', ')"
        exit 1
    }
    $selectedTools = @($Tool)
} else {
    Write-Header "AI 智能体专家团队 -- 扫描已安装的工具..."
    Write-Host ""
    foreach ($t in $AllTools) {
        if (Detect-Tool $t) {
            $selectedTools += $t
            Write-Host "  [*]  $(Get-ToolLabel $t)  已检测到" -ForegroundColor Green
        } else {
            Write-Host "  [ ]  $(Get-ToolLabel $t)  未找到" -ForegroundColor DarkGray
        }
    }
}

if ($selectedTools.Count -eq 0) {
    Write-Warn "未选择或检测到任何工具。"
    Write-Dim "提示: 使用 -Tool <名称> 强制安装指定工具。"
    Write-Dim "可选: $($AllTools -join ', ')"
    exit 0
}

Write-Host ""
Write-Header "AI 智能体专家团队 -- 安装智能体"
Write-Host "  仓库:     $RepoRoot"
Write-Host "  安装到:   $($selectedTools -join ', ')"
Write-Host ""

foreach ($t in $selectedTools) {
    Install-Tool $t
}

Write-Host ""
Write-OK "完成！已安装 $($selectedTools.Count) 个工具。"
Write-Host ""
Write-Dim "运行 .\scripts\convert.ps1 重新生成集成文件。"
Write-Host ""
