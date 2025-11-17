# 🎨 Status Line - Dashboard Temps Réel pour Claude Code

**Temps estimé** : 45-60 minutes
**Niveau** : 🟡 Intermédiaire à 🟠 Avancé

---

## 📚 Qu'est-ce que la Status Line ?

La **Status Line** est une barre d'information personnalisable affichée en bas de votre terminal Claude Code. Elle vous donne une visibilité temps réel sur :

- 📊 **État du projet** : branche Git, fichiers modifiés, staging
- 🧠 **Contexte utilisé** : tokens consommés, pourcentage de la limite
- 💰 **Coûts** : dépenses de la session en cours
- 📈 **Usage quotidien** : pourcentage du budget journalier, reset time

### 🎯 Pourquoi utiliser une Status Line ?

```
╔═══════════════════════════════════════════════════════╗
║              SANS STATUS LINE                         ║
╠═══════════════════════════════════════════════════════╣
║  ❌ Auto-compact surprise à 99%                       ║
║  ❌ Dépassement budget quotidien                      ║
║  ❌ Aucune visibilité sur les tokens                  ║
║  ❌ Coûts de session inconnus                         ║
╚═══════════════════════════════════════════════════════╝
                        ▼
╔═══════════════════════════════════════════════════════╗
║              AVEC STATUS LINE                         ║
╠═══════════════════════════════════════════════════════╣
║  ✅ Alerte avant auto-compact (90%+)                  ║
║  ✅ Tracking budget en temps réel                     ║
║  ✅ Visibilité tokens et cache                        ║
║  ✅ Optimisation coûts par session                    ║
╚═══════════════════════════════════════════════════════╝
```

**💡 Cas d'usage parfaits** :
- Sessions de développement longues (>2h)
- Projets avec contexte massif (>100K tokens)
- Optimisation des coûts Claude Pro
- Éviter les interruptions par auto-compact

---

## 🏗️ Architecture de la Status Line

### 1. Configuration Basique (JSON)

La Status Line se configure dans `.claude/settings.json` :

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "padding": 0
  }
}
```

**Paramètres** :
- `type`: `"command"` pour exécuter un script personnalisé
- `command`: Chemin absolu vers votre script
- `padding`: `0` = barre jusqu'au bord du terminal (recommandé)

### 2. Flux de Données

```
┌──────────────────────────────────────────────────┐
│         CLAUDE CODE ENGINE                       │
│  ┌────────────────────────────────────────┐     │
│  │  Session Data (JSON via stdin)         │     │
│  │  • session_id                           │     │
│  │  • transcript_path                      │     │
│  │  • model info                           │     │
│  │  • cost metrics                         │     │
│  │  • workspace context                    │     │
│  └────────────────┬───────────────────────┘     │
└──────────────────┼──────────────────────────────┘
                   │
                   ▼
┌──────────────────────────────────────────────────┐
│       VOTRE SCRIPT STATUSLINE                    │
│  ┌────────────────────────────────────────┐     │
│  │  1. Parse JSON input                    │     │
│  │  2. Extract data (tokens, cost, etc)    │     │
│  │  3. Fetch additional info (Git, API)    │     │
│  │  4. Format output string                │     │
│  └────────────────┬───────────────────────┘     │
└──────────────────┼──────────────────────────────┘
                   │
                   ▼
┌──────────────────────────────────────────────────┐
│           TERMINAL DISPLAY                       │
│                                                  │
│  📦 main │ +3 -1 │ 🧠 163K (81%) │ $0.12       │
│                                                  │
└──────────────────────────────────────────────────┘
```

### 3. Structure JSON Input

Claude Code passe ces données à votre script via **stdin** :

```json
{
  "hook_event_name": "Status",
  "session_id": "abc123...",
  "transcript_path": "/Library/Application Support/claude-code/transcripts/session.json",
  "cwd": "/Users/you/project",
  "model": {
    "id": "claude-sonnet-4-5-20250929",
    "display_name": "Sonnet 4.5"
  },
  "workspace": {
    "current_dir": "/Users/you/project",
    "project_dir": "/Users/you/project"
  },
  "version": "1.0.80",
  "output_style": {
    "name": "default"
  },
  "cost": {
    "total_cost_usd": 0.01234,
    "total_duration_ms": 45000,
    "total_api_duration_ms": 2300,
    "total_lines_added": 156,
    "total_lines_removed": 23
  }
}
```

**Champs clés** :
- `transcript_path` : Pour analyser les tokens utilisés
- `cost.total_cost_usd` : Coût de la session actuelle
- `model.id` : Modèle Claude utilisé
- `cwd` : Pour récupérer les infos Git

---

## 🎨 Architecture Multi-Couches (Solution Melvynx)

Melvynx a développé une Status Line en **3 niveaux** d'information :

```
╔════════════════════════════════════════════════════╗
║           STATUS LINE ARCHITECTURE                 ║
╠════════════════════════════════════════════════════╣
║  LIGNE 1 : Git Info                                ║
║  ┌──────────────────────────────────────────┐     ║
║  │ 📦 main │ +12 │ -3 │ 2 staged            │     ║
║  └──────────────────────────────────────────┘     ║
║                       ▼                            ║
║  LIGNE 2 : Session & Context                       ║
║  ┌──────────────────────────────────────────┐     ║
║  │ 💰 $0.15 │ 🧠 163K tokens │ 81% used      │     ║
║  └──────────────────────────────────────────┘     ║
║                       ▼                            ║
║  LIGNE 3 : Usage Limits                            ║
║  ┌──────────────────────────────────────────┐     ║
║  │ 📊 43% daily │ Reset: 2h06m │ ████░░░░    │     ║
║  └──────────────────────────────────────────┘     ║
╚════════════════════════════════════════════════════╝
```

### Composants Techniques

#### 🔍 1. Parsing du Transcript (Tokens)

```typescript
// Lire le fichier transcript.json
const transcript = JSON.parse(
  fs.readFileSync(input.transcript_path, 'utf-8')
);

// Extraire les tokens
const messages = transcript.messages || [];
const lastMessage = messages[messages.length - 1];

const inputTokens = lastMessage?.usage?.input_tokens || 0;
const cacheTokens = lastMessage?.usage?.cache_read_input_tokens || 0;
const totalTokens = inputTokens + cacheTokens;

// Calculer le pourcentage (limite Sonnet 4.5 = 200K)
const maxTokens = 200000;
const percentage = (totalTokens / maxTokens) * 100;
```

#### 🔐 2. Récupération des Credentials (macOS)

```
╔═══════════════════════════════════════════════╗
║      CREDENTIAL RETRIEVAL FLOW               ║
╠═══════════════════════════════════════════════╣
║                                               ║
║  macOS Keychain                               ║
║  ┌─────────────────────────────────────┐     ║
║  │ security find-generic-password      │     ║
║  │ -s "claude-code-credential"         │     ║
║  └──────────────┬──────────────────────┘     ║
║                 │                             ║
║                 ▼                             ║
║  ┌─────────────────────────────────────┐     ║
║  │   Extract API Token                 │     ║
║  │   Format: sk-ant-api03-xxxxx        │     ║
║  └──────────────┬──────────────────────┘     ║
║                 │                             ║
║                 ▼                             ║
║  ┌─────────────────────────────────────┐     ║
║  │  Fetch Usage from Claude API        │     ║
║  │  POST /api/auth/usage               │     ║
║  └─────────────────────────────────────┘     ║
║                                               ║
╚═══════════════════════════════════════════════╝
```

**Code Bash** :

```bash
#!/bin/bash

# Récupérer le token depuis le Keychain
TOKEN=$(security find-generic-password \
  -s "claude-code-credential" \
  -w 2>/dev/null)

# Interroger l'API Claude pour l'usage
USAGE=$(curl -s -X POST https://api.claude.ai/api/auth/usage \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json")

# Parser la réponse JSON
DAILY_PERCENT=$(echo $USAGE | jq -r '.daily_usage_percentage')
RESET_TIME=$(echo $USAGE | jq -r '.reset_time')
```

⚠️ **Windows** : Les credentials sont stockés différemment. Utilisez Claude Code pour localiser l'emplacement.

#### 📊 3. Informations Git

```bash
#!/bin/bash

# Récupérer la branche courante
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

# Compter les fichiers modifiés
ADDED=$(git diff --numstat | awk '{s+=$1} END {print s}')
REMOVED=$(git diff --numstat | awk '{s+=$2} END {print s}')

# Fichiers en staging
STAGED=$(git diff --cached --name-only | wc -l | tr -d ' ')

echo "📦 $BRANCH │ +$ADDED -$REMOVED │ $STAGED staged"
```

### 4. Progress Bar Visuelle

```typescript
function createProgressBar(percentage: number, width: number = 10): string {
  const filled = Math.round((percentage / 100) * width);
  const empty = width - filled;

  return '█'.repeat(filled) + '░'.repeat(empty);
}

// Exemple : 81% sur 10 caractères
createProgressBar(81, 10); // "████████░░"
```

---

## 🚀 Installation & Configuration

### Option 1 : Script Simple (Débutant)

**1. Créer le fichier statusline**

```bash
mkdir -p ~/.claude
nano ~/.claude/statusline.sh
```

**2. Script minimal** :

```bash
#!/bin/bash

# Lire le JSON depuis stdin
INPUT=$(cat)

# Extraire le coût
COST=$(echo $INPUT | jq -r '.cost.total_cost_usd // 0')

# Afficher une status line basique
echo "💰 \$$COST"
```

**3. Rendre exécutable** :

```bash
chmod +x ~/.claude/statusline.sh
```

**4. Configurer dans settings.json** :

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "padding": 0
  }
}
```

### Option 2 : Solution Avancée (Melvynx)

**1. Cloner le repo** :

```bash
git clone https://github.com/melvynx/claude-statusline.git
cd claude-statusline
```

**2. Installer les dépendances** :

```bash
npm install
```

**3. Build le projet** :

```bash
npm run build
```

**4. Configurer** :

Éditer `config.json` :

```json
{
  "colors": {
    "scheme": "progressive",
    "progressBar": {
      "low": "#00ff00",
      "medium": "#ffff00",
      "high": "#ff0000"
    }
  },
  "display": {
    "showModel": true,
    "progressBarWidth": 10
  }
}
```

**Options de couleurs** :
- `progressive` : Vert → Jaune → Rouge selon usage
- `green` : Toujours vert
- `custom` : Définir vos propres couleurs

**5. Lier dans settings.json** :

```json
{
  "statusLine": {
    "type": "command",
    "command": "/path/to/claude-statusline/dist/index.js",
    "padding": 0
  }
}
```

---

## 🎨 Personnalisation Avancée

### 1. Ajouter des Emojis Custom

```typescript
const ICONS = {
  git: '📦',
  tokens: '🧠',
  cost: '💰',
  usage: '📊',
  warning: '⚠️',
  danger: '🔴'
};

function formatStatusLine(data: StatusData): string {
  const gitInfo = `${ICONS.git} ${data.branch}`;
  const tokenInfo = `${ICONS.tokens} ${data.tokens}`;
  const costInfo = `${ICONS.cost} $${data.cost}`;

  return `${gitInfo} │ ${tokenInfo} │ ${costInfo}`;
}
```

### 2. Alertes Contexte (Auto-Compact)

```typescript
function getContextWarning(percentage: number): string {
  if (percentage >= 99) {
    return '🔴 AUTO-COMPACT IMMINENT!';
  } else if (percentage >= 90) {
    return '⚠️ Contexte presque plein';
  } else if (percentage >= 75) {
    return '🟡 Contexte élevé';
  }
  return '';
}
```

### 3. Couleurs ANSI

```typescript
const COLORS = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  magenta: '\x1b[35m',
  cyan: '\x1b[36m'
};

function colorize(text: string, color: keyof typeof COLORS): string {
  return `${COLORS[color]}${text}${COLORS.reset}`;
}

// Exemple
const warning = colorize('⚠️ 90% contexte', 'yellow');
```

### 4. Formatage Temps (Reset)

```typescript
function formatResetTime(milliseconds: number): string {
  const hours = Math.floor(milliseconds / 3600000);
  const minutes = Math.floor((milliseconds % 3600000) / 60000);

  return `${hours}h${minutes.toString().padStart(2, '0')}m`;
}

// Exemple : 7560000ms → "2h06m"
```

---

## 🔧 Dépannage & Debug

### Problème 1 : Status Line ne s'affiche pas

**Diagnostic** :

```bash
# Vérifier que le script est exécutable
ls -la ~/.claude/statusline.sh

# Devrait afficher : -rwxr-xr-x
```

**Solution** :

```bash
chmod +x ~/.claude/statusline.sh
```

### Problème 2 : Erreur "jq not found"

**Installation jq** :

```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install jq

# Windows (via Chocolatey)
choco install jq
```

### Problème 3 : Credentials Windows

**Localisation** :

```bash
# Demander à Claude Code
claude "Où sont stockées les credentials Claude Code sur Windows ?"
```

**Adaptation du script** :

```powershell
# PowerShell pour Windows
$token = (Get-ItemProperty -Path "HKCU:\Software\Anthropic\Claude" -Name "Token").Token
```

### Problème 4 : Transcript path incorrect

**Vérifier le chemin** :

```typescript
// Ajouter des logs
const input = JSON.parse(fs.readFileSync('/dev/stdin', 'utf-8'));
console.error('Transcript path:', input.transcript_path);

// Vérifier si le fichier existe
if (!fs.existsSync(input.transcript_path)) {
  console.error('ERROR: Transcript file not found!');
}
```

---

## 📊 Exemples Complets

### Exemple 1 : Status Line Bash Complète

```bash
#!/bin/bash

# Lire l'input JSON
INPUT=$(cat)

# Extraire les données
COST=$(echo "$INPUT" | jq -r '.cost.total_cost_usd // 0')
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path')
CWD=$(echo "$INPUT" | jq -r '.cwd')

# Git info (si dans un repo)
cd "$CWD" 2>/dev/null
if git rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  ADDED=$(git diff --numstat | awk '{s+=$1} END {print s+0}')
  REMOVED=$(git diff --numstat | awk '{s+=$2} END {print s+0}')
  GIT_INFO="📦 $BRANCH │ +$ADDED -$REMOVED"
else
  GIT_INFO="📦 No git"
fi

# Tokens (lecture du transcript)
if [ -f "$TRANSCRIPT" ]; then
  TOKENS=$(jq -r '.messages[-1].usage.input_tokens // 0' "$TRANSCRIPT")
  CACHE=$(jq -r '.messages[-1].usage.cache_read_input_tokens // 0' "$TRANSCRIPT")
  TOTAL=$((TOKENS + CACHE))
  PERCENT=$((TOTAL * 100 / 200000))
  TOKEN_INFO="🧠 ${TOTAL}K (${PERCENT}%)"
else
  TOKEN_INFO="🧠 N/A"
fi

# Coût formaté
COST_FORMATTED=$(printf "%.2f" $COST)

# Afficher la status line
echo "$GIT_INFO │ $TOKEN_INFO │ 💰 \$$COST_FORMATTED"
```

### Exemple 2 : Status Line TypeScript (Structure Melvynx)

```typescript
#!/usr/bin/env node

import fs from 'fs';
import { execSync } from 'child_process';

interface StatusInput {
  transcript_path: string;
  cwd: string;
  cost: {
    total_cost_usd: number;
  };
  model: {
    display_name: string;
  };
}

interface StatusLine {
  git: string;
  context: string;
  cost: string;
  usage: string;
}

// Lire l'input depuis stdin
const input: StatusInput = JSON.parse(
  fs.readFileSync('/dev/stdin', 'utf-8')
);

// Récupérer les infos Git
function getGitInfo(cwd: string): string {
  try {
    process.chdir(cwd);
    const branch = execSync('git rev-parse --abbrev-ref HEAD')
      .toString()
      .trim();
    const added = parseInt(
      execSync('git diff --numstat | awk \'{s+=$1} END {print s+0}\'')
        .toString()
        .trim()
    );
    const removed = parseInt(
      execSync('git diff --numstat | awk \'{s+=$2} END {print s+0}\'')
        .toString()
        .trim()
    );
    return `📦 ${branch} │ +${added} -${removed}`;
  } catch {
    return '📦 No git';
  }
}

// Récupérer les tokens depuis le transcript
function getTokenInfo(transcriptPath: string): string {
  try {
    const transcript = JSON.parse(fs.readFileSync(transcriptPath, 'utf-8'));
    const messages = transcript.messages || [];
    const lastMessage = messages[messages.length - 1];

    const inputTokens = lastMessage?.usage?.input_tokens || 0;
    const cacheTokens = lastMessage?.usage?.cache_read_input_tokens || 0;
    const total = inputTokens + cacheTokens;
    const percentage = Math.round((total / 200000) * 100);

    const totalK = Math.round(total / 1000);
    return `🧠 ${totalK}K (${percentage}%)`;
  } catch {
    return '🧠 N/A';
  }
}

// Formater le coût
function getCostInfo(cost: number): string {
  return `💰 $${cost.toFixed(2)}`;
}

// Récupérer l'usage quotidien (nécessite API token)
function getDailyUsage(): string {
  // TODO: Implémenter avec récupération du token
  return '📊 N/A';
}

// Construire la status line
const statusLine: StatusLine = {
  git: getGitInfo(input.cwd),
  context: getTokenInfo(input.transcript_path),
  cost: getCostInfo(input.cost.total_cost_usd),
  usage: getDailyUsage()
};

// Afficher
console.log(
  `${statusLine.git} │ ${statusLine.context} │ ${statusLine.cost}`
);
```

---

## 📋 Cheatsheet Rapide

### Configuration JSON

```json
{
  "statusLine": {
    "type": "command",
    "command": "/path/to/script.sh",
    "padding": 0
  }
}
```

### Commandes Essentielles

```bash
# Rendre le script exécutable
chmod +x ~/.claude/statusline.sh

# Tester le script manuellement
echo '{"cost":{"total_cost_usd":0.12}}' | ~/.claude/statusline.sh

# Vérifier la config Claude
cat ~/.claude/settings.json | jq '.statusLine'

# Recharger Claude après modification
# (relancer la session)
```

### Extraire Données JSON (jq)

```bash
# Coût
echo $INPUT | jq -r '.cost.total_cost_usd'

# Modèle
echo $INPUT | jq -r '.model.display_name'

# Transcript path
echo $INPUT | jq -r '.transcript_path'

# Workspace
echo $INPUT | jq -r '.workspace.current_dir'
```

### Git Infos

```bash
# Branche courante
git rev-parse --abbrev-ref HEAD

# Lignes ajoutées
git diff --numstat | awk '{s+=$1} END {print s+0}'

# Lignes supprimées
git diff --numstat | awk '{s+=$2} END {print s+0}'

# Fichiers en staging
git diff --cached --name-only | wc -l
```

---

## 🎓 Points Clés à Retenir

### ✅ Concepts Essentiels

1. **Status Line = Script Custom**
   - Reçoit JSON via stdin
   - Retourne string formatée via stdout
   - Rafraîchi automatiquement par Claude Code

2. **3 Sources de Données**
   - JSON input de Claude (cost, model, paths)
   - Transcript file (tokens, cache)
   - Git repo (branch, files, staging)

3. **Auto-Compact à 99%**
   - Limite Sonnet 4.5 : 200K tokens
   - Afficher une alerte à 90%+
   - Optimiser le contexte avant 99%

4. **Credentials API (avancé)**
   - macOS : Keychain
   - Windows : Registry ou autre
   - Permet tracking usage quotidien

### ⚠️ Erreurs à Éviter

1. ❌ **Script non exécutable**
   - Toujours `chmod +x` après création

2. ❌ **Chemin relatif dans config**
   - Utiliser chemins absolus (`~/.claude/...`)

3. ❌ **Oublier jq**
   - Installer jq pour parser JSON facilement

4. ❌ **Ignorer les erreurs**
   - Ajouter `2>/dev/null` pour gérer les repos non-git

### 💪 Best Practices

1. ✅ **Progressive disclosure**
   - Commencer simple (cost seulement)
   - Ajouter progressivement (git, tokens, usage)

2. ✅ **Performance**
   - Cacher les résultats API (rate limits)
   - Éviter les appels lents dans le script

3. ✅ **Couleurs ANSI**
   - Utiliser pour alertes visuelles
   - Rouge = danger, Jaune = warning, Vert = OK

4. ✅ **Testabilité**
   - Tester avec echo JSON pour debug
   - Logs dans stderr (pas stdout)

### 🚀 Next Steps

1. **Niveau Débutant** : Script bash simple avec cost + git
2. **Niveau Intermédiaire** : Ajouter tokens depuis transcript
3. **Niveau Avancé** : Intégrer API Claude pour usage quotidien
4. **Niveau Expert** : Solution TypeScript complète type Melvynx

---

## 📚 Ressources Complémentaires

### 📄 Documentation Officielle

- [Status Line Config](https://docs.claude.com/en/docs/claude-code/statusline) - Docs Claude Code
- [JSON Input Schema](https://docs.claude.com/en/docs/claude-code/statusline#input-format) - Structure complète

### 🎥 Vidéos

- [Status Line ULTIME - Melvynx](https://youtu.be/CgxOnY-RIlo) - 11 min, solution complète TypeScript

### 🔗 Repos Communauté

- [melvynx/claude-statusline](https://github.com/melvynx/claude-statusline) - Solution TypeScript avancée
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code) - Collection ressources

### 🛠️ Outils

- [jq](https://jqlang.github.io/jq/) - Parser JSON en ligne de commande
- [ANSI Escape Codes](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797) - Couleurs terminal

---

## 💬 Citations Inspirantes

> "Quand tu arrives à 99%, l'auto-compact s'effectue automatiquement et c'est une information cruciale quand tu codes pour réussir à avancer"
> — Melvynx

> "Moi je sais que quand j'arrive à la fin de ma session et qu'il me reste 30 minutes, je commence à bombarder les messages"
> — Melvynx (optimisation usage quotidien)

> "J'ai passé des jours sur cette status line à faire tout au pixel près"
> — Melvynx (qualité avant tout)

---

**🎯 Niveau de difficulté** : 🟡 Intermédiaire (installation simple) → 🟠 Avancé (customisation complète)
**⏱️ Temps de mise en pratique** : 15-30 min (basique) → 2-4h (solution complète)
**💪 Impact** : 🔥🔥🔥 Très élevé - Visibilité totale sur votre workflow Claude Code
