# 🏗️ Architecture Supernovae Studio - Claude Code

**Organisation :** Supernovae Studio
**Version :** 1.0.0
**Date :** Janvier 2025

---

## 📋 Table des Matières

1. [Vue d'ensemble](#vue-densemble)
2. [Architecture Globale](#architecture-globale)
3. [Structure de la Marketplace](#structure-de-la-marketplace)
4. [Plugin Local Global Info](#plugin-local-global-info)
5. [Plugin Traduction](#plugin-traduction)
6. [Plugin QR Code AI](#plugin-qr-code-ai)
7. [Flux de Données](#flux-de-données)
8. [Configuration MCP](#configuration-mcp)

---

## 🌟 Vue d'ensemble

Supernovae Studio fournit une marketplace Claude Code privée avec 3 plugins indépendants pour gérer :
- **174 locales** avec informations détaillées
- **Traduction contextuelle** utilisant les données de locales
- **Génération QR codes AI** avec intelligence artificielle

```
┌─────────────────────────────────────────────────────────────────┐
│                      SUPERNOVAE STUDIO                          │
│                     Claude Code Marketplace                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────────┐  ┌─────────────────┐  ┌───────────────┐  │
│  │ Local Global    │  │    Plugin       │  │  QR Code AI   │  │
│  │     Info        │  │   Traduction    │  │               │  │
│  │   (174 locales) │  │                 │  │  (Generation) │  │
│  └────────┬────────┘  └────────┬────────┘  └───────┬───────┘  │
│           │                    │                    │           │
│           │                    │                    │           │
│           ▼                    ▼                    ▼           │
│      MCP Server           MCP Client           MCP Server       │
│    (DB Access)         (Utilise les 2)         (QR Data)       │
│                                                                 │
│                    ┌────────────────┐                          │
│                    │   Cloud DB     │                          │
│                    │  (174 Locales) │                          │
│                    │  + QR Codes    │                          │
│                    └────────────────┘                          │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🏢 Architecture Globale

### Structure Complète du Projet

```
ai-claude-news-to-delete/
│
├── 📄 CLAUDE_CODE_NEWS.md              # Documentation dernières news
├── 📄 SUPERNOVAE_ARCHITECTURE.md       # Ce fichier
├── 📄 README.md                        # Guide d'installation
│
├── 📁 .claude/                         # Configuration Claude Code
│   ├── settings.json                   # Config projet + marketplace
│   ├── CLAUDE.md                       # Instructions globales
│   ├── 📁 commands/                    # Slash commands custom
│   │   ├── supernovae-status.md
│   │   └── sync-locales.md
│   └── 📁 agents/                      # Subagents custom
│       └── locale-validator.md
│
└── 📁 supernovae-marketplace/          # Marketplace Supernovae
    ├── 📁 .claude-plugin/
    │   └── marketplace.json            # Manifeste marketplace
    │
    ├── 📁 local-global-info/           # Plugin #1
    │   ├── 📁 .claude-plugin/
    │   │   └── plugin.json
    │   ├── 📁 skills/
    │   │   └── 📁 global-info/
    │   │       ├── SKILL.md
    │   │       ├── locale-reference.md
    │   │       └── api-docs.md
    │   ├── 📁 commands/
    │   │   ├── list-locales.md
    │   │   ├── get-locale.md
    │   │   ├── update-locale.md
    │   │   └── search-locales.md
    │   ├── 📁 scripts/
    │   │   ├── db-client.py
    │   │   ├── locale-crud.py
    │   │   └── validate-locale.py
    │   └── .mcp.json
    │
    ├── 📁 plugin-traduction/            # Plugin #2
    │   ├── 📁 .claude-plugin/
    │   │   └── plugin.json
    │   ├── 📁 skills/
    │   │   └── 📁 traduction/
    │   │       ├── SKILL.md
    │   │       ├── translation-guide.md
    │   │       └── locale-context.md
    │   ├── 📁 commands/
    │   │   ├── translate.md
    │   │   ├── batch-translate.md
    │   │   └── validate-translation.md
    │   └── 📁 scripts/
    │       ├── translator.py
    │       └── context-analyzer.py
    │
    └── 📁 qr-code-ai/                   # Plugin #3
        ├── 📁 .claude-plugin/
        │   └── plugin.json
        ├── 📁 skills/
        │   └── 📁 qr-code/
        │       ├── SKILL.md
        │       ├── generation-guide.md
        │       └── ai-parameters.md
        ├── 📁 commands/
        │   ├── generate-qr.md
        │   ├── analyze-qr.md
        │   └── batch-qr.md
        ├── 📁 scripts/
        │   ├── qr-generator.py
        │   └── qr-ai-processor.py
        └── .mcp.json
```

---

## 🏪 Structure de la Marketplace

### Marketplace Manifest

```
supernovae-marketplace/
│
├── .claude-plugin/
│   └── marketplace.json
│
└── [plugins...]

────────────────────────────────────────────────────────────────

marketplace.json Structure:
{
  "name": "supernovae-studio",
  "owner": {
    "name": "Supernovae Studio",
    "email": "dev@supernovae.studio"
  },
  "plugins": [
    {
      "name": "local-global-info",
      "source": "./local-global-info",
      "description": "Gestion des 174 locales avec DB cloud",
      "version": "1.0.0"
    },
    {
      "name": "plugin-traduction",
      "source": "./plugin-traduction",
      "description": "Traduction contextuelle multi-locale",
      "version": "1.0.0"
    },
    {
      "name": "qr-code-ai",
      "source": "./qr-code-ai",
      "description": "Génération intelligente de QR codes",
      "version": "1.0.0"
    }
  ]
}
```

### Installation Marketplace

```bash
# Depuis le répertoire du projet
claude

# Ajouter la marketplace
/plugin marketplace add ./supernovae-marketplace

# Installer tous les plugins
/plugin install local-global-info@supernovae-studio
/plugin install plugin-traduction@supernovae-studio
/plugin install qr-code-ai@supernovae-studio
```

---

## 🗺️ Plugin Local Global Info

### Vue d'ensemble

Plugin pour gérer une base de données de **174 locales** avec informations complètes (langue, région, format dates, devise, etc.).

### Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    LOCAL GLOBAL INFO PLUGIN                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                    SKILL.md                             │    │
│  │  ┌──────────────────────────────────────────────┐      │    │
│  │  │ Metadata (toujours chargé)                   │      │    │
│  │  │ - name: global-info                          │      │    │
│  │  │ - description: Manage 174 locales data       │      │    │
│  │  └──────────────────────────────────────────────┘      │    │
│  │                                                         │    │
│  │  ┌──────────────────────────────────────────────┐      │    │
│  │  │ Core Instructions (chargé si pertinent)      │      │    │
│  │  │ - CRUD operations                            │      │    │
│  │  │ - Search & filter                            │      │    │
│  │  │ - Validation rules                           │      │    │
│  │  └──────────────────────────────────────────────┘      │    │
│  │                                                         │    │
│  │  📄 locale-reference.md → Détails 174 locales          │    │
│  │  📄 api-docs.md → Documentation API DB                 │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                   SLASH COMMANDS                        │    │
│  │                                                         │    │
│  │  /list-locales [filter]                                │    │
│  │  /get-locale [locale-code]                             │    │
│  │  /update-locale [locale-code] [field] [value]          │    │
│  │  /search-locales [query]                               │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                      SCRIPTS                            │    │
│  │                                                         │    │
│  │  🐍 db-client.py        → Connexion DB cloud           │    │
│  │  🐍 locale-crud.py      → Operations CRUD              │    │
│  │  🐍 validate-locale.py  → Validation données           │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                    MCP SERVER                           │    │
│  │                                                         │    │
│  │  Tools Exposés:                                         │    │
│  │  - get_locale(code)                                     │    │
│  │  - list_locales(filter)                                 │    │
│  │  - update_locale(code, data)                            │    │
│  │  - search_locales(query)                                │    │
│  │  - validate_locale_data(data)                           │    │
│  └────────────────────────────────────────────────────────┘    │
│                            ▼                                    │
│                   ┌─────────────────┐                          │
│                   │   CLOUD DB      │                          │
│                   │ (174 Locales)   │                          │
│                   │                 │                          │
│                   │ - fr-FR         │                          │
│                   │ - en-US         │                          │
│                   │ - es-ES         │                          │
│                   │ - ...           │                          │
│                   └─────────────────┘                          │
└─────────────────────────────────────────────────────────────────┘
```

### Données Locale (Exemple)

```json
{
  "code": "fr-FR",
  "language": "Français",
  "region": "France",
  "currency": "EUR",
  "currency_symbol": "€",
  "date_format": "DD/MM/YYYY",
  "time_format": "HH:mm",
  "decimal_separator": ",",
  "thousands_separator": " ",
  "writing_direction": "ltr",
  "timezone": "Europe/Paris",
  "common_expressions": {
    "hello": "Bonjour",
    "goodbye": "Au revoir",
    "thank_you": "Merci"
  },
  "formal_style": true,
  "cultural_notes": "Usage du vouvoiement dans contexte formel"
}
```

### Fonctionnalités

```
┌──────────────────┐
│   CAPABILITIES   │
├──────────────────┤
│ ✓ List all 174   │
│   locales        │
│                  │
│ ✓ Get specific   │
│   locale details │
│                  │
│ ✓ Update locale  │
│   information    │
│                  │
│ ✓ Search across  │
│   locales        │
│                  │
│ ✓ Validate       │
│   locale data    │
│                  │
│ ✓ Export/Import  │
│   locale sets    │
└──────────────────┘
```

---

## 🌐 Plugin Traduction

### Vue d'ensemble

Plugin de traduction contextuelle qui utilise les données de Global Info pour assurer une précision maximale selon la locale cible.

### Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     PLUGIN TRADUCTION                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                    SKILL.md                             │    │
│  │                                                         │    │
│  │  Metadata:                                              │    │
│  │  - name: traduction                                     │    │
│  │  - description: Context-aware translation with locale   │    │
│  │                                                         │    │
│  │  Instructions:                                          │    │
│  │  1. Récupérer contexte locale via MCP Global Info      │    │
│  │  2. Récupérer données QR Code via MCP QR Code AI       │    │
│  │  3. Analyser contexte culturel                         │    │
│  │  4. Générer traduction adaptée                         │    │
│  │  5. Valider expressions idiomatiques                   │    │
│  │                                                         │    │
│  │  📄 translation-guide.md → Stratégies traduction       │    │
│  │  📄 locale-context.md → Contextes culturels            │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                   SLASH COMMANDS                        │    │
│  │                                                         │    │
│  │  /translate [text] [source-locale] [target-locale]     │    │
│  │  /batch-translate [file] [target-locales]              │    │
│  │  /validate-translation [text] [locale]                 │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                      SCRIPTS                            │    │
│  │                                                         │    │
│  │  🐍 translator.py          → Moteur traduction         │    │
│  │  🐍 context-analyzer.py    → Analyse contexte          │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                  MCP CLIENTS (Utilise)                  │    │
│  │                                                         │    │
│  │  → mcp__global_info__get_locale(code)                  │    │
│  │  → mcp__qr_code_ai__get_qr_data(id)                    │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Workflow de Traduction

```
INPUT TEXT (Source Locale)
        │
        ▼
┌──────────────────┐
│ 1. Get Source    │
│    Locale Info   │ ◄────── MCP: Global Info
│                  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 2. Get Target    │
│    Locale Info   │ ◄────── MCP: Global Info
│                  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 3. Get QR Code   │
│    Context (opt) │ ◄────── MCP: QR Code AI
│                  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 4. Analyze       │
│    Cultural      │
│    Context       │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 5. Generate      │
│    Translation   │
│                  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 6. Validate      │
│    & Format      │
│                  │
└────────┬─────────┘
         │
         ▼
OUTPUT TEXT (Target Locale)
```

### Exemple d'Utilisation

```markdown
# Traduction Simple
/translate "Hello, how are you?" en-US fr-FR

→ Contexte récupéré: fr-FR (formel, vouvoiement)
→ Résultat: "Bonjour, comment allez-vous ?"

# Traduction avec Contexte QR Code
/translate "Scan this QR code" en-US ja-JP

→ Contexte: ja-JP (polite form, vertical text)
→ QR Code data: 顧客向け資料
→ Résultat: "こちらのQRコードをスキャンしてください"
```

---

## 📱 Plugin QR Code AI

### Vue d'ensemble

Plugin pour générer, analyser et gérer des QR codes avec intelligence artificielle.

### Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      QR CODE AI PLUGIN                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                    SKILL.md                             │    │
│  │                                                         │    │
│  │  Metadata:                                              │    │
│  │  - name: qr-code-ai                                     │    │
│  │  - description: Generate and analyze QR codes with AI   │    │
│  │                                                         │    │
│  │  Instructions:                                          │    │
│  │  1. Parse request parameters                           │    │
│  │  2. Generate QR code with AI optimization              │    │
│  │  3. Store metadata in DB                               │    │
│  │  4. Return QR code + metadata                          │    │
│  │                                                         │    │
│  │  📄 generation-guide.md → Paramètres génération        │    │
│  │  📄 ai-parameters.md → Config AI                       │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                   SLASH COMMANDS                        │    │
│  │                                                         │    │
│  │  /generate-qr [data] [options]                          │    │
│  │  /analyze-qr [image-path]                               │    │
│  │  /batch-qr [data-file]                                  │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                      SCRIPTS                            │    │
│  │                                                         │    │
│  │  🐍 qr-generator.py       → Génération QR codes        │    │
│  │  🐍 qr-ai-processor.py    → Traitement IA              │    │
│  └────────────────────────────────────────────────────────┘    │
│                                                                 │
│  ┌────────────────────────────────────────────────────────┐    │
│  │                    MCP SERVER                           │    │
│  │                                                         │    │
│  │  Tools Exposés:                                         │    │
│  │  - generate_qr(data, options)                           │    │
│  │  - get_qr_data(qr_id)                                   │    │
│  │  - analyze_qr(image_data)                               │    │
│  │  - batch_generate(data_array)                           │    │
│  └────────────────────────────────────────────────────────┘    │
│                            ▼                                    │
│                   ┌─────────────────┐                          │
│                   │   CLOUD DB      │                          │
│                   │ (QR Codes Data) │                          │
│                   │                 │                          │
│                   │ - ID            │                          │
│                   │ - Data          │                          │
│                   │ - Metadata      │                          │
│                   │ - Created date  │                          │
│                   └─────────────────┘                          │
└─────────────────────────────────────────────────────────────────┘
```

### Workflow de Génération

```
INPUT: Data + Options
        │
        ▼
┌──────────────────┐
│ 1. Validate      │
│    Input Data    │
│                  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 2. AI Analysis   │
│    - Size optim  │
│    - Error corr  │
│    - Color scheme│
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 3. Generate      │
│    QR Code       │
│                  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 4. Store in DB   │
│    + Metadata    │
│                  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│ 5. Return        │
│    QR + ID       │
│                  │
└────────┬─────────┘
         │
         ▼
OUTPUT: QR Code Image + Metadata
```

### Métadonnées QR Code

```json
{
  "qr_id": "qr_abc123",
  "data": "https://supernovae.studio/product/123",
  "created_at": "2025-01-06T10:30:00Z",
  "options": {
    "error_correction": "H",
    "size": "300x300",
    "color": "#000000",
    "background": "#FFFFFF"
  },
  "ai_metadata": {
    "optimal_size": true,
    "readability_score": 0.98,
    "recommendations": ["Increase contrast", "Add quiet zone"]
  },
  "usage_stats": {
    "scans": 0,
    "last_scan": null
  }
}
```

---

## 🔄 Flux de Données

### Interaction entre les 3 Plugins (Indépendants)

```
┌────────────────────────────────────────────────────────────────────┐
│                         USER / CLAUDE                              │
└────────────────────────────────────────────────────────────────────┘
        │                        │                         │
        │                        │                         │
        ▼                        ▼                         ▼
┌──────────────┐       ┌──────────────┐        ┌──────────────┐
│    Plugin    │       │    Plugin    │        │    Plugin    │
│ Global Info  │       │  Traduction  │        │ QR Code AI   │
│              │       │              │        │              │
│ [Standalone] │       │ [Standalone] │        │ [Standalone] │
└──────┬───────┘       └──────┬───────┘        └──────┬───────┘
       │                      │                        │
       │ Expose               │ Consomme               │ Expose
       │ MCP Tools            │ MCP Tools              │ MCP Tools
       │                      │                        │
       ▼                      ▼                        ▼
┌──────────────┐       ┌──────────────┐        ┌──────────────┐
│ MCP Server   │◄──────│ MCP Client   │───────►│ MCP Server   │
│ Global Info  │       │              │        │ QR Code AI   │
└──────┬───────┘       └──────────────┘        └──────┬───────┘
       │                                               │
       ▼                                               ▼
┌──────────────┐                              ┌──────────────┐
│  Cloud DB    │                              │  Cloud DB    │
│ (174 Locales)│                              │  (QR Data)   │
└──────────────┘                              └──────────────┘
```

### Exemple de Workflow Complet

```
SCÉNARIO: Traduire une page web et générer QR codes pour 10 locales

┌─────────────────────────────────────────────────────────────────┐
│ ÉTAPE 1: User demande traduction multi-locale                  │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ ÉTAPE 2: Plugin Traduction récupère infos des 10 locales       │
│          via mcp__global_info__list_locales("target_list")     │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ ÉTAPE 3: Pour chaque locale:                                   │
│          - Get locale context via MCP Global Info               │
│          - Translate content                                    │
│          - Generate QR code via Plugin QR Code AI               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ ÉTAPE 4: QR Code AI génère 10 QR codes                         │
│          - Un par locale                                        │
│          - Stocke metadata dans Cloud DB                        │
│          - Retourne QR codes + IDs                              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ RÉSULTAT: 10 pages traduites + 10 QR codes                     │
│           Chaque QR code pointe vers page traduite              │
└─────────────────────────────────────────────────────────────────┘
```

---

## ⚙️ Configuration MCP

### MCP Servers Requis

```
┌─────────────────────────────────────────────────────────────────┐
│                       MCP ARCHITECTURE                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  MCP Server 1: Global Info                                      │
│  ┌───────────────────────────────────────────────────────┐     │
│  │ Name: global-info-server                              │     │
│  │ Transport: HTTP                                        │     │
│  │ Endpoint: https://api.supernovae.studio/mcp/locales   │     │
│  │ Auth: OAuth 2.0                                        │     │
│  │                                                        │     │
│  │ Tools:                                                 │     │
│  │ - get_locale(code: string)                            │     │
│  │ - list_locales(filter?: object)                       │     │
│  │ - update_locale(code: string, data: object)           │     │
│  │ - search_locales(query: string)                       │     │
│  │ - validate_locale_data(data: object)                  │     │
│  └───────────────────────────────────────────────────────┘     │
│                                                                 │
│  MCP Server 2: QR Code AI                                       │
│  ┌───────────────────────────────────────────────────────┐     │
│  │ Name: qr-code-ai-server                               │     │
│  │ Transport: HTTP                                        │     │
│  │ Endpoint: https://api.supernovae.studio/mcp/qrcodes   │     │
│  │ Auth: OAuth 2.0                                        │     │
│  │                                                        │     │
│  │ Tools:                                                 │     │
│  │ - generate_qr(data: string, options?: object)         │     │
│  │ - get_qr_data(qr_id: string)                          │     │
│  │ - analyze_qr(image_data: base64)                      │     │
│  │ - batch_generate(data_array: array)                   │     │
│  │ - update_qr_metadata(qr_id: string, metadata: object) │     │
│  └───────────────────────────────────────────────────────┘     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Configuration dans .claude/settings.json

```json
{
  "mcp": {
    "servers": {
      "global-info": {
        "transport": "http",
        "url": "https://api.supernovae.studio/mcp/locales",
        "auth": {
          "type": "oauth2",
          "clientId": "${GLOBAL_INFO_CLIENT_ID}",
          "clientSecret": "${GLOBAL_INFO_CLIENT_SECRET}"
        }
      },
      "qr-code-ai": {
        "transport": "http",
        "url": "https://api.supernovae.studio/mcp/qrcodes",
        "auth": {
          "type": "oauth2",
          "clientId": "${QR_CODE_CLIENT_ID}",
          "clientSecret": "${QR_CODE_CLIENT_SECRET}"
        }
      }
    }
  }
}
```

### Utilisation MCP dans Claude Code

```bash
# Lister les outils disponibles
/mcp

# Appeler un outil Global Info
/mcp__global_info__get_locale fr-FR

# Appeler un outil QR Code AI
/mcp__qr_code_ai__generate_qr "https://example.com"

# Dans slash command ou skill
mcp__global_info__list_locales('{"region": "Europe"}')
```

---

## 📊 Statistiques et Capacités

```
╔══════════════════════════════════════════════════════════════╗
║               SUPERNOVAE STUDIO CAPABILITIES                 ║
╠══════════════════════════════════════════════════════════════╣
║                                                              ║
║  📍 Locales Supportées        174                           ║
║  🌐 Langues Couvertes         ~80                           ║
║  🗺️  Régions                   195 pays                      ║
║                                                              ║
║  🔄 Traductions/heure         ~1000                          ║
║  📱 QR Codes/heure            ~500                           ║
║  💾 Stockage Cloud            Illimité                       ║
║                                                              ║
║  🔌 Plugins                   3 (indépendants)               ║
║  🎯 Slash Commands            12 total                       ║
║  🤖 Agent Skills              3 total                        ║
║  ⚙️  MCP Servers               2 total                        ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
```

---

## 🚀 Guide de Démarrage Rapide

### 1. Installation

```bash
# Dans votre projet
cd /path/to/your/project

# Démarrer Claude Code
claude

# Ajouter la marketplace
/plugin marketplace add ./supernovae-marketplace

# Installer les 3 plugins
/plugin install local-global-info@supernovae-studio
/plugin install plugin-traduction@supernovae-studio
/plugin install qr-code-ai@supernovae-studio
```

### 2. Configuration MCP

```bash
# Configurer les serveurs MCP
/mcp

# Authentifier Global Info
/mcp auth global-info

# Authentifier QR Code AI
/mcp auth qr-code-ai
```

### 3. Utilisation Basique

```bash
# Lister les locales disponibles
/list-locales

# Obtenir infos d'une locale
/get-locale fr-FR

# Traduire du texte
/translate "Hello World" en-US fr-FR

# Générer un QR code
/generate-qr "https://supernovae.studio"
```

---

## 📝 Notes Importantes

### Indépendance des Plugins

Les 3 plugins sont **totalement indépendants** :
- Peuvent être installés/désinstallés séparément
- Aucune dépendance directe entre eux
- Communication uniquement via MCP quand nécessaire

### Base de Données Cloud

- **Type :** Base de données cloud (Supabase/Firebase/MongoDB Atlas)
- **Accès :** Via MCP servers avec OAuth 2.0
- **Sécurité :** Credentials stockés en env variables
- **Backup :** Automatique quotidien

### Performance

- **Progressive Disclosure :** Seul le contexte nécessaire est chargé
- **Caching :** Données locales fréquentes cachées
- **Lazy Loading :** Scripts et fichiers chargés on-demand

---

## 🔐 Sécurité

```
┌──────────────────────────────────────────────────────────────┐
│                    SECURITY LAYERS                           │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│  Layer 1: Claude Code Permissions                           │
│  ├─ Allowlist outils                                        │
│  ├─ Sandbox mode (optionnel)                                │
│  └─ Deny rules pour fichiers sensibles                      │
│                                                              │
│  Layer 2: MCP Authentication                                │
│  ├─ OAuth 2.0 pour tous serveurs                            │
│  ├─ Credentials en variables d'environnement                │
│  └─ Token refresh automatique                               │
│                                                              │
│  Layer 3: API Rate Limiting                                 │
│  ├─ 1000 requêtes/heure par plugin                          │
│  ├─ Retry automatique avec backoff                          │
│  └─ Quota monitoring                                        │
│                                                              │
│  Layer 4: Data Validation                                   │
│  ├─ Validation schemas pour toutes inputs                   │
│  ├─ Sanitization automatique                                │
│  └─ Type checking strict                                    │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## 📚 Ressources Additionnelles

- **Repository :** `supernovae-marketplace/`
- **Documentation :** `CLAUDE_CODE_NEWS.md`
- **Support :** dev@supernovae.studio
- **Version :** 1.0.0

---

*Architecture créée pour Supernovae Studio - Janvier 2025*
