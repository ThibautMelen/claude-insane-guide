# 🎨 Status Line - Cheatsheet

**Référence rapide pour configurer et personnaliser votre Status Line**

---

## ⚡ Configuration Ultra-Rapide

### 1. Configuration JSON (.claude/settings.json)

```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "padding": 0
  }
}
```

### 2. Script Minimal (Bash)

```bash
#!/bin/bash
INPUT=$(cat)
COST=$(echo "$INPUT" | jq -r '.cost.total_cost_usd // 0')
echo "💰 \$$COST"
```

### 3. Rendre Exécutable

```bash
chmod +x ~/.claude/statusline.sh
```

---

## 📊 Structure JSON Input

```json
{
  "hook_event_name": "Status",
  "session_id": "abc123...",
  "transcript_path": "/path/to/transcript.json",
  "cwd": "/current/working/directory",
  "model": {
    "id": "claude-sonnet-4-5-20250929",
    "display_name": "Sonnet 4.5"
  },
  "cost": {
    "total_cost_usd": 0.01234,
    "total_duration_ms": 45000,
    "total_lines_added": 156,
    "total_lines_removed": 23
  }
}
```

---

## 🔧 Commandes Essentielles

### Parser JSON avec jq

```bash
# Coût total
echo $INPUT | jq -r '.cost.total_cost_usd'

# Modèle utilisé
echo $INPUT | jq -r '.model.display_name'

# Chemin du transcript
echo $INPUT | jq -r '.transcript_path'

# Working directory
echo $INPUT | jq -r '.cwd'

# Lignes ajoutées
echo $INPUT | jq -r '.cost.total_lines_added'
```

### Git Info

```bash
# Branche actuelle
git rev-parse --abbrev-ref HEAD

# Fichiers modifiés (ajouts)
git diff --numstat | awk '{s+=$1} END {print s+0}'

# Fichiers modifiés (suppressions)
git diff --numstat | awk '{s+=$2} END {print s+0}'

# Fichiers en staging
git diff --cached --name-only | wc -l

# Status court
git status --short
```

### Tokens depuis Transcript

```bash
# Lire le transcript JSON
TRANSCRIPT="/path/to/transcript.json"

# Tokens input
jq -r '.messages[-1].usage.input_tokens // 0' "$TRANSCRIPT"

# Tokens cache
jq -r '.messages[-1].usage.cache_read_input_tokens // 0' "$TRANSCRIPT"

# Total tokens (bash)
TOKENS=$(jq -r '.messages[-1].usage.input_tokens // 0' "$TRANSCRIPT")
CACHE=$(jq -r '.messages[-1].usage.cache_read_input_tokens // 0' "$TRANSCRIPT")
TOTAL=$((TOKENS + CACHE))
echo $TOTAL
```

---

## 🎨 Composants Visuels

### Emojis Populaires

```bash
📦  # Git / Branch
🧠  # Tokens / Context
💰  # Cost
📊  # Usage / Stats
⚠️  # Warning
🔴  # Danger / Critical
🟡  # Medium / Warning
🟢  # OK / Low
⏰  # Time / Reset
🔄  # Refresh / Update
```

### Progress Bar

```bash
# Fonction Bash
progress_bar() {
  local percent=$1
  local width=${2:-10}
  local filled=$((percent * width / 100))
  local empty=$((width - filled))

  printf '█%.0s' $(seq 1 $filled)
  printf '░%.0s' $(seq 1 $empty)
}

# Utilisation
progress_bar 81 10  # ████████░░
```

### Couleurs ANSI

```bash
# Codes couleurs
RESET='\033[0m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'

# Fonction colorize
colorize() {
  local text=$1
  local color=$2
  echo -e "${color}${text}${RESET}"
}

# Utilisation
colorize "⚠️ Warning" "$YELLOW"
colorize "✅ Success" "$GREEN"
colorize "❌ Error" "$RED"
```

---

## 📊 Templates Prêts à l'Emploi

### Template 1 : Minimal (Cost only)

```bash
#!/bin/bash
INPUT=$(cat)
COST=$(echo "$INPUT" | jq -r '.cost.total_cost_usd // 0')
printf "💰 \$%.2f" $COST
```

### Template 2 : Git + Cost

```bash
#!/bin/bash
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd')
COST=$(echo "$INPUT" | jq -r '.cost.total_cost_usd // 0')

cd "$CWD" 2>/dev/null
if git rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  echo "📦 $BRANCH │ 💰 \$$COST"
else
  echo "💰 \$$COST"
fi
```

### Template 3 : Git + Tokens + Cost

```bash
#!/bin/bash
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd')
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path')
COST=$(echo "$INPUT" | jq -r '.cost.total_cost_usd // 0')

# Git
cd "$CWD" 2>/dev/null
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-git")

# Tokens
if [ -f "$TRANSCRIPT" ]; then
  TOKENS=$(jq -r '.messages[-1].usage.input_tokens // 0' "$TRANSCRIPT")
  CACHE=$(jq -r '.messages[-1].usage.cache_read_input_tokens // 0' "$TRANSCRIPT")
  TOTAL=$((TOKENS + CACHE))
  TOTAL_K=$((TOTAL / 1000))
  PERCENT=$((TOTAL * 100 / 200000))
  TOKEN_INFO="🧠 ${TOTAL_K}K (${PERCENT}%)"
else
  TOKEN_INFO="🧠 N/A"
fi

echo "📦 $BRANCH │ $TOKEN_INFO │ 💰 \$$COST"
```

### Template 4 : Complet avec Progress Bar

```bash
#!/bin/bash
INPUT=$(cat)
CWD=$(echo "$INPUT" | jq -r '.cwd')
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path')
COST=$(echo "$INPUT" | jq -r '.cost.total_cost_usd // 0')

# Fonction progress bar
progress_bar() {
  local percent=$1
  local filled=$((percent / 10))
  local empty=$((10 - filled))
  printf '█%.0s' $(seq 1 $filled)
  printf '░%.0s' $(seq 1 $empty)
}

# Git
cd "$CWD" 2>/dev/null
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-git")
ADDED=$(git diff --numstat 2>/dev/null | awk '{s+=$1} END {print s+0}')
REMOVED=$(git diff --numstat 2>/dev/null | awk '{s+=$2} END {print s+0}')

# Tokens
if [ -f "$TRANSCRIPT" ]; then
  TOKENS=$(jq -r '.messages[-1].usage.input_tokens // 0' "$TRANSCRIPT")
  CACHE=$(jq -r '.messages[-1].usage.cache_read_input_tokens // 0' "$TRANSCRIPT")
  TOTAL=$((TOKENS + CACHE))
  TOTAL_K=$((TOTAL / 1000))
  PERCENT=$((TOTAL * 100 / 200000))
  PROGRESS=$(progress_bar $PERCENT)
  TOKEN_INFO="🧠 ${TOTAL_K}K (${PERCENT}%) $PROGRESS"
else
  TOKEN_INFO="🧠 N/A"
fi

# Output
echo "📦 $BRANCH +$ADDED -$REMOVED │ $TOKEN_INFO │ 💰 \$$COST"
```

---

## 🔧 TypeScript (Structure Avancée)

### Setup Base

```typescript
#!/usr/bin/env node
import fs from 'fs';
import { execSync } from 'child_process';

interface StatusInput {
  transcript_path: string;
  cwd: string;
  cost: { total_cost_usd: number };
  model: { display_name: string };
}

const input: StatusInput = JSON.parse(
  fs.readFileSync('/dev/stdin', 'utf-8')
);
```

### Helpers

```typescript
// Git info
function getGitBranch(cwd: string): string {
  try {
    process.chdir(cwd);
    return execSync('git rev-parse --abbrev-ref HEAD').toString().trim();
  } catch {
    return 'no-git';
  }
}

// Tokens
function getTokens(transcriptPath: string): { total: number; percent: number } {
  try {
    const transcript = JSON.parse(fs.readFileSync(transcriptPath, 'utf-8'));
    const lastMsg = transcript.messages[transcript.messages.length - 1];
    const input = lastMsg?.usage?.input_tokens || 0;
    const cache = lastMsg?.usage?.cache_read_input_tokens || 0;
    const total = input + cache;
    return { total, percent: Math.round((total / 200000) * 100) };
  } catch {
    return { total: 0, percent: 0 };
  }
}

// Progress bar
function progressBar(percent: number, width: number = 10): string {
  const filled = Math.round((percent / 100) * width);
  return '█'.repeat(filled) + '░'.repeat(Math.max(0, width - filled));
}

// Colorize
const colors = {
  reset: '\x1b[0m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  green: '\x1b[32m'
};

function colorize(text: string, color: keyof typeof colors): string {
  return `${colors[color]}${text}${colors.reset}`;
}
```

---

## 🐛 Debug & Test

### Tester Votre Script

```bash
# Créer un JSON de test
cat > /tmp/test-input.json << 'EOF'
{
  "transcript_path": "/path/to/transcript.json",
  "cwd": "/Users/you/project",
  "cost": {
    "total_cost_usd": 0.1234
  },
  "model": {
    "display_name": "Sonnet 4.5"
  }
}
EOF

# Tester le script
cat /tmp/test-input.json | ~/.claude/statusline.sh
```

### Logs de Debug

```bash
#!/bin/bash
INPUT=$(cat)

# Logger dans stderr (pas stdout!)
echo "DEBUG: Input received" >&2
echo "$INPUT" | jq '.' >&2

# Votre logique normale...
COST=$(echo "$INPUT" | jq -r '.cost.total_cost_usd')
echo "💰 \$$COST"
```

### Vérifier la Config

```bash
# Voir la config status line
cat ~/.claude/settings.json | jq '.statusLine'

# Vérifier que le script existe et est exécutable
ls -la ~/.claude/statusline.sh

# Devrait afficher : -rwxr-xr-x
```

---

## ⚠️ Troubleshooting Rapide

| Problème | Solution |
|----------|----------|
| Status line ne s'affiche pas | `chmod +x ~/.claude/statusline.sh` |
| "jq not found" | `brew install jq` (macOS) |
| Transcript path incorrect | Vérifier `input.transcript_path` existe |
| Git errors | Ajouter `2>/dev/null` aux commandes git |
| Mauvais formatage | Tester avec `cat test.json \| script.sh` |
| Couleurs cassées | Utiliser ANSI escape codes correctement |

---

## 📦 Installation jq (Parser JSON)

```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install jq

# Windows (Chocolatey)
choco install jq

# Vérifier installation
jq --version
```

---

## 🎯 Checklist Configuration

- [ ] Créer `~/.claude/statusline.sh`
- [ ] Ajouter le shebang `#!/bin/bash`
- [ ] Rendre exécutable `chmod +x`
- [ ] Installer jq `brew install jq`
- [ ] Configurer `.claude/settings.json`
- [ ] Tester avec JSON de test
- [ ] Relancer session Claude Code
- [ ] Vérifier l'affichage

---

## 📚 Ressources

- [Docs Status Line](https://docs.claude.com/en/docs/claude-code/statusline)
- [jq Manual](https://jqlang.github.io/jq/manual/)
- [ANSI Colors](https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797)
- [Vidéo Melvynx](https://youtu.be/CgxOnY-RIlo)

---

**💡 Tip** : Commencez simple (cost seulement), puis ajoutez progressivement git, tokens, usage quotidien.

**⚡ Quick Start** : Copier un template prêt à l'emploi ci-dessus et l'adapter à vos besoins !
