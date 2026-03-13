#!/bin/bash

# =================================================================
# Agency-Agents-ZH to OpenClaw Migration Script (Grouped & Synergy)
# =================================================================

SOURCE_DIR=$(pwd)
TARGET_BASE="$HOME/.openclaw/agents"
WORKSPACE_BASE="$HOME/.openclaw/workspace"

echo "🚀 Starting migration to OpenClaw..."

# Files to skip (main docs and strategy guides) - using exact agent IDs (filenames without .md)
SKIP_FILES=("README" "LICENSE" "CONTRIBUTING" "UPSTREAM" "AUDIT_REPORT" "QUICKSTART" "EXECUTIVE-BRIEF" "nexus-strategy")

# Optional clean step
if [[ "$1" == "--clean" ]]; then
    echo "🧹 Cleaning up existing project agents..."
fi

# 1. Collect all agents and their categories
declare -A CATEGORIES
declare -A AGENTS_BY_CAT
AGENTS_LIST=()

while read -r filepath; do
    filename=$(basename "$filepath" .md)
    
    # Skip major documentation files
    skip=false
    for s in "${SKIP_FILES[@]}"; do
        if [[ "$filename" == "$s" ]]; then
            skip=true
            break
        fi
    done
    [ "$skip" = true ] && continue

    # Category is the parent directory
    category=$(dirname "$filepath" | sed 's/^\.\///')
    [ "$category" == "." ] && category="general"
    
    CATEGORIES["$filename"]="$category"
    AGENTS_BY_CAT["$category"]+="$filename "
    AGENTS_LIST+=("$filename")
done < <(find . -maxdepth 2 -name "*.md")

# 2. Register Agents in grouped directories
count=0
for agent_id in "${AGENTS_LIST[@]}"; do
    category=${CATEGORIES[$agent_id]}
    filepath=$(find "$category" -maxdepth 1 -name "$agent_id.md" | head -n 1)
    [ -z "$filepath" ] && filepath=$(find . -maxdepth 1 -name "$agent_id.md" | head -n 1)

    agent_dir="$TARGET_BASE/$category/$agent_id/agent"
    workspace_dir="$WORKSPACE_BASE/$category/$agent_id"
    
    if [[ "$1" == "--clean" ]]; then
        echo "🗑️ Deleting: $agent_id..."
        openclaw agents delete "$agent_id" --force > /dev/null 2>&1
        continue
    fi

    # Extract name from frontmatter if possible
    agent_name=$(grep "^name: " "$filepath" | head -n 1 | sed 's/^name: //;s/"//g;s/'"'"'//g')
    [ -z "$agent_name" ] && agent_name="$agent_id"

    echo "⚙️ Registering: $agent_id ($agent_name) in group [$category]..."
    
    # Register with OpenClaw
    openclaw agents delete "$agent_id" --force > /dev/null 2>&1
    
    openclaw agents add "$agent_id" \
        --non-interactive \
        --workspace "$workspace_dir" \
        --agent-dir "$agent_dir" > /dev/null 2>&1
    
    # Deploy Identity
    mkdir -p "$workspace_dir"
    cp "$filepath" "$workspace_dir/IDENTITY.md"

    # Set identity name
    openclaw agents set-identity --agent "$agent_id" --name "$agent_name" > /dev/null 2>&1
    
    echo "✅ Deployed: $agent_id"
    ((count++))
done

# 3. Configure Synergy (Sub-Agents within same category)
if [[ "$1" != "--clean" ]]; then
    echo "🔗 Configuring team synergy (sub-agents)..."
    for category in "${!AGENTS_BY_CAT[@]}"; do
        [ "$category" == "general" ] && continue
        
        group_agents=(${AGENTS_BY_CAT[$category]})
        for agent_id in "${group_agents[@]}"; do
            workspace_dir="$WORKSPACE_BASE/$category/$agent_id"
            
            # Create sub-agents list
            sub_agents_entries=""
            for sa in "${group_agents[@]}"; do
                if [[ "$sa" != "$agent_id" ]]; then
                    sub_agents_entries+="      \"$sa\": { \"enabled\": true },\n"
                fi
            done
            sub_agents_entries=$(echo -e "$sub_agents_entries" | sed '$ s/,$//') # remove last comma
            
            # Create moltbot.json for local sub-agent config
            cat > "$workspace_dir/moltbot.json" <<EOF
{
  "agents": {
    "subagents": {
      "enabled": true,
      "entries": {
$sub_agents_entries
      }
    }
  }
}
EOF
        done
    done
fi

if [[ "$1" == "--clean" ]]; then
    echo "✨ Project agents cleaned up."
else
    echo ""
    echo "🎉 Successfully deployed $count agents with physical grouping and team synergy."
    echo "🔍 Try running: openclaw agents list"
fi
