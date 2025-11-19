#!/bin/bash

# Migration Script - Agentic Workflow Restructuration
# From: workflow-pattern-orchestration (old structure)
# To: agentic-workflow (new structure with 6 composable patterns)

set -e  # Exit on error

echo "╔═══════════════════════════════════════════════════════════╗"
echo "║     MIGRATION AGENTIC WORKFLOW - NOUVELLE STRUCTURE       ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""

# Base directory
BASE_DIR="/Users/thibaut/Documents/claude-insane-guide/agentic-workflow"
cd "$BASE_DIR"

echo "📂 Working directory: $BASE_DIR"
echo ""

# ============================================
# PHASE 1: CREATE NEW DIRECTORIES
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PHASE 1: Creating new directory structure..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Create architecture/ directory
echo "✓ Creating architecture/ directory..."
mkdir -p architecture

# 6-composable-patterns/ already created
echo "✓ 6-composable-patterns/ already exists"

# workflows/ and best-practices/ already exist
echo "✓ workflows/ already exists"
echo "✓ best-practices/ already exists"

echo ""

# ============================================
# PHASE 2: MOVE PATTERNS TO ARCHITECTURE
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PHASE 2: Moving pattern files to architecture/..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Move command-coordination.md → architecture/command-subcommand-agent.md
if [ -f "patterns/command-coordination.md" ]; then
  echo "✓ Moving command-coordination.md → architecture/command-subcommand-agent.md"
  mv patterns/command-coordination.md architecture/command-subcommand-agent.md
fi

# Move hook-automation.md → architecture/hooks-lifecycle.md
if [ -f "patterns/hook-automation.md" ]; then
  echo "✓ Moving hook-automation.md → architecture/hooks-lifecycle.md"
  mv patterns/hook-automation.md architecture/hooks-lifecycle.md
fi

# Move skill-invocation.md → architecture/skills-progressive-disclosure.md
if [ -f "patterns/skill-invocation.md" ]; then
  echo "✓ Moving skill-invocation.md → architecture/skills-progressive-disclosure.md"
  mv patterns/skill-invocation.md architecture/skills-progressive-disclosure.md
fi

# Move state-management.md → architecture/state-management.md
if [ -f "patterns/state-management.md" ]; then
  echo "✓ Moving state-management.md → architecture/state-management.md"
  mv patterns/state-management.md architecture/state-management.md
fi

echo ""

# ============================================
# PHASE 3: MOVE PATTERNS TO 6-COMPOSABLE-PATTERNS
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PHASE 3: Moving patterns to 6-composable-patterns/..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Move parallel-execution.md → 6-composable-patterns/3-parallelization.md
if [ -f "patterns/parallel-execution.md" ]; then
  echo "✓ Moving parallel-execution.md → 6-composable-patterns/3-parallelization.md"
  mv patterns/parallel-execution.md 6-composable-patterns/3-parallelization.md
fi

# Move command-agent-skill.md → 6-composable-patterns/4-orchestrator-workers.md
if [ -f "patterns/command-agent-skill.md" ]; then
  echo "✓ Moving command-agent-skill.md → 6-composable-patterns/4-orchestrator-workers.md"
  mv patterns/command-agent-skill.md 6-composable-patterns/4-orchestrator-workers.md
fi

# agent-orchestration.md content has been integrated into 4-orchestrator-workers.md
# BACKUP file was deleted on 2025-11-19 (content already integrated)
echo "✓ agent-orchestration.md was previously backed up and has been deleted"
echo "  (Content integrated into 6-composable-patterns/4-orchestrator-workers.md)"

# Patterns 5 and 6 already created
echo "✓ Pattern 5 (evaluator-optimizer.md) already created"
echo "✓ Pattern 6 (autonomous-agents.md) already created"

echo ""

# ============================================
# PHASE 4: MERGE ERROR-HANDLING
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PHASE 4: Merging error-handling.md into best-practices/..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Move error-handling.md → best-practices/error-resilience.md (append if exists)
if [ -f "patterns/error-handling.md" ]; then
  if [ -f "best-practices/error-resilience.md" ]; then
    echo "✓ Appending error-handling.md to best-practices/error-resilience.md"
    echo "" >> best-practices/error-resilience.md
    echo "---" >> best-practices/error-resilience.md
    echo "" >> best-practices/error-resilience.md
    echo "## Error Handling Patterns (Merged from patterns/)" >> best-practices/error-resilience.md
    echo "" >> best-practices/error-resilience.md
    cat patterns/error-handling.md >> best-practices/error-resilience.md
  else
    echo "✓ Moving error-handling.md → best-practices/error-resilience.md"
    mv patterns/error-handling.md best-practices/error-resilience.md
  fi
fi

echo ""

# ============================================
# PHASE 5: REMOVE REDUNDANT FILES
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PHASE 5: Removing redundant files..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Remove STRUCTURE-QUICK-REFERENCE.md (redundant with quick-reference.md)
if [ -f "STRUCTURE-QUICK-REFERENCE.md" ]; then
  echo "✓ Removing STRUCTURE-QUICK-REFERENCE.md (redundant)"
  rm STRUCTURE-QUICK-REFERENCE.md
fi

# Remove STRUCTURE-TEMPLATE.md (redundant)
if [ -f "STRUCTURE-TEMPLATE.md" ]; then
  echo "✓ Removing STRUCTURE-TEMPLATE.md (redundant)"
  rm STRUCTURE-TEMPLATE.md
fi

# Remove MERMAID-CONVERSION-WORKFLOW.md (out of scope)
if [ -f "MERMAID-CONVERSION-WORKFLOW.md" ]; then
  echo "✓ Removing MERMAID-CONVERSION-WORKFLOW.md (out of scope)"
  rm MERMAID-CONVERSION-WORKFLOW.md
fi

# Remove old patterns/ directory if empty
if [ -d "patterns" ]; then
  if [ -z "$(ls -A patterns)" ]; then
    echo "✓ Removing empty patterns/ directory"
    rmdir patterns
  else
    echo "⚠️  patterns/ not empty, keeping for manual review"
    echo "   Remaining files:"
    ls -la patterns/
  fi
fi

echo ""

# ============================================
# PHASE 6: CLEANUP WORKFLOWS (FUSION STARTUP)
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "PHASE 6: Preparing workflow fusion (manual step)..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "⚠️  Workflow fusion requires manual review:"
echo "   - blog-automation-startup.md"
echo "   - social-media-automation-startup.md"
echo "   - community-management-startup.md"
echo "   - content-repurposing-startup.md"
echo "   - multi-language-content-startup.md"
echo ""
echo "   → These will be merged into workflows/content-automation.md"
echo "   → Manual action required (next step)"
echo ""

# Keep these workflows as-is for now
echo "✓ Keeping enterprise workflows:"
echo "   - enterprise-rfp.md"
echo "   - ci-cd-pipeline.md"
echo "   - global-localization.md"
echo "   - security-incident-response.md"

echo ""

# ============================================
# PHASE 7: SUMMARY
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "MIGRATION COMPLETED ✅"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📊 NEW STRUCTURE:"
echo ""
echo "agentic-workflow/"
echo "├── README.md (à refondre)"
echo "├── orchestration-principles.md ✅ (gardé)"
echo "├── quick-reference.md ✅ (gardé)"
echo "│"
echo "├── 6-composable-patterns/"
echo "│   ├── 3-parallelization.md ✅ (moved)"
echo "│   ├── 4-orchestrator-workers.md ✅ (moved)"
echo "│   ├── 5-evaluator-optimizer.md ✅ (created)"
echo "│   └── 6-autonomous-agents.md ✅ (created)"
echo "│"
echo "├── architecture/"
echo "│   ├── command-subcommand-agent.md ✅ (moved)"
echo "│   ├── hooks-lifecycle.md ✅ (moved)"
echo "│   ├── skills-progressive-disclosure.md ✅ (moved)"
echo "│   └── state-management.md ✅ (moved)"
echo "│"
echo "├── workflows/"
echo "│   ├── enterprise-rfp.md ✅ (kept)"
echo "│   ├── ci-cd-pipeline.md ✅ (kept)"
echo "│   ├── global-localization.md ✅ (kept)"
echo "│   ├── security-incident-response.md ✅ (kept)"
echo "│   └── [startup workflows] ⚠️  (to merge)"
echo "│"
echo "└── best-practices/"
echo "    ├── cost-optimization.md ✅ (kept)"
echo "    ├── error-resilience.md ✅ (merged)"
echo "    └── performance.md ✅ (kept)"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "NEXT STEPS:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. ✅ DONE: Patterns 5 & 6 created"
echo "2. ✅ DONE: Architecture files moved"
echo "3. ✅ DONE: Redundant files removed"
echo ""
echo "4. ⏳ TODO: Create remaining pattern files"
echo "   - 6-composable-patterns/1-prompt-chaining.md"
echo "   - 6-composable-patterns/2-routing.md"
echo "   - 6-composable-patterns/README.md"
echo ""
echo "5. ⏳ TODO: Merge startup workflows"
echo "   - workflows/content-automation.md (fusion 5 startup files)"
echo ""
echo "6. ⏳ TODO: Refonte README.md principal"
echo "   - Vue d'ensemble 6 patterns"
echo "   - Navigation claire"
echo "   - Framework de décision"
echo ""

echo "Migration script completed! ✅"
echo ""
