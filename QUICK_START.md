# 🚀 Quick Start - Claude Code en 10 minutes

## 📋 Vue Rapide

Guide ultra-concis pour commencer avec Claude Code **immédiatement**.

---

## 🎯 Parcours Recommandés

### 🟢 Débutant (1-2 heures)

```bash
# 1. Memory - Persistance d'instructions
cat themes/1-memory/guide.md

# 2. Commands - Automatisation
cat themes/2-commands/guide.md

# 3. Exercice pratique
cat themes/1-memory/exercices/niveau-1.md
```

**Objectif** : Comprendre la base de Claude Code

### 🟡 Intermédiaire (4-6 heures)

```bash
# Parcours complet des guides 1-9
for i in {1..9}; do
  cat themes/$i-*/guide.md
done

# Exercices niveau 1-2 pour chaque thème
```

**Objectif** : Maîtriser les fonctionnalités principales

### 🟠 Expert (8-10 heures)

```bash
# Tous les guides + Interactive UI
cat themes/*/guide.md

# Patterns avancés
cat advanced/multi-dialog-patterns.md

# Showcase production
cat showcase/supernovae-studio/quick-start.md

# Tous les exercices niveau 3-4
```

**Objectif** : Expertise complète Claude Code

---

## ⚡ TL;DR - L'Essentiel en 5 minutes

### 1️⃣ Memory (.claude/CLAUDE.md)

```markdown
# .claude/CLAUDE.md

## Coding Style
- TypeScript strict mode
- 2 spaces indentation
- Prettier formatting

## Project Structure
- Components in src/components/
- API routes in src/app/api/

## Testing
- Jest for unit tests
- 80% coverage minimum
```

**Usage** : Claude applique ces règles automatiquement

### 2️⃣ Commands (.claude/commands/)

```markdown
# .claude/commands/review.md
---
description: Review code changes
---

Review les changements suivants :
- Vérifier TypeScript errors
- Vérifier tests passent
- Suggérer améliorations

!`git diff`
```

**Usage** : `/review` dans Claude Code

### 3️⃣ MCP Servers (config.json)

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"],
      "env": {
        "PATHS": "/Users/you/projects"
      }
    }
  }
}
```

**Usage** : Accès filesystem dans Claude

### 4️⃣ Plugins

```bash
# Installer un plugin
/plugin install formatter@company

# Enable pour le projet
/plugin enable formatter@company
```

### 5️⃣ Interactive UI (AskUserQuestion)

```javascript
const framework = await ask({
  question: "Which framework?",
  header: "Framework",
  options: [
    { label: "Next.js", description: "Full-stack React" },
    { label: "Nuxt", description: "Vue framework" }
  ]
});
```

---

## 📚 Cheat Sheets Rapides

### Memory Commands

- `/init` : Créer CLAUDE.md initial
- `/memory` : Éditer fichiers memory
- `#` : Quick add to memory

### Slash Commands Utiles

- `/clear` : Effacer conversation
- `/compact` : Compacter contexte
- `/config` : Settings
- `/cost` : Usage tokens
- `/rewind` : Annuler dernière action
- `/status` : Infos système

### Hooks Events

- **PreToolUse** : Avant outils
- **PostToolUse** : Après outils
- **UserPromptSubmit** : Soumission user
- **SessionStart/End** : Début/fin session

---

## 🔥 Setup Minimal Production

### Étape 1 : Memory

```bash
mkdir -p .claude
cat > .claude/CLAUDE.md << 'EOF'
# Project Instructions

## Stack
- Next.js 14 App Router
- TypeScript strict
- Tailwind CSS
- Supabase

## Conventions
- Functional components
- Custom hooks in hooks/
- Server actions in actions/
- Types in types/

## Quality
- Always handle errors
- Add loading states
- Write tests for critical paths
EOF
```

### Étape 2 : Command EPCT

```bash
cat > .claude/commands/epct.md << 'EOF'
---
description: Explore, Plan, Code, Test workflow
---

Pour $ARGUMENTS:

1. EXPLORE - Comprendre architecture
2. PLAN - Proposer implémentation
3. CODE - Après validation
4. TEST - Vérifier fonctionnement
EOF
```

### Étape 3 : MCP Filesystem

```bash
cat > ~/.config/claude-code/config.json << 'EOF'
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem"],
      "env": {
        "PATHS": "$HOME/projects"
      }
    }
  }
}
EOF
```

---

## 🎯 Commandes les Plus Utiles

```bash
# Initialiser projet
claude
/init

# Créer feature avec workflow
/epct "Create user authentication"

# Review changes
/review

# Voir coûts
/cost

# Annuler si problème
/rewind
```

---

## 📖 Pour Aller Plus Loin

### Documentation Complète

1. **Fondamentaux** : themes/1-memory → themes/3-hooks
2. **Intégrations** : themes/4-mcp → themes/6-plugins
3. **Avancé** : themes/7-agents → themes/10-interactive-ui
4. **Expert** : advanced/ & showcase/

### Ressources

- 📄 [Docs Officielles](https://code.claude.com/docs)
- 💬 [Discord Community](https://discord.gg/claude-code)
- 🔗 [GitHub Examples](https://github.com/anthropics/claude-code)

---

## 💡 Top 5 Tips

1. **Memory First** : Toujours créer `.claude/CLAUDE.md`
2. **Commands Réutilisables** : Automatiser workflows répétitifs
3. **MCP pour Intégrations** : Databases, APIs, services
4. **Plugins pour Équipes** : Distribuer configurations
5. **Interactive UI** : Meilleure UX pour configurations complexes

---

> **🎯 Challenge** : Créez votre premier workflow complet en 30 minutes !
> 1. Memory avec vos préférences
> 2. Command /build personnalisée
> 3. MCP pour votre DB
> 4. Test sur projet réel