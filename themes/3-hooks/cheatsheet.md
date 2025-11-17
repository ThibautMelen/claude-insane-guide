# 🎣 Hooks - Cheatsheet

> **Référence rapide pour hooks Claude Code**

---

## ⚡ Quick Start

### Configuration Minimale

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo 'Hello!'"
    }
  ]
}
```

**Localisation** :
- `.claude/settings.json` (projet)
- `~/.claude/settings.json` (global)
- `plugin/hooks/hooks.json` (plugin)

---

## 📋 Événements Disponibles

| Événement | Quand ? | Use Case |
|-----------|---------|----------|
| `SessionStart` | Démarrage session | Init, welcome message |
| `SessionEnd` | Fin session | Cleanup, logs |
| `PreToolUse` | **AVANT** outil | Validation, blocage |
| `PostToolUse` | **APRÈS** outil | Linting, tests, logs |
| `UserPromptSubmit` | User envoie prompt | Analytics, logging |
| `Notification` | Notification système | Custom handlers |
| `Stop` | Claude s'arrête | Cleanup |
| `SubagentStop` | Sub-agent termine | Logs, métriques |
| `PreCompact` | Avant compaction contexte | Sauvegarder état |

---

## 🔧 Propriétés Hook

| Propriété | Type | Requis ? | Description |
|-----------|------|----------|-------------|
| `event` | string | ✅ Oui | Type d'événement |
| `script` | string | ✅ Oui | Commande à exécuter |
| `tool` | string | ❌ Non | Filtrer par outil (`Edit`, `Bash`, etc.) |
| `pattern` | string | ❌ Non | Regex pour filtrer fichiers |
| `blocking` | boolean | ❌ Non | Hook bloquant si `true` (défaut: `false`) |

---

## 🎯 Templates Courants

### 🟢 Linting Auto

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(ts|tsx|js|jsx)$",
      "script": "eslint --fix $FILE"
    }
  ]
}
```

### 🟡 Tests Auto

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/",
      "script": "npm test -- --findRelatedTests $FILE"
    }
  ]
}
```

### 🟠 Bloquer Secrets

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "bash scripts/detect-secrets.sh",
      "blocking": true
    }
  ]
}
```

### 🔴 Notification Slack

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "curl -X POST $SLACK_WEBHOOK -d '{\"text\":\"Deploy done!\"}'"
    }
  ]
}
```

---

## 🧩 Variables Disponibles

Dans vos scripts, utilisez ces variables :

| Variable | Description | Exemple |
|----------|-------------|---------|
| `$FILE` | Fichier modifié | `src/App.tsx` |
| `$TOOL` | Outil utilisé | `Edit`, `Bash`, `Read` |
| `${CLAUDE_PLUGIN_ROOT}` | Racine plugin | `/path/to/plugin` |

**Exemple** :
```bash
echo "Tool: $TOOL modified $FILE"
```

---

## 🎨 Patterns Regex Utiles

```json
// JavaScript/TypeScript
"pattern": "\\.(js|jsx|ts|tsx)$"

// CSS/SCSS
"pattern": "\\.(css|scss|sass)$"

// Config files
"pattern": "\\.(json|yaml|yml)$"

// Source files only
"pattern": "^src/"

// Test files
"pattern": "\\.test\\.(ts|tsx)$"

// Specific directory
"pattern": "^components/"
```

---

## 🔒 Hooks Bloquants

**Ajouter `"blocking": true`** pour empêcher l'exécution si échec.

```json
{
  "event": "PreToolUse",
  "tool": "Bash",
  "script": "bash validate.sh",
  "blocking": true  // ← Si échec, Claude n'exécute PAS
}
```

**⚠️ Utiliser avec précaution** : Hooks bloquants doivent être **rapides** et **fiables** !

---

## 🚀 Multi-Environnements

**Structure** :
```
hooks/
├── dev.hooks.json
├── staging.hooks.json
└── production.hooks.json
```

**plugin.json** :
```json
{
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/${ENV}.hooks.json"
}
```

**Usage** :
```bash
export ENV=production
claude
```

---

## 🐛 Debug Hooks

### Vérifier Configuration

```bash
# Voir hooks actifs
cat .claude/settings.json | jq '.hooks'

# Tester script manuellement
bash scripts/my-hook.sh
```

### Logs

```bash
# Ajouter logs dans script
echo "[HOOK] $TOOL | $FILE" >> hooks.log
```

### Exit Codes

```bash
# Succès
exit 0

# Échec (bloque si "blocking": true)
exit 1
```

---

## ⚡ Quick Commands

```bash
# Permissions script
chmod +x scripts/hook.sh

# Valider JSON
jq . hooks/hooks.json

# Tester regex
echo "src/App.tsx" | grep -E "^src/"

# Variables disponibles (dans script)
echo "Tool: $TOOL"
echo "File: $FILE"
```

---

## 📚 Exemples Complets

### Workflow Frontend

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '⚛️ Frontend Workflow activé'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(tsx|jsx)$",
      "script": "eslint --fix $FILE && prettier --write $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/components/",
      "script": "npm test -- --findRelatedTests $FILE"
    }
  ]
}
```

### Workflow Security

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "bash scripts/detect-secrets.sh",
      "blocking": true
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(env|yaml)$",
      "script": "bash scripts/validate-config.sh",
      "blocking": true
    },
    {
      "event": "PostToolUse",
      "script": "echo '[AUDIT] $TOOL | $FILE' >> audit.log"
    }
  ]
}
```

---

## 📚 Ressources

### 📄 Documentation Officielle

- [Hooks Docs](https://code.claude.com/docs/en/hooks) - Guide officiel Anthropic
- [Hooks Events Reference](https://code.claude.com/docs/en/hooks#events) - Liste complète des événements
- [Hooks Guide (Agent SDK)](https://hexdocs.pm/claude_agent_sdk/hooks_guide.html) - Documentation technique SDK

### 🎥 Vidéos Recommandées

- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) ([🔗 YouTube](https://www.youtube.com/watch?v=Ffh9OeJ7yxw)) - Edmund Yong | 🔴 Expert
  - Automation avec hooks avancés
- [500h Optimisation Workflow](../../ressources/videos/500h-optimisation-workflow-melvynx.md) ([🔗 YouTube](https://youtu.be/kkkQKAPxna8)) - Melvynx | 🟠 Avancé
  - Workflows avec hooks

### 📝 Articles

- [Orchestration Workflows Enterprise](../../ressources/articles/orchestration-workflows-enterprise-perplexity.md) ([🔗 Source](https://www.perplexity.ai/search/summarize-the-current-webpage-YqEO3MquRBSTWbbJgkZWIw#0)) - Perplexity
  - Hooks dans orchestration complexe
- [Understanding Claude Code's Full Stack](../../ressources/articles/full-stack-orchestration-opalic.md) ([🔗 Source](https://alexop.dev/posts/understanding-claude-code-full-stack/)) - Alexander Opalic
  - Hooks : event-driven automation, automatic quality enforcement

### 🔗 Communauté

- [Awesome Hooks Examples](https://github.com/VoltAgent/awesome-claude-code#hooks) - Exemples communautaires
- [Edmund Yong Config](https://github.com/edmund-io/edmunds-claude-code) - Hooks configuration
- [Disler Hooks Mastery](https://github.com/disler/claude-code-hooks-mastery) - Mastery hooks automation
- [Disler Multi-Agent Observability](https://github.com/disler/claude-code-hooks-multi-agent-observability) - Monitoring real-time agents via hooks

---

**💡 Tip** : Testez vos hooks en standalone avant de les intégrer ! 🚀
