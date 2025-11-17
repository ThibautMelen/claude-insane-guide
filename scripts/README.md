# 🛠️ Scripts Utilitaires

Scripts Bash pour maintenir et analyser la documentation.

## 📋 Scripts Disponibles

### 📊 count-stats.sh

**Statistiques de documentation**

Génère un rapport complet sur :
- Nombre de fichiers Markdown
- Lignes de contenu par catégorie
- Détails par thème (1-9)
- Stats workflow-pattern-orchestration
- Stats ressources (articles/vidéos)
- Taille totale

**Usage** :
```bash
./scripts/count-stats.sh
```

**Exemple de sortie** :
```
📊 Statistiques Documentation - Claude Code Compréhension
==========================================================

📄 Fichiers Markdown : 85
  ├─ Themes : 28
  ├─ Workflow-Pattern-Orchestration : 32
  └─ Ressources : 17

📝 Lignes totales : 25,000

🎯 Thèmes (1-9) :
  1. memory          :  2 fichiers,   450 lignes
  2. commands        :  2 fichiers,   620 lignes
  ...

🚀 Workflow-Pattern-Orchestration :
  ├─ Patterns : 8
  ├─ Workflows : 9
  └─ Best Practices : 3

📚 Ressources :
  ├─ Articles : 4
  └─ Vidéos : 12

💾 Taille totale : 450K
```

---

### 🔍 validate-structure.sh

**Validation de l'arborescence**

Vérifie que la structure du projet est conforme :
- ✅ Tous les thèmes (1-9) présents
- ✅ Fichiers requis (guide.md, cheatsheet.md, README.md)
- ✅ Dossiers workflow-pattern-orchestration
- ✅ README dans ressources/
- ✅ Fichiers racine (.gitignore, CLAUDE.md, README.md)
- ⚠️  Nommage des fichiers (caractères spéciaux)

**Usage** :
```bash
./scripts/validate-structure.sh
```

**Codes de sortie** :
- `0` : Structure valide
- `1` : Erreurs détectées (structure invalide)

**Exemple de sortie** :
```
🔍 Validation Structure - Claude Code Compréhension
===================================================

1️⃣  Vérification structure themes/
✅ OK: 1-memory : structure complète
✅ OK: 2-commands : structure complète
...
❌ ERREUR: 5-agents : cheatsheet.md manquant

2️⃣  Vérification workflow-pattern-orchestration/
✅ OK: patterns/ : 8 fichiers
✅ OK: workflows/ : 9 fichiers
✅ OK: best-practices/ : 3 fichiers
✅ OK: README.md principal présent

3️⃣  Vérification ressources/
✅ OK: articles/ avec README.md
✅ OK: videos/ avec README.md

4️⃣  Vérification fichiers racine
✅ OK: README.md racine présent
✅ OK: .gitignore présent
✅ OK: .claude/CLAUDE.md présent

5️⃣  Vérification nommage fichiers
✅ OK: Tous les noms de fichiers sont conformes

📊 Résumé
==========
❌ Erreurs : 1
⚠️  Warnings : 0

❌ Structure invalide - Corriger les erreurs
```

---

### 🔗 check-links.sh

**Vérification des liens internes**

Analyse tous les liens Markdown et détecte :
- ❌ Liens cassés (fichiers manquants)
- ✅ Liens valides
- 🔗 Chemins relatifs incorrects

**Ignore** :
- Liens externes (http/https)
- Ancres seules (#section)

**Usage** :
```bash
./scripts/check-links.sh
```

**Codes de sortie** :
- `0` : Tous les liens valides
- `1` : Liens cassés détectés

**Exemple de sortie** :
```
🔗 Vérification Liens Internes - Claude Code Compréhension
===========================================================

📄 Analyse des liens dans les fichiers .md...

❌ CASSÉ: /path/to/themes/1-memory/guide.md
   Lien: ../commands/guide.md
   Cible: /path/to/themes/commands/guide.md

❌ CASSÉ: /path/to/README.md
   Lien: patterns/README.md
   Cible: /path/to/patterns/README.md

📊 Résumé
==========
📄 Fichiers vérifiés : 85
🔗 Liens cassés : 2

❌ 2 lien(s) cassé(s) détecté(s)

💡 Tip: Vérifier les chemins relatifs et les fichiers déplacés
```

---

## 🚀 Workflows Recommandés

### Avant Commit

```bash
# 1. Valider la structure
./scripts/validate-structure.sh

# 2. Vérifier les liens
./scripts/check-links.sh

# 3. Si tout est OK, commit
git add .
git commit -m "docs: update documentation"
```

### Maintenance Régulière

```bash
# Générer les stats
./scripts/count-stats.sh > docs-stats.txt

# Archiver
git add docs-stats.txt
git commit -m "docs: update statistics"
```

### CI/CD Integration

Ajouter dans `.github/workflows/validate.yml` :

```yaml
name: Validate Documentation

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Validate Structure
        run: ./scripts/validate-structure.sh

      - name: Check Links
        run: ./scripts/check-links.sh

      - name: Generate Stats
        run: ./scripts/count-stats.sh
```

---

## 📝 Développement

### Ajouter un Nouveau Script

1. Créer `scripts/mon-script.sh`
2. Ajouter le shebang : `#!/bin/bash`
3. Rendre exécutable : `chmod +x scripts/mon-script.sh`
4. Documenter dans ce README
5. Suivre les conventions :
   - `set -euo pipefail` (fail fast)
   - Echo clair avec emojis
   - Codes de sortie explicites (0 = succès)

### Conventions

**Variables** :
```bash
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
```

**Logging** :
```bash
echo "✅ OK: message"
echo "❌ ERREUR: message"
echo "⚠️  WARNING: message"
echo "📊 Info: message"
```

**Exit codes** :
- `0` : Succès
- `1` : Erreur
- `2` : Warning (optionnel)

---

## 🔧 Dépendances

**Outils requis** :
- `bash` (4.0+)
- `grep`
- `find`
- `wc`
- `du`
- `realpath`

**Vérification** :
```bash
command -v bash grep find wc du realpath
```

---

## 📚 Ressources

- [Bash Best Practices](https://bertvv.github.io/cheat-sheets/Bash.html)
- [ShellCheck](https://www.shellcheck.net/) - Linter pour scripts bash
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)

---

**Maintenance** : Ces scripts sont conçus pour être simples et maintenables. Pas de dépendances externes complexes.
