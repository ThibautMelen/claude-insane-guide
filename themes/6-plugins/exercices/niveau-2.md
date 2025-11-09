# 🟡 Niveau 2 : Utilisation - Plugins Multi-Composants

> **Objectif** : Créer un plugin complet avec Commands + Agents + Hooks et le distribuer sur GitHub
>
> **Durée estimée** : 20 minutes
>
> **Prérequis** : Avoir complété [Niveau 1](./niveau-1.md)

---

## 🎯 Ce que vous allez apprendre

- ✅ Ajouter des sub-agents à un plugin
- ✅ Configurer des hooks (événements)
- ✅ Combiner multiple composants dans un plugin
- ✅ Publier sur GitHub
- ✅ Créer marketplace GitHub
- ✅ Distribuer à une équipe

---

## 📚 Exercice 2.1 : Plugin Multi-Composants

### 🎬 Contexte

Vous voulez créer un plugin professionnel pour votre équipe de développement React, avec :
- Commands pour scaffolding
- Agent de revue de code
- Hooks pour linting automatique

### ✏️ Instructions

**Étape 1 : Structure complète**

```bash
# Créer plugin
mkdir react-team-tools
cd react-team-tools

# Structure
mkdir -p .claude-plugin commands agents hooks scripts
```

**Étape 2 : plugin.json complet**

Créez `.claude-plugin/plugin.json` :

```json
{
  "name": "react-team-tools",
  "version": "1.0.0",
  "description": "Outils équipe React - Commands, Agent reviewer, Hooks",
  "author": {
    "name": "Votre Équipe",
    "email": "team@example.com"
  },
  "license": "MIT",
  "keywords": ["react", "typescript", "team", "tooling"],

  "commands": ["./commands"],
  "agents": "./agents",
  "hooks": "./hooks/hooks.json"
}
```

**Étape 3 : Commands (3 fichiers)**

`commands/create-component.md` :

```markdown
---
name: create-component
description: Créer composant React avec tests et stories
---

Crée un composant React complet :

1. **Composant TypeScript**
   - Interface Props
   - Composant fonctionnel
   - PropTypes validation

2. **Tests Jest + RTL**
   - Tests rendering
   - Tests interactions
   - Tests accessibilité

3. **Storybook Story**
   - Default story
   - Variants

4. **CSS Module**

Demande le nom du composant et crée tous les fichiers dans `src/components/NomComposant/`.
```

`commands/create-hook.md` :

```markdown
---
name: create-hook
description: Créer custom React hook
---

Génère un custom hook React avec :
- TypeScript types
- Tests unitaires
- Documentation JSDoc
- Exemple d'utilisation en commentaire

Place dans `src/hooks/useNomHook.ts`.
```

`commands/refactor-to-composition.md` :

```markdown
---
name: refactor-to-composition
description: Refactoriser en composition pattern
---

Analyse le composant et suggère refactoring vers composition :
- Identifier responsabilités multiples
- Proposer découpage en composants
- Générer nouveaux composants
- Mettre à jour imports/exports
```

**Étape 4 : Agent Reviewer**

`agents/react-code-reviewer.md` :

```markdown
# React Code Reviewer

Tu es un expert React/TypeScript. Tu effectues des revues de code focalisées sur :

## 🎯 Critères de Revue

### Performance
- `useMemo` / `useCallback` utilisés correctement
- Pas de re-renders inutiles
- Code splitting approprié
- Lazy loading si pertinent

### Best Practices React
- Rules of Hooks respectées
- Props drilling évité (Context si nécessaire)
- Composants purement fonctionnels
- Key props correctes dans listes

### TypeScript
- Pas de `any`
- Types stricts pour Props
- Interfaces claires
- Generics si pertinent

### Accessibilité
- Attributs ARIA présents
- Labels sur inputs
- Focus management
- Keyboard navigation

### Tests
- Coverage suffisant
- Tests pertinents (pas snapshot uniquement)
- Tests accessibilité

## 🛠️ Tools Available

Read, Grep, Edit, Bash

## 📋 Output Format

```markdown
# Revue Code React - [Composant]

## ✅ Points Positifs
- ...

## ⚠️ À Améliorer
- ...

## 🐛 Bugs Potentiels
- ...

## 🔧 Suggestions Code
...

## 📊 Score Global
Performance: X/10
Best Practices: X/10
TypeScript: X/10
Accessibilité: X/10
```
```

**Étape 5 : Hooks Configuration**

`hooks/hooks.json` :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '⚛️ React Team Tools chargés !'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(tsx|ts|jsx|js)$",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/lint-changed.sh"
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git commit",
      "script": "echo '⚠️ Assurez-vous que les tests passent !'"
    }
  ]
}
```

**Étape 6 : Script Lint**

`scripts/lint-changed.sh` :

```bash
#!/bin/bash
# Lint fichiers React/TS modifiés

echo "🔍 Linting fichiers React/TypeScript..."

# Trouver fichiers .ts/.tsx/.js/.jsx modifiés
FILES=$(git diff --name-only --cached | grep -E '\\.(tsx?|jsx?)$')

if [ -z "$FILES" ]; then
  echo "✅ Aucun fichier React à linter"
  exit 0
fi

# Lint avec ESLint si disponible
if command -v eslint &> /dev/null; then
  echo "$FILES" | xargs eslint --cache --max-warnings 0
  if [ $? -eq 0 ]; then
    echo "✅ Lint réussi"
  else
    echo "⚠️ Warnings ESLint détectés"
  fi
else
  echo "⚠️ ESLint non installé, skip linting"
fi
```

```bash
# Rendre exécutable
chmod +x scripts/lint-changed.sh
```

**Étape 7 : README.md**

```markdown
# React Team Tools

Plugin Claude Code pour équipes React/TypeScript.

## 🔌 Composants

- **3 Commands** : `/create-component`, `/create-hook`, `/refactor-to-composition`
- **1 Agent** : React Code Reviewer
- **3 Hooks** : SessionStart, PostToolUse (lint), PreToolUse (git)

## 📦 Installation

\`\`\`bash
/plugin marketplace add username/react-team-marketplace
/plugin install react-team-tools@team
\`\`\`

## 🚀 Usage

\`\`\`bash
# Créer composant
/create-component

# Créer hook
/create-hook

# Refactor
/refactor-to-composition
\`\`\`

## 🤖 Agent

L'agent `react-code-reviewer` s'active automatiquement ou via Task tool.

## 🪝 Hooks

- **SessionStart** : Message bienvenue
- **PostToolUse Edit** : Lint auto fichiers .ts/.tsx
- **PreToolUse git commit** : Rappel tests

## 📄 License

MIT
```

### ✅ Validation

Plugin complet si :
- ✅ 3 commands dans `commands/`
- ✅ 1 agent dans `agents/`
- ✅ `hooks/hooks.json` configuré
- ✅ Script `lint-changed.sh` exécutable
- ✅ README.md documenté
- ✅ `plugin.json` pointe vers tous composants

---

## 📚 Exercice 2.2 : Publication GitHub

### 🎬 Contexte

Publiez votre plugin sur GitHub pour le partager.

### ✏️ Instructions

**Étape 1 : Git Init**

```bash
cd react-team-tools

git init
git add .
git commit -m "feat: initial plugin with commands, agent, hooks"
```

**Étape 2 : Créer repo GitHub**

```bash
# Avec GitHub CLI
gh repo create react-team-tools --public --source=. --remote=origin --push

# OU manuellement sur github.com
# Puis :
git remote add origin https://github.com/username/react-team-tools.git
git push -u origin main
```

**Étape 3 : Créer tag version**

```bash
git tag v1.0.0
git push --tags

# Créer release GitHub
gh release create v1.0.0 --generate-notes
```

**Étape 4 : Vérifier**

Visitez `https://github.com/username/react-team-tools` :
- ✅ Code visible
- ✅ Tag `v1.0.0` présent
- ✅ Release créée

### ✅ Validation

- ✅ Repo GitHub créé
- ✅ Code pushé
- ✅ Tag v1.0.0 créé
- ✅ Release publiée

---

## 📚 Exercice 2.3 : Marketplace GitHub

### 🎬 Contexte

Créez une marketplace GitHub pour distribuer vos plugins d'équipe.

### ✏️ Instructions

**Étape 1 : Créer repo marketplace**

```bash
# Nouveau dossier
mkdir react-team-marketplace
cd react-team-marketplace
```

**Étape 2 : marketplace.json**

```json
{
  "name": "react-team",
  "owner": {
    "name": "Votre Équipe React",
    "email": "react-team@example.com"
  },
  "description": "Marketplace outils équipe React",
  "plugins": [
    {
      "name": "react-team-tools",
      "source": {
        "source": "github",
        "repo": "username/react-team-tools",
        "ref": "v1.0.0"
      },
      "description": "Commands + Agent + Hooks pour React",
      "version": "1.0.0",
      "keywords": ["react", "typescript", "team"]
    }
  ]
}
```

**Étape 3 : README.md**

```markdown
# React Team Marketplace

Marketplace officielle équipe React.

## 📦 Plugins Disponibles

### react-team-tools (v1.0.0)
Commands, Agent, Hooks pour développement React.

## 🚀 Installation

\`\`\`bash
/plugin marketplace add username/react-team-marketplace
/plugin install react-team-tools@react-team
\`\`\`

## 📚 Documentation

Voir [react-team-tools](https://github.com/username/react-team-tools)
```

**Étape 4 : Publier**

```bash
git init
git add .
git commit -m "init: marketplace équipe React"

gh repo create react-team-marketplace --public --source=. --push

# Tag
git tag v1.0.0
git push --tags
```

**Étape 5 : Tester installation**

Dans Claude Code :

```bash
/plugin marketplace add username/react-team-marketplace
/plugin install react-team-tools@react-team
/plugin enable react-team-tools

# Tester
/create-component
```

### ✅ Validation

- ✅ Marketplace repo créé sur GitHub
- ✅ `marketplace.json` valide
- ✅ Plugin installable depuis marketplace
- ✅ Commands fonctionnent
- ✅ Agent disponible
- ✅ Hooks actifs

---

## 🎓 Points Clés Niveau 2

### 📦 Plugin Multi-Composants

```
react-team-tools/
├── .claude-plugin/plugin.json    ← Orchestrateur
├── commands/                     ← 3 commands
├── agents/                       ← 1 reviewer
├── hooks/hooks.json              ← 3 hooks
└── scripts/                      ← Utilitaires
```

Tous travaillent ensemble !

### 🪝 Hooks Power

```json
{
  "event": "PostToolUse",
  "tool": "Edit",
  "pattern": "\\.(tsx)$",       ← Filtre fichiers
  "script": "bash lint.sh"      ← Action auto
}
```

Automatisation zéro friction !

### 🏪 Marketplace GitHub

```json
{
  "source": {
    "source": "github",
    "repo": "org/plugin",
    "ref": "v1.0.0"              ← Version exacte
  }
}
```

Distribution professionnelle !

### 📊 Versioning

```bash
v1.0.0  → Release initiale
v1.0.1  → Fix bugs
v1.1.0  → Nouvelle command
v2.0.0  → Breaking changes
```

Semantic Versioning = confiance équipe.

---

## 🚀 Bonus : Aller Plus Loin

### Bonus 1 : Ajouter MCP Server

Ajoutez connexion Supabase.

Créez `.mcp.json` :

```json
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server"],
      "env": {
        "SUPABASE_URL": "${SUPABASE_URL}",
        "SUPABASE_ANON_KEY": "${SUPABASE_ANON_KEY}"
      }
    }
  }
}
```

Mettez à jour `plugin.json` :

```json
{
  "mcpServers": "./.mcp.json"
}
```

### Bonus 2 : CI/CD Validation

`.github/workflows/validate.yml` :

```yaml
name: Validate Plugin

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Validate plugin.json
        run: |
          jq empty .claude-plugin/plugin.json

      - name: Validate marketplace.json
        run: |
          jq empty marketplace.json || true

      - name: Check structure
        run: |
          test -d commands
          test -d agents
          test -f hooks/hooks.json
```

### Bonus 3 : Auto-Installation Équipe

Partagez ce `.claude/settings.json` :

```json
{
  "extraKnownMarketplaces": {
    "react-team": {
      "source": {
        "source": "github",
        "repo": "username/react-team-marketplace"
      }
    }
  },
  "autoInstallPlugins": [
    "react-team-tools@react-team"
  ]
}
```

Chaque membre équipe a automatiquement le plugin !

---

## ✏️ Mini-Défi

**Créez votre propre plugin équipe** avec :

1. **2-3 Commands** pertinentes pour votre stack
2. **1 Agent** reviewer spécialisé
3. **2+ Hooks** pour automatisation
4. **Publiez sur GitHub** avec versioning
5. **Marketplace** pour distribution

**Idées par stack** :

**Node.js/Express** :
- `/create-route`, `/create-middleware`
- Agent : API reviewer
- Hooks : Lint, security check

**Vue.js** :
- `/create-component-vue`, `/create-composable`
- Agent : Vue reviewer
- Hooks : Vetur lint

**Python/FastAPI** :
- `/create-endpoint`, `/create-model`
- Agent : Python reviewer
- Hooks : Black format, mypy check

---

## 🎯 Résumé Niveau 2

**Ce que vous maîtrisez maintenant** :

✅ Plugin avec multiple composants (Commands + Agents + Hooks)
✅ Hooks pour automatisation (SessionStart, PostToolUse, etc.)
✅ Publication GitHub avec versioning
✅ Marketplace GitHub pour distribution
✅ Installation équipe simplifiée

**Prochaine étape** :
➡️ [🟠 Niveau 3 - Maîtrise](./niveau-3.md) : Organisation enterprise, governance, workflows avancés

**Temps investi** : 20 minutes
**Compétence acquise** : Plugin professionnel distribué ✨

---

**🎉 Excellent travail !** Votre plugin est maintenant partageable et maintenable !

[← Niveau 1](./niveau-1.md) | [Guide Complet](../guide.md) | [Niveau 3 →](./niveau-3.md)
