# 🔌 Plugins - Cheatsheet

> **Référence rapide pour les plugins Claude Code**

---

## 📐 Structure Plugin Standard

```
my-plugin/
┣━━ 📁 .claude-plugin/          ⭐ REQUIS
┃   ┗━━ 📄 plugin.json          Manifeste obligatoire
┃
┣━━ 📁 commands/                ✨ Optionnel - Slash commands
┃   ┣━━ 📄 cmd1.md
┃   ┗━━ 📄 cmd2.md
┃
┣━━ 📁 agents/                  ✨ Optionnel - Sub-agents
┃   ┣━━ 📄 agent1.md
┃   ┗━━ 📄 agent2.md
┃
┣━━ 📁 skills/                  ✨ Optionnel - Capacités autonomes
┃   ┗━━ 📁 skill-name/
┃       ┗━━ 📄 SKILL.md
┃
┣━━ 📁 hooks/                   ✨ Optionnel - Événements
┃   ┗━━ 📄 hooks.json
┃
┣━━ 📄 .mcp.json                ✨ Optionnel - MCP servers
┣━━ 📄 README.md                📚 Documentation
┗━━ 📄 LICENSE                  ⚖️ Licence
```

---

## ⚡ Commandes CLI

### Marketplaces

```bash
# Ajouter marketplace GitHub
/plugin marketplace add owner/repo

# Ajouter marketplace Git
/plugin marketplace add https://gitlab.com/org/marketplace.git

# Ajouter marketplace locale
/plugin marketplace add ./path/to/marketplace

# Lister marketplaces
/plugin marketplace list

# Retirer marketplace
/plugin marketplace remove marketplace-name
```

### Installation / Gestion

```bash
# Installer plugin
/plugin install plugin-name@marketplace-name
/plugin install plugin-name  # Si marketplace par défaut

# Lister plugins installés
/plugin list

# Activer/Désactiver
/plugin enable plugin-name
/plugin disable plugin-name

# Info plugin
/plugin info plugin-name

# Mettre à jour
/plugin update plugin-name

# Désinstaller
/plugin uninstall plugin-name
```

---

## 📝 Templates JSON

### plugin.json Minimal

```json
{
  "name": "my-plugin"
}
```

### plugin.json Complet

```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "Description courte",
  "author": {
    "name": "Votre Nom",
    "email": "email@example.com"
  },
  "license": "MIT",
  "homepage": "https://github.com/user/plugin",
  "repository": {
    "type": "git",
    "url": "https://github.com/user/plugin.git"
  },
  "keywords": ["tag1", "tag2"],

  "commands": ["./commands"],
  "agents": "./agents",
  "hooks": "./hooks/hooks.json",
  "mcpServers": "./.mcp.json"
}
```

### marketplace.json

```json
{
  "name": "my-marketplace",
  "owner": {
    "name": "Propriétaire",
    "email": "owner@example.com"
  },
  "description": "Description marketplace",
  "strict": true,
  "plugins": [
    {
      "name": "plugin-name",
      "source": {
        "source": "github",
        "repo": "owner/repo",
        "ref": "v1.0.0"
      },
      "description": "Description plugin",
      "version": "1.0.0",
      "keywords": ["tag1", "tag2"]
    }
  ]
}
```

### hooks/hooks.json

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo 'Plugin chargé!'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(ts|tsx)$",
      "script": "bash scripts/lint.sh",
      "blocking": false
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "echo 'Validation...'",
      "blocking": true
    }
  ]
}
```

### .mcp.json

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    },
    "slack": {
      "type": "url",
      "url": "https://mcp.slack.com",
      "env": {
        "SLACK_TOKEN": "${SLACK_TOKEN}"
      }
    }
  }
}
```

**Serveurs MCP courants** :
- `@modelcontextprotocol/server-postgres` - PostgreSQL
- `@modelcontextprotocol/server-filesystem` - Filesystem
- `@modelcontextprotocol/server-github` - GitHub API
- URLs personnalisées (Datadog, PagerDuty, etc.)

---

## 🌍 Variables Environnement

### ${CLAUDE_PLUGIN_ROOT}

Chemin absolu du plugin - utilisable partout.

**Dans plugin.json** :
```json
{
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/hooks.json",
  "commands": ["${CLAUDE_PLUGIN_ROOT}/commands"]
}
```

**Dans hooks.json** :
```json
{
  "hooks": [{
    "event": "SessionStart",
    "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/init.sh"
  }]
}
```

**Dans scripts Bash** :
```bash
#!/bin/bash
CONFIG="${CLAUDE_PLUGIN_ROOT}/config"
source "${CONFIG}/env.sh"
```

### Variables Custom

**Dans .mcp.json** :
```json
{
  "mcpServers": {
    "db": {
      "command": "npx",
      "args": ["-y", "server-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}",
        "API_KEY": "${MY_API_KEY}"
      }
    }
  }
}
```

**Définir dans shell** :
```bash
export DATABASE_URL="postgres://..."
export MY_API_KEY="sk-..."
```

### Toutes les Variables Claude

| Variable | Usage | Exemple |
|----------|-------|---------|
| `CLAUDE_PLUGIN_ROOT` | Racine plugin courant (auto-set) | `/path/to/plugin` |
| `CLAUDE_PLUGIN_PATH` | Chemin plugins locaux custom | `~/my-plugins` |
| `CLAUDE_MCP_CONFIG` | Path .mcp.json custom | `~/.claude-mcp.json` |
| `CLAUDE_LOG_LEVEL` | Niveau logging | `DEBUG`, `INFO`, `WARN`, `ERROR` |
| `CLAUDE_SANDBOX_MODE` | Isolation scripts | `true`, `false` |
| `CLAUDE_MAX_SCRIPT_TIME` | Timeout scripts (secondes) | `300` (5 minutes) |
| `CLAUDE_MARKETPLACE_URL` | URL marketplace org | `https://plugins.company.com` |

---

## 🎯 Hooks - Événements Disponibles

| Événement | Quand ? | Cas d'Usage |
|-----------|---------|-------------|
| `SessionStart` | Démarrage session Claude | Initialisation, bienvenue |
| `SessionEnd` | Fin session | Cleanup, logs audit |
| `PreToolUse` | Avant utilisation outil | Validation, blocage |
| `PostToolUse` | Après utilisation outil | Linting, formatage |
| `UserPromptSubmit` | Soumission prompt user | Logging, analytics |
| `Notification` | Notification système | Alertes custom |
| `Stop` | Arrêt tâche | Cleanup ressources |
| `SubagentStop` | Arrêt sub-agent | Logs agents |
| `PreCompact` | Avant compaction contexte | Sauvegarde état |

### Options Hooks

| Option | Type | Description |
|--------|------|-------------|
| `event` | string | **REQUIS** - Événement à écouter |
| `script` | string | **REQUIS** - Script à exécuter |
| `tool` | string | Filtre par outil (Edit, Bash, etc.) |
| `pattern` | regex | Filtre par pattern (fichiers) |
| `blocking` | boolean | Si `true`, bloque si script exit != 0 |

---

## 🔗 Sources Plugins Marketplace

### GitHub
```json
{
  "source": {
    "source": "github",
    "repo": "owner/repo",
    "ref": "v1.0.0"  // ou "main", "develop", etc.
  }
}
```

### Git
```json
{
  "source": {
    "source": "git",
    "url": "https://gitlab.com/org/repo.git",
    "ref": "v1.0.0"
  }
}
```

### Local
```json
{
  "source": "./path/to/plugin"
}
```

### URL
```json
{
  "source": "https://example.com/plugins/my-plugin.zip"
}
```

---

## 🗂️ Exemples Quick Start

### 1. Plugin Command Simple

```bash
mkdir my-plugin
cd my-plugin
mkdir -p .claude-plugin commands

# plugin.json
cat > .claude-plugin/plugin.json << 'EOF'
{
  "name": "hello-plugin",
  "version": "1.0.0",
  "commands": ["./commands"]
}
EOF

# Command
cat > commands/hello.md << 'EOF'
---
name: hello
description: Say hello
---

Hello from my plugin!
EOF
```

**Test** :
```bash
/plugin marketplace add ./
/plugin install hello-plugin
/hello
```

### 2. Plugin avec Agent

```bash
mkdir -p agents

cat > agents/reviewer.md << 'EOF'
# Code Reviewer Agent

Tu effectues des revues de code.

## Tools
Read, Edit, Grep

## Output
Rapport markdown avec suggestions.
EOF

# Mettre à jour plugin.json
cat > .claude-plugin/plugin.json << 'EOF'
{
  "name": "review-plugin",
  "agents": "./agents"
}
EOF
```

### 3. Plugin avec Hooks

```bash
mkdir -p hooks scripts

cat > hooks/hooks.json << 'EOF'
{
  "hooks": [{
    "event": "SessionStart",
    "script": "echo '🚀 Plugin actif!'"
  }]
}
EOF

# Mettre à jour plugin.json
{
  "name": "hooks-plugin",
  "hooks": "./hooks/hooks.json"
}
```

### 4. Marketplace Locale

```bash
mkdir team-marketplace
cd team-marketplace

# Copier vos plugins
cp -r ../my-plugin .

# marketplace.json
cat > marketplace.json << 'EOF'
{
  "name": "team-tools",
  "owner": {"name": "Team"},
  "plugins": [
    {
      "name": "my-plugin",
      "source": "./my-plugin",
      "version": "1.0.0"
    }
  ]
}
EOF

# Ajouter
/plugin marketplace add ./team-marketplace
/plugin install my-plugin@team-tools
```

### 5. Marketplace GitHub

```bash
# Créer repo
gh repo create my-marketplace --public
cd my-marketplace

# marketplace.json
cat > marketplace.json << 'EOF'
{
  "name": "my-tools",
  "plugins": [
    {
      "name": "react-helpers",
      "source": {
        "source": "github",
        "repo": "username/react-helpers",
        "ref": "v1.0.0"
      },
      "version": "1.0.0"
    }
  ]
}
EOF

# Push
git add .
git commit -m "init marketplace"
git push origin main

# Utiliser
/plugin marketplace add username/my-marketplace
/plugin install react-helpers@my-tools
```

---

## 📊 Versioning Sémantique

```
MAJOR.MINOR.PATCH

1.0.0 → 1.0.1   Bug fix (patch)
1.0.1 → 1.1.0   Nouvelle feature (minor)
1.1.0 → 2.0.0   Breaking change (major)
```

**Exemples** :
- `1.0.0` : Release initiale
- `1.0.1` : Fix bug dans command
- `1.1.0` : Ajout nouvel agent
- `2.0.0` : Renommage commands (breaking)

---

## 🔧 Configuration Équipe

### .claude/settings.json

**Auto-installation** :
```json
{
  "extraKnownMarketplaces": {
    "team-tools": {
      "source": {
        "source": "github",
        "repo": "org/marketplace"
      }
    }
  },
  "autoInstallPlugins": [
    "security-baseline@team-tools",
    "frontend-tools@team-tools"
  ]
}
```

**Résultat** : Plugins installés automatiquement pour chaque membre équipe.

---

## ✅ Checklist Création Plugin

### 📋 Setup Initial
- [ ] Créer dossier `.claude-plugin/`
- [ ] Créer `plugin.json` avec au minimum `name`
- [ ] Ajouter components (commands/, agents/, etc.) à la **racine**
- [ ] Utiliser `${CLAUDE_PLUGIN_ROOT}` dans chemins
- [ ] Créer README.md avec exemples
- [ ] Ajouter LICENSE (MIT recommandé)
- [ ] Créer .gitignore

### 🔒 Sécurité
- [ ] JAMAIS hardcoder secrets/API keys
- [ ] Utiliser variables d'environnement
- [ ] Ajouter .env à .gitignore
- [ ] Fournir .env.example
- [ ] Valider tous les inputs utilisateur
- [ ] Permissions scripts minimales (755/644)
- [ ] Documenter permissions requises

### 🧪 Quality & Testing
- [ ] Tester localement avec marketplace locale
- [ ] Valider JSON avec `jq` ou linter
- [ ] Tester hooks (ne bloquent pas workflow)
- [ ] Vérifier performance scripts
- [ ] Code review par peer
- [ ] Scanner vulnérabilités (shellcheck, etc.)

### 📝 Documentation
- [ ] README.md complet avec :
  - [ ] Description claire
  - [ ] Prerequisites (Python, Node, etc.)
  - [ ] Installation steps
  - [ ] Usage examples
  - [ ] Configuration
  - [ ] Troubleshooting
- [ ] CHANGELOG.md initialisé
- [ ] Commentaires dans scripts complexes
- [ ] Examples dans commands/

### 🚀 Publication
- [ ] Versionner (Git + semantic versioning)
- [ ] Git tag version (`git tag v1.0.0`)
- [ ] Push tags (`git push --tags`)
- [ ] Ajouter à marketplace
- [ ] Tester installation depuis marketplace
- [ ] Annoncer release (changelog, docs)
- [ ] Partager avec équipe

### 🔄 Maintenance Continue
- [ ] Monitorer issues/feedback
- [ ] Mettre à jour dependencies
- [ ] Bumper version selon semver
- [ ] Documenter breaking changes
- [ ] Maintenir CHANGELOG.md

---

## 🚨 Erreurs Courantes

### ❌ plugin.json mal placé
```
my-plugin/
└── plugin.json  ← FAUX

✅ CORRECT :
my-plugin/
└── .claude-plugin/
    └── plugin.json
```

### ❌ Chemins absolus
```json
❌ "hooks": "/Users/me/plugin/hooks.json"
✅ "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/hooks.json"
```

### ❌ JSON invalide
```bash
# Valider avec jq
cat .claude-plugin/plugin.json | jq .

# Si erreur → fixer syntax
```

### ❌ Hooks trop lents
```json
❌ {
  "event": "PostToolUse",
  "script": "sleep 10"  ← Bloque tout!
}

✅ {
  "event": "PostToolUse",
  "pattern": "\\.tsx$",  ← Ciblé
  "script": "eslint --cache"  ← Rapide
}
```

---

## 📚 Liens Utiles

- [Guide Complet](./guide.md) - Documentation exhaustive
- [Cas d'Usage Réels](./cas-usage.md) - Exemples production-ready
- [Commands](../commands/guide.md) - Slash commands
- [Agents](../agents/guide.md) - Sub-agents
- [MCP](../mcp/guide.md) - Model Context Protocol
- [Skills](../skills/guide.md) - Agent capabilities

---

## 🎯 Quick Reference

| Besoin | Solution |
|--------|----------|
| Command réutilisable | Plugin avec `commands/` |
| Sub-agent custom | Plugin avec `agents/` |
| Validation auto | Plugin avec `hooks/` |
| Service externe | Plugin avec `.mcp.json` |
| Distribution équipe | Marketplace GitHub |
| Développement local | Marketplace locale |
| Standards enforced | `autoInstallPlugins` |

---

**Voir [Guide Complet](./guide.md) pour détails et exemples approfondis !**

---

## 📚 Ressources

### 📄 Documentation Officielle

- [Plugins Docs](https://code.claude.com/docs/en/plugins) - Guide officiel Anthropic
- [Agent SDK - Plugins](https://docs.claude.com/en/docs/agent-sdk/plugins) - Documentation technique SDK
- [Plugins Marketplace](https://code.claude.com/docs/en/plugins#marketplaces) - Système marketplace
- [Plugin.json Reference](https://code.claude.com/docs/en/plugins#plugin-json) - Référence manifeste

### 🎥 Vidéos Recommandées

- [Formation Claude Code 2.0](../../ressources/videos/formation-claude-code-2-0-melvynx.md) ([🔗 YouTube](https://www.youtube.com/watch?v=bDr1tGskTdw)) - Melvynx | 🟢 Débutant
  - Introduction aux plugins
- [Skills vs MCP vs Subagents](../../ressources/videos/skills-vs-mcp-vs-subagents.md) ([🔗 YouTube](https://youtu.be/ZroGqu7GyXM)) - Solo Swift Crafter | 🟢 Débutant
  - Quand utiliser plugins vs autres features
- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) ([🔗 YouTube](https://www.youtube.com/watch?v=Ffh9OeJ7yxw)) - Edmund Yong | 🔴 Expert
  - Plugins avancés et marketplace équipe

### 📝 Articles

- [Skills, Commands, Subagents, Plugins](../../ressources/articles/skills-commands-subagents-plugins-youngleaders.md) ([🔗 Source](https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins)) - YoungLeaders
  - Comparaison complète des features
- [Understanding Claude Code's Full Stack](../../ressources/articles/full-stack-orchestration-opalic.md) ([🔗 Source](https://alexop.dev/posts/understanding-claude-code-full-stack/)) - Alexander Opalic
  - Plugins : bundled packages pour team standardization et distribution

### 🔗 Communauté

- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code) ⭐ 17K - Liste curée commands & workflows
- [Awesome Claude Code Plugins](https://github.com/VoltAgent/awesome-claude-code#plugins) - Collection de plugins
- [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Configuration plugins
- [Community Marketplaces](https://github.com/VoltAgent/awesome-claude-code#marketplaces) - Marketplaces communautaires
- [Ralph Wiggum Plugin](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum) - Plugin officiel Anthropic pour génération autonome

### 📖 Plugins Avancés

- **Ralph Wiggum** ([🔗 GitHub](https://github.com/anthropics/claude-code/tree/main/plugins/ralph-wiggum) | [🔗 Article](https://ghuntley.com/ralph/))
  - Génération code autonome 24/7 via loop infini
  - Plugin officiel Anthropic
  - ROI documenté : $50K → $297 USD
  - Voir [Add-on Ralph Wiggum](../../themes/9-add-ons/ralph-wiggum/guide.md)

---

**💡 Tip** : Marketplace d'abord, plugin local ensuite ! ⚡
