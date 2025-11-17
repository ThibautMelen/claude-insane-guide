# 🆕 VS Code Extension Claude Code (Beta 2025)

> **Durée de lecture** : 30 minutes
> **Niveau** : 🟢 Débutant à 🟡 Intermédiaire
> **Prérequis** : VS Code installé

## 📘 Table des Matières

1. [Introduction](#-introduction)
2. [Installation](#-installation)
3. [Interface](#-interface)
4. [Features](#-features)
5. [Configuration](#-configuration)
6. [Terminal vs Extension](#-terminal-vs-extension)
7. [Migration](#-migration)
8. [Workflows](#-workflows)
9. [Troubleshooting](#-troubleshooting)
10. [Points Clés](#-points-clés)

---

## 🎯 Introduction

### Qu'est-ce que l'Extension VS Code ?

L'**extension VS Code Claude Code** est une **alternative graphique** au terminal, offrant la même puissance Claude directement dans votre IDE préféré.

```
╔═══════════════════════════════════════════╗
║     VS CODE EXTENSION ARCHITECTURE         ║
╚═══════════════════════════════════════════╝

┌─── VS CODE ────────────────────────────────┐
│                                            │
│  ┌──────────────┐    ┌──────────────┐     │
│  │   EDITOR     │    │   SIDEBAR    │     │
│  │              │◄───►│              │     │
│  │  Your Code   │    │  Claude Chat │     │
│  │              │    │              │     │
│  └──────────────┘    └──────┬───────┘     │
│                              │             │
│  ┌──────────────┐    ┌──────▼───────┐     │
│  │   TERMINAL   │    │   CLAUDE     │     │
│  │   (Optional) │    │   ENGINE     │     │
│  └──────────────┘    └──────────────┘     │
└────────────────────────────────────────────┘
```

### Pourquoi Utiliser l'Extension ?

**Avantages** :
- 🎨 **Interface graphique** intuitive
- 🔄 **Intégration native** VS Code
- 📍 **Context-aware** : voit votre code sélectionné
- ⚡ **Raccourcis clavier** personnalisables
- 🖱️ **Click-to-apply** pour suggestions
- 📊 **Visualisation** des changements

**Pour qui ?** :
- Développeurs préférant les GUI
- Nouveaux utilisateurs Claude Code
- Teams non-techniques
- Workflows visuels

---

## 🔧 Installation

### Méthode 1 : VS Code Marketplace

```bash
# 1. Ouvrir VS Code
code .

# 2. Ouvrir Command Palette
Cmd+Shift+P (Mac) / Ctrl+Shift+P (Windows/Linux)

# 3. Rechercher
> Extensions: Install Extensions

# 4. Chercher
"Claude Code"

# 5. Installer
Click "Install" sur "Claude Code" par Anthropic
```

### Méthode 2 : Installation CLI

```bash
# Via code CLI
code --install-extension anthropic.claude-code

# Vérifier installation
code --list-extensions | grep claude
```

### Méthode 3 : VSIX Manual

```bash
# Télécharger VSIX depuis GitHub
wget https://github.com/anthropics/claude-code-vscode/releases/latest/claude-code.vsix

# Installer
code --install-extension claude-code.vsix
```

### Configuration Initiale

```
╔═══════════════════════════════════════════╗
║         FIRST LAUNCH WIZARD                ║
╚═══════════════════════════════════════════╝

1. Authentication
   ├── Claude.ai account (recommended)
   └── API Key (alternative)

2. Model Selection
   ├── Claude 3.5 Sonnet (default)
   ├── Claude 3 Opus (complex tasks)
   └── Claude 3 Haiku (fast)

3. Preferences
   ├── Auto-save: Yes/No
   ├── Thinking mode: On/Off
   └── Theme: Light/Dark/Auto
```

---

## 🖼️ Interface

### Layout Principal

```
┌────────────────────────────────────────────┐
│  VS CODE WITH CLAUDE EXTENSION             │
├────────────────┬───────────────────────────┤
│                │                           │
│   EXPLORER     │      EDITOR AREA          │
│                │                           │
│  📁 Project    │   your-code.js           │
│   ├── src/     │                           │
│   ├── tests/   │   function getData() {    │
│   └── docs/    │     // Your code here     │
│                │   }                       │
├────────────────┤                           │
│                │                           │
│  CLAUDE CHAT   │                           │
│                │                           │
│  💬 Assistant  │                           │
│  > How can I   │                           │
│    help?       │                           │
│                │                           │
│  [Type message]│                           │
│                │                           │
├────────────────┴───────────────────────────┤
│  TERMINAL         OUTPUT        PROBLEMS   │
└────────────────────────────────────────────┘
```

### Composants Principaux

#### 1. Claude Sidebar

```
╔═══════════════════════════════════════════╗
║           CLAUDE SIDEBAR                   ║
╠═══════════════════════════════════════════╣
║  🤖 Claude Assistant                       ║
║  ─────────────────────────                 ║
║                                            ║
║  [New Chat] [History] [Settings]          ║
║                                            ║
║  ┌────────────────────────────┐           ║
║  │ Conversation Area          │           ║
║  │                             │           ║
║  │ User: Fix the bug in line 42│          ║
║  │                             │           ║
║  │ Claude: I found the issue...│           ║
║  │ [View Diff] [Apply Changes] │           ║
║  └────────────────────────────┘           ║
║                                            ║
║  ┌────────────────────────────┐           ║
║  │ 💬 Type your message...     │           ║
║  └────────────────────────────┘           ║
║  [Send] [Attach] [Commands]               ║
╚═══════════════════════════════════════════╝
```

#### 2. Inline Suggestions

```javascript
// Votre code avec suggestions Claude

function processData(data) {
  // Claude suggère ici
  ├── 🤖 Add input validation     [Accept]
  ├── 🤖 Handle edge cases         [Accept]
  └── 🤖 Add error handling        [Accept]

  return data;
}
```

#### 3. Command Palette Integration

```
Cmd+Shift+P → Claude Commands

> Claude: Ask Question
> Claude: Review Code
> Claude: Generate Tests
> Claude: Explain Selection
> Claude: Refactor
> Claude: Fix Errors
> Claude: Create Documentation
```

---

## ✨ Features

### 1. Context-Aware Assistance

**Sélection de Code** :
```javascript
// Sélectionnez ce code
const data = fetchData();
processData(data);

// Claude voit automatiquement :
// - Le code sélectionné
// - Le fichier entier
// - Les fichiers liés
// - L'historique Git
```

### 2. Visual Diff Integration

```
╔═══════════════════════════════════════════╗
║          VISUAL DIFF VIEW                  ║
╠═══════════════════════════════════════════╣
║  BEFORE           │  AFTER (Claude)        ║
║  ─────────────────┼─────────────────       ║
║  function old() { │  function improved() { ║
║    return data;   │    validate(data);    ║
║  }                │    return process();  ║
║                   │  }                    ║
║  ─────────────────┴─────────────────       ║
║  [Accept All] [Accept Selection] [Reject]  ║
╚═══════════════════════════════════════════╝
```

### 3. Smart Commands

**Raccourcis Principaux** :

| Commande | Raccourci | Action |
|----------|-----------|--------|
| Ask Claude | `Cmd+K Cmd+A` | Ouvrir chat |
| Review Selection | `Cmd+K Cmd+R` | Review code sélectionné |
| Generate Tests | `Cmd+K Cmd+T` | Créer tests |
| Fix Errors | `Cmd+K Cmd+F` | Corriger erreurs |
| Explain | `Cmd+K Cmd+E` | Expliquer sélection |

### 4. Slash Commands Support

```
Dans le chat Claude :

/commit     → Créer commit message
/review     → Review complet
/test       → Générer tests
/docs       → Créer documentation
/refactor   → Refactorer code
```

### 5. File Tree Integration

```
Clic droit sur fichier/dossier :

📁 src/
  └── 📄 component.js  [Right Click]
      ├── Claude: Review this file
      ├── Claude: Generate tests
      ├── Claude: Add documentation
      └── Claude: Find issues
```

---

## ⚙️ Configuration

### Settings.json

```json
{
  // Claude Extension Settings
  "claude.apiKey": "sk-ant-...",
  "claude.model": "claude-3-5-sonnet",
  "claude.autoSave": true,
  "claude.thinkingMode": false,

  // UI Preferences
  "claude.sidebar.position": "right",
  "claude.sidebar.width": 400,
  "claude.theme": "auto",

  // Behavior
  "claude.autoComplete": true,
  "claude.contextWindow": 200000,
  "claude.maxTokens": 4096,

  // Features
  "claude.inlineSuggestions": true,
  "claude.autoReview": false,
  "claude.gitIntegration": true,

  // Shortcuts (customize)
  "claude.keybindings": {
    "openChat": "cmd+k cmd+a",
    "reviewCode": "cmd+k cmd+r",
    "generateTests": "cmd+k cmd+t"
  }
}
```

### Workspace Settings

```json
// .vscode/settings.json (projet)
{
  "claude.projectContext": {
    "language": "typescript",
    "framework": "react",
    "testingLibrary": "jest",
    "styleGuide": "airbnb"
  },

  "claude.ignorePaths": [
    "**/node_modules/**",
    "**/dist/**",
    "**/.git/**"
  ],

  "claude.customPrompts": {
    "review": "Focus on security and performance",
    "test": "Use React Testing Library",
    "docs": "Generate JSDoc format"
  }
}
```

---

## 🔄 Terminal vs Extension

### Tableau Comparatif

```
┌─────────────────┬─────────────┬──────────────┐
│   Feature       │  Terminal   │  Extension   │
├─────────────────┼─────────────┼──────────────┤
│ Interface       │ CLI Text    │ GUI Visual   │
│ Learning Curve  │ Steep       │ Gentle       │
│ Speed           │ Fastest     │ Fast         │
│ Automation      │ Excellent   │ Good         │
│ Visual Feedback │ Limited     │ Rich         │
│ Context Aware   │ Manual      │ Automatic    │
│ Customization   │ Maximum     │ High         │
│ CI/CD Ready     │ Yes         │ Limited      │
│ Team Friendly   │ Dev Only    │ All Levels   │
│ Offline Mode    │ Partial     │ No           │
└─────────────────┴─────────────┴──────────────┘
```

### Quand Utiliser Quoi ?

**Terminal Claude** ✅ :
```bash
# Automation & CI/CD
claude -p "Run tests and deploy if passing"

# Batch operations
find . -name "*.js" | xargs claude -p "Add JSDoc"

# Scriptable workflows
./deploy.sh | claude -p "Analyze output"
```

**VS Code Extension** ✅ :
```
• Development interactif
• Review visuel de code
• Collaboration en équipe
• Apprentissage Claude Code
• Prototyping rapide
```

---

## 🚀 Migration depuis Terminal

### Guide de Migration

```bash
# 1. Exporter configuration Terminal
claude config export > claude-config.json

# 2. Importer dans Extension
# VS Code: Cmd+Shift+P
> Claude: Import Configuration

# 3. Migrer .claude/ files
cp -r .claude/ .vscode/claude/

# 4. Adapter settings
cat > .vscode/settings.json << 'EOF'
{
  "claude.projectMemory": ".vscode/claude/CLAUDE.md",
  "claude.commands": ".vscode/claude/commands/",
  "claude.agents": ".vscode/claude/agents/"
}
EOF
```

### Maintenir les Deux

```json
// Hybrid setup
{
  "claude.sync": {
    "enabled": true,
    "source": "terminal",  // or "extension"
    "bidirectional": true,
    "exclude": ["*.log", "temp/"]
  }
}
```

---

## 📊 Workflows Types

### Workflow 1 : Development Flow

```
1. CODE
   └─> Écrire code dans editor

2. SELECT
   └─> Sélectionner portion problématique

3. ASK CLAUDE
   └─> Cmd+K Cmd+A : "Optimize this"

4. REVIEW DIFF
   └─> Voir suggestions visuelles

5. APPLY
   └─> Click "Apply Changes"

6. TEST
   └─> Run tests automatiquement
```

### Workflow 2 : Debug Flow

```
1. ERROR APPEARS
   └─> Erreur dans Problems panel

2. CLICK ERROR
   └─> Navigate to problematic code

3. CLAUDE FIX
   └─> Cmd+K Cmd+F : Auto-fix

4. PREVIEW
   └─> Voir correction proposée

5. ACCEPT/MODIFY
   └─> Appliquer ou ajuster

6. VERIFY
   └─> Tests passent ✅
```

### Workflow 3 : Documentation Flow

```
1. SELECT FUNCTION/CLASS
   └─> Highlight code to document

2. GENERATE DOCS
   └─> Right-click → "Claude: Add Docs"

3. CUSTOMIZE
   └─> Ajuster format/contenu

4. INSERT
   └─> Auto-insert above code

5. COMMIT
   └─> Git commit avec message auto
```

---

## 🔧 Troubleshooting

### Problèmes Courants

#### Extension ne se charge pas

```bash
# Vérifier installation
code --list-extensions | grep claude

# Réinstaller
code --uninstall-extension anthropic.claude-code
code --install-extension anthropic.claude-code

# Clear cache
rm -rf ~/.vscode/extensions/anthropic.claude-code*
```

#### Pas de connexion API

```javascript
// Check settings.json
{
  "claude.apiKey": "sk-ant-...", // Vérifier
  "claude.apiEndpoint": "https://api.anthropic.com", // Default
  "claude.timeout": 30000 // Augmenter si nécessaire
}
```

#### Performance lente

```json
// Optimiser settings
{
  "claude.contextWindow": 100000,  // Réduire
  "claude.maxConcurrent": 1,       // Limiter
  "claude.cacheResponses": true,   // Activer
  "claude.debounceDelay": 500      // Augmenter
}
```

#### Conflits de raccourcis

```json
// Désactiver conflits
{
  "keyboard.dispatch": "keyCode",

  // Ou redéfinir
  "claude.keybindings": {
    "openChat": "alt+c alt+c",
    "reviewCode": "alt+c alt+r"
  }
}
```

### Logs et Debug

```bash
# Voir logs extension
Cmd+Shift+P → "Developer: Show Logs"
→ Extension Host → Filter: Claude

# Mode debug
"claude.debug": true,
"claude.verboseLogging": true

# Export logs
code --log-level=debug 2> claude-debug.log
```

---

## 🎓 Points Clés

### Concepts Essentiels

✅ **GUI-First** : Interface visuelle intuitive
✅ **IDE Integration** : Native dans VS Code workflow
✅ **Visual Feedback** : Diffs et previews visuels
✅ **Context-Aware** : Comprend votre projet automatiquement
✅ **Hybrid Possible** : Terminal + Extension ensemble

### Best Practices

1. **Commencer Simple** : Chat sidebar basique
2. **Explorer Features** : Une à la fois
3. **Personnaliser** : Adapter settings au projet
4. **Raccourcis** : Apprendre les essentiels
5. **Combiner** : Extension + Terminal selon besoins

### Avantages/Limitations

**Avantages** ✅ :
- Courbe apprentissage douce
- Feedback visuel riche
- Intégration IDE parfaite
- Accessible non-devs
- Collaboration facilitée

**Limitations** ❌ :
- Moins scriptable que CLI
- Dépendance VS Code
- Pas optimal pour CI/CD
- Consomme plus ressources
- Online uniquement

---

## 📚 Ressources

- 📄 [VS Code Extension Docs](https://code.claude.com/docs/en/vs-code)
- 📹 [Video: VS Code Extension Tutorial](https://youtube.com/watch?v=...)
- 🔗 [GitHub: Extension Source](https://github.com/anthropics/claude-code-vscode)
- 💬 [Discord: #vscode-extension](https://discord.gg/claude-code)

---

## Conclusion

L'**extension VS Code** démocratise Claude Code en offrant une **interface graphique** intuitive, parfaite pour :
- 🎓 **Apprentissage** progressif
- 👥 **Collaboration** en équipe
- 🎨 **Workflows** visuels
- ⚡ **Productivité** immédiate

**Recommandation** : Commencer avec l'extension pour apprendre, puis explorer le terminal pour l'automation avancée.

---

**Prochaine étape** → [TROUBLESHOOTING.md](../../TROUBLESHOOTING.md) | [Retour Thèmes](../README.md)