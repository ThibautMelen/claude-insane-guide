# MCP (Model Context Protocol) - Guide Complet

> 📄 **Documentation Officielle** : https://modelcontextprotocol.io/

---

## ⚠️ Note Importante sur les Approches MCP

**Ce guide présente DEUX approches** :

```
╔═══════════════════════════════════════════════════════════╗
║  📊 DEUX ÉCOLES DE PENSÉE SUR MCP                         ║
╚═══════════════════════════════════════════════════════════╝

🔵 APPROCHE OFFICIELLE ANTHROPIC
   ├─> MCP = Feature légitime et utile
   ├─> Cas d'usage valides : Databases, GitHub, APIs
   ├─> Documentation complète et support officiel
   └─> Utilisé en production par beaucoup d'entreprises

🟠 APPROCHE MELVYNX (Opinion basée sur expérience)
   ├─> Éviter MCP (sauf Context7)
   ├─> Préférer CLI natives (gh, psql, curl)
   ├─> Raison : Pollution contexte (10-20K tokens)
   └─> Optimisation contexte pour code important
```

**Ce guide documente les DEUX approches** pour que tu puisses choisir selon tes besoins :
- ✅ Sections techniques MCP = Doc officielle Anthropic
- 💡 Sections "Recommandation Melvynx" = Opinion basée expérience 500h

**Tu choisis** : Utilise MCP si bénéfices > coût contexte pour ton cas d'usage.

---

## 📚 Théorie

### Qu'est-ce que MCP ?

Le **MCP (Model Context Protocol)** est un protocole permettant d'étendre Claude Code avec des **outils externes** (GitHub, databases, APIs, etc.) accessibles directement depuis le terminal.

```
╔══════════════════════════════════════════╗
║     MCP - VUE D'ENSEMBLE                 ║
╚══════════════════════════════════════════╝

Claude Code
     │
     ├─> MCP Server GitHub
     │   └─> Créer issues, PR, repos
     │
     ├─> MCP Server Database
     │   └─> Lire/écrire BDD
     │
     ├─> MCP Server Files
     │   └─> Accès filesystem étendu
     │
     └─> Context7 (Documentation)
         └─> Docs frameworks (Vite, React, etc.)
```

**Source** : Formation Melvynx Claude Code 2.0

---

### 🎯 Problème Résolu

**Concept** :
```
Avant MCP :
├── Claude limité au filesystem local
├── Pas d'accès GitHub, databases, APIs
└── Prompts manuels pour actions externes ❌

Avec MCP :
├── Claude peut créer issues GitHub
├── Claude peut lire/écrire BDD
├── Claude peut appeler APIs externes
└── Outils disponibles directement ✅
```

---

### ⚠️ MCP vs CLI : Avertissement Important

**🚨 RECOMMANDATION MELVYNX** : **Éviter MCP, préférer CLI**

```
╔══════════════════════════════════════════════╗
║     MCP vs CLI : COMPARAISON                 ║
╚══════════════════════════════════════════════╝

❌ APPROCHE MCP (Non Recommandée)
┌────────────────────────────────────────────┐
│  Installer MCP GitHub                      │
│  → Ajoute outils dans contexte permanent   │
│  → Consomme tokens à chaque message        │
│  → Limite espace pour code important       │
│  → 5-10% du contexte perdu                 │
└────────────────────────────────────────────┘

✅ APPROCHE CLI (Recommandée)
┌────────────────────────────────────────────┐
│  Installer GitHub CLI (gh)                 │
│  brew install gh                           │
│  → Claude utilise commandes bash           │
│  → Aucun contexte consommé                 │
│  → Outils disponibles à la demande         │
│  → Contexte 100% dédié au code             │
└────────────────────────────────────────────┘
```

**💡 Pourquoi éviter MCP ?**

```
Problème : POLLUTION DU CONTEXTE

Sans MCP:
┌────────────────────────────────────┐
│ Contexte disponible: 200K tokens   │
│ ✅ 100% pour votre code            │
└────────────────────────────────────┘

Avec 5 MCP:
┌────────────────────────────────────┐
│ Contexte disponible: 200K tokens   │
│ ❌ 10-20K tokens → MCP tools       │
│ ✅ 180-190K tokens → code          │
│                                    │
│ → Moins d'espace pour code!        │
└────────────────────────────────────┘
```

**Quote Melvynx** :
> "Faites attention au MCP. En règle générale, je déconseille tous les MCP et je vous conseille d'utiliser des CLI."

> "Plus tu as de MCP, plus tu vas utiliser du contexte et moins tu auras de la place pour ce qui est important."

---

### 🌟 Exception : Context7 (Seul MCP Recommandé)

**Context7** est le **SEUL MCP** recommandé par Melvynx car il apporte une **vraie valeur ajoutée** :

```
╔════════════════════════════════════════╗
║     CONTEXT7 - MCP RECOMMANDÉ          ║
╚════════════════════════════════════════╝

✅ Accès documentation optimisée
   ├─> Next.js
   ├─> Vite
   ├─> React
   ├─> Supabase
   ├─> TailwindCSS
   └─> 100+ frameworks

✅ Pas de recherche internet nécessaire
   → Documentation directement injectée

✅ Contexte optimisé
   → Pas de HTML brut
   → Markdown structuré
   → Pertinent et concis

✅ Gain de temps significatif
   → Pas de WebFetch/WebSearch
   → Documentation à jour
```

**Installation Context7** :

```bash
# 1. Créer compte sur context7.co
# 2. Obtenir API key
# 3. Installer MCP HTTP server

claude mcp add --transport http context7 https://mcp.context7.co \
  --header "Authorization: Bearer YOUR_CONTEXT7_API_KEY"

# Ou avec variable d'environnement
export CONTEXT7_API_KEY="your-key"
claude mcp add --transport http context7 https://mcp.context7.co \
  --header "Authorization: Bearer ${CONTEXT7_API_KEY}"

# Ou avec scope (user = tous projets)
claude mcp add --transport http context7 https://mcp.context7.co \
  --scope user \
  --header "Authorization: Bearer ${CONTEXT7_API_KEY}"

# 4. Redémarrer Claude Code
Ctrl+C
claude

# 5. Utiliser
"Utilise Context7 pour la doc de Vite"
```

**Utilité** :
- Documentation instantanée sans quitter Claude
- Contexte optimisé (markdown, pas HTML)
- Toujours à jour avec dernières versions

---

### 🔧 Alternative CLI Recommandée

**Au lieu de MCP**, utiliser **CLI natives** :

```
╔═══════════════════════════════════════════╗
║   COMMANDES CLI RECOMMANDÉES              ║
╚═══════════════════════════════════════════╝

🔹 GitHub CLI (gh)
┌────────────────────────────────────────┐
│ brew install gh                        │
│                                        │
│ Fonctionnalités:                       │
│ • gh repo create                       │
│ • gh issue create                      │
│ • gh pr create                         │
│ • gh issue list                        │
│ • gh pr merge                          │
└────────────────────────────────────────┘

🔹 Git
┌────────────────────────────────────────┐
│ Préinstallé sur macOS/Linux            │
│                                        │
│ Fonctionnalités:                       │
│ • git add / commit / push              │
│ • git branch / checkout                │
│ • git status / diff                    │
│ • git log                              │
└────────────────────────────────────────┘

🔹 npm/pnpm/yarn
┌────────────────────────────────────────┐
│ Gestion de packages                    │
│                                        │
│ Fonctionnalités:                       │
│ • npm install                          │
│ • npm run dev / build / test           │
│ • npm publish                          │
└────────────────────────────────────────┘

🔹 curl / httpie
┌────────────────────────────────────────┐
│ Requêtes HTTP                          │
│                                        │
│ Fonctionnalités:                       │
│ • curl -X POST https://api.com         │
│ • http GET https://api.com             │
└────────────────────────────────────────┘

🔹 jq
┌────────────────────────────────────────┐
│ Manipulation JSON                      │
│                                        │
│ Fonctionnalités:                       │
│ • cat data.json | jq '.users'          │
│ • jq '.[] | select(.active)'           │
└────────────────────────────────────────┘

🔹 Docker CLI
┌────────────────────────────────────────┐
│ Gestion conteneurs                     │
│                                        │
│ Fonctionnalités:                       │
│ • docker ps                            │
│ • docker run / stop                    │
│ • docker compose up                    │
└────────────────────────────────────────┘
```

**Exemple Workflow CLI** :

```bash
# Créer repo GitHub
claude
> "Utilise gh pour créer un nouveau repo 'mon-projet'"
→ Exécute: gh repo create mon-projet --public

# Créer issue
> "Créer une issue 'Bug login' sur GitHub"
→ Exécute: gh issue create --title "Bug login" --body "..."

# Commit + Push
> "Commit les changements avec message 'fix: login'"
→ Exécute: git add . && git commit -m "fix: login" && git push
```

**Avantages CLI vs MCP** :
```
✅ Aucun contexte consommé
✅ Outils disponibles à la demande uniquement
✅ Plus de flexibilité (toutes commandes bash)
✅ Pas d'installation MCP nécessaire
✅ Performance identique ou supérieure
```

---

### 🎯 Use Cases Concrets

#### 1. GitHub avec CLI (Recommandé)

```bash
# Installation
brew install gh
gh auth login

# Utilisation dans Claude
claude
> "Créer un repo 'projet-test' et push le code actuel"

# Claude exécute:
→ gh repo create projet-test --public --source=. --push
```

#### 2. Documentation avec Context7 (Seul MCP OK)

```bash
# Installation
claude mcp add --transport http context7 https://mcp.context7.co \
  --header "Authorization: Bearer YOUR_KEY"

# Utilisation
claude
> "Utilise Context7 pour la doc de Next.js App Router"

# Claude récupère:
→ Documentation Next.js optimisée
→ Pas de WebSearch/WebFetch nécessaire
```

#### 3. Database avec CLI (Recommandé)

```bash
# Au lieu de MCP Database, utiliser:
# - psql (PostgreSQL)
# - mysql (MySQL)
# - mongosh (MongoDB)

claude
> "Utilise psql pour lire la table users"

# Claude exécute:
→ psql -U user -d database -c "SELECT * FROM users LIMIT 10"
```

---

## 📋 Cheatsheet

### Installation MCP (Si Vraiment Nécessaire)

```bash
# Lister MCP configurés
claude mcp list

# Ajouter MCP HTTP server
claude mcp add --transport http <name> <url> \
  --header "Authorization: Bearer <token>"

# Ajouter MCP SSE server (deprecated)
claude mcp add --transport sse <name> <url>

# Ajouter MCP stdio server (local)
claude mcp add --transport stdio <name> -- <command> [args]

# Avec scope spécifique
claude mcp add --transport http <name> <url> --scope user    # tous projets
claude mcp add --transport http <name> <url> --scope project  # .mcp.json versioned
claude mcp add --transport http <name> <url> --scope local    # défaut, ce projet

# Obtenir détails d'un server
claude mcp get <name>

# Supprimer MCP
claude mcp remove <name>

# Ajouter depuis JSON
claude mcp add-json <name> '<json-config>'

# Importer depuis Claude Desktop
claude mcp add-from-claude-desktop

# Check server status (dans Claude Code)
/mcp
```

### CLI Recommandés

```bash
# GitHub CLI
brew install gh
gh auth login
gh repo create <name>
gh issue create --title "..." --body "..."
gh pr create --title "..." --body "..."

# Git
git add .
git commit -m "message"
git push

# npm
npm install <package>
npm run dev
npm test

# Docker
docker ps
docker run <image>
docker compose up

# HTTP
curl -X POST https://api.com -d '{"key":"value"}'
http GET https://api.com

# JSON
cat data.json | jq '.users'
```

### Context7 (Seul MCP Recommandé)

```bash
# Installation HTTP server
claude mcp add --transport http context7 https://mcp.context7.co \
  --header "Authorization: Bearer YOUR_KEY"

# Ou avec scope user (tous projets)
claude mcp add --transport http context7 https://mcp.context7.co \
  --scope user \
  --header "Authorization: Bearer YOUR_KEY"

# Utilisation dans Claude
"Utilise Context7 pour la doc de <framework>"

# Frameworks supportés
- Next.js
- Vite
- React
- Vue
- Svelte
- Supabase
- TailwindCSS
- Et 100+ autres
```

---

## 🎯 Best Practices & Convention MCP

### 📦 Convention MCP : Approche "npm-like"

**Principe** : MCP servers installés **globalement**, documentés **par projet**.

```
┌─────────────────────────────────────────────────────┐
│                  MCP DEPENDENCIES                   │
├─────────────────────────────────────────────────────┤
│                                                     │
│  Global Install (une fois)                         │
│  ~/.config/claude-code/config.json                 │
│  ├── ahrefs MCP                                    │
│  └── filesystem MCP                                │
│                                                     │
│              ↓  disponibles partout                │
│                                                     │
│  Project A: SEO Tool                               │
│  ~/project-a/.claude/CLAUDE.md                     │
│  ├── "Required: ahrefs"  ← Documented!             │
│  └── Setup snippet                                 │
│                                                     │
│  Project B: File Manager                           │
│  ~/project-b/.claude/CLAUDE.md                     │
│  ├── "Required: filesystem"  ← Documented!         │
│  └── Setup snippet                                 │
│                                                     │
│  Project C: API Only                               │
│  ~/project-c/.claude/CLAUDE.md                     │
│  └── No MCP required                               │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

### 🎯 Différence Clé: Les 3 Scopes MCP

**Comprendre les 3 scopes MCP** : user → project → local

```
╔════════════════════════════════════════════════════╗
║           MCP SCOPES - HIÉRARCHIE                  ║
╚════════════════════════════════════════════════════╝

🌍 user scope (Tous tes projets)
   ~/.claude/settings.json
   ~/.config/claude-code/config.json
   └─> Disponible partout sur ton PC
       ✅ Tous tes projets
       ✅ Persiste entre projets
       ✅ --scope user

🔵 project scope (Équipe, versioned)
   ~/my-project/.mcp.json
   └─> Config versionée (git ✅)
       ✅ Partagée avec l'équipe
       ✅ Standard du projet
       ✅ Override user scope
       ✅ --scope project

🔴 local scope (Toi, ce projet) - DÉFAUT
   ~/my-project/.claude/settings.json (local)
   ~/my-project/.env
   └─> Config personnelle (git ❌)
       ✅ Toi uniquement, ce projet
       ✅ Juste sur ton PC
       ✅ Override project scope
       ✅ --scope local (défaut)
```

**Tableau Comparatif** :

| Aspect  | user                   | project                | local (défaut)         |
|---------|------------------------|------------------------|------------------------|
| Fichier | `~/.config/...`        | `.mcp.json` (racine)   | `.claude/settings.json`|
| Portée  | Tous tes projets       | Ce projet (équipe)     | Ce projet (toi)        |
| Git     | ❌ Pas committé         | ✅ Committé             | ❌ Pas committé         |
| Équipe  | ❌ Juste toi            | ✅ Tout le monde        | ❌ Juste toi            |
| Flag    | `--scope user`         | `--scope project`      | `--scope local` (défaut)|

---

### 📊 Schéma Complet - Structure Fichiers MCP

```
╔════════════════════════════════════════════════════╗
║        ORGANISATION FICHIERS MCP                   ║
╚════════════════════════════════════════════════════╝

🏠 Ton PC
│
├── ~/.claude/
│   ├── settings.json           ← USER scope config
│   ├── mcp.json (ou similaire) ← USER scope MCP
│   └── ...
│
├── ~/.env                       ← USER scope secrets
│
└── ~/my-project/
    │
    ├── .mcp.json                ← PROJECT scope (git ✅)
    │
    ├── .claude/
    │   ├── settings.json        ← Project settings (git ✅)
    │   └── settings.local.json  ← LOCAL scope (git ❌)
    │
    ├── .env                     ← PROJECT/LOCAL secrets (git ❌)
    │
    └── .gitignore
        ├── .env                 ← Ignoré
        └── .claude/*.local.json ← Ignoré
```

---

### 🔄 Précédence MCP - Cascade d'Override

```
╔════════════════════════════════════════════════════╗
║           ORDRE DE PRIORITÉ                        ║
╚════════════════════════════════════════════════════╝

        🔴 LOCAL (toi, ce projet)
              ↓ override
        🔵 PROJECT (équipe, ce projet)
              ↓ override
        🌍 USER (toi, partout)


Exemple Concret:
┌─────────────────────────────────────────────────┐
│ 🌍 USER: ahrefs MCP (API key dev perso)        │
│    ~/.claude/mcp.json                           │
│    → env: { AHREFS_API_TOKEN: "dev-key-123" }  │
└─────────────────────────────────────────────────┘
              ↓ override par...
┌─────────────────────────────────────────────────┐
│ 🔵 PROJECT: ahrefs MCP (API key équipe)        │
│    ~/seo-project/.mcp.json                      │
│    → env: { AHREFS_API_TOKEN: "team-key-456" } │
└─────────────────────────────────────────────────┘
              ↓ override par...
┌─────────────────────────────────────────────────┐
│ 🔴 LOCAL: ahrefs MCP (API key test perso)      │
│    ~/seo-project/.claude/settings.local.json    │
│    → env: { AHREFS_API_TOKEN: "test-key-789" } │
│                                                 │
│ ✅ CETTE VALEUR GAGNE !                         │
└─────────────────────────────────────────────────┘
```

---

### 💡 Use Cases Scopes

#### 🌍 USER scope - Quand l'utiliser ?

```
✅ Utiliser pour:
   ├─> MCP utilisés dans TOUS tes projets
   │   Exemple: Context7 (docs)
   │
   ├─> Config personnelle globale
   │   Exemple: Tes préférences Claude
   │
   └─> API keys dev personnelles
       Exemple: Ton token GitHub perso

❌ Ne PAS utiliser pour:
   └─> Config spécifique à un projet
       → Mettre dans PROJECT scope
```

**Exemple** :

```json
// ~/.claude/mcp.json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"],
      "env": {
        "CONTEXT7_API_KEY": "ta-key-perso"
      }
    }
  }
}
```

---

#### 🔵 PROJECT scope - Quand l'utiliser ?

```
✅ Utiliser pour:
   ├─> MCP requis pour CE projet
   │   Exemple: Ahrefs pour projet SEO
   │
   ├─> Config standard de l'équipe
   │   Exemple: Règles linting, format
   │
   └─> API keys d'équipe (via ref 1Password)
       Exemple: Token Ahrefs de l'équipe

❌ Ne PAS utiliser pour:
   └─> Override temporaire personnel
       → Mettre dans LOCAL scope
```

**Exemple** :

```json
// ~/seo-project/.mcp.json
{
  "mcpServers": {
    "ahrefs": {
      "command": "npx",
      "args": ["-y", "@ahrefs/mcp-server"],
      "env": {
        "AHREFS_API_TOKEN": "from-team-1password"
      }
    }
  }
}
```

---

#### 🔴 LOCAL scope - Quand l'utiliser ?

```
✅ Utiliser pour:
   ├─> Override temporaire config projet
   │   Exemple: Tester avec API key différente
   │
   ├─> Config personnelle NON partagée
   │   Exemple: Tes préférences sur CE projet
   │
   └─> Secrets locaux (testing)
       Exemple: Token sandbox perso

❌ Ne PAS utiliser pour:
   └─> Config à partager avec équipe
       → Mettre dans PROJECT scope
```

**Exemple** :

```json
// ~/seo-project/.claude/settings.local.json
{
  "mcpServers": {
    "ahrefs": {
      "env": {
        "AHREFS_API_TOKEN": "ma-sandbox-key-test"
      }
    }
  }
}
```

---

### 📋 Checklist Setup MCP avec Scopes

**1️⃣ MCP Global (USER)** :
```bash
# Context7 pour tous projets
nano ~/.claude/mcp.json
# Add context7 config
```

**2️⃣ MCP Projet (PROJECT)** :
```bash
# Ahrefs pour projet SEO
nano ~/seo-project/.mcp.json
# Add ahrefs config

# Commit !
git add .mcp.json
git commit -m "feat: add ahrefs MCP requirement"
```

**3️⃣ Override Local (LOCAL)** :
```bash
# Tester avec sandbox key
nano ~/seo-project/.claude/settings.local.json
# Override AHREFS_API_TOKEN

# Vérifier .gitignore
cat .gitignore | grep "local"
# → .claude/*.local.json doit être ignoré
```

---

### ⚠️ Erreurs Fréquentes

**❌ Committer fichiers LOCAL** :

```bash
# MAUVAIS
git add .claude/settings.local.json
git commit -m "Add my personal config"

# → Expose tes secrets persos !
# → Override la config d'équipe

# BON
# Vérifier .gitignore contient:
.claude/*.local.json
.env
```

**❌ Hardcoder secrets dans PROJECT** :

```json
// ❌ MAUVAIS - .mcp.json
{
  "mcpServers": {
    "ahrefs": {
      "env": {
        "AHREFS_API_TOKEN": "ahrf_abc123def456"
      }
    }
  }
}

// ✅ BON - .mcp.json
{
  "mcpServers": {
    "ahrefs": {
      "env": {
        "AHREFS_API_TOKEN": "from-1password-vault/seo-project/ahrefs"
      }
    }
  }
}
```

**❌ Confondre PROJECT et LOCAL** :

```
Scénario: Veux tester nouvelle version MCP

❌ MAUVAIS: Modifier .mcp.json (PROJECT)
   → Change config pour toute l'équipe
   → Peut casser le workflow des autres

✅ BON: Créer override dans .claude/settings.local.json
   → Juste pour toi
   → Autres devs pas affectés
   → Tester en sécurité
```

### 📝 Template Documentation Projet

**Exemple concret** : Project SEO Tool

**~/seo-tool/.claude/CLAUDE.md** :

```markdown
# SEO Analytics Tool

AI-powered SEO analysis platform using Ahrefs data

---

## ⚠️ Required MCP Servers

This project requires these MCP servers to function.

### Ahrefs (SEO data provider)

**Status**: Should be globally installed

Add to `~/.config/claude-code/config.json` if not already installed:

\```json
{
  "mcpServers": {
    "ahrefs": {
      "command": "npx",
      "args": ["-y", "@ahrefs/mcp-server-ahrefs"],
      "env": {
        "AHREFS_API_TOKEN": "get-from-1password/seo-tool/ahrefs-token"
      }
    }
  }
}
\```

**Why documented**: Core dependency - all SEO features rely on Ahrefs data

**Verify installation**:
\```bash
# In Claude Code, check if these tools are available:
# mcp__ahrefs__site-explorer-metrics
# mcp__ahrefs__keywords-explorer-overview
\```

---

## Project Setup

1. Install dependencies: `npm install`
2. Setup Ahrefs MCP (see above)
3. Copy `.env.example` to `.env`
4. Run dev server: `npm run dev`
```

### ✅ Avantages de cette Approche

#### 1️⃣ **Onboarding**
```
New dev clone projet
  → Lit .claude/CLAUDE.md
  → Sait exactement quels MCP installer
  → Setup reproductible
```

#### 2️⃣ **Documentation**
```
Project self-contained
  → Dependencies explicites
  → Pas de surprise
  → Savoir tribal préservé
```

#### 3️⃣ **Reproductibilité**
```
Même setup partout
  → Pas de "works on my machine"
  → CI/CD facilité
  → Debugging simplifié
```

#### 4️⃣ **Maintenance**
```
MCP deprecated?
  → `grep -r "deprecated-mcp" **/.claude/CLAUDE.md`
  → Sais quels projets sont affectés
  → Migration planifiée
```

#### 5️⃣ **Flexibility**
```
Dev peut override
  → Config globale pour défaut
  → Override project-specific si besoin
  → Best of both worlds
```

### 📊 Comparaison npm vs MCP

| Approche             | npm              | MCP (convention)        |
|---------------------|------------------|-------------------------|
| **Global install**  | `npm i -g`       | `~/.config/claude-code/config.json` |
| **Project dependency** | `package.json` | `.claude/CLAUDE.md`   |
| **Install command** | `npm install`    | Manual setup            |
| **Verification**    | `npm list`       | Manual check in Claude  |
| **Documentation**   | README.md        | .claude/CLAUDE.md       |

### 🔄 Workflow avec cette Convention

#### Setup Nouveau Projet

**1. Créer le projet**
```bash
mkdir my-project && cd my-project
mkdir .claude
```

**2. Documenter les MCP requis**

Éditer `.claude/CLAUDE.md` :

```markdown
## Required MCP Servers

### Ahrefs (SEO data)
[Setup snippet ici]

### Postgres (database)
[Setup snippet ici]
```

**3. Installer les MCP globalement** (si pas déjà fait)

```bash
# Edit ~/.config/claude-code/config.json
# Add ahrefs and postgres
```

**4. Dev, commit, push**

```bash
git add .claude/CLAUDE.md
git commit -m "docs: add MCP requirements"
git push
```

#### Cloner un Projet Existant

**1. Clone**
```bash
git clone https://github.com/team/project
cd project
```

**2. Lire les requirements**
```bash
cat .claude/CLAUDE.md
# Section "Required MCP Servers"
```

**3. Installer MCP manquants**
```bash
# Edit ~/.config/claude-code/config.json
# Suivre snippets dans CLAUDE.md
```

**4. Vérifier**
```bash
claude
# Tester tools MCP disponibles
```

### 💡 Best Practices Additionnelles

#### ✅ DO

- **Documenter TOUS les MCP requis** dans .claude/CLAUDE.md
- **Snippet de config complet** (copier-coller ready)
- **Expliquer le "pourquoi"** (à quoi sert ce MCP)
- **Instructions de vérification** (comment tester)
- **Variables d'env requises** (API keys, etc.)
- **Liens vers docs officielles** du MCP server

#### ❌ DON'T

- **Assumer MCP pré-installés** (documenter!)
- **Hardcoder secrets** dans snippets (use env vars)
- **Oublier de versionner** .claude/CLAUDE.md
- **Config incomplètes** (args manquants, etc.)
- **Ne pas expliquer** pourquoi MCP nécessaire

### 📋 Template Complet

Voici un template complet `.claude/CLAUDE.md` avec MCP :

```markdown
# [Project Name]

[Project description]

---

## ⚠️ Required MCP Servers

### [MCP Server Name] ([Purpose])

**Status**: Global installation required

Add to `~/.config/claude-code/config.json`:

\```json
{
  "mcpServers": {
    "[server-name]": {
      "command": "npx",
      "args": ["-y", "@scope/mcp-server-name"],
      "env": {
        "API_KEY": "get-from-[where]"
      }
    }
  }
}
\```

**Why documented**: [Explanation of why this MCP is needed]

**Verify installation**:
\```bash
# In Claude Code, check these tools exist:
# mcp__[server]__[tool-name]
\```

**Environment variables**:
- `API_KEY`: Get from [1Password/Vault] → [path]

**Documentation**: [Link to official MCP docs]

---

## Project Setup

1. Install MCP servers (see above)
2. Install dependencies: `npm install`
3. Setup environment: `cp .env.example .env`
4. Run dev: `npm run dev`

---

## Additional Documentation

[Rest of your project documentation]
```

---

## 🎓 Points Clés

### Concepts Essentiels

✅ **MCP = Outils externes** : Étendre Claude Code
❌ **Éviter MCP (sauf Context7)** : Consomme contexte inutilement
✅ **Préférer CLI natives** : gh, git, npm, curl, jq, docker
🌟 **Context7 = Exception** : Seul MCP recommandé (docs frameworks)
✅ **Contexte > Outils** : Garder maximum d'espace pour le code

### Règle d'Or

| Besoin | ❌ MCP | ✅ CLI |
|--------|--------|--------|
| GitHub | MCP GitHub | `gh` (GitHub CLI) |
| Database | MCP Database | `psql`, `mysql`, `mongosh` |
| HTTP | MCP Fetch | `curl`, `httpie` |
| JSON | MCP JSON | `jq` |
| Docker | MCP Docker | `docker` CLI |
| **Docs** | - | **Context7** (OK!) |

### Commandes Clés

| Action | Commande |
|--------|----------|
| Installer GitHub CLI | `brew install gh` |
| Authentifier GitHub | `gh auth login` |
| Créer repo | `gh repo create <name>` |
| Créer issue | `gh issue create` |
| Installer Context7 | `claude mcp transport ...` |

---

## 📚 Ressources

### 📄 Documentation Officielle
- 📄 **Model Context Protocol** : https://modelcontextprotocol.io/
  - Spécification complète MCP
  - Architecture et concepts
- 📄 **Context7** : https://context7.co
  - Seul MCP recommandé pour documentation

### 📝 Articles & Intégrations
- 📝 **Understanding Claude Code Full Stack** : https://alexop.dev/posts/understanding-claude-code-full-stack/
  - MCP dans l'écosystème Claude Code
  - Quand utiliser MCP vs CLI
  - Patterns d'intégration

### 🎥 Vidéos Recommandées
- 🎥 **Melvynx - Formation Claude Code 2.0** : https://www.youtube.com/watch?v=bDr1tGskTdw (42:00 - MCP)
  - ⚠️ Pourquoi éviter MCP (pollution contexte)
  - ✅ Exception Context7 (seul recommandé)
  - CLI alternatives recommandées

### 🔧 CLI Alternatives (Recommandées)
- 📄 **GitHub CLI** : https://cli.github.com
  - `gh` > MCP GitHub (performance + contexte)
- 📄 **PostgreSQL CLI** : https://www.postgresql.org/docs/current/app-psql.html
  - `psql` > MCP Database
- 📄 **httpie** : https://httpie.io/
  - `http` > MCP Fetch/HTTP

### 📚 Ressources Internes
- 📋 [Cheatsheet MCP](./cheatsheet.md) - Référence rapide
- 🔗 [Skills](../4-skills/guide.md) - MCP vs Skills (comparaison)
- 🔗 [Agents](../5-agents/guide.md) - Agents avec MCP (patterns)
- 🔗 [Plugins](../6-plugins/guide.md) - Packaging MCP dans plugins
- 🔗 [Best Practices](../9-best-practices/guide.md) - CLI > MCP (règle)
- 🔗 [Commands](../2-commands/guide.md) - Commands avec CLI natifs

---

## 🆕 Features MCP Avancées

### 🔐 OAuth Authentication

Beaucoup de MCP servers cloud nécessitent authentication. Claude Code supporte OAuth 2.0.

**Workflow** :

```bash
# 1. Ajouter le server
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp

# 2. Dans Claude Code, authentifier
/mcp
# Sélectionner "Authenticate" pour le server
# → Browser s'ouvre pour OAuth flow

# 3. Utiliser le server authentifié
> "Check Sentry errors from last 24h"
```

**Features** :
- Tokens stockés sécurisement et refresh automatique
- "Clear authentication" dans `/mcp` menu pour révoquer
- Fonctionne avec HTTP servers

---

### 📎 MCP Resources (@mentions)

MCP servers peuvent exposer **resources** référençables avec `@mentions`.

**Utilisation** :

```bash
# Lister resources disponibles
> @  # Autocomplete montre resources de tous MCP servers

# Référencer une resource
> "Analyze @github:issue://123 and suggest a fix"
> "Review @docs:file://api/authentication"
> "Compare @postgres:schema://users with @docs:file://database/user-model"
```

**Features** :
- Resources auto-fetchées et incluses comme attachments
- Fuzzy search dans autocomplete
- Contenu text, JSON, structured data

---

### ⚡ MCP Prompts (Slash Commands)

MCP servers peuvent exposer **prompts** qui deviennent slash commands.

**Format** : `/mcp__servername__promptname [args]`

**Exemple** :

```bash
# Lister tous les prompts MCP
> /  # Autocomplete montre /mcp__* commands

# Utiliser un prompt MCP
> /mcp__github__create_pr "Add new feature" main
> /mcp__database__query_users --active=true --limit=10
```

**Features** :
- Découverte automatique depuis MCP servers
- Arguments passés space-separated
- Permissions configurables par prompt

---

### 🔧 Autres Features MCP

**Environment Variable Expansion** :

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}"
      }
    }
  }
}
```

**Claude as MCP Server** :

```bash
# Utiliser Claude Code comme MCP server
claude mcp serve

# Dans Claude Desktop config
{
  "mcpServers": {
    "claude-code": {
      "type": "stdio",
      "command": "/full/path/to/claude",
      "args": ["mcp", "serve"]
    }
  }
}
```

**Output Limits** :

```bash
# Augmenter limite output MCP (défaut: 25K tokens)
export MAX_MCP_OUTPUT_TOKENS=50000
claude
```

---

## Conclusion

**MCP** permet d'étendre Claude Code, mais **consomme du contexte précieux**.

**Règle Melvynx** : **Éviter MCP, utiliser CLI**.

**Exception** : **Context7** pour documentation frameworks.

**Setup recommandé** :
```bash
# ✅ CLI natives
brew install gh
brew install jq
brew install httpie

# ✅ Context7 (seul MCP)
claude mcp transport https://mcp.context7.co --api-key KEY

# ❌ Éviter autres MCP
# → Utilisent contexte inutilement
# → CLI équivalents plus performants
```

**Quote Melvynx** :
> "Faites attention au MCP. Plus tu as de MCP, plus tu vas utiliser du contexte et moins tu auras de la place pour ce qui est important."
