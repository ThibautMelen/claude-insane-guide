# 🎣 Hooks Claude Code - Guide Complet

> **Automatisez vos workflows avec des événements système**

📄 **Docs officielles** : [Claude Code Hooks](https://code.claude.com/docs/hooks)

---

## 📚 Table des Matières

1. [Théorie Fondamentale](#-théorie-fondamentale)
2. [Événements Disponibles](#-événements-disponibles)
3. [Configuration](#-configuration)
4. [Cas d'Usage](#-cas-dusage)
5. [Patterns Avancés](#-patterns-avancés)
6. [Points Clés](#-points-clés)
7. [Ressources](#-ressources)

---

## 📚 Théorie Fondamentale

### 🎯 Qu'est-ce qu'un Hook ?

Un **hook** est un **gestionnaire d'événements** qui s'exécute automatiquement en réponse à des événements système de Claude Code.

**Schéma conceptuel** :

```
Sans Hooks                     Avec Hooks
───────────                    ──────────

User: "Deploy"                 User: "Deploy"
  │                              │
  ▼                              ▼
Claude exécute                 1️⃣ PreToolUse Hook ✓
  │                            2️⃣ Claude exécute
  ▼                            3️⃣ PostToolUse Hook ✓
Done                           4️⃣ Notification Hook ✓
                                 │
                                 ▼
                               ✅ Tests auto
                               ✅ Logs envoyés
                               ✅ Team notifiée
```

### 🧩 Problème Résolu

**Avant les Hooks** :
- 😓 Validation manuelle après chaque modification
- 😓 Linting à lancer manuellement
- 😓 Oublis de tests avant commits
- 😓 Pas de notifications automatiques

**Avec les Hooks** :
- 🎉 Validation automatique sur événements
- 🎉 Linting auto après édition
- 🎉 Tests déclenchés automatiquement
- 🎉 Notifications Slack/Discord configurables

### 🔧 Les Deux Types de Hooks

Claude Code supporte **deux façons** de configurer des hooks :

```
╔══════════════════════════════════════════════════════════╗
║  HOOKS CLAUDE CODE - 2 CONFIGURATIONS                   ║
╚══════════════════════════════════════════════════════════╝

1️⃣ SETTINGS.JSON (Global ou Projet)
   ┌────────────────────────────────────────────┐
   │ 📍 Location : .claude/settings.json        │
   │ 📄 Scope    : Projet ou global (~/.claude) │
   │ ⚡ Usage    : Hooks spécifiques au projet  │
   │ 💡 Exemple  : Lint avant commit            │
   └────────────────────────────────────────────┘

2️⃣ PLUGINS (Réutilisable et partageable)
   ┌────────────────────────────────────────────┐
   │ 📍 Location : plugin/hooks/hooks.json      │
   │ 📄 Scope    : Package réutilisable         │
   │ ⚡ Usage    : Distribuer hooks à l'équipe  │
   │ 💡 Exemple  : Security audit automatique   │
   └────────────────────────────────────────────┘
```

**📌 Important** : Les hooks dans plugins sont **plus portables** et **partageables** !

---

### 🎭 Before Tool vs After Tool (Melvynx 500h)

Selon **Melvynx**, les deux hooks les plus utilisés sont **PreToolUse** et **PostToolUse**. Voici leurs **cas d'usage distincts** :

```
╔═══════════════════════════════════════════════════════════╗
║  BEFORE vs AFTER TOOL - CAS D'USAGE                       ║
╚═══════════════════════════════════════════════════════════╝

🔒 BEFORE TOOL (PreToolUse)
   └─> VALIDATION & SÉCURITÉ
       ├─> Bloquer commandes dangereuses (rm -rf)
       ├─> Demander confirmation utilisateur
       ├─> Vérifier permissions
       └─> Valider patterns de commandes

✨ AFTER TOOL (PostToolUse)
   └─> MODIFICATION & AUTOMATION
       ├─> Run prettier/ESLint automatiquement
       ├─> Ajouter du contexte (ex: tests results)
       ├─> Formater output
       └─> Envoyer notifications
```

**Règle d'or** :
- **Before** = Peut **bloquer** l'exécution (sécurité)
- **After** = **Améliore** le résultat (automation)

---

#### 🔒 Before Tool : Validation & Sécurité

**Objectif** : **Intercepter** les commandes avant exécution pour valider ou bloquer.

**Exemple 1 : Bloquer `rm -rf` dangereux**

```bash
# .claude/hooks/before-tool.sh

#!/bin/bash

# Lire la commande que Claude veut exécuter
COMMAND="$TOOL_ARGS"

# Pattern dangereux : rm -rf dans /user ou /home
if [[ "$TOOL_NAME" == "Bash" ]] && [[ "$COMMAND" == *"rm -rf /user"* || "$COMMAND" == *"rm -rf /home"* ]]; then
  echo "⚠️ ATTENTION : Commande dangereuse détectée !"
  echo "Tentative de suppression dans : /user ou /home"
  echo "Commande : $COMMAND"
  echo ""
  echo "Voulez-vous vraiment continuer ? (y/N)"

  # Exit 1 = BLOQUE l'exécution
  exit 1
fi

# Exit 0 = AUTORISE l'exécution
exit 0
```

**Configuration** (.claude/settings.json) :

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "bash .claude/hooks/before-tool.sh",
      "blocking": true
    }
  ]
}
```

**Workflow** :

```
Claude veut exécuter : `rm -rf /user/temp/not-exist`
         │
         ▼
🔒 Before Hook s'exécute
         │
         ├─> Pattern détecté : "rm -rf /user"
         ├─> Affiche warning
         └─> Exit 1 (BLOQUE)

❌ Commande ANNULÉE
✅ Système protégé
```

---

**Exemple 2 : Confirmation pour force push**

```bash
#!/bin/bash

if [[ "$TOOL_NAME" == "Bash" ]] && [[ "$TOOL_ARGS" == *"git push --force"* ]]; then
  BRANCH=$(git branch --show-current)

  if [[ "$BRANCH" == "main" || "$BRANCH" == "master" ]]; then
    echo "⚠️ Force push sur $BRANCH détecté !"
    echo "Voulez-vous vraiment force push sur la branche principale ?"
    exit 1
  fi
fi

exit 0
```

---

#### ✨ After Tool : Automation & Amélioration

**Objectif** : **Modifier** ou **enrichir** après l'exécution d'un tool.

**Exemple 1 : Prettier automatique après édition**

```bash
# .claude/hooks/after-tool.sh

#!/bin/bash

# Si Claude a modifié un fichier
if [[ "$TOOL_NAME" == "Edit" || "$TOOL_NAME" == "Write" ]]; then
  FILE="$TOOL_FILE"

  # Run prettier sur le fichier modifié
  if command -v prettier &> /dev/null; then
    echo "✨ Running prettier on $FILE..."
    prettier --write "$FILE"
  fi
fi

exit 0
```

**Configuration** :

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "bash .claude/hooks/after-tool.sh"
    },
    {
      "event": "PostToolUse",
      "tool": "Write",
      "script": "bash .claude/hooks/after-tool.sh"
    }
  ]
}
```

**Workflow** :

```
Claude modifie fichier : `src/components/Button.tsx`
         │
         ▼
Fichier sauvegardé
         │
         ▼
✨ After Hook s'exécute
         │
         ├─> Détecte Edit tool
         ├─> Run prettier --write Button.tsx
         └─> Fichier formaté automatiquement

✅ Code propre sans action manuelle
```

---

**Exemple 2 : Ajouter contexte après tests**

```bash
#!/bin/bash

# Si Claude a lancé des tests
if [[ "$TOOL_NAME" == "Bash" ]] && [[ "$TOOL_ARGS" == *"npm test"* ]]; then
  # Récupérer résultat tests
  TEST_RESULT="$TOOL_OUTPUT"

  # Analyser si échec
  if [[ "$TEST_RESULT" == *"FAIL"* ]]; then
    echo "⚠️ Tests échoués détectés"
    echo "Logs complets :"
    cat test-output.log

    # Injecter dans contexte Claude
    echo "CONTEXT: Tests failed, check logs above"
  else
    echo "✅ Tests passés"
  fi
fi

exit 0
```

---

### 🚀 Yolo Mode + Hook Sécurité (Melvynx)

Melvynx utilise un **alias `cc`** pour lancer Claude en **mode bypass permissions** (dangereux mais rapide), combiné avec un **Before Hook** pour bloquer les commandes vraiment dangereuses.

#### 1️⃣ Créer l'alias Yolo Mode

```bash
# ~/.bashrc ou ~/.zshrc

# Alias cc = Claude Code en mode bypass
alias cc="claude --dangerous-skip-permission"
```

**Effet** :
- Claude n'attend **PLUS** de validation pour chaque action
- Exécution **ultra-rapide**
- ⚠️ **DANGER** : Claude peut tout faire sans demander !

---

#### 2️⃣ Installer le Hook Sécurité

Pour **limiter les dégâts** en Yolo Mode, installer un hook qui bloque les commandes critiques :

```bash
# .claude/hooks/yolo-safety.sh

#!/bin/bash

DANGEROUS_PATTERNS=(
  "rm -rf /"
  "rm -rf /user"
  "rm -rf /home"
  "rm -rf ~"
  "git push --force main"
  "git push --force master"
  "sudo rm"
  "chmod 777 /"
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if [[ "$TOOL_ARGS" == *"$pattern"* ]]; then
    echo "🚨 YOLO MODE : Commande BLOQUÉE par sécurité"
    echo "Pattern dangereux : $pattern"
    echo "Commande tentée : $TOOL_ARGS"
    exit 1
  fi
done

exit 0
```

**Configuration** :

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "bash .claude/hooks/yolo-safety.sh",
      "blocking": true
    }
  ]
}
```

---

#### 🎯 Workflow Yolo Mode Sécurisé

```
╔═══════════════════════════════════════════════════════════╗
║  YOLO MODE + HOOK SÉCURITÉ                                ║
╚═══════════════════════════════════════════════════════════╝

1️⃣ Lancer Claude en Yolo Mode
   $ cc

2️⃣ Claude exécute actions sans demander
   → Suppression fichiers ✅
   → Modifications code ✅
   → Git commits ✅
   → Installation packages ✅

3️⃣ MAIS si commande dangereuse
   → Before Hook intercepte
   → Pattern détecté
   → BLOQUÉ automatiquement ❌

✅ Résultat : Rapidité + Sécurité minimale
```

**Avantages** :
- 🚀 **Vitesse** : Pas d'attente validation
- 🔒 **Sécurité** : Commandes critiques bloquées
- 🎯 **Productivité** : Flow de travail fluide

**Inconvénients** :
- ⚠️ Claude peut faire des erreurs non critiques
- ⚠️ Faut bien configurer les patterns dangereux
- ⚠️ Toujours vérifier avec `git diff` avant commit

---

### 🛠️ Créer un Hook avec Claude (Workflow Melvynx)

Melvynx recommande d'utiliser **Claude lui-même** pour écrire des hooks optimaux.

**Workflow** :

```bash
# 1. Ouvrir dossier projet dans Claude
claude

# 2. Demander à Claude de créer le hook
→ "Peux-tu me créer un nouveau hook PreToolUse qui bloque les commandes rm -rf dangereuses ?"

# 3. IMPORTANT : Fournir la documentation
→ Copier-coller la doc officielle hooks : https://code.claude.com/docs/hooks
→ Ou uploader PDF de la doc

# 4. Claude génère le hook complet
   ├─> Script bash avec validation
   ├─> Configuration settings.json
   └─> Exemples de tests

# 5. Sauvegarder et tester
```

**Astuce** : Toujours fournir la **documentation officielle** pour que Claude génère des hooks corrects.

---

## 🎯 Événements Disponibles

### 📋 Liste Complète des Événements

Voici **tous les événements** que vous pouvez hooker :

```
╔═══════════════════════════════════════════════════════════════╗
║  ÉVÉNEMENT         │  QUAND IL SE DÉCLENCHE                   ║
╠════════════════════╪══════════════════════════════════════════╣
║  SessionStart      │  Au démarrage d'une session Claude       ║
║  SessionEnd        │  À la fin d'une session                  ║
║  PreToolUse        │  AVANT l'exécution d'un outil            ║
║  PostToolUse       │  APRÈS l'exécution d'un outil            ║
║  UserPromptSubmit  │  Quand l'utilisateur envoie un prompt    ║
║  Notification      │  Lors d'une notification système         ║
║  Stop              │  Quand Claude s'arrête                   ║
║  SubagentStop      │  Quand un sub-agent termine              ║
║  PreCompact        │  Avant compaction du contexte            ║
╚═══════════════════════════════════════════════════════════════╝
```

### 🔄 Cycle de Vie d'une Interaction

Comprendre **quand** chaque hook se déclenche :

```
┌─────────────────────────────────────────────────────────┐
│  CYCLE DE VIE - HOOKS ÉVÉNEMENTS                       │
└─────────────────────────────────────────────────────────┘

1️⃣ SessionStart
   └─> Claude démarre
       │
       ▼
2️⃣ UserPromptSubmit
   └─> User tape un message
       │
       ▼
3️⃣ PreToolUse (si tool nécessaire)
   └─> AVANT exécution (ex: Edit, Bash, Read)
       │
       ▼
4️⃣ [Tool exécuté par Claude]
       │
       ▼
5️⃣ PostToolUse
   └─> APRÈS exécution (validation, logs)
       │
       ▼
6️⃣ Notification (optionnel)
   └─> Envoyer résultat Slack/Discord
       │
       ▼
7️⃣ Stop / SubagentStop
   └─> Fin de tâche
       │
       ▼
8️⃣ SessionEnd
   └─> Fermeture session
```

### ⚙️ Hooks Bloquants vs Non-Bloquants

Les hooks peuvent être **bloquants** ou **non-bloquants** :

```
┌─────────────────────────────────────────┐
│  NON-BLOQUANT (défaut)                 │
│  ─────────────────────                 │
│  Hook échoue → ⚠️ Warning              │
│  Claude continue quand même            │
│                                         │
│  Use case:                              │
│  • Logs                                 │
│  • Notifications                        │
│  • Métriques                            │
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  BLOQUANT ("blocking": true)           │
│  ──────────────────────────            │
│  Hook échoue → ❌ STOP                 │
│  Claude n'exécute PAS l'outil          │
│                                         │
│  Use case:                              │
│  • Validation sécurité                  │
│  • Détection secrets                    │
│  • Compliance checks                    │
└─────────────────────────────────────────┘
```

**⚠️ Attention** : Les hooks bloquants doivent être **rapides** et **fiables** !

---

## ⚙️ Configuration

### 📄 Option 1 : settings.json

**Localisation** :
- Global : `~/.claude/settings.json`
- Projet : `.claude/settings.json` (dans votre projet)

**Format** :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '🚀 Session démarrée !'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "npm run lint"
    }
  ]
}
```

**Propriétés disponibles** :

| Propriété | Type | Description | Exemple |
|-----------|------|-------------|---------|
| `event` | string | ⭐ **REQUIS** - Type d'événement | `"PostToolUse"` |
| `script` | string | ⭐ **REQUIS** - Commande à exécuter | `"bash lint.sh"` |
| `tool` | string | Filtrer par outil spécifique | `"Edit"`, `"Bash"` |
| `pattern` | string | Regex pour filtrer fichiers | `"\\.(tsx\|jsx)$"` |
| `blocking` | boolean | Hook bloquant si `true` | `true` ou `false` |

**Exemples** :

```json
{
  "hooks": [
    // 🟢 Simple : Message au démarrage
    {
      "event": "SessionStart",
      "script": "echo '👋 Bienvenue !'"
    },

    // 🟡 Filtré : Lint seulement fichiers React
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(tsx|jsx)$",
      "script": "eslint $FILE"
    },

    // 🔴 Bloquant : Empêcher commit de secrets
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "bash scripts/detect-secrets.sh",
      "blocking": true
    }
  ]
}
```

### 📦 Option 2 : Plugin hooks.json

**Localisation** :
```
my-plugin/
┣━━ .claude-plugin/
┃   ┗━━ plugin.json          # Déclare hooks
┗━━ hooks/
    ┗━━ hooks.json            # Configuration hooks
```

**plugin.json** :

```json
{
  "name": "my-plugin",
  "hooks": "./hooks/hooks.json"
}
```

**hooks/hooks.json** :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '⚛️ React Plugin chargé !'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(tsx|jsx)$",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/lint.sh"
    }
  ]
}
```

**💡 Astuce** : Utilisez `${CLAUDE_PLUGIN_ROOT}` pour chemins relatifs !

---

## 🎯 Cas d'Usage

### 🟢 Cas 1 : Linting Automatique

**Objectif** : Linter automatiquement les fichiers TypeScript/JavaScript après modification.

**Configuration** :

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(ts|tsx|js|jsx)$",
      "script": "eslint --fix $FILE && echo '✅ Linted: $FILE'"
    }
  ]
}
```

**Variables disponibles** :
- `$FILE` : Chemin du fichier modifié
- `$TOOL` : Nom de l'outil utilisé (Edit, Bash, etc.)

**Résultat** :
```
Claude modifie src/App.tsx
  └─> Hook PostToolUse déclenché
      └─> eslint --fix src/App.tsx
          └─> ✅ Linted: src/App.tsx
```

### 🟡 Cas 2 : Tests Automatiques

**Objectif** : Runner les tests après modification dans `src/`.

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/.*\\.(ts|tsx)$",
      "script": "npm test -- --findRelatedTests $FILE"
    }
  ]
}
```

**Résultat** :
- Édition de `src/components/Button.tsx`
- → Tests de `Button.test.tsx` exécutés automatiquement
- → ❌ Tests fail → Warning visible dans Claude

### 🟠 Cas 3 : Sécurité - Bloquer Secrets

**Objectif** : **Empêcher** le commit de secrets (credentials, API keys).

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

**scripts/detect-secrets.sh** :

```bash
#!/bin/bash

# Rechercher patterns de secrets
if git diff --cached | grep -E "(api_key|password|secret|token)" > /dev/null; then
  echo "❌ BLOQUÉ : Secrets détectés dans le commit !"
  exit 1
fi

echo "✅ Aucun secret détecté"
exit 0
```

**Résultat** :
```
User: "Commit les changements"
  └─> Claude: git add .
      └─> PreToolUse Hook déclenché
          └─> detect-secrets.sh trouve "api_key"
              └─> ❌ BLOQUÉ (exit 1)
                  └─> Claude n'exécute PAS git commit
```

### 🔴 Cas 4 : Notifications Slack

**Objectif** : Notifier l'équipe après déploiement.

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "bash scripts/notify-slack.sh"
    }
  ]
}
```

**scripts/notify-slack.sh** :

```bash
#!/bin/bash

WEBHOOK_URL="https://hooks.slack.com/services/YOUR/WEBHOOK/URL"

curl -X POST $WEBHOOK_URL \
  -H 'Content-Type: application/json' \
  -d '{
    "text": "🚀 Déploiement terminé !",
    "blocks": [
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "*Déploiement réussi* ✅\nEnvironnement: Production"
        }
      }
    ]
  }'
```

**Résultat** :
```
Claude exécute : bash deploy.sh
  └─> Déploiement réussi
      └─> Hook PostToolUse déclenché
          └─> notify-slack.sh
              └─> 📱 Message Slack envoyé à l'équipe
```

---

## 💪 Patterns Avancés

### 🔄 Pattern 1 : Hooks Multi-Environnements

Configurer des hooks **différents** selon l'environnement (dev, staging, prod).

**Structure** :

```
my-plugin/
┣━━ hooks/
┃   ┣━━ dev.hooks.json
┃   ┣━━ staging.hooks.json
┃   ┗━━ production.hooks.json
┗━━ .claude-plugin/
    ┗━━ plugin.json
```

**plugin.json** :

```json
{
  "name": "my-app",
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/${ENV}.hooks.json"
}
```

**dev.hooks.json** (léger) :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '🔧 Dev mode'"
    }
  ]
}
```

**production.hooks.json** (strict) :

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "script": "bash security-checks.sh",
      "blocking": true
    },
    {
      "event": "PostToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "bash notify-team.sh"
    }
  ]
}
```

**Usage** :

```bash
# Dev
export ENV=dev
claude

# Production
export ENV=production
claude
```

### 🎭 Pattern 2 : Hooks Conditionnels

Exécuter des hooks **seulement si conditions remplies**.

**Exemple** : Tester seulement si tests existent.

```bash
#!/bin/bash
# hooks-scripts/test-if-exists.sh

FILE=$1

# Trouver fichier de test associé
TEST_FILE="${FILE%.tsx}.test.tsx"

if [ -f "$TEST_FILE" ]; then
  echo "🧪 Running tests for $TEST_FILE"
  npm test -- $TEST_FILE
else
  echo "⏭️ No test file found, skipping"
fi
```

**hooks.json** :

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.tsx$",
      "script": "bash hooks-scripts/test-if-exists.sh $FILE"
    }
  ]
}
```

### 🔗 Pattern 3 : Chaîner Plusieurs Hooks

Exécuter **plusieurs scripts** séquentiellement.

```bash
#!/bin/bash
# hooks-scripts/chain.sh

echo "1️⃣ Linting..."
npm run lint || exit 1

echo "2️⃣ Tests..."
npm test || exit 1

echo "3️⃣ Build..."
npm run build || exit 1

echo "✅ Toutes les étapes réussies !"
```

**hooks.json** :

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git push",
      "script": "bash hooks-scripts/chain.sh",
      "blocking": true
    }
  ]
}
```

**Résultat** : Si lint/tests/build échouent → Push **bloqué** ❌

### 🧠 Pattern 4 : Hooks avec Contexte

Passer du contexte entre hooks via fichiers temporaires.

```bash
#!/bin/bash
# hooks-scripts/pre-deploy.sh

# Sauvegarder timestamp
date +%s > /tmp/claude-deploy-start

echo "📦 Déploiement démarré..."
```

```bash
#!/bin/bash
# hooks-scripts/post-deploy.sh

START=$(cat /tmp/claude-deploy-start)
END=$(date +%s)
DURATION=$((END - START))

echo "⏱️ Déploiement terminé en ${DURATION}s"

# Envoyer métriques
curl -X POST https://metrics.example.com/deploys \
  -d "duration=${DURATION}"
```

**hooks.json** :

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "bash hooks-scripts/pre-deploy.sh"
    },
    {
      "event": "PostToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "bash hooks-scripts/post-deploy.sh"
    }
  ]
}
```

---

## 🎓 Points Clés

### ✅ Concepts Essentiels

1. **Hook = Gestionnaire d'Événements**
   - S'exécute automatiquement sur événements système
   - Non-bloquant par défaut (sauf `blocking: true`)

2. **9 Événements Disponibles**
   - SessionStart, SessionEnd
   - PreToolUse, PostToolUse
   - UserPromptSubmit, Notification
   - Stop, SubagentStop, PreCompact

3. **2 Configurations Possibles**
   - **settings.json** : Hooks projet-specific
   - **Plugin hooks.json** : Hooks réutilisables et partageables

4. **Filtrage Précis**
   - `tool` : Filtrer par outil (Edit, Bash, Read, etc.)
   - `pattern` : Regex pour filtrer fichiers
   - Variables : `$FILE`, `$TOOL`

5. **Hooks Bloquants**
   - `"blocking": true` → Empêche exécution si échoue
   - Use case : Sécurité, compliance, validation

### 🎯 Best Practices

**DO ✅** :

- ✅ **Tester** scripts hooks en standalone avant intégration
- ✅ **Utiliser** hooks bloquants seulement pour sécurité critique
- ✅ **Logger** sorties des hooks pour debugging
- ✅ **Timeout** hooks longs (ne pas bloquer Claude)
- ✅ **Variables d'env** pour configuration (API keys, webhooks)
- ✅ **Chemins relatifs** avec `${CLAUDE_PLUGIN_ROOT}`
- ✅ **Exit codes** corrects (0 = succès, 1+ = échec)

**DON'T ❌** :

- ❌ **Surcharger** hooks (performance)
- ❌ **Hooks bloquants lents** (timeout)
- ❌ **Hardcoder** secrets dans scripts
- ❌ **Ignorer** exit codes des scripts
- ❌ **Oublier** chmod +x sur scripts bash
- ❌ **Hooks trop génériques** (filtrer avec `tool` et `pattern`)

### 🚨 Erreurs Courantes

**1. Hook ne se déclenche pas**

```bash
# Vérifier configuration
cat .claude/settings.json | jq '.hooks'

# Vérifier permissions script
ls -la scripts/my-hook.sh
chmod +x scripts/my-hook.sh  # Si nécessaire
```

**2. Hook bloque Claude alors que non-bloquant**

```json
❌ MAUVAIS :
{
  "event": "PreToolUse",
  "script": "exit 1"  # Pas de "blocking"
}
// → Devrait être non-bloquant mais bloque quand même PreToolUse

✅ CORRECT :
{
  "event": "PostToolUse",  // Après, pas avant
  "script": "exit 1"
}
```

**3. Variables non remplacées**

```json
❌ MAUVAIS :
{
  "script": "eslint '$FILE'"  // Quotes simples
}

✅ CORRECT :
{
  "script": "eslint $FILE"  // Sans quotes ou doubles
}
```

**4. Pattern regex incorrect**

```json
❌ MAUVAIS :
{
  "pattern": ".(tsx|jsx)$"  // Manque \\ pour échapper
}

✅ CORRECT :
{
  "pattern": "\\.(tsx|jsx)$"  // Double backslash pour JSON
}
```

---

## 📚 Ressources

### 📄 Documentation Officielle

- 📄 **Claude Code Hooks** : https://code.claude.com/docs/en/hooks
- 📄 **Hooks Guide Complet** : https://code.claude.com/docs/en/hooks-guide
- 📄 **Engineering Best Practices** : https://www.anthropic.com/engineering/claude-code-best-practices

### 📝 Articles & Guides

- 📝 **Hooks Best Practices (Anthropic)** : https://www.anthropic.com/engineering/claude-code-best-practices
  - Événements système, automation patterns
  - Guidelines officielles sécurité
- 📝 **How I Use Hooks** : https://blog.sshh.io/p/how-i-use-every-claude-code-feature
  - Workflow production avec hooks

### 🎥 Vidéos Recommandées

- 🎥 **Melvynx - 500h Claude Code Workflow** : [Fiche complète](../../ressources/videos/500h-optimisation-workflow-melvynx.md)
  - Before/After Tool distinction claire
  - Yolo Mode + hook sécurité (`alias cc`)
  - Workflow création avec Claude + documentation

### 🔗 Repositories Communauté

- 🔗 **Disler Hooks Mastery** : https://github.com/disler/claude-code-hooks-mastery
  - Patterns avancés hooks production
  - Exemples sécurité, validation, automation
  - Best practices testées en production
- 🔗 **Weston Hobson Commands** : https://github.com/wshobson/commands
  - Exemples hooks intégrés aux commands
- 🔗 **Edmund Yong Setup** : https://github.com/edmund-io/edmunds-claude-code
  - Hooks production (linting, testing, security)

### 🔧 Outils & Packs

- 🔧 **CCLI Blueprint (Melvynx)** : https://mlv.sh/ccli
  - Pack hooks sécurité pré-configurés
  - Yolo Mode setup sécurisé
  - Status line avec hooks monitoring

### 📚 Ressources Internes

- 📋 [Cheatsheet Hooks](./cheatsheet.md) - Référence rapide API
- 🎓 [Exercices Hooks](../exercises/hooks/) - Création hooks custom
- 🔗 [Commands](../2-commands/guide.md) - Quand utiliser Commands vs Hooks
- 🔗 [Plugins](../6-plugins/guide.md) - Packaging hooks dans plugins
- 🔗 [Best Practices](../9-best-practices/guide.md) - Patterns hooks avancés

### 💡 Use Cases Inspirants

**Linting & Formatting** :
```json
{
  "event": "PostToolUse",
  "tool": "Edit",
  "script": "prettier --write $FILE && eslint --fix $FILE"
}
```

**Git Hooks Integration** :
```json
{
  "event": "PreToolUse",
  "tool": "Bash",
  "pattern": "git commit",
  "script": "bash .git/hooks/pre-commit",
  "blocking": true
}
```

**Performance Monitoring** :
```json
{
  "event": "PostToolUse",
  "script": "echo '[METRIC] Tool: $TOOL | File: $FILE | Time: $(date)' >> metrics.log"
}
```

---
