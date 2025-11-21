# 🔌 Plugins Claude Code - Guide Complet

> **Maîtrisez le système d'extensibilité le plus puissant de Claude Code**

---

## 📚 Table des Matières

1. [Théorie Fondamentale](#-théorie-fondamentale)
2. [Architecture d'un Plugin](#-architecture-dun-plugin)
3. [Création de Plugins](#-création-de-plugins)
4. [Marketplaces](#-marketplaces)
5. [Développement Avancé](#-développement-avancé)
6. [Cas Pratiques](#-cas-pratiques)
7. [Points Clés](#-points-clés)
8. [Ressources](#-ressources)

**📚 Pattern Anthropic** :
- [Pattern 4: Orchestrator-Workers](../../agentic-workflow/6-composable-patterns/4-orchestrator-workers.md) - Plugins pour distribuer Commands/Agents/Skills

---

## 📚 Théorie Fondamentale

### 🎯 Qu'est-ce qu'un Plugin Claude Code ?

Un **plugin** est un **système d'extensibilité modulaire** qui permet de :

✅ **Bundler** plusieurs fonctionnalités en un seul package réutilisable
✅ **Distribuer** des configurations à toute une équipe
✅ **Partager** des workflows standardisés
✅ **Versionner** vos outils et prompts
✅ **Organiser** votre environnement de développement

**Schéma conceptuel** :

```
Sans Plugins                     Avec Plugins
─────────────                    ────────────

.claude/                         .claude-plugins/
├── settings.json                ├── frontend-tools/     📦
│   ├── commands (éparpillés)    │   ├── commands/
│   ├── agents (mélangés)        │   ├── agents/
│   └── hooks (désorganisés)     │   ├── skills/
                                 │   └── hooks/
❌ Maintenance difficile          │
❌ Partage compliqué              ├── backend-tools/     📦
❌ Versioning impossible          │   └── ...
                                 │
                                 └── security-audit/    📦
                                     └── ...

                                 ✅ Modulaire
                                 ✅ Partageable
                                 ✅ Versionné
```

### 🧩 Problème Résolu

**Avant les Plugins** :
- 😓 Configuration dispersée dans `.claude/settings.json`
- 😓 Impossible de partager facilement avec l'équipe
- 😓 Pas de versioning des prompts/agents
- 😓 Migration manuelle entre projets

**Avec les Plugins** :
- 🎉 Tout packagé dans un dossier réutilisable
- 🎉 Installation en 1 commande : `/plugin install nom@marketplace`
- 🎉 Versioning Git automatique
- 🎉 Distribution via marketplaces (GitHub, Git, local)

### 🔧 Les 5 Composants d'un Plugin

Un plugin peut contenir **jusqu'à 5 types de composants** :

```
╔═══════════════════════════════════════════════════════════════╗
║  🔌 PLUGIN CLAUDE CODE - 5 COMPOSANTS POSSIBLES              ║
╚═══════════════════════════════════════════════════════════════╝

1️⃣ COMMANDS (Slash Commands)
   ┌────────────────────────────────────────────┐
   │ 📍 Location : commands/                    │
   │ 📄 Format   : Markdown avec frontmatter    │
   │ ⚡ Usage    : /nom-command                 │
   │ 💡 Exemple  : /create-api, /review-code    │
   └────────────────────────────────────────────┘

2️⃣ AGENTS (Sub-agents spécialisés)
   ┌────────────────────────────────────────────┐
   │ 📍 Location : agents/                      │
   │ 📄 Format   : Markdown avec YAML frontmatter│
   │ ⚡ Usage    : Auto ou via Task tool        │
   │ 💡 Exemple  : code-reviewer, test-runner   │
   └────────────────────────────────────────────┘

3️⃣ SKILLS (Capacités autonomes du modèle)
   ┌────────────────────────────────────────────┐
   │ 📍 Location : skills/nom-skill/SKILL.md    │
   │ 📄 Format   : Dossier avec SKILL.md        │
   │ ⚡ Usage    : Invoqué automatiquement      │
   │ 💡 Exemple  : pdf-processor, xlsx-handler  │
   └────────────────────────────────────────────┘

4️⃣ HOOKS (Gestionnaires d'événements)
   ┌────────────────────────────────────────────┐
   │ 📍 Location : hooks/hooks.json             │
   │ 📄 Format   : JSON configuration           │
   │ ⚡ Usage    : Auto sur événements système  │
   │ 💡 Exemple  : PostToolUse, SessionStart    │
   └────────────────────────────────────────────┘

5️⃣ MCP SERVERS (Outils externes)
   ┌────────────────────────────────────────────┐
   │ 📍 Location : .mcp.json                    │
   │ 📄 Format   : JSON configuration           │
   │ ⚡ Usage    : Connexion services externes  │
   │ 💡 Exemple  : Database, Slack, GitHub API  │
   └────────────────────────────────────────────┘
```

**📌 Important** : Un plugin peut contenir **n'importe quelle combinaison** de ces composants !

**Exemples** :
- Plugin minimal : Juste 1 command
- Plugin complet : Commands + Agents + Skills + Hooks + MCP
- Plugin spécialisé : Seulement Skills + Hooks

---

## 🆕 Nouveautés 2025 - Système de Plugins

### Gestion des Plugins Améliorée

**Installation depuis marketplace** :
```bash
# Ajouter une marketplace
/plugin marketplace add your-org/claude-plugins

# Installer un plugin
/plugin install formatter@your-org

# Enable/disable
/plugin enable plugin-name@marketplace-name
/plugin disable plugin-name@marketplace-name
```

**Configuration équipe dans `.claude/settings.json`** :
```json
{
  "enabledPlugins": {
    "formatter@company-tools": true
  },
  "extraKnownMarketplaces": {
    "company-tools": {
      "source": {"source": "github", "repo": "org/repo"}
    }
  }
}
```

### Types de Sources Supportées

- **GitHub repositories** : `github.com/org/repo`
- **URLs Git** : Tout repo git accessible
- **Répertoires locaux** : Pour développement

## 🏗️ Architecture d'un Plugin

### 📐 Structure Standard

Voici la structure **complète** d'un plugin (tous composants inclus) :

```
my-awesome-plugin/
┣━━ 📁 .claude-plugin/          ⭐ REQUIS
┃   ┗━━ 📄 plugin.json          ⭐ Manifeste obligatoire
┃
┣━━ 📁 commands/                ✨ Optionnel
┃   ┣━━ 📄 create-api.md
┃   ┣━━ 📄 review-pr.md
┃   ┗━━ 📄 debug-error.md
┃
┣━━ 📁 agents/                  ✨ Optionnel
┃   ┣━━ 📄 code-reviewer.md
┃   ┣━━ 📄 test-generator.md
┃   ┗━━ 📄 security-auditor.md
┃
┣━━ 📁 skills/                  ✨ Optionnel
┃   ┣━━ 📁 pdf-processor/
┃   ┃   ┗━━ 📄 SKILL.md
┃   ┗━━ 📁 image-analyzer/
┃       ┗━━ 📄 SKILL.md
┃
┣━━ 📁 hooks/                   ✨ Optionnel
┃   ┗━━ 📄 hooks.json
┃
┣━━ 📄 .mcp.json                ✨ Optionnel
┃
┣━━ 📁 scripts/                 📦 Utilitaires
┃   ┣━━ 📄 install.sh
┃   ┗━━ 📄 setup.js
┃
┣━━ 📄 README.md                📚 Documentation
┣━━ 📄 LICENSE                  ⚖️ Licence
┗━━ 📄 .gitignore               🔒 Exclusions Git
```

**📋 Checklist Structure** :
- ✅ `.claude-plugin/plugin.json` **OBLIGATOIRE**
- ✅ Directories (`commands/`, `agents/`, etc.) à la **racine**
- ✅ Pas dans `.claude-plugin/` (seulement plugin.json dedans)
- ✅ README.md pour documenter usage

### 📄 Le Manifeste : plugin.json

Le fichier **`plugin.json`** est le **cœur du plugin**. Il décrit son contenu.

**Schema minimal** :

```json
{
  "name": "my-plugin"
}
```

C'est tout ! Juste le `name` est requis.

**Schema complet** :

```json
{
  "name": "my-awesome-plugin",
  "version": "1.2.0",
  "description": "Plugin pour développement frontend React/Next.js",
  "author": {
    "name": "Équipe Frontend",
    "email": "frontend@entreprise.com"
  },
  "license": "MIT",
  "homepage": "https://github.com/org/my-plugin",
  "repository": {
    "type": "git",
    "url": "https://github.com/org/my-plugin.git"
  },
  "keywords": ["react", "nextjs", "frontend", "testing"],

  "commands": ["./commands"],
  "agents": "./agents/",
  "hooks": "./hooks/hooks.json",
  "mcpServers": "./.mcp.json"
}
```

**Champs Importants** :

| Champ | Type | Description |
|-------|------|-------------|
| `name` | string | ⭐ **REQUIS** - Identifiant unique (kebab-case) |
| `version` | string | Versioning sémantique (1.2.0) |
| `description` | string | Description courte |
| `author` | object | Informations auteur |
| `commands` | array/string | Chemins vers commands/ |
| `agents` | string | Chemin vers agents/ |
| `hooks` | string | Chemin vers hooks.json |
| `mcpServers` | string | Chemin vers .mcp.json |

**💡 Astuce** : Utilisez des chemins relatifs avec `${CLAUDE_PLUGIN_ROOT}` pour portabilité !

**Exemple avancé** :

```json
{
  "name": "enterprise-security",
  "version": "2.0.0",
  "commands": [
    "./commands/security",
    "./commands/compliance"
  ],
  "agents": "${CLAUDE_PLUGIN_ROOT}/agents",
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/production.json",
  "mcpServers": "${CLAUDE_PLUGIN_ROOT}/.mcp.json"
}
```

### 🌳 Arborescence par Composant

Détaillons chaque dossier :

#### 1️⃣ commands/

Contient vos **slash commands** réutilisables.

```
commands/
┣━━ 📄 create-endpoint.md
┣━━ 📄 generate-tests.md
┗━━ 📄 refactor-component.md
```

Chaque `.md` contient un prompt avec frontmatter :

```markdown
---
name: create-endpoint
description: Créer un endpoint API RESTful
---

Crée un endpoint API avec :
- Validation Zod
- Error handling
- Tests Jest
- Documentation OpenAPI
```

**Usage après installation** : `/create-endpoint`

#### 2️⃣ agents/

Contient vos **sub-agents** spécialisés.

```
agents/
┣━━ 📄 code-reviewer.md
┣━━ 📄 test-runner.md
┗━━ 📄 security-auditor.md
```

Exemple `code-reviewer.md` :

```markdown
# Code Reviewer Agent

Tu es un expert en revue de code. Tu dois :

1. Analyser la qualité du code
2. Identifier les bugs potentiels
3. Suggérer des améliorations
4. Vérifier les best practices

## Tools Available
- Read, Edit, Grep, Bash

## Output Format
Markdown avec sections :
- 🐛 Bugs
- ⚡ Performance
- 🎨 Style
- ✅ Validations
```

**Usage** : Claude invoque automatiquement ou via Task tool.

#### 3️⃣ skills/

Contient vos **skills** (capacités autonomes).

```
skills/
┣━━ 📁 pdf-analyzer/
┃   ┗━━ 📄 SKILL.md
┗━━ 📁 screenshot-diff/
    ┗━━ 📄 SKILL.md
```

Chaque skill a son propre dossier avec `SKILL.md`.

**Voir** : [Guide Skills](../skills/guide.md) pour détails.

#### 4️⃣ hooks/

Fichier `hooks.json` pour événements système.

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '🚀 Plugin chargé !'"
    },
    {
      "event": "PostToolUse",
      "script": "bash scripts/validate.sh"
    }
  ]
}
```

**Événements disponibles** :
- `SessionStart`, `SessionEnd`
- `PreToolUse`, `PostToolUse`
- `UserPromptSubmit`
- `Notification`
- `Stop`, `SubagentStop`
- `PreCompact`

#### 5️⃣ .mcp.json

Configuration MCP servers dans le plugin.

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}"
      }
    }
  }
}
```

**Voir** : [Guide MCP](../mcp/guide.md) pour configuration détaillée.

---

## 🛠️ Création de Plugins

### 🎬 Premier Plugin Simple

Créons un plugin minimal en **5 minutes** !

**Objectif** : Plugin avec 1 command pour créer des composants React.

#### Étape 1 : Structure de base

```bash
mkdir my-first-plugin
cd my-first-plugin
mkdir -p .claude-plugin commands
```

#### Étape 2 : Créer plugin.json

```bash
cat > .claude-plugin/plugin.json << 'EOF'
{
  "name": "react-helpers",
  "version": "1.0.0",
  "description": "Helpers pour développement React",
  "commands": ["./commands"]
}
EOF
```

#### Étape 3 : Créer votre première command

```bash
cat > commands/create-component.md << 'EOF'
---
name: create-component
description: Créer un composant React avec TypeScript
---

Crée un composant React fonctionnel avec :

1. TypeScript + Props interface
2. Fichier .module.css associé
3. Tests Jest/RTL
4. Storybook story

Demande le nom du composant, puis génère tous les fichiers.
EOF
```

#### Étape 4 : Tester localement

```bash
# Créer marketplace locale
cd ..
mkdir test-marketplace
cp -r my-first-plugin test-marketplace/

# Dans Claude Code
/plugin marketplace add ./test-marketplace
/plugin install react-helpers@test-marketplace
/plugin enable react-helpers

# Tester
/create-component
```

**🎉 Félicitations !** Vous avez créé votre premier plugin !

### 🔧 Ajouter des Commands

Enrichissons notre plugin avec plus de commands.

```bash
cd my-first-plugin

# Command pour hooks
cat > commands/create-hook.md << 'EOF'
---
name: create-hook
description: Créer un custom React hook
---

Crée un hook React réutilisable avec :
- TypeScript
- Tests unitaires
- Documentation JSDoc
- Exemple d'utilisation
EOF

# Command pour contextes
cat > commands/create-context.md << 'EOF'
---
name: create-context
description: Créer un Context React avec provider
---

Génère :
- Context + Provider
- Hook useContext personnalisé
- TypeScript types
- Tests
EOF
```

**Mettre à jour plugin.json** (si chemins spécifiques) :

```json
{
  "name": "react-helpers",
  "version": "1.1.0",
  "commands": [
    "./commands/create-component.md",
    "./commands/create-hook.md",
    "./commands/create-context.md"
  ]
}
```

**💡 Ou pointer vers le dossier** :

```json
{
  "commands": ["./commands"]
}
```

Claude charge automatiquement tous les `.md` du dossier !

### 🤖 Ajouter des Sub-Agents

Ajoutons un agent de revue de code React.

```bash
mkdir agents

cat > agents/react-reviewer.md << 'EOF'
---
name: react-reviewer
description: Expert React/Next.js reviewer. Reviews code for performance, best practices, and TypeScript quality. Use proactively after React code changes.
tools: Read, Grep, Edit, Bash
model: sonnet
permissionMode: default
---

You are an expert React/Next.js code reviewer.

When invoked:
1. Run git diff to see recent React/Next.js changes
2. Focus on modified components and hooks
3. Begin review immediately

## 🎯 Review Checklist

### Performance
- Correct usage of useMemo/useCallback
- Avoid unnecessary re-renders
- Appropriate code splitting
- Lazy loading of components

### Best Practices
- Hooks rules respected
- Avoid props drilling (use Context if necessary)
- Purely functional components
- Accessibility (a11y)

### TypeScript
- Strict types (no any)
- Complete props interfaces
- Generics when relevant

## 📋 Output Format

Provide feedback organized by priority:

```markdown
# React Review - [Component Name]

## ✅ Points Positifs
- ...

## ⚠️ À Améliorer
- ...

## 🔧 Code Suggestions
...
```
EOF
```

**Mettre à jour plugin.json** :

```json
{
  "name": "react-helpers",
  "version": "1.2.0",
  "commands": ["./commands"],
  "agents": "./agents"
}
```

**Usage après installation** :

```bash
# Claude invoque automatiquement lors de revues React
# Ou manuellement via Task tool
```

### 🎓 Bundler des Skills

Ajoutons un skill pour analyser les bundles Webpack.

```bash
mkdir -p skills/bundle-analyzer

cat > skills/bundle-analyzer/SKILL.md << 'EOF'
# Bundle Analyzer Skill

Analyse les bundles JavaScript/TypeScript pour optimiser la taille.

## Capabilities
- Parse webpack-bundle-analyzer output
- Identifier gros packages
- Suggérer alternatives légères
- Détecter duplications

## Usage
Invoqué automatiquement quand l'utilisateur demande analyse de bundle.

## Tools
Read (pour lire stats.json), Bash (pour générer rapports)
EOF
```

**Mettre à jour plugin.json** :

```json
{
  "name": "react-helpers",
  "version": "1.3.0",
  "commands": ["./commands"],
  "agents": "./agents"
  // Skills auto-découverts dans skills/
}
```

### 🪝 Configurer des Hooks

Ajoutons des hooks pour valider le code avant commits.

```bash
mkdir hooks

cat > hooks/hooks.json << 'EOF'
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '⚛️ React Helpers Plugin activé !'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "bash scripts/lint-changed.sh"
    },
    {
      "event": "UserPromptSubmit",
      "script": "echo 'Analysing React patterns...'"
    }
  ]
}
EOF
```

**Créer script de validation** :

```bash
mkdir scripts

cat > scripts/lint-changed.sh << 'EOF'
#!/bin/bash
# Valider fichiers .tsx/.jsx modifiés

echo "🔍 Linting fichiers React..."
eslint --ext .tsx,.jsx .
EOF

chmod +x scripts/lint-changed.sh
```

**Mettre à jour plugin.json** :

```json
{
  "name": "react-helpers",
  "version": "1.4.0",
  "commands": ["./commands"],
  "agents": "./agents",
  "hooks": "./hooks/hooks.json"
}
```

### 🔌 Intégrer MCP Servers

Ajoutons MCP pour connexion base de données.

```bash
cat > .mcp.json << 'EOF'
{
  "mcpServers": {
    "supabase": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "${SUPABASE_URL}"
      }
    },
    "vercel": {
      "command": "npx",
      "args": ["-y", "@vercel/mcp-server"],
      "env": {
        "VERCEL_TOKEN": "${VERCEL_TOKEN}"
      }
    }
  }
}
EOF
```

**Mettre à jour plugin.json** :

```json
{
  "name": "react-helpers",
  "version": "2.0.0",
  "commands": ["./commands"],
  "agents": "./agents",
  "hooks": "./hooks/hooks.json",
  "mcpServers": "./.mcp.json"
}
```

**🎉 Plugin Complet !** Vous avez maintenant un plugin avec **tous les composants** :
- ✅ Commands
- ✅ Agents
- ✅ Skills
- ✅ Hooks
- ✅ MCP Servers

---

## 🏪 Marketplaces

### 🎯 Qu'est-ce qu'une Marketplace ?

Une **marketplace** est un **catalogue JSON** qui liste des plugins disponibles.

**Analogie** :

```
Marketplace = App Store
Plugin = Application

┌─────────────────────────────────────┐
│  📱 MARKETPLACE "Frontend Tools"    │
├─────────────────────────────────────┤
│  📦 react-helpers       v2.0.0      │
│  📦 vue-toolkit         v1.5.3      │
│  📦 angular-utils       v3.1.0      │
│  📦 tailwind-pro        v1.2.4      │
└─────────────────────────────────────┘

Commande :
/plugin install react-helpers@frontend-tools
```

**Avantages** :
- 🎯 Distribution centralisée
- 🔄 Versioning automatique
- 👥 Partage équipe simplifié
- 🔒 Gouvernance (qui peut installer quoi)

### 📐 Structure d'une Marketplace

Fichier `marketplace.json` :

```json
{
  "name": "frontend-tools",
  "owner": {
    "name": "Équipe Frontend",
    "email": "frontend@entreprise.com"
  },
  "description": "Outils développement frontend",
  "plugins": [
    {
      "name": "react-helpers",
      "source": {
        "source": "github",
        "repo": "entreprise/react-helpers"
      },
      "description": "Helpers React/Next.js",
      "version": "2.0.0"
    },
    {
      "name": "tailwind-pro",
      "source": "./local-plugins/tailwind-pro",
      "description": "Utilitaires Tailwind CSS",
      "version": "1.2.0"
    }
  ]
}
```

**Schéma complet** :

```
╔══════════════════════════════════════════════════════════╗
║  MARKETPLACE.JSON - STRUCTURE                            ║
╚══════════════════════════════════════════════════════════╝

{
  "name": string                  // Identifiant marketplace
  "owner": {                      // Propriétaire
    "name": string,
    "email": string (optionnel)
  },
  "description": string,          // Description
  "strict": boolean,              // Mode strict (default: true)
  "plugins": [                    // Liste plugins
    {
      "name": string,             // ⭐ Nom plugin
      "source": string | object,  // ⭐ Source
      "description": string,      // Description
      "version": string,          // Versioning sémantique
      "author": object,           // Auteur (optionnel)
      "keywords": array           // Tags recherche
    }
  ]
}
```

### 🔗 Sources de Plugins

Un plugin peut provenir de **4 sources** :

#### 1️⃣ GitHub Repository

```json
{
  "name": "react-helpers",
  "source": {
    "source": "github",
    "repo": "organisation/react-helpers",
    "ref": "main"  // Optionnel (branche/tag)
  }
}
```

**Avantages** :
- ✅ Versioning Git automatique
- ✅ CI/CD intégrable
- ✅ Pull requests pour reviews

#### 2️⃣ Git Repository (autre que GitHub)

```json
{
  "name": "internal-tools",
  "source": {
    "source": "git",
    "url": "https://gitlab.com/team/internal-tools.git",
    "ref": "v1.2.0"
  }
}
```

**Cas d'usage** :
- GitLab, Bitbucket, repos privés
- Self-hosted Git servers

#### 3️⃣ Chemin Local

```json
{
  "name": "dev-plugin",
  "source": "./plugins/dev-plugin"
}
```

**Cas d'usage** :
- Développement local
- Testing avant publication
- Plugins non-versionnés

#### 4️⃣ URL Directe

```json
{
  "name": "external-plugin",
  "source": "https://cdn.example.com/plugins/external-plugin.zip"
}
```

### 🚀 Créer une Marketplace

#### Marketplace Locale (Développement)

**Étape 1 : Structure**

```bash
mkdir team-marketplace
cd team-marketplace

# Créer quelques plugins
mkdir react-helpers vue-toolkit

# Structure react-helpers
mkdir -p react-helpers/.claude-plugin
echo '{"name":"react-helpers"}' > react-helpers/.claude-plugin/plugin.json

# Structure vue-toolkit
mkdir -p vue-toolkit/.claude-plugin
echo '{"name":"vue-toolkit"}' > vue-toolkit/.claude-plugin/plugin.json
```

**Étape 2 : marketplace.json**

```bash
cat > marketplace.json << 'EOF'
{
  "name": "team-tools",
  "owner": {
    "name": "Équipe Dev"
  },
  "description": "Outils internes équipe développement",
  "plugins": [
    {
      "name": "react-helpers",
      "source": "./react-helpers",
      "description": "Helpers React",
      "version": "1.0.0"
    },
    {
      "name": "vue-toolkit",
      "source": "./vue-toolkit",
      "description": "Toolkit Vue.js",
      "version": "1.0.0"
    }
  ]
}
EOF
```

**Étape 3 : Ajouter dans Claude**

```bash
# Dans Claude Code
/plugin marketplace add ./team-marketplace
/plugin install react-helpers@team-tools
```

#### Marketplace GitHub (Production)

**Étape 1 : Créer Repo GitHub**

```bash
# Créer repo
gh repo create team-plugins --public

# Structure
mkdir team-plugins
cd team-plugins

# Ajouter plugins comme submodules OU dossiers
mkdir plugins
# ... ajouter vos plugins
```

**Étape 2 : marketplace.json**

```json
{
  "name": "team-official",
  "owner": {
    "name": "Organisation",
    "email": "dev@org.com"
  },
  "plugins": [
    {
      "name": "react-helpers",
      "source": {
        "source": "github",
        "repo": "organisation/react-helpers",
        "ref": "v2.0.0"
      },
      "version": "2.0.0"
    }
  ]
}
```

**Étape 3 : Distribution Équipe**

```bash
# Chaque membre ajoute :
/plugin marketplace add https://github.com/organisation/team-plugins
/plugin install react-helpers@team-official
```

**💡 Automatiser avec `.claude/settings.json`** :

```json
{
  "extraKnownMarketplaces": {
    "team-official": {
      "source": {
        "source": "github",
        "repo": "organisation/team-plugins"
      }
    }
  }
}
```

Maintenant `/plugin install react-helpers` cherche automatiquement dans `team-official` !

### 📦 Distribuer des Plugins

#### Workflow Git Standard

**1. Développement**

```bash
# Créer plugin
mkdir my-plugin
cd my-plugin
git init

# Développer...
mkdir -p .claude-plugin commands
# ...

# Commit
git add .
git commit -m "feat: initial plugin"
```

**2. Publication GitHub**

```bash
# Push sur GitHub
gh repo create my-plugin --public
git push origin main

# Créer release
git tag v1.0.0
git push --tags
gh release create v1.0.0 --generate-notes
```

**3. Ajouter à Marketplace**

Éditer `marketplace.json` de votre organisation :

```json
{
  "plugins": [
    {
      "name": "my-plugin",
      "source": {
        "source": "github",
        "repo": "username/my-plugin",
        "ref": "v1.0.0"
      },
      "version": "1.0.0"
    }
  ]
}
```

**4. Update**

```bash
# Développer v1.1.0
git commit -m "feat: nouvelle fonctionnalité"
git tag v1.1.0
git push --tags
gh release create v1.1.0

# Mettre à jour marketplace.json
```

#### Workflow Équipe Enterprise

**Configuration `.claude/settings.json`** partagée :

```json
{
  "extraKnownMarketplaces": {
    "enterprise-tools": {
      "source": {
        "source": "github",
        "repo": "company/plugins-marketplace"
      }
    }
  },
  "autoInstallPlugins": [
    "security-baseline@enterprise-tools",
    "code-standards@enterprise-tools",
    "compliance-checker@enterprise-tools"
  ]
}
```

**Avantages** :
- ✅ Plugins installés automatiquement pour nouveaux membres
- ✅ Standards enforced au niveau organisation
- ✅ Compliance automatique
- ✅ Gouvernance centralisée

### 🔒 Mode "strict" vs "loose"

**Mode strict (default)** :

```json
{
  "strict": true,  // ou omis (default)
  "plugins": [
    {
      "name": "my-plugin",
      "source": "./my-plugin"
    }
  ]
}
```

Chaque plugin **DOIT avoir** `.claude-plugin/plugin.json`.

**Mode loose** :

```json
{
  "strict": false,
  "plugins": [
    {
      "name": "simple-plugin",
      "source": "./simple-plugin",
      "commands": ["./commands"],
      "agents": "./agents"
    }
  ]
}
```

L'entrée marketplace **devient le manifeste** ! Pas besoin de `plugin.json` dans le plugin.

**Quand utiliser loose ?**
- Prototyping rapide
- Plugins très simples
- Migration legacy tools

---

## 🔧 Développement Avancé

### 🌍 Variables d'Environnement

#### ${CLAUDE_PLUGIN_ROOT}

Pointe vers le **chemin absolu du plugin**.

**Utilisation dans plugin.json** :

```json
{
  "name": "my-plugin",
  "commands": ["${CLAUDE_PLUGIN_ROOT}/commands"],
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/hooks.json"
}
```

**Utilisation dans hooks** :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/init.sh"
    }
  ]
}
```

**Utilisation dans scripts** :

```bash
#!/bin/bash
# scripts/setup.sh

CONFIG_PATH="${CLAUDE_PLUGIN_ROOT}/config"
source "${CONFIG_PATH}/env.sh"

echo "Plugin root: ${CLAUDE_PLUGIN_ROOT}"
```

**💡 Pourquoi ?** Portabilité totale ! Le plugin fonctionne peu importe où il est installé.

#### Variables Custom

Définir vos propres variables dans `.mcp.json` :

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["-y", "server-postgres"],
      "env": {
        "DATABASE_URL": "${DATABASE_URL}",
        "API_KEY": "${INTERNAL_API_KEY}",
        "ENV": "production"
      }
    }
  }
}
```

L'utilisateur définit dans son shell :

```bash
export DATABASE_URL="postgres://..."
export INTERNAL_API_KEY="sk-..."
```

### 🗂️ Organisation Complexe

#### Plugin Multi-Environnements

```
enterprise-plugin/
┣━━ 📁 .claude-plugin/
┃   ┗━━ 📄 plugin.json
┣━━ 📁 commands/
┃   ┣━━ 📁 dev/
┃   ┃   ┗━━ 📄 debug.md
┃   ┣━━ 📁 staging/
┃   ┃   ┗━━ 📄 deploy-staging.md
┃   ┗━━ 📁 production/
┃       ┗━━ 📄 deploy-prod.md
┣━━ 📁 hooks/
┃   ┣━━ 📄 dev.hooks.json
┃   ┣━━ 📄 staging.hooks.json
┃   ┗━━ 📄 production.hooks.json
┗━━ 📁 config/
    ┣━━ 📄 dev.env
    ┣━━ 📄 staging.env
    └━━ 📄 production.env
```

**plugin.json conditionnel** :

```json
{
  "name": "enterprise-plugin",
  "commands": [
    "./commands/dev",
    "./commands/staging",
    "./commands/production"
  ],
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/${ENV}.hooks.json"
}
```

L'utilisateur définit `ENV` :

```bash
export ENV=production
```

#### Plugin Modulaire

```
modular-plugin/
┣━━ 📁 modules/
┃   ┣━━ 📁 frontend/
┃   ┃   ┣━━ 📄 plugin.json
┃   ┃   ┗━━ 📁 commands/
┃   ┣━━ 📁 backend/
┃   ┃   ┣━━ 📄 plugin.json
┃   ┃   ┗━━ 📁 commands/
┃   ┗━━ 📁 database/
┃       ┣━━ 📄 plugin.json
┃       ┗━━ 📁 commands/
┗━━ 📄 marketplace.json
```

**marketplace.json** :

```json
{
  "name": "modular",
  "plugins": [
    {
      "name": "frontend-module",
      "source": "./modules/frontend"
    },
    {
      "name": "backend-module",
      "source": "./modules/backend"
    },
    {
      "name": "database-module",
      "source": "./modules/database"
    }
  ]
}
```

L'utilisateur choisit ses modules :

```bash
/plugin install frontend-module@modular
/plugin install backend-module@modular
# Pas database si non nécessaire
```

### 🐛 Testing & Debugging

#### Commandes Debug

```bash
# Mode verbose
claude --debug

# Lister plugins installés
/plugin list

# Voir statut plugin
/plugin info react-helpers

# Désactiver temporairement
/plugin disable react-helpers

# Réactiver
/plugin enable react-helpers

# Désinstaller
/plugin uninstall react-helpers
```

#### Validation Plugin

**Créer script de validation** :

```bash
#!/bin/bash
# scripts/validate.sh

echo "🔍 Validation plugin..."

# Vérifier plugin.json existe
if [ ! -f ".claude-plugin/plugin.json" ]; then
  echo "❌ Manque .claude-plugin/plugin.json"
  exit 1
fi

# Valider JSON
if ! jq empty .claude-plugin/plugin.json 2>/dev/null; then
  echo "❌ plugin.json invalide"
  exit 1
fi

# Vérifier name présent
NAME=$(jq -r '.name' .claude-plugin/plugin.json)
if [ "$NAME" == "null" ] || [ -z "$NAME" ]; then
  echo "❌ Champ 'name' manquant"
  exit 1
fi

echo "✅ Plugin valide : $NAME"
```

**Utiliser dans CI/CD** :

```yaml
# .github/workflows/validate.yml
name: Validate Plugin

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate
        run: bash scripts/validate.sh
```

#### Common Issues

**Problème 1 : Plugin non détecté**

```bash
# Vérifier structure
ls -la .claude-plugin/
# Doit contenir plugin.json

# Vérifier JSON valide
cat .claude-plugin/plugin.json | jq .
```

**Problème 2 : Commands non chargées**

```bash
# Vérifier chemin dans plugin.json
jq '.commands' .claude-plugin/plugin.json

# Vérifier fichiers existent
ls -la commands/
```

**Problème 3 : Hooks non exécutés**

```bash
# Vérifier chemin hooks
jq '.hooks' .claude-plugin/plugin.json

# Vérifier format hooks.json
cat hooks/hooks.json | jq .

# Tester script manuellement
bash scripts/mon-hook.sh
```

### 📊 Versioning

#### Semantic Versioning

Suivre **semver.org** :

```
MAJOR.MINOR.PATCH

1.0.0 → 1.0.1  (patch : bug fix)
1.0.1 → 1.1.0  (minor : nouvelle feature)
1.1.0 → 2.0.0  (major : breaking change)
```

**Exemples** :

```json
// v1.0.0 - Initial release
{
  "name": "my-plugin",
  "version": "1.0.0",
  "commands": ["./commands"]
}

// v1.0.1 - Bug fix dans command
{
  "name": "my-plugin",
  "version": "1.0.1",
  "commands": ["./commands"]
}

// v1.1.0 - Ajout agent
{
  "name": "my-plugin",
  "version": "1.1.0",
  "commands": ["./commands"],
  "agents": "./agents"  // NOUVEAU
}

// v2.0.0 - Renommage commands (breaking)
{
  "name": "my-plugin",
  "version": "2.0.0",
  "commands": ["./cmd"]  // BREAKING: chemin changé
}
```

#### Update Policies

**Conservative** (recommandé équipes) :

```json
// marketplace.json
{
  "plugins": [
    {
      "name": "critical-plugin",
      "source": {
        "source": "github",
        "repo": "org/critical-plugin",
        "ref": "v1.2.3"  // Version EXACTE
      },
      "version": "1.2.3"
    }
  ]
}
```

**Progressive** :

```json
{
  "plugins": [
    {
      "name": "dev-plugin",
      "source": {
        "source": "github",
        "repo": "org/dev-plugin",
        "ref": "main"  // Dernière version main
      }
    }
  ]
}
```

**Workflow Updates** :

```bash
# Dev teste nouvelle version
/plugin install dev-plugin@latest

# Si OK, update marketplace
# v1.2.3 → v1.3.0

# Équipe pull
/plugin update dev-plugin
```

---

## 🎓 Cas Pratiques

### 🎨 Cas 1 : Plugin Équipe Frontend

**Contexte** : Équipe React/Next.js avec 10 devs, besoin standardisation.

**Objectifs** :
- ✅ Commands pour scaffolding (composants, hooks, pages)
- ✅ Agent revue code React
- ✅ Hooks pour linting auto
- ✅ MCP Vercel pour déploiements

#### Structure

```
frontend-team-plugin/
┣━━ .claude-plugin/
┃   ┗━━ plugin.json
┣━━ commands/
┃   ┣━━ create-component.md
┃   ┣━━ create-page.md
┃   ┣━━ create-api-route.md
┃   ┗━━ deploy.md
┣━━ agents/
┃   ┣━━ react-reviewer.md
┃   ┗━━ performance-auditor.md
┣━━ hooks/
┃   ┗━━ hooks.json
┣━━ .mcp.json
┗━━ scripts/
    ┣━━ lint.sh
    ┗━━ format.sh
```

#### plugin.json

```json
{
  "name": "frontend-team",
  "version": "1.0.0",
  "description": "Outils équipe frontend React/Next.js",
  "author": {
    "name": "Équipe Frontend"
  },
  "commands": ["./commands"],
  "agents": "./agents",
  "hooks": "./hooks/hooks.json",
  "mcpServers": "./.mcp.json"
}
```

#### hooks/hooks.json

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '⚛️ Frontend Team Plugin chargé !'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(tsx|jsx)$",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/lint.sh"
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "echo '⚠️ Vérifiez tests avant commit'"
    }
  ]
}
```

#### .mcp.json

```json
{
  "mcpServers": {
    "vercel": {
      "command": "npx",
      "args": ["-y", "@vercel/mcp-server"],
      "env": {
        "VERCEL_TOKEN": "${VERCEL_TOKEN}"
      }
    },
    "supabase": {
      "command": "npx",
      "args": ["-y", "@supabase/mcp-server"],
      "env": {
        "SUPABASE_URL": "${SUPABASE_URL}",
        "SUPABASE_KEY": "${SUPABASE_ANON_KEY}"
      }
    }
  }
}
```

#### Distribution

**Marketplace GitHub** :

```bash
# Créer repo
gh repo create frontend-team-plugin --private
git push origin main

# Marketplace organisation
cat > team-marketplace/marketplace.json << 'EOF'
{
  "name": "team-tools",
  "plugins": [
    {
      "name": "frontend-team",
      "source": {
        "source": "github",
        "repo": "organisation/frontend-team-plugin",
        "ref": "v1.0.0"
      },
      "version": "1.0.0"
    }
  ]
}
EOF
```

**Installation équipe** :

```bash
# Dans .claude/settings.json (partagé équipe)
{
  "extraKnownMarketplaces": {
    "team-tools": {
      "source": {
        "source": "github",
        "repo": "organisation/team-marketplace"
      }
    }
  },
  "autoInstallPlugins": [
    "frontend-team@team-tools"
  ]
}
```

**Résultat** :
- ✅ Chaque dev a automatiquement le plugin
- ✅ Commands standardisées : `/create-component`, `/deploy`
- ✅ Revues code automatiques (agent)
- ✅ Linting auto après éditions
- ✅ Connexion Vercel/Supabase

### 🔒 Cas 2 : Enterprise Security Plugin

**Contexte** : Grande entreprise, compliance stricte, audits sécurité.

**Objectifs** :
- ✅ Agent security auditor
- ✅ Commands pour scans vulnérabilités
- ✅ Hooks bloquants si credentials détectées
- ✅ MCP pour SIEM (Security Information and Event Management)

#### Structure

```
enterprise-security/
┣━━ .claude-plugin/
┃   ┗━━ plugin.json
┣━━ agents/
┃   ┣━━ security-auditor.md
┃   ┣━━ compliance-checker.md
┃   ┗━━ threat-detector.md
┣━━ commands/
┃   ┣━━ scan-dependencies.md
┃   ┣━━ check-secrets.md
┃   ┗━━ audit-report.md
┣━━ hooks/
┃   ┗━━ hooks.json
┣━━ .mcp.json
┗━━ scripts/
    ┣━━ detect-secrets.sh
    ┗━━ vulnerability-scan.sh
```

#### hooks/hooks.json (Bloquants)

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/detect-secrets.sh",
      "blocking": true
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(env|yaml|json)$",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-config.sh",
      "blocking": true
    },
    {
      "event": "SessionEnd",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/send-audit-log.sh"
    }
  ]
}
```

#### scripts/detect-secrets.sh

```bash
#!/bin/bash
# Bloquer si secrets détectés

if grep -rE '(password|api_key|secret)\\s*=\\s*["\'][^"\']+["\']' . ; then
  echo "❌ BLOQUÉ : Credentials détectées !"
  echo "Utilisez variables d'environnement."
  exit 1
fi

echo "✅ Aucun secret détecté"
exit 0
```

#### .mcp.json (SIEM)

```json
{
  "mcpServers": {
    "siem": {
      "command": "npx",
      "args": ["-y", "@company/siem-mcp-server"],
      "env": {
        "SIEM_ENDPOINT": "${SIEM_ENDPOINT}",
        "SIEM_TOKEN": "${SIEM_TOKEN}"
      }
    },
    "vault": {
      "command": "npx",
      "args": ["-y", "@hashicorp/vault-mcp"],
      "env": {
        "VAULT_ADDR": "${VAULT_ADDR}",
        "VAULT_TOKEN": "${VAULT_TOKEN}"
      }
    }
  }
}
```

**Résultat** :
- 🔒 Impossible de commit secrets (hook bloquant)
- 🔍 Scans vulnérabilités automatiques
- 📊 Logs d'audit envoyés au SIEM
- ✅ Compliance enforced automatiquement

### 🏢 Cas 3 : Marketplace Organisation

**Contexte** : Organisation 100+ devs, multiples équipes (Frontend, Backend, DevOps, Security).

**Objectif** : Marketplace centralisée avec plugins par domaine.

#### Structure Marketplace

```
company-marketplace/
┣━━ marketplace.json
┣━━ plugins/
┃   ┣━━ frontend-tools/
┃   ┣━━ backend-tools/
┃   ┣━━ devops-tools/
┃   ┗━━ security-baseline/
┗━━ README.md
```

#### marketplace.json

```json
{
  "name": "company-official",
  "owner": {
    "name": "Engineering",
    "email": "engineering@company.com"
  },
  "description": "Marketplace officielle Company",
  "plugins": [
    {
      "name": "frontend-tools",
      "source": {
        "source": "github",
        "repo": "company/frontend-tools",
        "ref": "v2.1.0"
      },
      "description": "Outils React/Next.js",
      "version": "2.1.0",
      "keywords": ["react", "nextjs", "frontend"]
    },
    {
      "name": "backend-tools",
      "source": {
        "source": "github",
        "repo": "company/backend-tools",
        "ref": "v1.5.2"
      },
      "description": "Outils Node.js/Python",
      "version": "1.5.2",
      "keywords": ["nodejs", "python", "api"]
    },
    {
      "name": "devops-tools",
      "source": {
        "source": "github",
        "repo": "company/devops-tools",
        "ref": "v3.0.1"
      },
      "description": "CI/CD, Docker, K8s",
      "version": "3.0.1",
      "keywords": ["docker", "kubernetes", "terraform"]
    },
    {
      "name": "security-baseline",
      "source": {
        "source": "github",
        "repo": "company/security-baseline",
        "ref": "v1.0.0"
      },
      "description": "Standards sécurité obligatoires",
      "version": "1.0.0",
      "keywords": ["security", "compliance"],
      "required": true
    }
  ]
}
```

#### Configuration Équipe (.claude/settings.json)

**Frontend Team** :

```json
{
  "extraKnownMarketplaces": {
    "company-official": {
      "source": {
        "source": "github",
        "repo": "company/marketplace"
      }
    }
  },
  "autoInstallPlugins": [
    "security-baseline@company-official",
    "frontend-tools@company-official"
  ]
}
```

**Backend Team** :

```json
{
  "extraKnownMarketplaces": {
    "company-official": {
      "source": {
        "source": "github",
        "repo": "company/marketplace"
      }
    }
  },
  "autoInstallPlugins": [
    "security-baseline@company-official",
    "backend-tools@company-official"
  ]
}
```

**DevOps Team** :

```json
{
  "autoInstallPlugins": [
    "security-baseline@company-official",
    "devops-tools@company-official",
    "frontend-tools@company-official",
    "backend-tools@company-official"
  ]
}
```

**Résultat** :
- ✅ `security-baseline` installé pour TOUS (obligatoire)
- ✅ Chaque équipe a ses outils spécifiques
- ✅ DevOps a accès à tout (multi-domaines)
- ✅ Updates centralisées (bump version → tous reçoivent)

### 🔄 Cas 4 : Multi-Plugin Workflow

**Contexte** : Dev fullstack travaillant sur React + Node.js + PostgreSQL.

**Objectif** : Combiner plusieurs plugins pour workflow complet.

#### Plugins Installés

```bash
# Marketplace personnelle
/plugin marketplace add ./my-marketplace

# Plugins individuels
/plugin install react-helpers@my-marketplace
/plugin install node-backend@my-marketplace
/plugin install postgres-tools@my-marketplace
/plugin install testing-suite@my-marketplace
```

#### Workflow Typique

**1. Nouvelle Feature**

```bash
# Créer composant React
/create-component UserProfile

# Créer endpoint API
/create-endpoint /api/users/:id

# Créer table PostgreSQL
/create-migration add_users_table
```

**2. Développement**

```bash
# Agent revue React (de react-helpers)
# Agent revue API (de node-backend)
# Automatiques via hooks PostToolUse
```

**3. Tests**

```bash
# Générer tests (de testing-suite)
/generate-tests UserProfile
/generate-integration-tests /api/users
```

**4. Déploiement**

```bash
# Migration DB (de postgres-tools)
/migrate production

# Deploy API (de node-backend)
/deploy-api staging

# Deploy frontend (de react-helpers)
/deploy-frontend staging
```

**Schéma Workflow** :

```
┌─────────────────────────────────────────────────┐
│  WORKFLOW MULTI-PLUGIN                          │
├─────────────────────────────────────────────────┤
│                                                 │
│  1️⃣ SCAFFOLDING                                │
│     /create-component    [react-helpers]       │
│     /create-endpoint     [node-backend]        │
│     /create-migration    [postgres-tools]      │
│            │                                    │
│            ▼                                    │
│  2️⃣ DÉVELOPPEMENT                              │
│     Edit fichiers                               │
│     → Hooks auto-lint    [tous plugins]        │
│     → Agents review      [react/node]          │
│            │                                    │
│            ▼                                    │
│  3️⃣ TESTS                                      │
│     /generate-tests      [testing-suite]       │
│     → Hooks run tests    [testing-suite]       │
│            │                                    │
│            ▼                                    │
│  4️⃣ DÉPLOIEMENT                                │
│     /migrate production  [postgres-tools]      │
│     /deploy-api          [node-backend]        │
│     /deploy-frontend     [react-helpers]       │
│                                                 │
└─────────────────────────────────────────────────┘
```

**Résultat** :
- ✅ Workflow fluide multi-technos
- ✅ Chaque plugin apporte ses outils
- ✅ Hooks orchestrent automatiquement
- ✅ Productivité maximale

---

## 🎯 Points Clés

### ✅ Concepts Essentiels

1. **Plugin = Bundle Réutilisable**
   - Commands, Agents, Skills, Hooks, MCP
   - Versionné, partageable, modulaire

2. **Marketplace = Catalogue Distribution**
   - GitHub, Git, local
   - Versioning sémantique
   - Auto-installation équipes

3. **5 Composants Possibles**
   - Commands : Slash commands
   - Agents : Sub-agents spécialisés
   - Skills : Capacités autonomes
   - Hooks : Événements système
   - MCP : Services externes

4. **plugin.json = Manifeste Obligatoire**
   - Seul champ requis : `name`
   - Chemins relatifs avec `${CLAUDE_PLUGIN_ROOT}`
   - Dans `.claude-plugin/` directory

### 🔧 Best Practices

**DO ✅** :

- ✅ **Versionner** vos plugins (semver)
- ✅ **Documenter** dans README.md
- ✅ **Tester** localement avant distribution
- ✅ **Utiliser** `${CLAUDE_PLUGIN_ROOT}` pour portabilité
- ✅ **Organiser** par domaine (frontend/, backend/, etc.)
- ✅ **Automatiser** avec hooks pertinents
- ✅ **Partager** via marketplaces équipe
- ✅ **Valider** JSON avec `jq` ou linters

**DON'T ❌** :

- ❌ **Mélanger** configurations personnelles et plugins
- ❌ **Oublier** `.claude-plugin/plugin.json`
- ❌ **Hardcoder** chemins absolus
- ❌ **Pusher** secrets dans plugins (use env vars)
- ❌ **Ignorer** versioning sémantique
- ❌ **Créer** plugins monolithiques (privilégier modularité)
- ❌ **Surcharger** hooks (performance)

### 🚨 Erreurs Courantes

**1. plugin.json mal placé**

```
❌ MAUVAIS :
my-plugin/
└── plugin.json  (à la racine)

✅ CORRECT :
my-plugin/
└── .claude-plugin/
    └── plugin.json
```

**2. Chemins absolus**

```json
❌ MAUVAIS :
{
  "hooks": "/Users/me/plugins/my-plugin/hooks.json"
}

✅ CORRECT :
{
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/hooks.json"
}
```

**3. Confusion Sub-agents**

⚠️ **IMPORTANT** : Les sub-agents peuvent être définis :
- Dans plugins (`agents/`)
- Dans `.claude/settings.json`
- Les deux sont valides !

```json
// Plugin
{
  "agents": "./agents"
}

// OU settings.json
{
  "agents": {
    "my-agent": {
      "prompt": "..."
    }
  }
}
```

**4. Hooks bloquants mal utilisés**

```json
❌ MAUVAIS : Bloquer toutes les éditions
{
  "event": "PreToolUse",
  "tool": "Edit",
  "blocking": true,
  "script": "sleep 10"  // ❌ Ralentit tout !
}

✅ CORRECT : Bloquer seulement si problème
{
  "event": "PreToolUse",
  "tool": "Edit",
  "pattern": "\\.env$",
  "blocking": true,
  "script": "bash check-secrets.sh"  // Rapide, ciblé
}
```

### 📊 Quand Utiliser Quoi ?

**Plugin Simple** :
- 1-5 commands
- Pas d'agents/hooks
- Usage personnel
→ Structure minimale

**Plugin Équipe** :
- Commands standardisées
- Agents revue code
- Hooks linting
- MCP services partagés
→ Marketplace GitHub

**Plugin Enterprise** :
- Compliance enforced
- Hooks bloquants
- MCP SIEM/Vault
- Multi-environnements
→ Marketplace privée + gouvernance

**Marketplace Organisation** :
- Multiples plugins
- Versioning strict
- Auto-installation
- Governance centralisée
→ `.claude/settings.json` partagé

---

## 🌐 Architecture de l'Écosystème Plugins

### 🏗️ Vue Hiérarchique Complète

Comprendre la hiérarchie globale de l'écosystème plugins :

```
                         🌐 INTERNET
                              │
        ╔═════════════════════╧═════════════════════╗
        ║       🏪 MARKETPLACE LAYER                ║
        ║  (GitHub, Git, Local, Organisation)       ║
        ╚═════════════════════╤═════════════════════╝
                              │
           ┌──────────────────┼──────────────────┐
           │                  │                  │
      ╔════╧═════╗      ╔════╧═════╗      ╔════╧═════╗
      ║ 📊 PROJET ║      ║ 📊 PROJET ║      ║ 📊 PROJET ║
      ║   Data    ║      ║  FinTech  ║      ║    Web    ║
      ╚════╤═════╝      ╚════╤═════╝      ╚════╤═════╝
           │                  │                  │
    ┌──────┴──────┐    ┌──────┴──────┐    ┌──────┴──────┐
    │             │    │             │    │             │
╔═══╧═══╗   ╔═══╧═══╗ ╔═══╧═══╗   ╔═══╧═══╗ ╔═══╧═══╗   ╔═══╧═══╗
║📦Plugin║   ║📦Plugin║ ║📦Plugin║   ║📦Plugin║ ║📦Plugin║   ║📦Plugin║
║   A    ║   ║   B    ║ ║   C    ║   ║   D    ║ ║   E    ║   ║   F    ║
╚═══╤═══╝   ╚═══╤═══╝ ╚═══╤═══╝   ╚═══╤═══╝ ╚═══╤═══╝   ╚═══╤═══╝
    │           │        │           │        │           │
    └───────────┴────────┴───────────┴────────┴───────────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
   ╔════╧═════╗          ╔════╧═════╗         ╔════╧═════╗
   ║ 🔧 COMPO- ║          ║ 🤖 COMPO- ║         ║ 💡 COMPO- ║
   ║  NENTS    ║          ║  NENTS    ║         ║  NENTS    ║
   ╚════╤═════╝          ╚════╤═════╝         ╚════╤═════╝
        │                     │                     │
   Commands              Agents                 Skills
   Hooks                 MCP                    Scripts
```

### 🔄 Flux de Données et Interactions

Comprendre comment les données circulent dans l'écosystème :

```
   👨‍💻 USER
      │
      │ /command ou prompt
      ▼
┌──────────────────┐
│  💬 Claude Code  │◄───────── 📝 CLAUDE.md (Guidelines)
│    Interface     │
└────────┬─────────┘
         │
         │ Parse & Route
         ▼
┌────────────────────────────────────────────────┐
│            📦 PLUGIN ECOSYSTEM                 │
│  ┌──────────┬──────────┬──────────┬─────────┐ │
│  │ Commands │  Agents  │  Skills  │  Hooks  │ │
│  │    🔧    │    🤖    │    💡    │   🎣    │ │
│  └────┬─────┴────┬─────┴────┬─────┴────┬────┘ │
│       │          │          │          │      │
│       └──────────┴──────────┴──────────┘      │
│                   │                            │
└───────────────────┼────────────────────────────┘
                    │
          ┌─────────┴─────────┐
          │                   │
     🔌 MCP Servers      📜 Scripts
     (External APIs)     (Executables)
          │                   │
          ▼                   ▼
    🌐 Services          ⚙️ Actions
```

### 🎯 Modèle Conceptuel : Du Marketplace au Code

```
MARKETPLACE 🏪          INSTALLATION 📥         RUNTIME ⚡
═══════════════         ═══════════════         ══════════

[GitHub Repos]                                 User types:
[Git URLs]      ──┐                           "/deploy prod"
[Local Paths]     │                                 │
[Org Registries]  │                                 ▼
                  │                           Plugin détecté
                  └─► /plugin install ──►     │
                      my-plugin@github        ▼
                            │              Command exécuté
                            ▼                   │
                      Plugin copié            ▼
                      dans projet          Agents invoqués
                            │                   │
                            ▼                   ▼
                      Hooks activés        MCP appelés
                            │                   │
                            ▼                   ▼
                      ✅ Prêt               Résultat ✨
```

---

## 📊 Tableau Comparatif Exhaustif des Composants

### 🔍 Comparaison Détaillée

| Composant | Rôle Principal | Invocation | Format Fichier | Analogie Métier | Exemple Concret |
|-----------|---------------|------------|----------------|-----------------|-----------------|
| **Command** 🔧 | Action immédiate invocable | `/deploy` par user | `.md` avec frontmatter YAML | Bouton d'action dans UI | `/create-api` → génère endpoint |
| **Agent** 🤖 | Orchestrateur intelligent multi-tâches | Auto ou via Task tool | `.md` avec instructions + capabilities | Chef de projet assignant tâches | Agent "code-reviewer" analyse PR |
| **Skill** 💡 | Expertise métier packagée réutilisable | Invoqué automatiquement par Claude | `SKILL.md` dans dossier dédié | Formation professionnelle | Skill "pdf-processor" lit PDFs |
| **Hook** 🎣 | Réaction automatique à événements | Trigger automatique (events) | `hooks.json` avec config | Alarme/Notification système | Hook "PreToolUse" bloque .env |
| **MCP** 🔌 | Connecteur vers services externes | Via API/protocol | `.mcp.json` avec config serveur | Intégration SaaS (Zapier) | MCP "database" query PostgreSQL |
| **Script** 📜 | Fichier exécutable autonome | Par hooks, skills ou commands | `.sh`, `.py`, `.js`, etc. | Outil dans boîte à outils | `deploy.sh` déploie app |

### 🎯 Quand Utiliser Chaque Composant ?

```
╔═══════════════════════════════════════════════════════════════════╗
║  SCÉNARIO                          │  COMPOSANT RECOMMANDÉ        ║
╠════════════════════════════════════╪══════════════════════════════╣
║  Action rapide utilisateur         │  Command 🔧                  ║
║  Orchestration workflow complexe   │  Agent 🤖                    ║
║  Expertise réutilisable            │  Skill 💡                    ║
║  Automatisation sur événements     │  Hook 🎣                     ║
║  Connexion services externes       │  MCP 🔌                      ║
║  Exécution code système            │  Script 📜                   ║
║  Guidelines comportement Claude    │  CLAUDE.md 📝                ║
╚═══════════════════════════════════════════════════════════════════╝
```

### 💡 Exemples Concrets d'Usage par Composant

#### Command : Action Directe
```markdown
# /deploy

Déploie l'application sur l'environnement spécifié.

**Usage**: /deploy [staging|production]

**Steps**:
1. Run tests (npm test)
2. Build assets (npm run build)
3. Push to server (rsync)
4. Verify deployment (health check)
5. Notify team (Slack webhook)
```

#### Agent : Orchestration
```markdown
# Release Manager Agent

Tu es un gestionnaire de release. Ton rôle :
- Coordonner le pipeline de déploiement complet
- Valider que tous les tests passent
- Gérer le rollback si nécessaire
- Notifier les stakeholders

**Tools Available**: Bash, Read, Edit, Write

Toujours vérifier les dépendances avant de déployer.
```

#### Skill : Expertise Packagée
```markdown
# Data Validation Skill

**Expertise**: Valider qualité et intégrité des données

**Capabilities**:
- Validation de schémas (JSON Schema, Zod)
- Détection de duplicatas
- Analyse d'outliers statistiques
- Profilage de données (types, distributions)

**Usage**: Invoke automatiquement quand données à valider.

**Tools**: Python scripts in `scripts/validate.py`
```

---

## 🔄 Cycle de Vie Complet d'un Plugin

### 📈 Du Concept à la Production

```
  START (💡 Idée)
    │
    ▼
╔═══════════════════╗
║  1. IDEATION      ║  → Définir besoin métier clair
╚═══════╤═══════════╝  → Identifier composants nécessaires
        │              → Estimer complexité (Simple/Équipe/Enterprise)
        ▼
╔═══════════════════╗
║  2. ARCHITECTURE  ║  → Choisir composants (Commands/Agents/Skills/Hooks/MCP)
╚═══════╤═══════════╝  → Définir structure dossiers
        │              → Planifier dépendances externes
        ▼
╔═══════════════════╗
║  3. DEVELOPMENT   ║  → Coder fichiers .md, scripts, configs JSON
╚═══════╤═══════════╝  → Respecter conventions nommage
        │              → Documenter inline (commentaires)
        ▼
╔═══════════════════╗
║  4. LOCAL TEST    ║  → Test marketplace locale
╚═══════╤═══════════╝  → Validation fonctionnelle
        │              → Fix bugs détectés
        ▼
    ┌───┴───┐
    │ OK?   │───► NON ──┐
    └───┬───┘           │
        │ OUI           │
        ▼               ▼
╔═══════════════════╗   RETOUR
║  5. VERSIONING    ║   à DEVELOPMENT
╚═══════╤═══════════╝
        │   Semantic versioning (semver):
        │   • MAJOR.MINOR.PATCH
        │   • 1.0.0 → 1.1.0 (new feature)
        │   • 1.1.0 → 1.1.1 (bug fix)
        │   • 1.1.1 → 2.0.0 (breaking change)
        ▼
╔═══════════════════╗
║  6. DOCUMENTATION ║  → README.md complet avec exemples
╚═══════╤═══════════╝  → CHANGELOG.md avec historique
        │              → Screenshots/GIFs si UI
        ▼
╔═══════════════════╗
║  7. PUBLISH       ║  → Git tag version (git tag v1.0.0)
╚═══════╤═══════════╝  → Push to marketplace (GitHub/Git/Org)
        │              → Annoncer release (changelog, docs)
        ▼
╔═══════════════════╗
║  8. DISTRIBUTION  ║  → Users install via /plugin install
╚═══════╤═══════════╝  → Monitoring downloads/usage
        │              → Collecter feedback utilisateurs
        ▼
╔═══════════════════╗
║  9. MONITORING    ║  → Issues GitHub
╚═══════╤═══════════╝  → Demandes features
        │              → Bug reports
        ▼
╔═══════════════════╗
║ 10. MAINTENANCE   ║  → Corriger bugs (patch releases)
╚═══════╤═══════════╝  → Ajouter features (minor releases)
        │              → Refactoring majeur (major releases)
        │
        └──────► RETOUR à DEVELOPMENT (Cycle continu)
```

### ⏱️ Timeline Typique par Type de Plugin

```
Plugin Simple (1-5 commands)
════════════════════════════
Ideation      : 30 min
Development   : 2-4h
Testing       : 30 min
Documentation : 1h
Total         : 4-6h

Plugin Équipe (Commands + Agents + Hooks)
═════════════════════════════════════════
Ideation      : 2h (meetings équipe)
Architecture  : 4h (design review)
Development   : 1-2 jours
Testing       : 4h (QA multi-env)
Documentation : 4h (user guides)
Total         : 3-5 jours

Plugin Enterprise (Full stack + Governance)
═══════════════════════════════════════════
Ideation      : 1 semaine (stakeholders)
Architecture  : 1 semaine (security review)
Development   : 2-4 semaines
Testing       : 1 semaine (compliance tests)
Documentation : 1 semaine (full docs)
Deployment    : 1 semaine (phased rollout)
Total         : 6-10 semaines
```

---

## ✅ Best Practices & Conventions Détaillées

### 🏷️ Guidelines de Nommage

```
┌─────────────────────────────────────────────────────────────────┐
│  ÉLÉMENT           │  CONVENTION          │  EXEMPLES          │
├────────────────────┼──────────────────────┼────────────────────┤
│  Plugin name       │  kebab-case          │  data-validator    │
│                    │                      │  frontend-tools    │
│                    │                      │  security-audit    │
├────────────────────┼──────────────────────┼────────────────────┤
│  Command file      │  verb-noun.md        │  create-api.md     │
│                    │                      │  deploy-app.md     │
│                    │                      │  run-tests.md      │
├────────────────────┼──────────────────────┼────────────────────┤
│  Agent file        │  role-based.md       │  code-reviewer.md  │
│                    │                      │  orchestrator.md   │
│                    │                      │  security-audit.md │
├────────────────────┼──────────────────────┼────────────────────┤
│  Skill folder      │  domain-name/        │  pdf-processor/    │
│                    │                      │  data-analytics/   │
│                    │                      │  image-ocr/        │
├────────────────────┼──────────────────────┼────────────────────┤
│  Script file       │  action.ext          │  deploy.sh         │
│                    │                      │  validate.py       │
│                    │                      │  backup.js         │
├────────────────────┼──────────────────────┼────────────────────┤
│  Version           │  semver              │  1.0.0             │
│                    │  MAJOR.MINOR.PATCH   │  2.3.1             │
│                    │                      │  0.1.0-beta        │
├────────────────────┼──────────────────────┼────────────────────┤
│  MCP server key    │  service-name        │  database          │
│                    │                      │  slack             │
│                    │                      │  github-api        │
└─────────────────────────────────────────────────────────────────┘
```

### 🏗️ Organisation Recommandée : Single Responsibility Principle

```
Principe : Un plugin = Un domaine métier
═════════════════════════════════════════

    ❌ MAUVAIS (Plugin monolithique)
    ═══════════════════════════════

    mega-company-plugin/
    ├─ commands/
    │  ├─ deploy.md          # DevOps
    │  ├─ test.md            # QA
    │  ├─ validate-data.md   # Data
    │  ├─ api-call.md        # Backend
    │  └─ train-model.md     # ML
    ├─ agents/
    │  ├─ everything.md      # Fait tout !
    │  └─ ...
    └─ hooks/
       └─ all-hooks.json     # Trop de responsabilités

    ❌ Problèmes :
    • Difficile à maintenir (trop de domaines)
    • Couplage fort (changement casse tout)
    • Impossible à réutiliser partiellement
    • Confusion des responsabilités


    ✅ BON (Plugins modulaires par domaine)
    ═══════════════════════════════════════

    Company Ecosystem/
    │
    ├─ devops-toolkit/           📦 Plugin 1 : DevOps
    │  ├─ commands/
    │  │  ├─ deploy.md
    │  │  └─ rollback.md
    │  ├─ agents/
    │  │  └─ deployment-manager.md
    │  └─ hooks/
    │     └─ hooks.json
    │
    ├─ testing-suite/            📦 Plugin 2 : Tests
    │  ├─ commands/
    │  │  ├─ run-tests.md
    │  │  └─ coverage.md
    │  ├─ agents/
    │  │  └─ test-coordinator.md
    │  └─ scripts/
    │     └─ run-all.sh
    │
    ├─ data-platform/            📦 Plugin 3 : Data
    │  ├─ skills/
    │  │  ├─ etl-processing/
    │  │  └─ validation/
    │  ├─ agents/
    │  │  └─ data-orchestrator.md
    │  └─ .mcp.json
    │
    └─ ml-ops/                   📦 Plugin 4 : Machine Learning
       ├─ commands/
       │  └─ train-model.md
       ├─ skills/
       │  └─ model-deployment/
       └─ agents/
          └─ ml-pipeline.md

    ✅ Avantages :
    • Maintenabilité : Chaque plugin a un scope clair
    • Réutilisabilité : Installer seulement ce dont on a besoin
    • Scalabilité : Ajouter plugins sans toucher existants
    • Collaboration : Équipes différentes = plugins différents
```

### 🔒 Sécurité et Gestion des Secrets

```
CHECKLIST SÉCURITÉ COMPLÈTE
═══════════════════════════

  🔐 Secrets & Credentials
  ⬜ JAMAIS hardcoder API keys, tokens, passwords
  ⬜ Utiliser variables d'environnement exclusivement
  ⬜ Ajouter .env à .gitignore
  ⬜ Fournir .env.example avec placeholders
  ⬜ Documenter variables requises dans README

  🛡️ Validation & Sanitization
  ⬜ Valider TOUS les inputs utilisateur
  ⬜ Sanitizer données avant exécution scripts
  ⬜ Limiter longueur inputs (prevent DoS)
  ⬜ Whitelister caractères autorisés (regex)

  📝 Logging & Audit
  ⬜ Logger actions sensibles (éditions fichiers critiques)
  ⬜ NE PAS logger secrets/credentials
  ⬜ Timestamp tous les logs
  ⬜ Niveau de log configurable (DEBUG, INFO, WARN, ERROR)

  🔧 Permissions Scripts
  ⬜ Permissions minimales (principe du moindre privilège)
  ⬜ chmod 755 pour scripts exécutables
  ⬜ chmod 644 pour configs/data
  ⬜ Éviter sudo dans scripts (documenter si requis)

  🧪 Testing Sécurité
  ⬜ Tester en sandbox isolée d'abord
  ⬜ Code review par peer avant merge
  ⬜ Scanner vulnérabilités (bandit, shellcheck, etc.)
  ⬜ Test injection (SQL, command, XSS si applicable)

  📚 Documentation Sécurité
  ⬜ Lister permissions requises explicitement
  ⬜ Documenter surface d'attaque
  ⬜ Changelog sécurité dans releases
  ⬜ Security policy (SECURITY.md)
```

**Gestion des Secrets - Exemple Concret** :

```bash
# ❌ MAUVAIS : Secrets hardcodés
# commands/deploy.md
API_KEY="sk_live_abc123xyz"  # ❌ JAMAIS FAIRE ÇA !
curl -H "Authorization: Bearer $API_KEY" ...

# ✅ BON : Variables d'environnement
# commands/deploy.md
if [ -z "$API_KEY" ]; then
  echo "❌ Erreur : Variable API_KEY non définie"
  echo "💡 Définir dans .env ou exporter :"
  echo "   export API_KEY=your_key_here"
  exit 1
fi
curl -H "Authorization: Bearer $API_KEY" ...
```

**Fichiers de configuration** :

```bash
# .env (NON versionné, ajouté à .gitignore)
API_KEY=sk_live_abc123xyz
DATABASE_URL=postgresql://user:pass@localhost/db
SLACK_WEBHOOK=https://hooks.slack.com/services/xxx

# .env.example (Versionné dans Git)
API_KEY=your_api_key_here
DATABASE_URL=postgresql://user:password@host:5432/database
SLACK_WEBHOOK=https://hooks.slack.com/services/YOUR_WEBHOOK
```

### 📦 Gestion des Dépendances Multi-Niveaux

```
PYRAMIDE DES DÉPENDANCES
════════════════════════

┌─────────────────────────────────────────────────────────┐
│                                                         │
│  📍 NIVEAU 1 : System Level (OS)                       │
│  ════════════════════════════════                       │
│  Requis sur machine hôte                               │
│  • Python 3.9+                                          │
│  • Node.js 18+                                          │
│  • Bash 5.0+                                            │
│  • Git 2.30+                                            │
│                                                         │
│  📝 Documentation : README.md section "Prerequisites"   │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  📍 NIVEAU 2 : Plugin Level (Inter-plugins)            │
│  ══════════════════════════════════════                 │
│  Dépendances entre plugins                             │
│                                                         │
│  # plugin.json                                          │
│  {                                                      │
│    "dependencies": {                                    │
│      "base-utils": "^1.0.0",                            │
│      "security-tools": ">=2.1.0 <3.0.0"                 │
│    }                                                    │
│  }                                                      │
│                                                         │
│  📝 Versioning semver avec ranges                       │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  📍 NIVEAU 3 : Script Level (Runtime)                  │
│  ════════════════════════════════                       │
│  Dépendances scripts individuels                       │
│                                                         │
│  # requirements.txt (Python)                            │
│  pandas>=2.0.0                                          │
│  requests^2.31.0                                        │
│  pydantic~=2.5.0                                        │
│                                                         │
│  # package.json (Node.js)                               │
│  {                                                      │
│    "dependencies": {                                    │
│      "axios": "^1.6.0",                                 │
│      "zod": "^3.22.0"                                   │
│    }                                                    │
│  }                                                      │
│                                                         │
│  📝 Lockfiles pour reproductibilité                     │
│     • requirements.lock                                 │
│     • package-lock.json                                 │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Semantic Versioning (semver) Expliqué** :

```
MAJOR.MINOR.PATCH
  │     │     │
  │     │     └─► Bug fixes (1.0.0 → 1.0.1)
  │     │         • Pas de breaking changes
  │     │         • Rétrocompatible 100%
  │     │         • Exemple : Fix typo, correction calcul
  │     │
  │     └───────► New features (1.0.0 → 1.1.0)
  │               • Nouvelles fonctionnalités
  │               • Rétrocompatible (backward compatible)
  │               • Exemple : Nouvelle command, nouvel agent
  │
  └─────────────► Breaking changes (1.0.0 → 2.0.0)
                  • Changements incompatibles
                  • Peut casser code existant
                  • Exemple : Renommer command, changer API

Préfixes spéciaux :
• ^1.2.3  →  >=1.2.3 <2.0.0  (minor updates OK)
• ~1.2.3  →  >=1.2.3 <1.3.0  (patch updates OK)
• >=1.0.0 <2.0.0             (range explicite)
```

---

## 🔧 Variables d'Environnement Importantes

### 📋 Référence Complète

```
┌──────────────────────────────────────────────────────────────┐
│  VARIABLE                   │  USAGE                         │
├─────────────────────────────┼────────────────────────────────┤
│  CLAUDE_PLUGIN_PATH         │  Chemin racine plugins locaux  │
│  Exemple: ~/my-plugins      │  Override path par défaut      │
│                             │                                │
│  CLAUDE_PLUGIN_ROOT         │  Racine du plugin courant      │
│  (Auto-set par Claude)      │  Utilisé dans plugin.json      │
│                             │  Exemple: ${CLAUDE_PLUGIN_ROOT}│
│                             │                                │
│  CLAUDE_MCP_CONFIG          │  Path vers .mcp.json custom    │
│  Exemple: ~/.claude-mcp.json│  Si différent de défaut       │
│                             │                                │
│  CLAUDE_LOG_LEVEL           │  Niveau logging                │
│  Values: DEBUG, INFO, WARN, │  Contrôle verbosité logs       │
│         ERROR               │                                │
│                             │                                │
│  CLAUDE_SANDBOX_MODE        │  Isolation des exécutions      │
│  Values: true, false        │  Sécurité scripts              │
│                             │                                │
│  CLAUDE_MAX_SCRIPT_TIME     │  Timeout scripts (secondes)    │
│  Exemple: 300 (5 minutes)   │  Prévient scripts infinis      │
│                             │                                │
│  CLAUDE_MARKETPLACE_URL     │  URL marketplace custom        │
│  Exemple: https://my.org/   │  Pour organisations            │
│         plugins/            │                                │
└──────────────────────────────────────────────────────────────┘
```

**Exemple d'utilisation dans plugin.json** :

```json
{
  "name": "my-plugin",
  "commands": "${CLAUDE_PLUGIN_ROOT}/commands",
  "agents": "${CLAUDE_PLUGIN_ROOT}/agents",
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/hooks.json",
  "mcpServers": "${CLAUDE_PLUGIN_ROOT}/.mcp.json"
}
```

**Pourquoi utiliser `${CLAUDE_PLUGIN_ROOT}` ?**
- ✅ **Portabilité** : Plugin fonctionne quel que soit le chemin d'installation
- ✅ **Multi-OS** : Compatible Linux, macOS, Windows
- ✅ **Team sharing** : Pas de paths hardcodés spécifiques à une machine

---

## 📚 Ressources

### 📄 Documentation Officielle

- 📄 **Claude Code Plugins** : https://code.claude.com/docs/en/plugins (inféré)
- 📄 **Engineering Best Practices** : https://www.anthropic.com/engineering/claude-code-best-practices

### 📝 Articles & Deep Dives

- 📝 **Understanding Claude Code Full Stack** : https://alexop.dev/posts/understanding-claude-code-full-stack/
  - Architecture complète Plugins système
  - Intégration Commands, Agents, Hooks, MCP
  - Patterns production

### 🎥 Vidéos Recommandées

- 🎥 **NetworkChuck** - Claude Code Terminal Workflow
  - Workflow multi-plugins en production
- 🎥 **Edmund Yong - 800h Claude Code** : https://www.youtube.com/watch?v=Ffh9OeJ7yxw
  - Setup complet plugins ecosystem
  - Best practices organisation

### 🔗 Repositories Communauté

- 🔗 **Awesome Claude Plugins** : https://github.com/VoltAgent/awesome-claude-plugins (inféré)
  - Catalogue plugins communautaire
  - Frontend, Backend, DevOps, Security
- 🔗 **Weston Hobson Plugins** : https://github.com/wshobson/commands
  - Commands packagées en plugins
- 🔗 **Edmund Yong Setup** : https://github.com/edmund-io/edmunds-claude-code
  - Configuration plugins production

### 📚 Ressources Internes

- 📋 [Cheatsheet Plugins](./cheatsheet.md) - Référence rapide API
- 🎓 [Exemples Plugins](./cas-usage.md) - Cas d'usage pratiques
- 🔗 [Commands](../2-commands/guide.md) - Packaging commands
- 🔗 [Agents](../6-agents/guide.md) - Packaging agents
- 🔗 [Skills](../4-skills/guide.md) - Packaging skills
- 🔗 [Hooks](../3-hooks/guide.md) - Packaging hooks
- 🔗 [MCP](../5-mcp/guide.md) - Intégration MCP dans plugins
- 🔗 [Memory](../1-memory/guide.md) - Memory vs Plugins

### 🛠️ Outils Validation

- **jq** : Valider JSON - https://jqlang.github.io/jq/
- **yamllint** : Valider YAML
- **shellcheck** : Valider scripts Bash

---

## 🎓 Conclusion

Les **Plugins Claude Code** sont le **système d'extensibilité le plus puissant** pour :

✅ **Standardiser** workflows équipes
✅ **Partager** configurations facilement
✅ **Versionner** prompts et outils
✅ **Distribuer** via marketplaces
✅ **Automatiser** avec hooks

**Prochaines Étapes** :

1. 🏪 Configurez marketplace locale
2. 👥 Partagez avec votre équipe
3. 🚀 Explorez plugins communauté

**Happy Plugin Building!** 🔌
