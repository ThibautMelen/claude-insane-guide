# 🟠 Niveau 3 : Maîtrise - Enterprise & Governance

> **Objectif** : Créer une infrastructure de plugins enterprise avec marketplace organisation, governance, et workflows avancés
>
> **Durée estimée** : 25 minutes
>
> **Prérequis** : Avoir complété [Niveau 2](./niveau-2.md)

---

## 🎯 Ce que vous allez apprendre

- ✅ Architecture marketplace organisation multi-plugins
- ✅ Governance et policies (plugins requis, versions)
- ✅ Configuration équipe avec `.claude/settings.json`
- ✅ Plugin enterprise avec tous composants
- ✅ Multi-environnements (dev, staging, prod)
- ✅ CI/CD pour validation et distribution

---

## 📚 Exercice 3.1 : Marketplace Organisation

### 🎬 Contexte

Vous gérez une organisation avec 50+ développeurs répartis en 4 équipes :
- Frontend (React/Next.js)
- Backend (Node.js/Python)
- DevOps (Docker/K8s)
- Security

Chaque équipe a ses outils, mais certains plugins sont obligatoires pour tous.

### ✏️ Instructions

**Étape 1 : Structure Marketplace**

```bash
mkdir company-plugins-marketplace
cd company-plugins-marketplace

# Structure
mkdir -p plugins docs .github/workflows
```

**Étape 2 : marketplace.json**

```json
{
  "name": "company-official",
  "owner": {
    "name": "Company Engineering",
    "email": "engineering@company.com"
  },
  "description": "Marketplace officielle Company - Plugins validés et maintenus",
  "strict": true,

  "plugins": [
    {
      "name": "security-baseline",
      "source": {
        "source": "github",
        "repo": "company/security-baseline-plugin",
        "ref": "v2.1.0"
      },
      "description": "⭐ Standards sécurité OBLIGATOIRES",
      "version": "2.1.0",
      "keywords": ["security", "compliance", "required"],
      "required": true
    },
    {
      "name": "frontend-tools",
      "source": {
        "source": "github",
        "repo": "company/frontend-tools-plugin",
        "ref": "v3.2.1"
      },
      "description": "Outils équipe Frontend (React/Next.js)",
      "version": "3.2.1",
      "keywords": ["react", "nextjs", "frontend"],
      "team": "frontend"
    },
    {
      "name": "backend-tools",
      "source": {
        "source": "github",
        "repo": "company/backend-tools-plugin",
        "ref": "v2.5.0"
      },
      "description": "Outils équipe Backend (Node.js/Python)",
      "version": "2.5.0",
      "keywords": ["nodejs", "python", "api"],
      "team": "backend"
    },
    {
      "name": "devops-tools",
      "source": {
        "source": "github",
        "repo": "company/devops-tools-plugin",
        "ref": "v4.0.2"
      },
      "description": "Outils DevOps (Docker, K8s, Terraform)",
      "version": "4.0.2",
      "keywords": ["docker", "kubernetes", "terraform"],
      "team": "devops"
    },
    {
      "name": "database-tools",
      "source": {
        "source": "github",
        "repo": "company/database-tools-plugin",
        "ref": "v1.3.0"
      },
      "description": "Migrations, queries, optimisations DB",
      "version": "1.3.0",
      "keywords": ["postgres", "mysql", "database"]
    },
    {
      "name": "testing-suite",
      "source": {
        "source": "github",
        "repo": "company/testing-suite-plugin",
        "ref": "v2.0.0"
      },
      "description": "Génération tests (unit, integration, e2e)",
      "version": "2.0.0",
      "keywords": ["testing", "jest", "cypress"]
    }
  ]
}
```

**Étape 3 : README.md**

```markdown
# Company Plugins Marketplace 🏢

> Marketplace officielle Company Engineering

## 📦 Plugins Disponibles

### ⭐ Obligatoires (tous devs)

| Plugin | Version | Description |
|--------|---------|-------------|
| **security-baseline** | v2.1.0 | Standards sécurité Company |

### 👥 Par Équipe

#### Frontend
- **frontend-tools** (v3.2.1) - React, Next.js, Tailwind

#### Backend
- **backend-tools** (v2.5.0) - Node.js, Python, APIs

#### DevOps
- **devops-tools** (v4.0.2) - Docker, K8s, Terraform

### 🔧 Transverses

| Plugin | Description |
|--------|-------------|
| **database-tools** | Migrations, queries |
| **testing-suite** | Tests generator |

## 🚀 Installation

### Configuration Initiale

Ajouter à votre `.claude/settings.json` :

\`\`\`json
{
  "extraKnownMarketplaces": {
    "company-official": {
      "source": {
        "source": "github",
        "repo": "company/plugins-marketplace"
      }
    }
  }
}
\`\`\`

### Par Équipe

**Frontend** :
\`\`\`json
{
  "autoInstallPlugins": [
    "security-baseline@company-official",
    "frontend-tools@company-official",
    "testing-suite@company-official"
  ]
}
\`\`\`

**Backend** :
\`\`\`json
{
  "autoInstallPlugins": [
    "security-baseline@company-official",
    "backend-tools@company-official",
    "database-tools@company-official",
    "testing-suite@company-official"
  ]
}
\`\`\`

**DevOps** :
\`\`\`json
{
  "autoInstallPlugins": [
    "security-baseline@company-official",
    "devops-tools@company-official",
    "database-tools@company-official"
  ]
}
\`\`\`

## 📚 Documentation

- [Security Baseline](./docs/security-baseline.md)
- [Frontend Tools](./docs/frontend-tools.md)
- [Backend Tools](./docs/backend-tools.md)
- [DevOps Tools](./docs/devops-tools.md)

## 🔄 Updates

Vérifier updates : `/plugin update [nom-plugin]`

Politique : Updates obligatoires sous 1 semaine pour security patches.

## 🐛 Issues

Report bugs : [GitHub Issues](https://github.com/company/plugins-marketplace/issues)

## 👥 Maintenance

Équipe Platform Engineering - platform@company.com
```

**Étape 4 : Documentation Plugins**

`docs/security-baseline.md` :

```markdown
# Security Baseline Plugin

## 🔒 Description

Plugin obligatoire enforçant standards sécurité Company.

## 📦 Composants

### Commands
- `/security-scan` - Scanner vulnérabilités
- `/check-secrets` - Détecter secrets exposés
- `/compliance-report` - Rapport compliance

### Agents
- `security-auditor` - Audit code automatique
- `threat-detector` - Détection menaces

### Hooks
- **PreToolUse Bash** - Bloque commits avec secrets
- **PostToolUse Edit** - Valide config sécurisées
- **SessionEnd** - Envoie logs audit au SIEM

### MCP
- SIEM integration (Splunk)
- Vault (secrets management)

## ⚙️ Configuration Requise

Variables environnement :
\`\`\`bash
export SIEM_ENDPOINT="https://siem.company.com"
export SIEM_TOKEN="..."
export VAULT_ADDR="https://vault.company.com"
export VAULT_TOKEN="..."
\`\`\`

## 🚨 Hooks Bloquants

- ❌ Commit avec secrets → BLOQUÉ
- ❌ Fichiers .env dans Git → BLOQUÉ
- ❌ Dependencies vulnérables → WARNING

## 📊 Compliance

Ce plugin enforce :
- SOC 2 Type II
- ISO 27001
- PCI DSS (si applicable)
```

**Étape 5 : CI/CD Validation**

`.github/workflows/validate-marketplace.yml` :

```yaml
name: Validate Marketplace

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  validate:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Validate marketplace.json
        run: |
          jq empty marketplace.json
          echo "✅ marketplace.json valide"

      - name: Check plugins exist
        run: |
          # Vérifier que tous les repos plugins existent
          PLUGINS=$(jq -r '.plugins[].source.repo' marketplace.json)
          for plugin in $PLUGINS; do
            echo "Checking $plugin..."
            gh repo view $plugin || exit 1
          done
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}

      - name: Validate versions
        run: |
          # Vérifier que refs/tags existent
          jq -c '.plugins[]' marketplace.json | while read plugin; do
            REPO=$(echo $plugin | jq -r '.source.repo')
            REF=$(echo $plugin | jq -r '.source.ref')
            echo "Validating $REPO @ $REF"
            gh api repos/$REPO/git/ref/tags/$REF || exit 1
          done
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

**Étape 6 : Publier**

```bash
git init
git add .
git commit -m "init: company plugins marketplace"

gh repo create company-plugins-marketplace --private --source=. --push
git tag v1.0.0
git push --tags
```

### ✅ Validation

- ✅ Marketplace avec 6+ plugins
- ✅ `required: true` pour security-baseline
- ✅ Documentation par plugin
- ✅ CI/CD validation
- ✅ Publié sur GitHub

---

## 📚 Exercice 3.2 : Plugin Enterprise Complet

### 🎬 Contexte

Créez le plugin `security-baseline` mentionné ci-dessus.

### ✏️ Instructions

**Étape 1 : Structure**

```bash
mkdir security-baseline-plugin
cd security-baseline-plugin

mkdir -p .claude-plugin commands agents hooks scripts
mkdir -p config/{dev,staging,production}
```

**Étape 2 : plugin.json avec variables**

`.claude-plugin/plugin.json` :

```json
{
  "name": "security-baseline",
  "version": "2.1.0",
  "description": "Security baseline enforcing Company standards",
  "author": {
    "name": "Company Security Team",
    "email": "security@company.com"
  },
  "license": "PROPRIETARY",
  "keywords": ["security", "compliance", "required"],

  "commands": ["${CLAUDE_PLUGIN_ROOT}/commands"],
  "agents": "${CLAUDE_PLUGIN_ROOT}/agents",
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/${ENV:-production}.hooks.json",
  "mcpServers": "${CLAUDE_PLUGIN_ROOT}/.mcp.json"
}
```

**Étape 3 : Commands**

`commands/security-scan.md` :

```markdown
---
name: security-scan
description: Scanner vulnérabilités code et dependencies
---

Effectue scan sécurité complet :

1. **Dependencies**
   - npm audit / pip-audit
   - Check versions obsolètes
   - Vulnérabilités connues (CVE)

2. **Code**
   - Secrets exposés (regex patterns)
   - SQL injection patterns
   - XSS vulnerabilities
   - Hardcoded credentials

3. **Configuration**
   - HTTPS enforced
   - CORS configuré
   - Headers sécurité présents

Génère rapport avec :
- Criticalité (Critical, High, Medium, Low)
- Recommandations fixes
- Liens CVE si applicable
```

`commands/check-secrets.md` :

```markdown
---
name: check-secrets
description: Détecter secrets exposés dans code
---

Scan tous fichiers pour patterns secrets :

**Patterns détectés** :
- API keys (AWS, GCP, Azure, etc.)
- Tokens (JWT, OAuth, etc.)
- Passwords hardcodés
- Private keys (.pem, .key)
- Database URLs avec credentials

**Actions** :
1. Liste tous matches
2. Suggère migration vers Vault
3. Génère .gitignore si manquant
4. Propose pre-commit hook

⚠️ BLOQUE commit si secrets détectés !
```

`commands/compliance-report.md` :

```markdown
---
name: compliance-report
description: Générer rapport compliance (SOC2, ISO27001)
---

Génère rapport compliance pour audits :

**Checklist SOC 2** :
- Access controls
- Encryption at rest/transit
- Logging & monitoring
- Incident response
- Data retention

**Checklist ISO 27001** :
- Asset management
- Risk assessment
- Security policies
- Personnel security

Format : PDF + JSON exportable
```

**Étape 4 : Agents**

`agents/security-auditor.md` :

```markdown
# Security Auditor Agent

Expert sécurité application. Effectue audits automatiques.

## 🎯 Focus Areas

### OWASP Top 10
1. Injection (SQL, NoSQL, OS)
2. Broken Authentication
3. Sensitive Data Exposure
4. XML External Entities (XXE)
5. Broken Access Control
6. Security Misconfiguration
7. Cross-Site Scripting (XSS)
8. Insecure Deserialization
9. Using Components with Known Vulnerabilities
10. Insufficient Logging & Monitoring

### Company Standards
- Secrets dans Vault uniquement
- MFA enforced
- HTTPS partout
- Input validation stricte
- Output encoding
- CORS restrictif

## 🛠️ Tools

Read, Grep, Bash, Edit

## 📋 Output

\`\`\`markdown
# Security Audit Report

## 🔴 Critical Issues
- ...

## 🟠 High Priority
- ...

## 🟡 Medium Priority
- ...

## 🟢 Low Priority
- ...

## ✅ Compliant
- ...

## 📊 Score: X/100
\`\`\`
```

`agents/threat-detector.md` :

```markdown
# Threat Detector Agent

Détecte menaces potentielles en temps réel.

## 🎯 Threats Monitored

- Suspicious patterns (reverse shells, etc.)
- Obfuscated code
- Eval/exec usage
- File system access non justifié
- Network calls suspects
- Data exfiltration patterns

## 🚨 Actions

1. Log threat au SIEM
2. Notifier Security team
3. Bloquer si critique
4. Suggérer mitigations

## Output

Alerts temps réel dans Claude + SIEM logs
```

**Étape 5 : Hooks Multi-Env**

`hooks/production.hooks.json` :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '🔒 Security Baseline PROD activé'"
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git commit",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/pre-commit-check.sh",
      "blocking": true
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(env|yaml|yml|json)$",
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

`hooks/dev.hooks.json` :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '🔒 Security Baseline DEV activé (hooks non bloquants)'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "bash ${CLAUDE_PLUGIN_ROOT}/scripts/lint-security.sh",
      "blocking": false
    }
  ]
}
```

**Étape 6 : Scripts**

`scripts/pre-commit-check.sh` :

```bash
#!/bin/bash
# Vérifications pre-commit bloquantes

echo "🔍 Pre-commit security checks..."

# Check 1: Secrets
echo "1. Checking for secrets..."
if grep -rE '(password|api_key|secret|token)\s*=\s*["'\''][^"'\'']+["'\'']' . 2>/dev/null | grep -v node_modules; then
  echo "❌ BLOQUÉ : Secrets détectés !"
  echo "👉 Utilisez Vault : /check-secrets"
  exit 1
fi

# Check 2: .env files
echo "2. Checking for .env in commits..."
if git diff --cached --name-only | grep -E '\\.env$'; then
  echo "❌ BLOQUÉ : Fichier .env dans commit !"
  echo "👉 Ajoutez .env au .gitignore"
  exit 1
fi

# Check 3: Large files
echo "3. Checking file sizes..."
LARGE_FILES=$(git diff --cached --name-only | xargs -I {} stat -f%z {} 2>/dev/null | awk '$1 > 5000000')
if [ -n "$LARGE_FILES" ]; then
  echo "⚠️ WARNING : Fichiers > 5MB détectés"
fi

echo "✅ Pre-commit checks passed"
exit 0
```

`scripts/send-audit-log.sh` :

```bash
#!/bin/bash
# Envoyer logs audit au SIEM

if [ -z "$SIEM_ENDPOINT" ]; then
  echo "⚠️ SIEM_ENDPOINT not configured, skipping audit log"
  exit 0
fi

LOG_DATA=$(cat <<EOF
{
  "timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "user": "${USER}",
  "session_duration": "${SECONDS}",
  "plugin": "security-baseline",
  "version": "2.1.0"
}
EOF
)

curl -X POST "$SIEM_ENDPOINT/api/audit" \
  -H "Authorization: Bearer $SIEM_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$LOG_DATA" \
  2>/dev/null

echo "📊 Audit log sent to SIEM"
```

```bash
chmod +x scripts/*.sh
```

**Étape 7 : .mcp.json**

```json
{
  "mcpServers": {
    "vault": {
      "command": "npx",
      "args": ["-y", "@hashicorp/vault-mcp-server"],
      "env": {
        "VAULT_ADDR": "${VAULT_ADDR}",
        "VAULT_TOKEN": "${VAULT_TOKEN}"
      }
    },
    "siem": {
      "command": "npx",
      "args": ["-y", "@company/siem-mcp-server"],
      "env": {
        "SIEM_ENDPOINT": "${SIEM_ENDPOINT}",
        "SIEM_TOKEN": "${SIEM_TOKEN}"
      }
    }
  }
}
```

**Étape 8 : Publier**

```bash
git init
git add .
git commit -m "feat: security baseline plugin v2.1.0"

gh repo create security-baseline-plugin --private --source=. --push

git tag v2.1.0
git push --tags
gh release create v2.1.0 --notes "Production-ready security baseline"
```

### ✅ Validation

- ✅ Plugin complet (Commands + Agents + Hooks + MCP)
- ✅ Multi-env (dev vs prod hooks)
- ✅ Hooks bloquants en prod
- ✅ Scripts audit/compliance
- ✅ Integration SIEM + Vault
- ✅ Publié et versionné

---

## 📚 Exercice 3.3 : Configuration Équipe

### 🎬 Contexte

Distribuez la configuration aux équipes pour auto-installation.

### ✏️ Instructions

**Étape 1 : Template .claude/settings.json**

`team-configs/frontend-team.settings.json` :

```json
{
  "extraKnownMarketplaces": {
    "company-official": {
      "source": {
        "source": "github",
        "repo": "company/plugins-marketplace"
      }
    }
  },

  "autoInstallPlugins": [
    "security-baseline@company-official",
    "frontend-tools@company-official",
    "testing-suite@company-official"
  ],

  "pluginSettings": {
    "security-baseline": {
      "env": "production",
      "strictMode": true,
      "siem": {
        "endpoint": "${SIEM_ENDPOINT}",
        "token": "${SIEM_TOKEN}"
      }
    }
  }
}
```

`team-configs/backend-team.settings.json` :

```json
{
  "extraKnownMarketplaces": {
    "company-official": {
      "source": {
        "source": "github",
        "repo": "company/plugins-marketplace"
      }
    }
  },

  "autoInstallPlugins": [
    "security-baseline@company-official",
    "backend-tools@company-official",
    "database-tools@company-official",
    "testing-suite@company-official"
  ]
}
```

**Étape 2 : Script d'installation**

`install-team-config.sh` :

```bash
#!/bin/bash
# Installation configuration équipe

echo "🏢 Company Plugin Configuration Setup"
echo ""
echo "Sélectionnez votre équipe :"
echo "1) Frontend"
echo "2) Backend"
echo "3) DevOps"
echo "4) Security"

read -p "Choix (1-4): " choice

case $choice in
  1)
    CONFIG="frontend-team.settings.json"
    TEAM="Frontend"
    ;;
  2)
    CONFIG="backend-team.settings.json"
    TEAM="Backend"
    ;;
  3)
    CONFIG="devops-team.settings.json"
    TEAM="DevOps"
    ;;
  4)
    CONFIG="security-team.settings.json"
    TEAM="Security"
    ;;
  *)
    echo "❌ Choix invalide"
    exit 1
    ;;
esac

echo ""
echo "📦 Installation configuration équipe $TEAM..."

# Créer .claude si n'existe pas
mkdir -p ~/.claude

# Backup si existe
if [ -f ~/.claude/settings.json ]; then
  cp ~/.claude/settings.json ~/.claude/settings.json.backup
  echo "💾 Backup créé : ~/.claude/settings.json.backup"
fi

# Copier config
cp "team-configs/$CONFIG" ~/.claude/settings.json

echo "✅ Configuration installée !"
echo ""
echo "📝 Variables d'environnement requises :"
echo "  export SIEM_ENDPOINT='https://siem.company.com'"
echo "  export SIEM_TOKEN='...'"
echo "  export VAULT_ADDR='https://vault.company.com'"
echo "  export VAULT_TOKEN='...'"
echo ""
echo "🚀 Relancez Claude Code pour activer les plugins"
```

**Étape 3 : Documentation Onboarding**

`docs/ONBOARDING.md` :

```markdown
# Onboarding - Company Plugins

## 🎯 Pour Nouveaux Développeurs

### 1. Installer Configuration

\`\`\`bash
# Cloner repo config
git clone https://github.com/company/plugins-marketplace.git
cd plugins-marketplace

# Lancer setup interactif
bash install-team-config.sh

# Choisir votre équipe
\`\`\`

### 2. Variables Environnement

Ajouter à votre `~/.zshrc` ou `~/.bashrc` :

\`\`\`bash
# Company Plugin Env
export SIEM_ENDPOINT="https://siem.company.com"
export SIEM_TOKEN="demander-a-platform-team"
export VAULT_ADDR="https://vault.company.com"
export VAULT_TOKEN="demander-a-platform-team"
\`\`\`

Puis :
\`\`\`bash
source ~/.zshrc
\`\`\`

### 3. Vérifier Installation

Lancer Claude Code, puis :

\`\`\`bash
/plugin list

# Vous devriez voir :
# ✅ security-baseline (enabled)
# ✅ [autres plugins équipe] (enabled)
\`\`\`

### 4. Premier Usage

\`\`\`bash
# Scanner sécurité projet
/security-scan

# Vérifier secrets
/check-secrets

# Générer rapport compliance
/compliance-report
\`\`\`

## 🔒 Security Baseline (Obligatoire)

### Hooks Actifs

- ❌ **Bloque** commits avec secrets
- ❌ **Bloque** fichiers .env
- ⚠️ **Warn** dependencies vulnérables
- 📊 **Log** audit au SIEM

### Que faire si bloqué ?

\`\`\`bash
# Secrets détectés
/check-secrets
# → Suggère migration Vault

# .env dans commit
echo ".env" >> .gitignore
git add .gitignore
\`\`\`

## 📚 Ressources

- [Security Baseline Docs](./security-baseline.md)
- [Frontend Tools](./frontend-tools.md)
- [Testing Suite](./testing-suite.md)
- [Support Slack](https://company.slack.com/archives/platform-support)

## 🐛 Problèmes ?

Contact Platform Engineering : platform@company.com
```

### ✅ Validation

- ✅ Configs par équipe créées
- ✅ Script installation interactif
- ✅ Documentation onboarding
- ✅ Variables environnement documentées
- ✅ Support défini

---

## 🎓 Points Clés Niveau 3

### 🏢 Marketplace Enterprise

```json
{
  "plugins": [
    {
      "required": true,  ← Obligatoire tous devs
      "team": "frontend"  ← Ou spécifique équipe
    }
  ]
}
```

Governance centralisée !

### 🔧 Multi-Env Hooks

```json
// plugin.json
{
  "hooks": "${CLAUDE_PLUGIN_ROOT}/hooks/${ENV}.hooks.json"
}

// Dev : ENV=dev → non-bloquant
// Prod : ENV=production → bloquant
```

Flexibilité par environnement !

### 📦 Auto-Installation

```json
// .claude/settings.json
{
  "autoInstallPlugins": [
    "security-baseline@company-official"
  ]
}
```

Zero-config pour nouveaux devs !

### 🔒 Compliance Enforced

```bash
# Hooks bloquants
PreToolUse → Valide avant action
PostToolUse → Vérifie après action
SessionEnd → Audit logs
```

Standards automatiques !

---

## 🚀 Bonus : Aller Plus Loin

### Bonus 1 : Metrics & Analytics

Ajoutez plugin tracking usage :

```json
// .mcp.json
{
  "analytics": {
    "command": "npx",
    "args": ["@company/analytics-mcp"],
    "env": {
      "ANALYTICS_ENDPOINT": "${ANALYTICS_ENDPOINT}"
    }
  }
}
```

Hooks pour tracker :
- Commands les plus utilisées
- Temps sessions
- Erreurs fréquentes

### Bonus 2 : Plugin Updates Auto

GitHub Action hebdomadaire :

```yaml
# .github/workflows/update-plugins.yml
name: Update Plugins

on:
  schedule:
    - cron: '0 9 * * 1'  # Lundi 9h

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Check for updates
        run: |
          # Check GitHub releases
          # Update marketplace.json si nouvelles versions
          # Create PR automatique
```

### Bonus 3 : Governance Dashboard

Web app pour visualiser :
- Plugins installés par dev
- Compliance rate
- Versions utilisées
- Adoption metrics

Tech : Next.js + API querying SIEM logs

---

## ✏️ Projet Final

**Créez infrastructure complète** pour votre organisation :

1. **Marketplace** avec 5+ plugins
2. **Plugin enterprise** obligatoire (security/quality/etc.)
3. **Configs par équipe** (frontend, backend, etc.)
4. **Scripts onboarding** automatiques
5. **CI/CD** validation + updates
6. **Documentation** complète + support

**Présentation finale** :
- Architecture overview
- Governance policies
- Metrics adoption
- ROI estimé (temps gagné)

---

## 🎯 Résumé Niveau 3

**Ce que vous maîtrisez maintenant** :

✅ Marketplace organisation multi-plugins
✅ Governance et compliance enforced
✅ Configuration équipe avec auto-installation
✅ Plugin enterprise production-ready
✅ Multi-environnements (dev, staging, prod)
✅ CI/CD validation et distribution
✅ Onboarding automatisé
✅ Metrics et monitoring

**Vous êtes maintenant expert Plugins Claude Code !** 🎓

**Temps investi total (Niveaux 1-3)** : ~60 minutes
**Compétence acquise** : Architecture plugins enterprise ✨

---

**🎉 Félicitations !** Vous maîtrisez l'infrastructure plugins enterprise !

[← Niveau 2](./niveau-2.md) | [Guide Complet](../guide.md) | [Cheatsheet](../cheatsheet.md)
