# 🌟 Supernovae Studio - Claude Code Configuration

**Configuration complète Claude Code avec marketplace privée et 3 plugins pour gestion de locales, traduction et QR codes AI**

Version 1.0.0 | Janvier 2025

---

## 📋 Table des Matières

- [Vue d'ensemble](#-vue-densemble)
- [Prérequis](#-prérequis)
- [Installation Rapide](#-installation-rapide)
- [Configuration](#-configuration)
- [Utilisation](#-utilisation)
- [Plugins Disponibles](#-plugins-disponibles)
- [Documentation](#-documentation)
- [Troubleshooting](#-troubleshooting)
- [Support](#-support)

---

## 🎯 Vue d'ensemble

Supernovae Studio fournit une suite complète d'outils Claude Code pour :

- **174 Locales** - Gestion complète avec base de données cloud
- **Traduction Contextuelle** - Précision maximale avec adaptation culturelle
- **QR Codes AI** - Génération et analyse intelligente

### Plugins Inclus

| Plugin | Description | Capabilities |
|--------|-------------|--------------|
| **Local Global Info** | Gestion des 174 locales | CRUD, recherche, validation, MCP server |
| **Plugin Traduction** | Traduction contextuelle | Multi-locale, contexte culturel, batch |
| **QR Code AI** | QR codes intelligents | Génération AI, analyse, optimisation |

---

## 🔧 Prérequis

### Logiciels Requis

- **Claude Code** ≥ 1.0.0
- **Python** ≥ 3.8
- **Node.js** ≥ 18.0.0
- **Git** (pour version control)

### Variables d'Environnement

Créer un fichier `.env` à la racine du projet :

```bash
# Global Info MCP Server
GLOBAL_INFO_DB_URL=https://api.supernovae.studio/db/locales
GLOBAL_INFO_CLIENT_ID=your_client_id
GLOBAL_INFO_CLIENT_SECRET=your_client_secret

# QR Code AI MCP Server
QR_CODE_AI_DB_URL=https://api.supernovae.studio/db/qrcodes
QR_CODE_CLIENT_ID=your_qr_client_id
QR_CODE_CLIENT_SECRET=your_qr_client_secret
```

⚠️ **Important** : Ne jamais committer le fichier `.env` !

---

## 🚀 Installation Rapide

### 1. Cloner ou Télécharger le Projet

```bash
cd /path/to/your/projects
# Le projet est déjà dans: /Users/thibaut/Desktop/ai-claude-news-to-delete
```

### 2. Installer les Dépendances

```bash
# Python dependencies
pip install -r requirements.txt

# Node dependencies (si applicable)
npm install
```

### 3. Démarrer Claude Code

```bash
cd /Users/thibaut/Desktop/ai-claude-news-to-delete
claude
```

### 4. Ajouter la Marketplace

Dans Claude Code :

```bash
/plugin marketplace add ./supernovae-marketplace
```

### 5. Installer les Plugins

```bash
/plugin install local-global-info@supernovae-studio
/plugin install plugin-traduction@supernovae-studio
/plugin install qr-code-ai@supernovae-studio
```

### 6. Redémarrer Claude Code

```bash
/exit
claude
```

🎉 **C'est fait !** Les plugins sont maintenant disponibles.

---

## ⚙️ Configuration

### Configuration MCP Servers

Authentifier les serveurs MCP :

```bash
# Dans Claude Code
/mcp

# Sélectionner "Authenticate" pour chaque serveur:
# - global-info
# - qr-code-ai
```

### Vérifier l'Installation

```bash
# Vérifier les plugins installés
/plugin

# Vérifier les commandes disponibles
/help

# Vérifier le statut complet
/supernovae-status
```

### Permissions

Les permissions sont pré-configurées dans `.claude/settings.json`. Pour modifier :

```bash
/permissions
```

---

## 📖 Utilisation

### Commandes de Base

#### Global Info (Locales)

```bash
# Lister toutes les 174 locales
/list-locales

# Obtenir une locale spécifique
/get-locale fr-FR

# Rechercher des locales
/search-locales Europe

# Mettre à jour une locale
/update-locale fr-FR timezone Europe/Paris
```

#### Traduction

```bash
# Traduction simple
/translate "Hello, how are you?" en-US fr-FR

# Traduction par batch
/batch-translate "Welcome" en-US fr-FR,es-ES,de-DE

# Valider une traduction
/validate-translation "Bonjour, comment allez-vous ?" fr-FR
```

#### QR Code AI

```bash
# Générer un QR code
/generate-qr "https://supernovae.studio"

# Générer avec options
/generate-qr "https://supernovae.studio" large H

# Analyser un QR code
/analyze-qr ./path/to/qr-code.png

# Batch generation
/batch-qr ./products.json
```

### Utilisation avec MCP

Les plugins exposent des outils MCP utilisables directement :

```bash
# Global Info MCP
/mcp__global_info__get_locale fr-FR
/mcp__global_info__list_locales

# QR Code AI MCP
/mcp__qr_code_ai__generate_qr "https://example.com"
/mcp__qr_code_ai__analyze_qr image.png
```

### Workflows Courants

#### Workflow 1 : Traduire pour Plusieurs Locales

```bash
# 1. Lister les locales européennes
/list-locales region=Europe

# 2. Traduire vers plusieurs locales
/batch-translate "Welcome to our website" en-US fr-FR,de-DE,es-ES,it-IT

# 3. Générer des QR codes pour chaque version
/batch-qr translated-pages.json
```

#### Workflow 2 : Ajouter une Nouvelle Locale

```bash
# 1. Demander à Claude de créer les données
"Create locale data for Catalan (Spain) - ca-ES"

# 2. Valider avec le subagent
"Use the locale-validator subagent to validate this data"

# 3. Ajouter à la base de données
/update-locale ca-ES [data]
```

#### Workflow 3 : Analyse et Optimisation QR Code

```bash
# 1. Analyser un QR code existant
/analyze-qr ./old-qr-code.png

# 2. Voir les recommandations AI
# Claude affiche score et suggestions

# 3. Générer version optimisée
/generate-qr [same-data] large H
```

---

## 🔌 Plugins Disponibles

### 1. Local Global Info

**Gestion des 174 locales internationales**

**Capabilities:**
- Accès CRUD complet à la DB cloud
- 174 locales avec informations détaillées
- Recherche et filtrage avancés
- Validation des données
- Export/Import JSON/CSV

**Files:**
- `SKILL.md` - Capacité principale
- Commands : `list-locales`, `get-locale`, `update-locale`, `search-locales`
- Scripts : `locale-crud.py`, `validate-locale.py`
- MCP Server : `global-info`

**Documentation:** `supernovae-marketplace/local-global-info/`

### 2. Plugin Traduction

**Traduction contextuelle multi-locale**

**Capabilities:**
- Traduction avec contexte culturel
- Utilise Global Info pour précision
- Support QR Code AI pour contexte domaine
- Analyse idiomatique et formelle
- Validation de qualité

**Files:**
- `SKILL.md` - Capacité de traduction
- Commands : `translate`, `batch-translate`, `validate-translation`
- Scripts : `translator.py`, `context-analyzer.py`
- MCP Client : Utilise `global-info` et `qr-code-ai`

**Documentation:** `supernovae-marketplace/plugin-traduction/`

### 3. QR Code AI

**Génération et analyse intelligente de QR codes**

**Capabilities:**
- Génération optimisée par AI
- Analyse et scoring de lisibilité
- Recommandations automatiques
- Métadonnées enrichies
- Génération par batch

**Files:**
- `SKILL.md` - Capacité QR codes
- Commands : `generate-qr`, `analyze-qr`, `batch-qr`
- Scripts : `qr-generator.py`, `qr-ai-processor.py`
- MCP Server : `qr-code-ai`

**Documentation:** `supernovae-marketplace/qr-code-ai/`

---

## 📚 Documentation

### Fichiers Principaux

| Fichier | Description |
|---------|-------------|
| `CLAUDE_CODE_NEWS.md` | Dernières news et features Claude Code 2025 |
| `SUPERNOVAE_ARCHITECTURE.md` | Architecture détaillée avec schémas ASCII |
| `.claude/CLAUDE.md` | Instructions globales du projet |
| `README.md` | Ce fichier |

### Guides Additionnels

- **Architecture détaillée** : Voir `SUPERNOVAE_ARCHITECTURE.md`
- **News Claude Code** : Voir `CLAUDE_CODE_NEWS.md`
- **Configuration projet** : Voir `.claude/CLAUDE.md`
- **Settings** : Voir `.claude/settings.json`

### Ressources Externes

- [Claude Code Documentation](https://code.claude.com/docs)
- [MCP Protocol](https://modelcontextprotocol.io)
- [Anthropic Academy](https://anthropic.skilljar.com)

---

## 🐛 Troubleshooting

### Problèmes Courants

#### Plugin Non Reconnu

**Symptôme** : Le plugin n'apparaît pas dans `/plugin`

**Solution** :
```bash
# Vérifier la marketplace
/plugin marketplace list

# Ré-ajouter si nécessaire
/plugin marketplace add ./supernovae-marketplace

# Réinstaller
/plugin install [plugin-name]@supernovae-studio
```

#### MCP Server Inaccessible

**Symptôme** : Erreur lors des appels MCP

**Solution** :
```bash
# Vérifier connexion
/mcp

# Ré-authentifier
/mcp auth global-info
/mcp auth qr-code-ai

# Vérifier credentials dans .env
```

#### Commandes Non Trouvées

**Symptôme** : `/list-locales` : command not found

**Solution** :
```bash
# Vérifier plugin activé
/plugin

# Redémarrer Claude Code
/exit
claude

# Vérifier avec /help
/help
```

#### Erreurs Python

**Symptôme** : ModuleNotFoundError

**Solution** :
```bash
# Réinstaller dépendances
pip install -r requirements.txt

# Vérifier version Python
python --version  # Doit être ≥ 3.8
```

### Logs et Debug

```bash
# Mode debug
claude --debug

# Logs MCP
claude --mcp-debug

# Voir contexte
/context

# Voir coûts
/cost
```

---

## 🆘 Support

### Obtenir de l'Aide

1. **Vérifier la documentation** : Lire `CLAUDE_CODE_NEWS.md` et `SUPERNOVAE_ARCHITECTURE.md`
2. **Consulter les logs** : Voir `.claude/session-log.txt`
3. **Utiliser le debug mode** : `claude --debug`
4. **Demander à Claude** : Claude peut vous aider à troubleshoot !

### Contact

- **Email** : dev@supernovae.studio
- **Documentation** : Voir fichiers du projet
- **Repository** : (Ajouter lien GitHub si applicable)

### Contribuer

Pour contribuer :
1. Fork le repository
2. Créer une branche : `git checkout -b feature/ma-feature`
3. Commit : `git commit -m "[feat] Description"`
4. Push : `git push origin feature/ma-feature`
5. Créer une Pull Request

---

## 📊 Statistiques

```
┌──────────────────────────────────────────┐
│      SUPERNOVAE STUDIO STATS             │
├──────────────────────────────────────────┤
│ Locales supportées:        174           │
│ Plugins:                   3             │
│ Slash commands:            12            │
│ Agent Skills:              3             │
│ MCP Servers:               2             │
│ Scripts Python:            6             │
│ Version:                   1.0.0         │
└──────────────────────────────────────────┘
```

---

## 🎓 Best Practices

### Utilisation avec Claude

1. **Soyez spécifiques** : "Traduire vers fr-FR avec style formel" vs "Traduire en français"
2. **Utilisez les images** : Drag & drop des mocks ou screenshots
3. **Course Correction** : Escape pour interrompre, Double-Escape pour revenir
4. **Gestion contexte** : Utilisez `/clear` entre tâches différentes
5. **Exploitez les Skills** : Les plugins se chargent automatiquement selon contexte

### Développement

1. **Testez avant commit** : `python -m pytest` et `npm test`
2. **Suivez le style** : Black pour Python, Prettier pour JS
3. **Documentez** : Mettez à jour README et CLAUDE.md
4. **Validez les locales** : Toujours utiliser `locale-validator` subagent
5. **Loggez les opérations** : Pour debug et audit

---

## 📝 Changelog

### Version 1.0.0 (2025-01-06)

**Initial Release**
- ✨ Plugin Local Global Info (174 locales)
- ✨ Plugin Traduction (contexte culturel)
- ✨ Plugin QR Code AI (génération intelligente)
- ✨ Configuration Claude Code complète
- ✨ Documentation complète (ASCII diagrams)
- ✨ MCP Servers configurés
- ✨ Slash commands personnalisés
- ✨ Subagent locale-validator

---

## 📜 License

MIT License - Voir `LICENSE` file

---

## 🙏 Remerciements

- **Anthropic** pour Claude Code et les outils
- **Supernovae Studio** pour le développement
- **Community** pour les contributions

---

**Supernovae Studio** © 2025

*Configuration créée avec ❤️ pour Claude Code*
