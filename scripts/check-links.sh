#!/bin/bash
# check-links.sh - Vérifier les liens internes cassés
#
# Usage: ./scripts/check-links.sh

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "🔗 Vérification Liens Internes - Claude Code Compréhension"
echo "==========================================================="
echo ""

BROKEN_LINKS=0
CHECKED_FILES=0

# Fonction pour vérifier un lien
check_link() {
  local file="$1"
  local link="$2"
  local base_dir=$(dirname "$file")

  # Ignorer liens externes (http/https)
  if [[ "$link" =~ ^https?:// ]]; then
    return 0
  fi

  # Ignorer ancres seules (#section)
  if [[ "$link" =~ ^# ]]; then
    return 0
  fi

  # Retirer l'ancre si présente
  local link_path="${link%%#*}"

  # Construire le chemin absolu
  local full_path
  if [[ "$link_path" == /* ]]; then
    full_path="$PROJECT_ROOT$link_path"
  else
    full_path="$base_dir/$link_path"
  fi

  # Normaliser le chemin
  full_path=$(realpath -m "$full_path" 2>/dev/null || echo "$full_path")

  # Vérifier si le fichier existe
  if [ ! -e "$full_path" ]; then
    echo "❌ CASSÉ: $file"
    echo "   Lien: $link"
    echo "   Cible: $full_path"
    echo ""
    ((BROKEN_LINKS++))
    return 1
  fi

  return 0
}

# Parcourir tous les fichiers markdown
echo "📄 Analyse des liens dans les fichiers .md..."
echo ""

while IFS= read -r file; do
  ((CHECKED_FILES++))

  # Extraire tous les liens markdown [text](url)
  links=$(grep -o '\[.*\]([^)]\+)' "$file" 2>/dev/null | sed 's/.*](\([^)]*\)).*/\1/' || true)

  if [ -n "$links" ]; then
    while IFS= read -r link; do
      check_link "$file" "$link" || true
    done <<< "$links"
  fi
done < <(find "$PROJECT_ROOT" -name "*.md" -not -path "*/.git/*" -not -path "*/node_modules/*")

echo ""
echo "📊 Résumé"
echo "=========="
echo "📄 Fichiers vérifiés : $CHECKED_FILES"
echo "🔗 Liens cassés : $BROKEN_LINKS"
echo ""

if [ $BROKEN_LINKS -eq 0 ]; then
  echo "✅ Tous les liens internes sont valides !"
  exit 0
else
  echo "❌ $BROKEN_LINKS lien(s) cassé(s) détecté(s)"
  echo ""
  echo "💡 Tip: Vérifier les chemins relatifs et les fichiers déplacés"
  exit 1
fi
