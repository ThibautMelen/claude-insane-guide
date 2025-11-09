# 📰 Claude Code - Dernières News et Fonctionnalités 2025

**Date de mise à jour :** Janvier 2025
**Sources :** Documentation officielle Anthropic, Engineering Blog

---

## 🚀 Vue d'ensemble

Claude Code est l'outil CLI officiel d'Anthropic pour le coding agentique. Il permet à Claude de fonctionner comme un développeur autonome avec accès complet à votre environnement de développement.

### Modèle Actuel
- **Claude Sonnet 4.5** (septembre 2025)
- 70.6% sur SWE-bench Verified (state-of-the-art)
- Peut maintenir le focus pendant 30+ heures sur des tâches complexes
- 200,000 tokens de contexte
- **Prix :** $3/M tokens input, $15/M tokens output

---

## 🆕 Nouvelles Fonctionnalités Majeures 2025

### 1. Checkpoints Automatiques
- Sauvegarde automatique de l'état du code avant chaque édition
- Retour en arrière avec `Esc+Esc` ou `/rewind`
- Permet l'expérimentation sans risque

### 2. Extensions Multi-plateformes
- **VS Code Extension (Beta)** - Intégration sidebar native avec diffs inline
- **Web Interface** - Claude Code sur le web pour utilisateurs Pro/Max
- **Mobile iOS** - Preview de recherche disponible
- **JetBrains IDEs** - IntelliJ, PyCharm, WebStorm, etc.

### 3. Subagents Spécialisés
- Agents spécialisés pour développement parallèle
- Isolation du contexte pour préserver les tokens
- Agents résumables avec `agentId`
- Types : Plan Agent (built-in), Custom subagents

### 4. Background Tasks
- Processus long-running restent actifs
- `/bashes` pour lister et gérer les tâches
- Parfait pour builds, tests, serveurs de dev

---

## 🔌 Système de Plugins

### Architecture des Plugins

Les plugins permettent d'étendre Claude Code avec des fonctionnalités personnalisées.

**Structure d'un plugin :**
```
my-plugin/
├── .claude-plugin/
│   └── plugin.json          # Métadonnées du plugin
├── commands/                 # Slash commands personnalisés
├── agents/                   # Subagents custom
├── skills/                   # Agent Skills
├── hooks/                    # Event handlers
└── .mcp.json                # Serveurs MCP
```

### Gestion des Plugins

**Installation :**
```bash
# Ajouter une marketplace
/plugin marketplace add your-org/claude-plugins

# Installer un plugin
/plugin install formatter@your-org

# Enable/disable
/plugin enable plugin-name@marketplace-name
/plugin disable plugin-name@marketplace-name
```

**Configuration équipe :**

Dans `.claude/settings.json` :
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

### Marketplaces

**Types de sources :**
- Repositories GitHub
- URLs Git
- Répertoires locaux

**Configuration :**
```json
{
  "name": "my-marketplace",
  "owner": {"name": "Organization"},
  "plugins": [
    {
      "name": "plugin-name",
      "source": "./plugin-folder",
      "description": "Plugin description"
    }
  ]
}
```

---

## 🧠 Système de Mémoire

### Hiérarchie des Fichiers CLAUDE.md

| Type | Localisation | Usage | Partagé avec |
|------|--------------|-------|--------------|
| **Enterprise** | `/Library/Application Support/ClaudeCode/CLAUDE.md` | Politiques org | Tous les users |
| **Project** | `./CLAUDE.md` ou `./.claude/CLAUDE.md` | Instructions équipe | Équipe via git |
| **User** | `~/.claude/CLAUDE.md` | Préférences perso | Vous (tous projets) |
| **Project Local** | `./CLAUDE.local.md` | Projet personnel | Vous (deprecated) |

### Fonctionnalités

**Imports :**
```markdown
Voir @README pour overview et @package.json pour npm commands.

# Instructions Additionnelles
- git workflow @docs/git-instructions.md
- Préférences perso @~/.claude/my-project-instructions.md
```
- Max profondeur : 5 niveaux
- Chemins relatifs et absolus supportés

**Quick Add :**
- Commencer l'input avec `#` pour ajouter rapidement en mémoire
- `/memory` pour éditer les fichiers de mémoire
- `/init` pour bootstrapper un CLAUDE.md

**Best Practices :**
- Être spécifique : "Utilise indentation 2 espaces" vs "Formate bien"
- Structurer avec headings markdown
- Rester concis : <100 lignes typiquement
- Réviser périodiquement

---

## ⚡ Slash Commands

### Built-in (40+)

| Commande | Description |
|----------|-------------|
| `/add-dir` | Ajouter répertoires de travail |
| `/agents` | Gérer les subagents |
| `/clear` | Effacer l'historique |
| `/compact [instructions]` | Compacter la conversation |
| `/config` | Ouvrir Settings |
| `/context` | Visualiser l'usage du contexte |
| `/cost` | Stats d'usage tokens |
| `/hooks` | Gérer les hooks |
| `/init` | Initialiser CLAUDE.md |
| `/mcp` | Gérer serveurs MCP |
| `/memory` | Éditer fichiers mémoire |
| `/model` | Sélectionner modèle |
| `/permissions` | Mettre à jour permissions |
| `/rewind` | Revenir en arrière |
| `/sandbox` | Activer sandboxing |
| `/status` | Voir version/modèle/compte |

### Slash Commands Personnalisés

**Localisation :**
- Projet : `.claude/commands/` (partagé via git)
- User : `~/.claude/commands/` (personnel)
- Plugin : `commands/` dans plugin root

**Format :**
```markdown
---
description: Description brève
allowed-tools: Bash(git:*), Edit, Read
argument-hint: [arg1] [arg2]
model: claude-sonnet-4-5-20250929
---

Instructions de la commande ici avec $ARGUMENTS ou $1, $2, etc.

# Exécution Bash avec !
- Statut actuel: !`git status`

# Références fichiers avec @
Review @src/utils/helpers.js
```

**Fonctionnalités :**
- Arguments : `$ARGUMENTS` (tous) ou `$1, $2, $3` (positionnels)
- Exécution Bash : `` !`git status` `` s'exécute avant la commande
- Références fichiers : `@path/to/file` inclut le contenu
- Namespacing : Sous-répertoires pour organisation

### SlashCommand Tool

Permet à Claude d'invoquer les commandes programmatiquement.

**Désactiver :**
```bash
/permissions
# Ajouter à deny rules: SlashCommand
```

**Désactiver commande spécifique :**
```markdown
---
disable-model-invocation: true
---
```

**Budget caractères :**
- Défaut : 15,000 caractères
- Custom : `SLASH_COMMAND_TOOL_CHAR_BUDGET` env var

---

## 🎣 Hooks

Les hooks sont des commandes shell qui s'exécutent à des points spécifiques du lifecycle.

### Événements Disponibles

- **PreToolUse** - Avant appels d'outils (peut bloquer)
- **PostToolUse** - Après complétion outil
- **UserPromptSubmit** - Quand user soumet prompt
- **Notification** - Quand Claude envoie notifications
- **Stop** - Quand Claude finit de répondre
- **SubagentStop** - Quand subagent se termine
- **PreCompact** - Avant compaction
- **SessionStart** - Début/reprise session
- **SessionEnd** - Fin session

### Configuration Exemple

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.command' >> ~/.claude/bash-log.txt"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "prettier --write \"$(jq -r '.tool_input.file_path')\""
          }
        ]
      }
    ]
  }
}
```

### Cas d'Usage

- **Notifications** - Alertes desktop quand input nécessaire
- **Formatage automatique** - Lancer prettier/gofmt après éditions
- **Logging** - Tracker toutes commandes pour compliance
- **Feedback** - Valider code contre conventions
- **Permissions custom** - Bloquer modifications fichiers sensibles
- **Testing** - Lancer tests après changements code

---

## 🤖 Agents et Subagents

### Qu'est-ce qu'un Subagent ?

Assistants IA spécialisés avec :
- But et expertise spécifiques
- Propre contexte window (séparé du principal)
- System prompt custom
- Permissions outils spécifiques

### Types

**Built-in :**
- **Plan Agent** - Utilisé en plan mode pour recherche codebase

**Custom Subagents :**
- Fichiers Markdown avec YAML frontmatter
- Localisations : `.claude/agents/` (projet) ou `~/.claude/agents/` (user)
- Plugin agents : Fournis par plugins

### Format de Configuration

```markdown
---
name: code-reviewer
description: Expert code review specialist. Use proactively after code changes.
tools: Read, Grep, Glob, Bash
model: sonnet  # ou 'inherit' ou 'opus' ou 'haiku'
---

System prompt ici. Définir rôle, capacités, approche, best practices,
et contraintes pour le subagent.
```

### Fonctionnalités Clés

**Préservation Contexte :**
- Chaque subagent a contexte isolé
- Évite pollution conversation principale

**Sélection Modèle :**
- Aliases : `sonnet`, `opus`, `haiku`
- `'inherit'` utilise modèle conversation principale

**Accès Outils :**
- Omettre `tools` pour hériter tous outils (including MCP)
- Spécifier outils individuels pour contrôle granulaire

**Invocation :**
- Automatique : Claude délègue selon description
- Explicite : "Use the test-runner subagent..."
- Proactive : Inclure "use PROACTIVELY" dans description

**Subagents Résumables :**
- Chaque exécution obtient `agentId` unique
- Reprendre conversation précédente : fournir `agentId` via paramètre `resume`

---

## 🛠️ Agent Skills (Nouvelle Fonctionnalité Majeure)

### Concept

Les **Agent Skills** permettent de donner à Claude des capacités spécialisées via des dossiers organisés d'instructions, scripts, et ressources.

### Principe : Progressive Disclosure

**3 Niveaux de détail :**

1. **Niveau 1 - Metadata** : `name` et `description` dans frontmatter (toujours chargé)
2. **Niveau 2 - SKILL.md complet** : Chargé quand skill pertinent
3. **Niveau 3+ - Fichiers additionnels** : Chargés on-demand

### Structure d'un Skill

```
.claude/skills/
└── pdf-processing/
    ├── SKILL.md           # Fichier principal
    ├── reference.md       # Documentation référence
    ├── forms.md           # Instructions formulaires
    └── scripts/
        ├── extract.py     # Scripts exécutables
        └── fill.py
```

### Exemple SKILL.md

```markdown
---
name: pdf-processing
description: Process, fill, and manipulate PDF documents
---

# PDF Processing Skill

This skill enables Claude to work with PDF files.

## Capabilities

- Read PDF metadata and content
- Fill PDF forms
- Extract text and images
- Merge/split PDFs

## Usage

When working with PDFs, read @reference.md for detailed API docs.
For form filling, read @forms.md for specific instructions.

## Scripts

- `scripts/extract.py` - Extract PDF form fields
- `scripts/fill.py` - Fill PDF form with data
```

### Avantages

- **Contexte débordé** : Scripts exécutés sans charger dans contexte
- **Découverte automatique** : Claude trouve et charge skills selon besoin
- **Composable** : Combiner plusieurs skills
- **Partageable** : Via git ou plugins

### Sécurité

⚠️ **Attention** : N'installer que des skills de sources fiables. Auditer le code et scripts avant utilisation.

---

## 🔗 Model Context Protocol (MCP)

### Qu'est-ce que MCP ?

Standard open-source pour connecter applications AI à outils et sources de données externes.

### Fonctionnement

**3 Types de transport :**
- HTTP (recommandé)
- SSE (déprécié)
- stdio (local)

**Installation :**
```bash
claude mcp add --transport http <name> <url>
```

**Authentification :**
- OAuth 2.0 pour serveurs remote via `/mcp`

**Scopes :**
- Local (projet-spécifique)
- Project (équipe-partagé)
- User (cross-project)

### Serveurs MCP Populaires

**Développement & Testing :**
- Sentry, Socket, Hugging Face, Jam

**Project Management :**
- Asana, Atlassian (Jira/Confluence)
- ClickUp, Linear, Notion
- Monday, Intercom

**Databases :**
- Airtable, HubSpot, Daloopa

**Payments :**
- PayPal, Plaid, Square, Stripe

**Design & Media :**
- Figma, Cloudinary, Canva, invideo

**Infrastructure :**
- Cloudflare, Netlify, Vercel

**Automation :**
- Workato, Zapier

### MCP Slash Commands

Format :
```bash
/mcp__<server-name>__<prompt-name> [arguments]
```

Exemple :
```bash
/mcp__github__list_prs
/mcp__github__pr_review 456
```

### Permissions MCP

⚠️ **Wildcards NON supportés** :

- ✅ `mcp__github` (approuve TOUS outils du serveur github)
- ✅ `mcp__github__get_issue` (approuve outil spécifique)
- ❌ `mcp__github__*` (wildcards non supportés)

---

## 🏆 Best Practices (Anthropic Engineering)

### 1. Customiser Votre Setup

**a. Créer fichiers CLAUDE.md**
- Commandes bash communes
- Fichiers core et fonctions utilitaires
- Guidelines style code
- Instructions testing
- Étiquette repository

**b. Tuner vos CLAUDE.md**
- Refiner comme n'importe quel prompt fréquent
- Utiliser `#` pour ajouter rapidement
- Passer par prompt improver parfois
- Ajouter emphase ("IMPORTANT", "YOU MUST")

**c. Gérer allowlist outils**
- Quatre méthodes : "Always allow", `/permissions`, édition manuelle, CLI flag
- Commencer conservateur, ouvrir progressivement

**d. Installer gh CLI**
- Claude sait utiliser `gh` pour GitHub
- Création issues, PRs, lecture comments, etc.

### 2. Donner Plus d'Outils à Claude

**a. Bash tools**
- Claude hérite votre environnement bash
- Documenter outils custom dans CLAUDE.md

**b. MCP**
- Config project, global, ou `.mcp.json` checked-in
- Flag `--mcp-debug` pour troubleshooting

**c. Custom slash commands**
- Templates prompts dans `.claude/commands`
- Keyword `$ARGUMENTS` pour paramètres

### 3. Workflows Communs

**a. Explore, Plan, Code, Commit**
1. Lire fichiers/images/URLs pertinents
2. Faire un plan (utiliser "think" pour extended thinking)
3. Implémenter solution
4. Commit et créer PR

**b. Write Tests, Commit; Code, Iterate, Commit**
1. Écrire tests basés sur input/output attendus
2. Lancer tests et confirmer qu'ils échouent
3. Commit tests
4. Écrire code qui passe les tests
5. Commit code

**c. Write Code, Screenshot Result, Iterate**
1. Donner à Claude moyen de prendre screenshots (Puppeteer MCP)
2. Fournir mock visuel
3. Implémenter design, screenshot, itérer
4. Commit

**d. Safe YOLO Mode**
- `claude --dangerously-skip-permissions` dans container sans internet
- Pour fixing lint ou génération boilerplate

**e. Codebase Q&A**
- Poser questions sur codebase
- Claude explore pour trouver réponses
- Excellent pour onboarding

**f. Interaction avec Git**
- Recherche historique git
- Écriture commit messages
- Opérations git complexes

**g. Interaction avec GitHub**
- Création PRs
- Résolution comments review
- Fixing failed builds
- Triage issues

**h. Jupyter Notebooks**
- Lecture et écriture notebooks
- Interprétation outputs incluant images
- Nettoyage esthétique

### 4. Optimiser Workflow

**a. Instructions spécifiques**
- Plus de détails = meilleur taux de succès

**b. Fournir images**
- Paste screenshots (cmd+ctrl+shift+4 sur macOS)
- Drag and drop
- Chemins fichiers

**c. Mentionner fichiers**
- Tab-completion pour référencer rapidement

**d. Fournir URLs**
- Paste URLs pour fetch et lecture
- Allowlist domaines via `/permissions`

**e. Course Correct Early**
- Demander plan avant coding
- Escape pour interrompre
- Double-tap Escape pour revenir en arrière
- Demander undo changes

**f. Utiliser `/clear`**
- Garder contexte focalisé
- Reset entre tâches

**g. Checklists et Scratchpads**
- Fichiers Markdown pour tâches complexes
- GitHub issues comme checklist

**h. Passer data à Claude**
- Copy-paste
- Pipe (`cat foo.txt | claude`)
- Claude pull via bash/MCP
- Lecture fichiers ou fetch URLs

### 5. Headless Mode (Automation)

Flag `-p` avec prompt pour mode non-interactif.

**Use cases :**
- Issue triage automatique
- Linting subjectif code reviews
- CI/CD automation

### 6. Multi-Claude Workflows

**a. Write + Verify Pattern**
1. Claude 1 écrit code
2. `/clear` ou nouveau Claude
3. Claude 2 review
4. Claude 3 édite basé sur feedback

**b. Multiple Checkouts**
- 3-4 checkouts git séparés
- Claude dans chaque avec tâche différente
- Cycler pour approuver permissions

**c. Git Worktrees**
```bash
git worktree add ../project-feature-a feature-a
cd ../project-feature-a && claude
```

**d. Headless avec Harness Custom**
- Fanning out : grandes migrations
- Pipelining : intégrer dans pipelines existants

---

## 📊 Context et Performance

### Context Window
- 200,000 tokens disponibles
- Utiliser `/context` pour visualiser usage
- Prompt caching : 90% réduction coût, 85% réduction latence

### Pricing
- Write cache : 1.25× coût base
- Read cache : 0.1× coût base

### Optimisations
- Context editing : retire appels outils stale (29% amélioration)
- Memory tool : stockage externe persistant
- Compaction : résumé pour maintenir espace (39% amélioration avec memory)

---

## 🔒 Sécurité

### Sandbox Mode

**Configuration :**
```json
{
  "sandbox": {
    "enabled": true,
    "autoAllowBashIfSandboxed": true,
    "excludedCommands": ["git", "docker"],
    "network": {
      "allowUnixSockets": ["/var/run/docker.sock"],
      "allowLocalBinding": true
    }
  }
}
```

### Permissions

**Configuration :**
```json
{
  "permissions": {
    "allow": ["Bash(npm run lint)", "Read(~/.zshrc)"],
    "deny": ["Bash(curl:*)", "Read(./.env)", "Read(./secrets/**)"],
    "ask": ["Bash(git push:*)"],
    "additionalDirectories": ["../docs/"],
    "defaultMode": "acceptEdits"
  }
}
```

### Best Practices

- Jamais run en tant que root
- Utiliser VM ou container
- Sandboxing avec filesystem + network isolation
- Auditer configs mensuellement
- Approche allowlist + denylist on top
- Trust MCP servers explicitement
- Exclure fichiers sensibles via deny rules

---

## 🌐 Variables d'Environnement

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_MODEL` | Modèle par défaut |
| `CLAUDE_CODE_MAX_OUTPUT_TOKENS` | Max output tokens |
| `MAX_MCP_OUTPUT_TOKENS` | Limite output MCP tool (défaut: 25,000) |
| `DISABLE_PROMPT_CACHING` | Désactiver caching |
| `SLASH_COMMAND_TOOL_CHAR_BUDGET` | Limite metadata commands (défaut: 15,000) |

---

## 📈 Statistiques et Croissance 2025

- **300%** croissance users actifs depuis lancement Claude 4
- **5.5x** augmentation revenue (Mai-Août 2025)
- **60%** réduction temps debugging
- **164%** augmentation vélocité développement
- Extensions web et mobile élargissent l'accès
- Maturation VS Code extension et JetBrains integration

---

## 🔮 Roadmap et Futur

### En Cours
- Features additionnelles pour lifecycle Skills complet
- Intégration Skills avec MCP servers
- Skills auto-créés et auto-évalués par agents

### Vision
- Agent SDK pour construire agents custom
- Agents pouvant créer/éditer leurs propres Skills
- Codification patterns comportement en capacités réutilisables

---

## 📚 Ressources

- **Documentation :** [code.claude.com/docs](https://code.claude.com/docs)
- **GitHub :** [github.com/anthropics/claude-code](https://github.com/anthropics/claude-code)
- **Skills Cookbook :** [github.com/anthropics/claude-cookbooks/tree/main/skills](https://github.com/anthropics/claude-cookbooks/tree/main/skills)
- **MCP Docs :** [modelcontextprotocol.io](https://modelcontextprotocol.io/)
- **Anthropic Academy :** [anthropic.skilljar.com](https://anthropic.skilljar.com/)

---

## 💡 Points Clés à Retenir

1. **Plugins** = Bundles de commands, agents, hooks, Skills, MCP servers
2. **Skills** = Capacités spécialisées avec progressive disclosure
3. **MCP** = Standard pour connecter outils et données externes
4. **Subagents** = Contexte isolé pour tâches spécialisées
5. **CLAUDE.md** = Mémoire hiérarchique (enterprise → project → user)
6. **Hooks** = Automation à points lifecycle spécifiques
7. **Progressive Disclosure** = Charger contexte only as needed
8. **Course Correction** = Interrupt, plan, iterate pour meilleurs résultats

---

*Document généré pour Supernovae Studio - Configuration Claude Code*
