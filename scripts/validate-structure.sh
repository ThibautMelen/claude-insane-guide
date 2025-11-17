#!/bin/bash
# validate-structure.sh - Valider l'arborescence du projet
#
# Usage: ./scripts/validate-structure.sh

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🔍 Validation Structure - Claude Code Compréhension"
echo "==================================================="
echo ""

ERRORS=0
WARNINGS=0

# Fonction pour logger les erreurs
error() {
  echo "❌ ERREUR: $1"
  ((ERRORS++))
}

# Fonction pour logger les warnings
warning() {
  echo "⚠️  WARNING: $1"
  ((WARNINGS++))
}

# Fonction pour logger les succès
success() {
  echo "✅ OK: $1"
}

# 1. Vérifier structure des thèmes
echo "1️⃣  Vérification structure themes/"
for i in {1..9}; do
  THEME_DIR="$PROJECT_ROOT/themes/$i-"*
  if ! ls $THEME_DIR 1> /dev/null 2>&1; then
    error "Thème $i manquant"
    continue
  fi

  THEME_NAME=$(basename $THEME_DIR)

  # Vérifier guide.md et cheatsheet.md (sauf thèmes 8 et 9)
  if [ "$i" -lt 8 ]; then
    if [ ! -f "$THEME_DIR/guide.md" ]; then
      error "$THEME_NAME : guide.md manquant"
    fi
    if [ ! -f "$THEME_DIR/cheatsheet.md" ]; then
      error "$THEME_NAME : cheatsheet.md manquant"
    fi
    if [ -f "$THEME_DIR/guide.md" ] && [ -f "$THEME_DIR/cheatsheet.md" ]; then
      success "$THEME_NAME : structure complète"
    fi
  else
    # Thèmes 8 et 9 : vérifier README.md
    if [ ! -f "$THEME_DIR/README.md" ]; then
      error "$THEME_NAME : README.md manquant"
    else
      success "$THEME_NAME : README.md présent"
    fi
  fi
done
echo ""

# 2. Vérifier workflow-pattern-orchestration
echo "2️⃣  Vérification workflow-pattern-orchestration/"
WPO="$PROJECT_ROOT/workflow-pattern-orchestration"

if [ ! -d "$WPO/patterns" ]; then
  error "Dossier patterns/ manquant"
else
  PATTERNS_COUNT=$(find "$WPO/patterns" -name "*.md" -not -name "README.md" | wc -l | tr -d ' ')
  success "patterns/ : $PATTERNS_COUNT fichiers"
fi

if [ ! -d "$WPO/workflows" ]; then
  error "Dossier workflows/ manquant"
else
  WORKFLOWS_COUNT=$(find "$WPO/workflows" -name "*.md" -not -name "README.md" | wc -l | tr -d ' ')
  success "workflows/ : $WORKFLOWS_COUNT fichiers"
fi

if [ ! -d "$WPO/best-practices" ]; then
  error "Dossier best-practices/ manquant"
else
  BP_COUNT=$(find "$WPO/best-practices" -name "*.md" -not -name "README.md" | wc -l | tr -d ' ')
  success "best-practices/ : $BP_COUNT fichiers"
fi

if [ ! -f "$WPO/README.md" ]; then
  error "workflow-pattern-orchestration/README.md manquant"
else
  success "README.md principal présent"
fi
echo ""

# 3. Vérifier ressources
echo "3️⃣  Vérification ressources/"
if [ ! -d "$PROJECT_ROOT/ressources/articles" ]; then
  error "Dossier articles/ manquant"
elif [ ! -f "$PROJECT_ROOT/ressources/articles/README.md" ]; then
  warning "articles/README.md manquant"
else
  success "articles/ avec README.md"
fi

if [ ! -d "$PROJECT_ROOT/ressources/videos" ]; then
  error "Dossier videos/ manquant"
elif [ ! -f "$PROJECT_ROOT/ressources/videos/README.md" ]; then
  warning "videos/README.md manquant"
else
  success "videos/ avec README.md"
fi
echo ""

# 4. Vérifier fichiers racine
echo "4️⃣  Vérification fichiers racine"
if [ ! -f "$PROJECT_ROOT/README.md" ]; then
  error "README.md racine manquant"
else
  success "README.md racine présent"
fi

if [ ! -f "$PROJECT_ROOT/.gitignore" ]; then
  warning ".gitignore manquant"
else
  success ".gitignore présent"
fi

if [ ! -f "$PROJECT_ROOT/.claude/CLAUDE.md" ]; then
  error ".claude/CLAUDE.md manquant"
else
  success ".claude/CLAUDE.md présent"
fi
echo ""

# 5. Vérifier nommage des fichiers
echo "5️⃣  Vérification nommage fichiers"
BAD_NAMES=$(find "$PROJECT_ROOT" -name "*.md" -not -path "*/.git/*" | grep -E "[# @\(\)\[\]]" || true)
if [ -n "$BAD_NAMES" ]; then
  warning "Fichiers avec caractères spéciaux détectés:"
  echo "$BAD_NAMES" | while read -r file; do
    echo "  - $(basename "$file")"
  done
else
  success "Tous les noms de fichiers sont conformes"
fi
echo ""

# 6. Résumé
echo "📊 Résumé"
echo "=========="
echo "❌ Erreurs : $ERRORS"
echo "⚠️  Warnings : $WARNINGS"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
  echo "✅ Structure validée avec succès !"
  exit 0
elif [ $ERRORS -eq 0 ]; then
  echo "⚠️  Structure validée avec warnings"
  exit 0
else
  echo "❌ Structure invalide - Corriger les erreurs"
  exit 1
fi
