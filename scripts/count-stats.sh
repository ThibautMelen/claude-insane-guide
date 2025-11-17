#!/bin/bash
# count-stats.sh - Statistiques de documentation
#
# Usage: ./scripts/count-stats.sh

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "📊 Statistiques Documentation - Claude Code Compréhension"
echo "=========================================================="
echo ""

# Fichiers Markdown
TOTAL_MD=$(find "$PROJECT_ROOT" -name "*.md" -not -path "*/.git/*" -not -path "*/node_modules/*" | wc -l | tr -d ' ')
echo "📄 Fichiers Markdown : $TOTAL_MD"

# Par catégorie
THEMES_MD=$(find "$PROJECT_ROOT/themes" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
WORKFLOW_MD=$(find "$PROJECT_ROOT/workflow-pattern-orchestration" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
RESSOURCES_MD=$(find "$PROJECT_ROOT/ressources" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

echo "  ├─ Themes : $THEMES_MD"
echo "  ├─ Workflow-Pattern-Orchestration : $WORKFLOW_MD"
echo "  └─ Ressources : $RESSOURCES_MD"
echo ""

# Lignes de contenu
TOTAL_LINES=$(find "$PROJECT_ROOT" -name "*.md" -not -path "*/.git/*" -not -path "*/node_modules/*" -exec cat {} \; | wc -l | tr -d ' ')
echo "📝 Lignes totales : $TOTAL_LINES"
echo ""

# Themes détaillés
echo "🎯 Thèmes (1-9) :"
for i in {1..9}; do
  THEME_DIR="$PROJECT_ROOT/themes/$i-*"
  if ls $THEME_DIR 1> /dev/null 2>&1; then
    THEME_NAME=$(basename $THEME_DIR | cut -d'-' -f2-)
    THEME_FILES=$(find $THEME_DIR -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    THEME_LINES=$(find $THEME_DIR -name "*.md" -exec cat {} \; 2>/dev/null | wc -l | tr -d ' ')
    printf "  %d. %-15s : %2d fichiers, %5d lignes\n" "$i" "$THEME_NAME" "$THEME_FILES" "$THEME_LINES"
  fi
done
echo ""

# Workflow-Pattern-Orchestration
echo "🚀 Workflow-Pattern-Orchestration :"
PATTERNS=$(find "$PROJECT_ROOT/workflow-pattern-orchestration/patterns" -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | tr -d ' ')
WORKFLOWS=$(find "$PROJECT_ROOT/workflow-pattern-orchestration/workflows" -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | tr -d ' ')
BEST_PRACTICES=$(find "$PROJECT_ROOT/workflow-pattern-orchestration/best-practices" -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | tr -d ' ')

echo "  ├─ Patterns : $PATTERNS"
echo "  ├─ Workflows : $WORKFLOWS"
echo "  └─ Best Practices : $BEST_PRACTICES"
echo ""

# Ressources
echo "📚 Ressources :"
ARTICLES=$(find "$PROJECT_ROOT/ressources/articles" -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | tr -d ' ')
VIDEOS=$(find "$PROJECT_ROOT/ressources/videos" -name "*.md" -not -name "README.md" 2>/dev/null | wc -l | tr -d ' ')

echo "  ├─ Articles : $ARTICLES"
echo "  └─ Vidéos : $VIDEOS"
echo ""

# Taille totale
TOTAL_SIZE=$(find "$PROJECT_ROOT" -name "*.md" -not -path "*/.git/*" -not -path "*/node_modules/*" -exec du -ch {} + 2>/dev/null | grep total | awk '{print $1}')
echo "💾 Taille totale : $TOTAL_SIZE"
echo ""

echo "✅ Analyse terminée !"
