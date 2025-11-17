# 📥 Workflow Installation - Guide Visuel

> **Workflows détaillés pour installer plugins et marketplaces avec diagrammes étape par étape**

---

## 📚 Table des Matières

1. [Règle d'Or](#-règle-dor)
2. [Workflow 1: Installation CLI](#-workflow-1--installation-cli)
3. [Workflow 2: Installation Config](#-workflow-2--installation-config)
4. [Workflow 3: Installation Locale](#-workflow-3--installation-locale)
5. [Workflow 4: Fork Plugin Community](#-workflow-4--fork-plugin-community)
6. [Erreurs Courantes](#-erreurs-courantes)
7. [Decision Tree](#-decision-tree)

---

## ⚠️ Règle d'Or

```
╔═══════════════════════════════════════════════════════════╗
║                                                           ║
║  VOUS DEVEZ AJOUTER LA MARKETPLACE AVANT LES PLUGINS     ║
║                                                           ║
║  ❌ IMPOSSIBLE: /plugin install sans marketplace         ║
║  ✅ CORRECT: Marketplace → Plugins                       ║
║                                                           ║
╚═══════════════════════════════════════════════════════════╝
```

---

## 🔧 Workflow 1 : Installation CLI

**Contexte** : Installation manuelle globale via CLI

### Étapes Détaillées

```
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 1: Ajouter Marketplace                           │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
        /plugin marketplace add owner/repo
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  Marketplace ajoutée dans:                              │
│  ~/.claude/marketplace-registries.json                  │
│  (Claude gère automatiquement)                          │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 2: Vérifier Marketplace                          │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
            /plugin marketplace list
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  Output:                                                │
│  • owner-repo (GitHub)                                  │
│    Status: ✅ Active                                    │
│    Plugins: 5 available                                 │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 3: Installer Plugins                             │
└─────────────────────┬───────────────────────────────────┘
                      │
    ┌─────────────────┴─────────────────┐
    │                                   │
    ▼                                   ▼
/plugin install                    /plugin install
plugin1@owner-repo                 plugin2@owner-repo
    │                                   │
    └─────────────────┬─────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 4: Vérifier Installation                         │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
                /plugin list
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  Output:                                                │
│  ✅ plugin1@owner-repo  (enabled)                       │
│  ✅ plugin2@owner-repo  (enabled)                       │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
            ✅ INSTALLATION RÉUSSIE
```

### Commandes Exactes

```bash
# Étape 1: Ajouter marketplace
/plugin marketplace add thibaut/my-plugins

# Étape 2: Vérifier
/plugin marketplace list

# Étape 3: Installer plugins
/plugin install productivity-tools@my-plugins
/plugin install code-snippets@my-plugins

# Étape 4: Vérifier installation
/plugin list

# Étape 5: Utiliser
/my-plugin-command
```

---

## ⚙️ Workflow 2 : Installation Config

**Contexte** : Configuration automatique via `extraKnownMarketplaces`

### Étapes Détaillées

```
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 1: Créer/Éditer settings.json                    │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
        Ouvrir: .claude/settings.json
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  {                                                      │
│    "extraKnownMarketplaces": {                          │
│      "team-tools": {                                    │
│        "source": {                                      │
│          "source": "github",                            │
│          "repo": "company/team-plugins"                 │
│        }                                                │
│      }                                                  │
│    }                                                    │
│  }                                                      │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 2: Sauvegarder + Commit (si projet)             │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
            git add .claude/settings.json
            git commit -m "feat: add team marketplace"
            git push
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 3: Redémarrer Claude ou Recharger Config        │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
            claude --reload  (ou restart)
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  Marketplace activée automatiquement dans ce contexte   │
│  ✅ Disponible pour tous les membres équipe (Git)      │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 4: Installer Plugins                             │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
        /plugin install security-baseline@team-tools
        /plugin install frontend-standards@team-tools
                      │
                      ▼
            ✅ INSTALLATION RÉUSSIE
```

### Configuration Complète avec Auto-Install

```json
// .claude/settings.json (PROJECT SCOPE)
{
  "extraKnownMarketplaces": {
    "team-tools": {
      "source": {
        "source": "github",
        "repo": "company/team-plugins"
      }
    },
    "enterprise-security": {
      "source": {
        "source": "git",
        "url": "https://git.company.com/security-plugins.git"
      }
    }
  },
  "autoInstallPlugins": [
    "security-baseline@enterprise-security",
    "code-standards@team-tools",
    "testing-suite@team-tools"
  ]
}
```

**Résultat** :
- ✅ Marketplaces activées automatiquement
- ✅ Plugins installés automatiquement au démarrage
- ✅ Équipe entière synchronisée (versionné Git)

---

## 🏠 Workflow 3 : Installation Locale

**Contexte** : Marketplace locale pour développement/testing

### Étapes Détaillées

```
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 1: Créer Structure Marketplace                   │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
        mkdir -p .marketplace/.claude-plugin
        cd .marketplace
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 2: Créer marketplace.json                        │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    cat > .claude-plugin/marketplace.json << 'EOF'
    {
      "name": "local-tools",
      "owner": {"name": "Me"},
      "plugins": [
        {
          "name": "my-plugin",
          "source": "./my-plugin",
          "version": "1.0.0"
        }
      ]
    }
    EOF
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 3: Créer Plugin                                  │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    mkdir -p my-plugin/.claude-plugin
    mkdir -p my-plugin/commands
                      │
                      ▼
    # plugin.json
    echo '{"name":"my-plugin"}' > my-plugin/.claude-plugin/plugin.json
                      │
                      ▼
    # Command
    cat > my-plugin/commands/test.md << 'EOF'
    ---
    name: test
    ---
    Test command!
    EOF
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 4: Configurer dans settings.json                 │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    # .claude/settings.json
    {
      "extraKnownMarketplaces": {
        "local-tools": {
          "source": "./.marketplace"
        }
      }
    }
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 5: Installer et Tester                           │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
            /plugin install my-plugin@local-tools
            /test
                      │
                      ▼
            ✅ MARKETPLACE LOCALE FONCTIONNELLE
```

### Structure Finale

```
my-project/
├── .git/
├── .claude/
│   └── settings.json
│       {
│         "extraKnownMarketplaces": {
│           "local-tools": {"source": "./.marketplace"}
│         }
│       }
│
└── .marketplace/
    ├── .claude-plugin/
    │   └── marketplace.json
    │       {
    │         "name": "local-tools",
    │         "plugins": [
    │           {"name": "my-plugin", "source": "./my-plugin"}
    │         ]
    │       }
    │
    └── my-plugin/
        ├── .claude-plugin/
        │   └── plugin.json
        └── commands/
            └── test.md
```

---

## 🍴 Workflow 4 : Fork Plugin Community

**Contexte** : Modifier un plugin community et l'ajouter à ta marketplace

### Workflow Complet

```
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 1: Fork sur GitHub (via UI)                      │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    GitHub UI: Fork community/awesome-plugin
               → thibaut/awesome-plugin
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 2: Clone TON fork localement                     │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    cd ~/.claude/marketplace-hub/personal-marketplace/
    mkdir -p dev-plugins
    cd dev-plugins
    git clone https://github.com/thibaut/awesome-plugin.git
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 3: Référence dans marketplace.json               │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    # personal-marketplace/.claude-plugin/marketplace.json
    {
      "name": "personal",
      "plugins": [
        {
          "name": "awesome-plugin-custom",
          "source": "./dev-plugins/awesome-plugin",
          "description": "My fork with custom features",
          "version": "1.0.0-custom"
        }
      ]
    }
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 4: Installer et Tester                           │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    /plugin install awesome-plugin-custom@personal
    /awesome-plugin-command
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 5: Modifier le Code                              │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    cd dev-plugins/awesome-plugin
    # ... éditer fichiers ...

    git add .
    git commit -m "feat: add my custom feature"
    git push origin main
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│  ÉTAPE 6: (Optionnel) Référence GitHub                  │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
    # marketplace.json (pour prod)
    {
      "name": "awesome-plugin-custom",
      "source": {
        "source": "github",
        "repo": "thibaut/awesome-plugin",
        "ref": "main"
      }
    }
                      │
                      ▼
            ✅ FORK INTÉGRÉ DANS TA MARKETPLACE
```

### Diagramme Références

```
    MARKETPLACE COMMUNITY
    ┌──────────────────────┐
    │ community/awesome    │
    │ └─ awesome-plugin    │◄────┐
    └──────────────────────┘     │
                                 │ (fork)
                                 │
    TON FORK GITHUB              │
    ┌──────────────────────┐     │
    │ thibaut/awesome      │─────┘
    │ └─ awesome-plugin    │
    └──────┬───────────────┘
           │
           │ (clone)
           ▼
    TON MARKETPLACE LOCAL
    ┌──────────────────────┐
    │ personal-marketplace │
    │ └─ dev-plugins/      │
    │    └─ awesome-plugin │◄─── référencé dans marketplace.json
    └──────────────────────┘
```

---

## ❌ Erreurs Courantes

### Erreur 1: Installer Plugin AVANT Marketplace

```
❌ TENTATIVE:
/plugin install awesome-tool

❌ ERREUR:
Error: No marketplace found for 'awesome-tool'
Available marketplaces: none

✅ SOLUTION:
# TOUJOURS ajouter marketplace AVANT
/plugin marketplace add community/tools
/plugin install awesome-tool@tools
```

### Erreur 2: Oublier @marketplace-name

```
❌ TENTATIVE:
/plugin marketplace add thibaut/plugins
/plugin install my-tool

❌ ERREUR:
Error: Ambiguous plugin 'my-tool'
Found in multiple marketplaces: personal, thibaut-plugins

✅ SOLUTION:
/plugin install my-tool@thibaut-plugins
```

### Erreur 3: Mauvais Chemin Local

```
❌ TENTATIVE:
# settings.json
{
  "extraKnownMarketplaces": {
    "local": {"source": "marketplace"}  ← Chemin relatif incorrect
  }
}

❌ ERREUR:
Error: Marketplace not found at 'marketplace'

✅ SOLUTION:
{
  "extraKnownMarketplaces": {
    "local": {"source": "./.marketplace"}  ← Chemin correct depuis projet root
  }
}
```

### Erreur 4: Git non Versionné (Project Scope)

```
❌ PROBLÈME:
# .claude/settings.json créé mais pas versionné Git

❌ RÉSULTAT:
Équipe ne voit pas la marketplace configurée

✅ SOLUTION:
git add .claude/settings.json
git commit -m "feat: add team marketplace"
git push
```

---

## 🌳 Decision Tree

### Quelle Méthode d'Installation Choisir ?

```
                    START
                      │
                      ▼
        ┌─────────────────────────┐
        │ Besoin de partager avec │
        │ équipe/organisation ?    │
        └────────┬────────────────┘
                 │
        ┌────────┴────────┐
        │                 │
       OUI               NON
        │                 │
        ▼                 ▼
┌────────────────┐  ┌────────────────┐
│ CONFIG FILE    │  │ CLI MANUEL     │
│ (extraKnown    │  │ (/plugin       │
│  Marketplaces) │  │  marketplace   │
│                │  │  add)          │
│ ✅ Versionné   │  │                │
│ ✅ Auto        │  │ ✅ Quick test  │
│ ✅ Équipe sync │  │ ✅ Explore     │
└────────────────┘  └────────────────┘
        │                 │
        └────────┬────────┘
                 │
                 ▼
        ┌─────────────────────────┐
        │ Marketplace locale ou   │
        │ GitHub ?                │
        └────────┬────────────────┘
                 │
        ┌────────┴────────┐
        │                 │
     LOCALE            GITHUB
        │                 │
        ▼                 ▼
┌────────────────┐  ┌────────────────┐
│ source:        │  │ source:        │
│ "./.market"    │  │ {"source":     │
│                │  │  "github",     │
│ ✅ Dev/test    │  │  "repo": "..."}│
│ ✅ Prototyping │  │                │
│                │  │ ✅ Prod        │
│                │  │ ✅ Distribution│
└────────────────┘  └────────────────┘
```

### Quelle Source pour Plugin ?

```
            PLUGIN SOURCE
                 │
        ┌────────┴────────┐
        │                 │
   EN MODIF          STABLE
        │                 │
        ▼                 ▼
┌────────────────┐  ┌────────────────┐
│ LOCAL PATH     │  │ GITHUB/GIT     │
│ "./my-plugin"  │  │ "owner/repo"   │
│                │  │                │
│ ✅ Dev actif   │  │ ✅ Production  │
│ ✅ Testing     │  │ ✅ Versioning  │
│                │  │ ✅ Team share  │
└────────────────┘  └────────────────┘
```

---

## 📚 Ressources

### Guides Connexes
- [Scopes et Marketplaces](./scopes-et-marketplaces.md) - Organisation complète
- [Guide Plugins](./guide.md) - Documentation exhaustive
- [Cheatsheet](./cheatsheet.md) - Référence rapide

### Documentation Officielle
- [Plugins Installation](https://docs.claude.com/en/docs/claude-code/plugins#installation)
- [Marketplaces](https://docs.claude.com/en/docs/claude-code/plugin-marketplaces)

---

**Version** : 1.0.0
**Dernière mise à jour** : 2025-01-14
