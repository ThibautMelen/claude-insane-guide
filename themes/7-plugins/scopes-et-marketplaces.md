# 🌍 Scopes et Marketplaces - Guide Complet

> **Clarifications essentielles sur les scopes, l'organisation des marketplaces, et les workflows d'installation**

---

## 📚 Table des Matières

1. [Les 3 Scopes](#-les-3-scopes)
2. [Deux Méthodes d'Activation Marketplace](#-deux-méthodes-dactivation-marketplace)
3. [Workflow d'Installation](#-workflow-dinstallation)
4. [Plugins Standalone vs Marketplace](#-plugins-standalone-vs-marketplace)
5. [Organisation des Marketplaces](#-organisation-des-marketplaces)
6. [Copie de Plugins entre Marketplaces](#-copie-de-plugins-entre-marketplaces)
7. [Exemples Concrets](#-exemples-concrets)
8. [FAQ](#-faq)
9. [Cheatsheet Scopes](#-cheatsheet-scopes)

---

## 🎯 Les 3 Scopes

Claude Code utilise **3 niveaux de configuration** (scopes) qui s'appliquent dans un ordre de priorité spécifique.

### Vue d'ensemble

```
PRIORITÉ (du plus spécifique au plus général)
═══════════════════════════════════════════

┌─────────────────────────────────────────┐
│  3️⃣ LOCAL SCOPE (Override)             │
│  📍 .claude/settings.local.json         │
│  🔒 Gitignored (personnel)              │
│  ⚡ Priority: HIGHEST                   │
└─────────────────┬───────────────────────┘
                  │
                  ↓ (override)
┌─────────────────────────────────────────┐
│  2️⃣ PROJECT SCOPE                      │
│  📍 .claude/settings.json               │
│  📦 Versionné Git (équipe)              │
│  ⚡ Priority: MEDIUM                    │
└─────────────────┬───────────────────────┘
                  │
                  ↓ (fallback)
┌─────────────────────────────────────────┐
│  1️⃣ USER SCOPE (Global)                │
│  📍 ~/.claude/settings.json             │
│  👤 Personnel (tous projets)            │
│  ⚡ Priority: LOWEST                    │
└─────────────────────────────────────────┘
```

### 1️⃣ User Scope (~/.claude/)

**Emplacement** : `~/.claude/settings.json`

**Caractéristiques** :
- ✅ Configuration **globale** pour tous vos projets
- ✅ Plugins personnels utilisés partout
- ✅ Marketplaces communauté/personnelles
- ❌ PAS versionné Git (personnel)

**Cas d'usage** :
- Plugins de productivité personnelle
- Marketplaces communauté (GitHub public)
- Configuration outils favoris

**Exemple** :
```json
// ~/.claude/settings.json
{
  "extraKnownMarketplaces": {
    "personal-tools": {
      "source": {
        "source": "github",
        "repo": "thibaut/my-personal-plugins"
      }
    },
    "awesome-community": {
      "source": {
        "source": "github",
        "repo": "community/awesome-plugins"
      }
    }
  },
  "enabledPlugins": {
    "productivity-tools@personal-tools": true,
    "code-snippets@awesome-community": true
  }
}
```

### 2️⃣ Project Scope (.claude/)

**Emplacement** : `<project-root>/.claude/settings.json`

**Caractéristiques** :
- ✅ Configuration **projet spécifique**
- ✅ **Versionné Git** → partagé avec équipe
- ✅ Marketplaces équipe/organisation
- ✅ Standards enforced pour tous les membres

**Détection** : Claude détecte automatiquement `.git` à la racine

**Cas d'usage** :
- Plugins spécifiques au projet
- Marketplaces équipe privées
- Standards équipe enforced
- Workflows projet automatisés

**Exemple** :
```json
// <project>/.claude/settings.json
{
  "extraKnownMarketplaces": {
    "project-tools": {
      "source": "./.marketplace"  // Local au projet
    },
    "team-enterprise": {
      "source": {
        "source": "github",
        "repo": "company/enterprise-plugins"
      }
    }
  },
  "autoInstallPlugins": [
    "security-baseline@team-enterprise",
    "frontend-standards@project-tools"
  ]
}
```

### 3️⃣ Local Scope (Override)

**Emplacement** : `.claude/settings.local.json`

**Caractéristiques** :
- ✅ **Override** local (priorité maximale)
- ✅ **Gitignored** (PAS partagé équipe)
- ✅ Personnalisation sans polluer config équipe
- ⚠️ NE PAS utiliser pour marketplaces (use project ou user scope)

**Cas d'usage** :
- Désactiver temporairement un plugin projet
- Override comportement spécifique
- Tests locaux sans affecter équipe

**Exemple** :
```json
// .claude/settings.local.json (GITIGNORED)
{
  "enabledPlugins": {
    "expensive-plugin@team-tools": false  // Override: désactiver localement
  },
  "logLevel": "DEBUG"  // Override pour debugging
}
```

---

## 🔧 Deux Méthodes d'Activation Marketplace

Il existe **DEUX méthodes distinctes** pour activer une marketplace. Elles sont **différentes** et **non combinées**.

### Comparaison

```
╔════════════════════════════════════════════════════════════════╗
║  MÉTHODE                │  SCOPE        │  USAGE              ║
╠════════════════════════════════════════════════════════════════╣
║  1️⃣ /plugin marketplace  │  GLOBAL       │  Manuel, user      ║
║     add                  │  (~/.claude)  │  Activation CLI    ║
║                          │               │                    ║
║  2️⃣ extraKnownMarket-    │  CONTEXTUEL   │  Auto, projet     ║
║     places               │  (project/    │  Config file       ║
║                          │   user)       │                    ║
╚════════════════════════════════════════════════════════════════╝
```

### Méthode 1: `/plugin marketplace add` (CLI)

**Commande** : `/plugin marketplace add <source>`

**Caractéristiques** :
- ✅ Activation **manuelle** via CLI
- ✅ Ajouté **globalement** (user scope)
- ✅ Disponible **partout** après ajout
- ❌ Non contextuel (pas automatique selon projet)

**Workflow** :
```bash
# Ajouter marketplace manuellement
/plugin marketplace add thibaut/my-plugins

# Maintenant disponible globalement
/plugin install awesome-tool@my-plugins
```

**Où c'est stocké** :
```
~/.claude/
└── marketplace-registries.json  # Claude gère automatiquement
```

**Cas d'usage** :
- Quick test d'une nouvelle marketplace
- Ajout ponctuel marketplace communauté
- Développement/exploration

### Méthode 2: `extraKnownMarketplaces` (Config)

**Configuration** : `.claude/settings.json` ou `~/.claude/settings.json`

**Caractéristiques** :
- ✅ Activation **automatique** selon contexte
- ✅ **Contextuel** (project ou user scope)
- ✅ Versionné Git (si project scope)
- ✅ Équipe entière synchronisée

**Workflow** :
```json
// .claude/settings.json (PROJECT SCOPE)
{
  "extraKnownMarketplaces": {
    "team-tools": {
      "source": {
        "source": "github",
        "repo": "company/team-plugins"
      }
    }
  }
}
```

**Résultat** :
- ✅ Marketplace activée automatiquement dans ce projet
- ✅ Équipe entière a accès (versionné Git)
- ✅ Pas besoin de `/plugin marketplace add`

**Cas d'usage** :
- Configuration équipe (project scope)
- Standards organisation (enterprise)
- Automatisation (pas d'action manuelle)

### ⚠️ IMPORTANT: Les deux méthodes sont INDÉPENDANTES

```
❌ FAUX (confusion courante):
"Si j'utilise extraKnownMarketplaces, ça enlève du user scope"

✅ VRAI:
- /plugin marketplace add → Ajout global manuel
- extraKnownMarketplaces → Activation contextuelle
- Les deux peuvent coexister
- extraKnownMarketplaces NE SUPPRIME RIEN du user scope
```

**Exemple coexistence** :
```bash
# User scope: marketplace ajoutée manuellement
~/.claude/ → my-personal-tools (via CLI)

# Project scope: marketplace automatique
<project>/.claude/settings.json → team-enterprise (via config)

# Résultat: LES DEUX disponibles dans le projet !
/plugin install tool1@my-personal-tools  ✅
/plugin install tool2@team-enterprise     ✅
```

---

## 📥 Workflow d'Installation

### ⚠️ RÈGLE CRITIQUE

```
╔═══════════════════════════════════════════════════════════╗
║  VOUS DEVEZ AJOUTER LA MARKETPLACE AVANT LES PLUGINS     ║
║                                                           ║
║  ❌ IMPOSSIBLE: /plugin install sans marketplace         ║
║  ✅ CORRECT:                                              ║
║     1. Ajouter marketplace                                ║
║     2. Installer plugins individuellement                 ║
╚═══════════════════════════════════════════════════════════╝
```

### Workflow Complet

```
START
  │
  ├─► Étape 1: Ajouter Marketplace
  │   │
  │   ├─► Option A: CLI (global)
  │   │   /plugin marketplace add owner/repo
  │   │
  │   └─► Option B: Config (contextuel)
  │       extraKnownMarketplaces in settings.json
  │
  ├─► Étape 2: Installer Plugins
  │   │
  │   /plugin install plugin-name@marketplace-name
  │   /plugin install plugin2@marketplace-name
  │   ...
  │
  └─► Étape 3: Activer/Utiliser
      │
      /plugin enable plugin-name
      /my-plugin-command
```

### Exemples Concrets

#### Exemple 1: Installation Manuelle (CLI)

```bash
# ❌ ERREUR: Essayer d'installer sans marketplace
/plugin install awesome-tool
# → Error: No marketplace found for 'awesome-tool'

# ✅ CORRECT: Ajouter marketplace AVANT
/plugin marketplace add community/awesome-plugins

# Maintenant installer plugins
/plugin install awesome-tool@awesome-plugins
/plugin install another-tool@awesome-plugins
```

#### Exemple 2: Installation Automatique (Config)

```json
// .claude/settings.json (PROJECT SCOPE)
{
  "extraKnownMarketplaces": {
    "team-tools": {
      "source": {
        "source": "github",
        "repo": "company/team-marketplace"
      }
    }
  },
  "autoInstallPlugins": [
    "security-baseline@team-tools",
    "frontend-tools@team-tools"
  ]
}
```

**Résultat** :
- ✅ Marketplace activée automatiquement
- ✅ Plugins installés automatiquement
- ✅ Équipe entière synchronisée (Git)

#### Exemple 3: Marketplace Locale

```bash
# Structure projet
my-project/
├── .git/
├── .claude/
│   └── settings.json
└── .marketplace/
    ├── .claude-plugin/
    │   └── marketplace.json
    └── my-plugin/
        └── ...

# settings.json
{
  "extraKnownMarketplaces": {
    "local-tools": {
      "source": "./.marketplace"
    }
  }
}

# Installer plugins de la marketplace locale
/plugin install my-plugin@local-tools
```

---

## 🔌 Plugins Standalone vs Marketplace

### Différence Fondamentale

```
╔═══════════════════════════════════════════════════════════╗
║  TYPE               │  LOCATION          │  REQUIS       ║
╠═══════════════════════════════════════════════════════════╣
║  STANDALONE         │  .claude/commands/ │  Rien         ║
║  Plugins simples    │  .claude/agents/   │  (juste .md)  ║
║                     │  .claude/skills/   │               ║
║                     │                    │               ║
║  MARKETPLACE-BASED  │  Via plugin system │  plugin.json  ║
║  Plugins packaging  │  .claude-plugin/   │  + structure  ║
╚═══════════════════════════════════════════════════════════╝
```

### Plugins Standalone

**Définition** : Fichiers individuels directement dans `.claude/`

**Structure** :
```
.claude/
├── commands/
│   ├── deploy.md       # Standalone command
│   └── test.md         # Standalone command
├── agents/
│   └── reviewer.md     # Standalone agent
└── skills/
    └── pdf-reader/
        └── SKILL.md    # Standalone skill
```

**Caractéristiques** :
- ✅ **Aucun packaging** requis
- ✅ Pas de `plugin.json`
- ✅ Directement utilisables
- ❌ Pas de versioning
- ❌ Difficile à partager/distribuer

**Cas d'usage** :
- 1-3 commands simples personnelles
- Tests rapides
- Prototyping
- Configuration projet unique

### Plugins Marketplace-Based

**Définition** : Package complet avec `plugin.json` distribué via marketplace

**Structure** :
```
my-plugin/
├── .claude-plugin/
│   └── plugin.json     # ⭐ REQUIS
├── commands/
│   └── *.md
├── agents/
│   └── *.md
└── skills/
    └── */
```

**Caractéristiques** :
- ✅ **Packaging complet**
- ✅ Versioning sémantique
- ✅ Distribution via marketplace
- ✅ Partage équipe facilité
- ✅ Peut inclure: commands, agents, skills, hooks, MCP

**Cas d'usage** :
- 3+ plugins à partager
- Équipe/organisation
- Versioning nécessaire
- Distribution large

### Quand utiliser quoi ?

```
DÉCISION
════════

Plugins Standalone:
├─► 1-3 fichiers simples
├─► Usage personnel uniquement
├─► Pas besoin versioning
└─► Prototyping rapide

Marketplace-Based:
├─► 3+ composants
├─► Partage équipe/communauté
├─► Versioning requis
├─► Distribution automatisée
└─► Workflow complexe
```

### ⚠️ IMPORTANT: Un Plugin N'Appartient PAS Forcément à une Marketplace

```
❌ FAUX:
"Tous les plugins doivent être dans une marketplace"

✅ VRAI:
- Plugins standalone: Existent SANS marketplace
- Plugins marketplace: Package distribué VIA marketplace
- Les deux sont valides selon le besoin
```

---

## 📊 Organisation des Marketplaces

### Combien de Marketplaces par Scope ?

```
╔═══════════════════════════════════════════════════════════╗
║  SCOPE              │  RECOMMANDATION   │  RAISON        ║
╠═══════════════════════════════════════════════════════════╣
║  USER SCOPE         │  2-4 marketplaces │  Personnel +   ║
║  (~/.claude/)       │                   │  communauté    ║
║                     │                   │                ║
║  PROJECT SCOPE      │  1 marketplace    │  Focus projet  ║
║  (.claude/)         │  (95% des cas)    │  clair         ║
║                     │  Parfois 2        │                ║
║                     │                   │                ║
║  LOCAL SCOPE        │  0 (overrides)    │  Pas de        ║
║  (settings.local)   │                   │  marketplaces  ║
╚═══════════════════════════════════════════════════════════╝
```

### User Scope: 2-4 Marketplaces

**Recommandé** :
```
~/.claude/settings.json
{
  "extraKnownMarketplaces": {
    "personal": {
      "source": {"source": "github", "repo": "me/personal-plugins"}
    },
    "team": {
      "source": {"source": "github", "repo": "company/team-plugins"}
    },
    "community": {
      "source": {"source": "github", "repo": "awesome/plugins"}
    },
    "enterprise": {
      "source": {"source": "git", "url": "https://git.company.com/plugins.git"}
    }
  }
}
```

**Organisation** :
- `personal` : Plugins persos (code snippets, productivity)
- `team` : Équipe directe (frontend, backend tools)
- `community` : Open source (awesome-plugins, etc.)
- `enterprise` : Organisation (security, compliance)

### Project Scope: 1 Marketplace (95% cas)

**Recommandé** :
```
<project>/.claude/settings.json
{
  "extraKnownMarketplaces": {
    "project-tools": {
      "source": "./.marketplace"
    }
  }
}
```

**Raisons** :
- ✅ Focus clair (outils projet uniquement)
- ✅ Simplicité (pas de confusion)
- ✅ Maintenance facile

**Exception: Parfois 2 marketplaces**

```json
{
  "extraKnownMarketplaces": {
    "frontend-tools": {
      "source": "./.marketplace/frontend"
    },
    "backend-tools": {
      "source": "./.marketplace/backend"
    }
  }
}
```

**Cas d'usage** :
- Projet monorepo complexe
- Équipes frontend + backend séparées
- Domaines métier très différents

---

## ❌ Copie de Plugins entre Marketplaces

### ⚠️ RÈGLE CRITIQUE

```
╔═══════════════════════════════════════════════════════════╗
║  VOUS NE POUVEZ PAS COPIER UN PLUGIN D'UNE MARKETPLACE   ║
║  À UNE AUTRE                                              ║
║                                                           ║
║  Raison: Les plugins sont des RÉFÉRENCES, pas des        ║
║  fichiers copiables                                       ║
╚═══════════════════════════════════════════════════════════╝
```

### Pourquoi c'est Impossible ?

**marketplace.json contient des RÉFÉRENCES, pas des fichiers**

```json
// marketplace.json
{
  "plugins": [
    {
      "name": "awesome-plugin",
      "source": {
        "source": "github",
        "repo": "community/awesome-plugin"  // ← RÉFÉRENCE
      }
    }
  ]
}
```

**Explication** :
- Un plugin = **une source unique** (GitHub, Git, local)
- marketplace.json = **catalogue de références**
- Impossible de "copier" une référence GitHub vers une autre marketplace

### ✅ Solutions Alternatives

#### Solution 1: Fork sur GitHub → Référence ton Fork

```bash
# 1. Fork le plugin community sur GitHub (via UI)
# community/awesome-plugin → thibaut/awesome-plugin

# 2. Référence TON fork dans ta marketplace
```

```json
// my-marketplace/marketplace.json
{
  "plugins": [
    {
      "name": "awesome-plugin-fork",
      "source": {
        "source": "github",
        "repo": "thibaut/awesome-plugin"  // ← TON FORK
      },
      "description": "My fork of awesome plugin",
      "version": "1.0.0-custom"
    }
  ]
}
```

#### Solution 2: Clone Localement → Référence Local

```bash
# Structure
~/.claude/
└── marketplace-hub/
    └── personal-marketplace/
        ├── .claude-plugin/marketplace.json
        └── cloned-plugins/
            └── awesome-plugin/          # ← Clone ici
                ├── .claude-plugin/plugin.json
                ├── commands/
                └── agents/
```

```json
// marketplace.json
{
  "plugins": [
    {
      "name": "cloned-plugin",
      "source": "./cloned-plugins/awesome-plugin",  // ← Local
      "description": "Local copy of community plugin"
    }
  ]
}
```

#### Solution 3: Installer Directement depuis Source

```bash
# Pas besoin de copier - installer depuis marketplace originale
/plugin marketplace add community/awesome-marketplace
/plugin install awesome-plugin@awesome-marketplace
```

**Tu n'as PAS besoin de "copier" le plugin dans ta marketplace !**

### Workflow Recommandé (Modifier un Plugin Community)

```bash
# 1. Fork sur GitHub (via UI)
# community/plugin → thibaut/plugin

# 2. Clone localement pour développement
cd ~/.claude/marketplace-hub/personal-marketplace/
mkdir -p dev-plugins
cd dev-plugins
git clone https://github.com/thibaut/plugin.git

# 3. Référence dans ton marketplace
# personal-marketplace/.claude-plugin/marketplace.json
{
  "plugins": [
    {
      "name": "my-modified-plugin",
      "source": "./dev-plugins/plugin",
      "version": "1.0.0-custom"
    }
  ]
}

# 4. Test localement
/plugin install my-modified-plugin@personal

# 5. Modifie le code
cd dev-plugins/plugin
# ... éditer fichiers ...

# 6. Commit et push sur TON fork
git add .
git commit -m "feat: custom modifications"
git push origin main

# 7. Change référence pour prod (optionnel)
# marketplace.json → source: {"source": "github", "repo": "thibaut/plugin"}
```

---

## 💡 Exemples Concrets

### Exemple 1: Dev Fullstack - User + Project Scopes

**Context**: Dev fullstack travaillant sur projet React + Node.js

**User Scope** (`~/.claude/settings.json`) :
```json
{
  "extraKnownMarketplaces": {
    "personal-productivity": {
      "source": {"source": "github", "repo": "me/productivity-plugins"}
    },
    "awesome-community": {
      "source": {"source": "github", "repo": "community/awesome-plugins"}
    }
  },
  "enabledPlugins": {
    "code-snippets@personal-productivity": true,
    "git-helpers@awesome-community": true
  }
}
```

**Project Scope** (`.claude/settings.json`) :
```json
{
  "extraKnownMarketplaces": {
    "project-tools": {
      "source": "./.marketplace"
    }
  },
  "autoInstallPlugins": [
    "react-helpers@project-tools",
    "node-backend@project-tools"
  ]
}
```

**Résultat** :
- User scope: Productivité perso (disponible partout)
- Project scope: Outils projet (React + Node)
- Les deux coexistent harmonieusement

### Exemple 2: Organisation Enterprise

**User Scope** (`~/.claude/settings.json`) :
```json
{
  "extraKnownMarketplaces": {
    "enterprise-security": {
      "source": {
        "source": "git",
        "url": "https://git.company.com/security-plugins.git"
      }
    },
    "team-frontend": {
      "source": {"source": "github", "repo": "company/frontend-plugins"}
    }
  }
}
```

**Project Scope** (`.claude/settings.json`) :
```json
{
  "extraKnownMarketplaces": {
    "project-specific": {
      "source": "./.marketplace"
    }
  },
  "autoInstallPlugins": [
    "security-baseline@enterprise-security",  // Obligatoire organisation
    "frontend-standards@team-frontend",       // Standards équipe
    "api-helpers@project-specific"            // Outils projet
  ]
}
```

### Exemple 3: Marketplace Locale pour Testing

```bash
# Structure développement
~/dev/
├── my-plugin/                    # Plugin en développement
│   ├── .claude-plugin/
│   │   └── plugin.json
│   └── commands/
└── test-marketplace/
    ├── .claude-plugin/
    │   └── marketplace.json
    └── my-plugin/  (symlink)    # Lien symbolique vers ../my-plugin

# marketplace.json
{
  "name": "test-marketplace",
  "plugins": [
    {
      "name": "my-plugin",
      "source": "./my-plugin"
    }
  ]
}

# Test
/plugin marketplace add ~/dev/test-marketplace
/plugin install my-plugin@test-marketplace
/my-plugin-command
```

---

## ❓ FAQ

### Q1: Quelle est la différence entre user scope et project scope ?

**Réponse** :
- **User scope** (`~/.claude/`) : Configuration globale, tous projets
- **Project scope** (`.claude/`) : Configuration projet, versionné Git

### Q2: Dois-je utiliser /plugin marketplace add ou extraKnownMarketplaces ?

**Réponse** :
- **CLI** (`/plugin marketplace add`) : Ajout manuel global
- **Config** (`extraKnownMarketplaces`) : Activation contextuelle automatique
- **Recommandation** : Config pour projets équipe, CLI pour tests

### Q3: Puis-je avoir le même plugin dans user et project scope ?

**Réponse** : Oui ! Priority: Local > Project > User

```json
// User scope: version personnelle
{
  "enabledPlugins": {
    "my-tool@personal": true
  }
}

// Project scope: version équipe
{
  "enabledPlugins": {
    "my-tool@team": true
  }
}

// Résultat: Version équipe utilisée (project scope priority)
```

### Q4: Combien de marketplaces maximum ?

**Réponse** :
- **User scope** : 2-4 recommandé (pas de limite technique)
- **Project scope** : 1 (95% cas), parfois 2

### Q5: Puis-je copier un plugin d'une marketplace community vers ma marketplace perso ?

**Réponse** : ❌ **NON**, impossible de copier. Solutions :
1. Fork sur GitHub → référence ton fork
2. Clone localement → référence en local
3. Installer directement depuis marketplace source

### Q6: extraKnownMarketplaces enlève-t-il des marketplaces du user scope ?

**Réponse** : ❌ **NON** ! Les deux méthodes sont **indépendantes** :
- CLI → Ajout global
- extraKnownMarketplaces → Activation contextuelle
- Elles **coexistent** sans conflit

### Q7: Dois-je créer un .git dans .claude/ pour avoir project scope ?

**Réponse** : ❌ **NON** ! Le scope dépend de la **localisation du fichier** :
- `.claude/settings.json` dans un projet Git → project scope
- `~/.claude/settings.json` → user scope
- Pas besoin de `.git` dans `.claude/`

### Q8: Puis-je avoir des plugins sans marketplace ?

**Réponse** : ✅ **OUI** ! Plugins standalone :
- `.claude/commands/*.md` → Commands standalone
- `.claude/agents/*.md` → Agents standalone
- `.claude/skills/*/SKILL.md` → Skills standalone

Pas besoin de marketplace pour plugins simples !

---

## 📋 Cheatsheet Scopes

### Structure Fichiers

```
USER SCOPE
~/.claude/
├── settings.json           # Config globale
├── commands/               # Commands perso
├── agents/                 # Agents perso
└── marketplace-hub/        # Vos marketplaces (optionnel)

PROJECT SCOPE
<project>/.claude/
├── settings.json           # Config projet (GIT VERSIONED)
├── settings.local.json     # Override local (GITIGNORED)
├── commands/               # Commands projet
└── .marketplace/           # Marketplace locale (optionnel)

LOCAL SCOPE
.claude/settings.local.json  # Override (GITIGNORED)
```

### Commandes Rapides

```bash
# Ajouter marketplace globalement
/plugin marketplace add owner/repo

# Installer plugin
/plugin install plugin-name@marketplace-name

# Lister plugins
/plugin list

# Activer/Désactiver
/plugin enable plugin-name
/plugin disable plugin-name
```

### Priorité Configuration

```
LOCAL > PROJECT > USER

Exemple:
├── Local:   logLevel = "DEBUG"   ✅ USED
├── Project: logLevel = "INFO"    (ignored)
└── User:    logLevel = "WARN"    (ignored)
```

### Template Configuration

```json
// User scope (~/.claude/settings.json)
{
  "extraKnownMarketplaces": {
    "personal": {"source": {"source": "github", "repo": "me/plugins"}},
    "community": {"source": {"source": "github", "repo": "awesome/plugins"}}
  },
  "enabledPlugins": {
    "productivity@personal": true,
    "git-tools@community": true
  }
}

// Project scope (.claude/settings.json)
{
  "extraKnownMarketplaces": {
    "project": {"source": "./.marketplace"}
  },
  "autoInstallPlugins": [
    "security-baseline@enterprise",
    "project-tools@project"
  ]
}

// Local scope (.claude/settings.local.json) - GITIGNORED
{
  "enabledPlugins": {
    "expensive-plugin@team": false  // Override: disable locally
  }
}
```

---

## 📚 Ressources

### Guides Connexes
- [Guide Plugins Complet](./guide.md) - Documentation exhaustive
- [Cheatsheet Plugins](./cheatsheet.md) - Référence rapide
- [Cas d'Usage Réels](./cas-usage.md) - Exemples production

### Documentation Officielle
- [Claude Code Plugins](https://docs.claude.com/en/docs/claude-code/plugins)
- [Marketplaces](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces)
- [Settings](https://docs.claude.com/en/docs/claude-code/settings)

---

**Version** : 1.0.0
**Dernière mise à jour** : 2025-01-14
**Basé sur** : Conversation détaillée + Documentation officielle Claude Code
