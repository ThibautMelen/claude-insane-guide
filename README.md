# 📚 Guide Claude Code - Maîtrise Complète

> **Formation progressive pour maîtriser Claude Code** - De débutant à expert

---

## 🎯 À Propos

Guide d'apprentissage complet sur **Claude Code** et l'écosystème Anthropic, organisé par **ordre pédagogique** pour une progression optimale.

**Public** : Développeurs francophones souhaitant maîtriser Claude Code.

**🆕 Nouveautés 2025** :
- Theme 10 : Interactive UI (AskUserQuestion)
- Patterns avancés multi-dialog
- Showcase production (Supernovae Studio)
- Updates Claude Sonnet 4.5

---

## 📖 Format d'Apprentissage

Chaque thème suit une structure identique :

```
📁 themes/X-nom-theme/
├── 📄 guide.md          → 📚 Théorie complète + use cases
└── 📄 cheatsheet.md     → ⚡ Référence rapide
```

---

## 🗺️ Parcours d'Apprentissage

### 📚 Ordre Pédagogique Recommandé

Suivez cet ordre pour une progression optimale :

```
1️⃣ MEMORY
   ↓ Base - Persistance des instructions
2️⃣ COMMANDS
   ↓ Automatisation - Prompts réutilisables
3️⃣ HOOKS
   ↓ Événements - Automatisation avancée
4️⃣ MCP
   ↓ Intégration - Protocole externe
5️⃣ SKILLS
   ↓ Capacités - Spécialisations
6️⃣ PLUGINS
   ↓ Empaquetage - Distribution
7️⃣ AGENTS
   ↓ Orchestration - Délégation tâches
8️⃣ WORKFLOWS
   ↓ Orchestration avancée - Pipelines
9️⃣ BEST PRACTICES
   ↓ Synthèse - Stratégies production
🔟 INTERACTIVE UI
   ↓ Dialogues - AskUserQuestion avancé
1️⃣1️⃣ VS CODE EXTENSION
   ↓ Extension - Intégration IDE
1️⃣2️⃣ STATUS LINE
   └─> Dashboard - Tracking temps réel

Pour Experts :
💪 ADVANCED PATTERNS → Multi-dialog & Decision Trees
🎯 SHOWCASE → Cas réels production
```

---

## 📁 Structure du Projet

```
claude-anthropic-comprhension/
┃
┣━━ 📁 themes/                  ⭐ PARCOURS COMPLET (ordre pédagogique)
┃   ┃
┃   ┣━━ 📁 1-memory/
┃   ┃   ├── 📄 guide.md         → Persistance instructions (.claude/CLAUDE.md)
┃   ┃   └── 📄 cheatsheet.md    → Référence rapide
┃   ┃
┃   ┣━━ 📁 2-commands/
┃   ┃   ├── 📄 guide.md         → Slash commands réutilisables
┃   ┃   └── 📄 cheatsheet.md    → Templates courants
┃   ┃
┃   ┣━━ 📁 3-hooks/
┃   ┃   ├── 📄 guide.md         → Gestionnaires d'événements système
┃   ┃   └── 📄 cheatsheet.md    → Hooks bloquants & patterns
┃   ┃
┃   ┣━━ 📁 4-mcp/
┃   ┃   ├── 📄 guide.md         → Model Context Protocol
┃   ┃   └── 📄 cheatsheet.md    → Serveurs populaires
┃   ┃
┃   ┣━━ 📁 5-skills/
┃   ┃   ├── 📄 guide.md         → Capacités spécialisées
┃   ┃   └── 📄 cheatsheet.md    → Structure skills
┃   ┃
┃   ┣━━ 📁 6-plugins/
┃   ┃   ├── 📄 guide.md         → Système d'extensibilité modulaire
┃   ┃   └── 📄 cheatsheet.md    → Marketplaces & distribution
┃   ┃
┃   ┣━━ 📁 7-agents/
┃   ┃   ├── 📄 guide.md         → Sub-agents & orchestration
┃   ┃   └── 📄 cheatsheet.md    → Agents built-in
┃   ┃
┃   ┣━━ 📁 8-workflows/
┃   ┃   ├── 📄 guide.md         → Pipelines automatisés
┃   ┃   └── 📄 cheatsheet.md    → Patterns orchestration
┃   ┃
┃   ┣━━ 📁 9-best-practices/
┃   ┃   ├── 📄 guide.md         → Stratégies production
┃   ┃   └── 📄 cheatsheet.md    → DO/DON'T essentiels
┃   ┃
┃   ┣━━ 📁 10-interactive-ui/   🆕
┃   ┃   ├── 📄 guide.md         → AskUserQuestion avancé
┃   ┃   └── 📄 cheatsheet.md    → Patterns dialogues
┃   ┃
┃   ┣━━ 📁 11-vs-code-extension/
┃   ┃   └── 📄 guide.md         → Extension VS Code
┃   ┃
┃   ┗━━ 📁 12-statusline/       🆕
┃       ├── 📄 guide.md         → Dashboard temps réel
┃       └── 📄 cheatsheet.md    → Templates & config
┃
┣━━ 📁 advanced/                💪 Patterns experts 🆕
┃   ├── 📄 multi-dialog-patterns.md → Decision trees complexes
┃   └── 📁 examples/
┃
┣━━ 📁 showcase/                🎯 Cas réels production 🆕
┃   └── 📁 supernovae-studio/
┃       ├── 📄 README.md        → Vue d'ensemble
┃       ├── 📄 architecture.md  → Architecture technique
┃       └── 📄 quick-start.md   → Setup rapide
┃
┣━━ 📁 ressources/              📹📄 Vidéos & articles
┃   ┣━━ 📁 videos/
┃   ┃   ├── terminal-ai-workflow.md
┃   ┃   ├── skills-vs-mcp-vs-subagents.md
┃   ┃   └── 800h-claude-code-edmund-yong.md
┃   └── 📁 articles/            🆕 Articles techniques
┃
┣━━ 📁 .claude/                 ⚙️ Configuration projet
┃   ├── 📄 CLAUDE.md            → Memory & règles projet
┃   └── 📁 commands/
┃
┣━━ 📄 README.md                📚 Ce fichier
┣━━ 📄 STATUS.md                ⚠️ État de la documentation
┣━━ 📄 QUICK_START.md           🚀 Guide démarrage rapide 🆕
┗━━ 📄 ressources.md            🔗 Index ressources
```

---

## 🚀 Quick Start

### 1️⃣ Commencer Par Memory

Le **foundation** de tout projet Claude Code :

```bash
# Lire le guide
cat themes/1-memory/guide.md

# Référence rapide
cat themes/1-memory/cheatsheet.md

# Premier guide
cat themes/1-memory/guide.md
```

**Pourquoi commencer ici ?** Memory (.claude/CLAUDE.md) est la base pour persister vos préférences et instructions.

### 2️⃣ Suivre le Parcours Pédagogique

Progressez thème par thème dans l'ordre numéroté :

```
1-memory → 2-commands → 3-hooks → ... → 9-best-practices
```

Chaque thème **s'appuie sur les précédents**.

### 3️⃣ Pratiquer

Lisez les **guides** pour comprendre les concepts, puis utilisez les **cheatsheets** comme référence rapide.

Chaque thème contient :
- 📚 **Guide complet** : Théorie + exemples concrets
- ⚡ **Cheatsheet** : Référence rapide pour usage quotidien

---

## 📚 Thèmes du Parcours

| # | Thème | Description |
|---|-------|-------------|
| 1 | memory | Persistance instructions (.claude/CLAUDE.md) |
| 2 | commands | Slash commands réutilisables |
| 3 | hooks | Gestionnaires d'événements système |
| 4 | mcp | Model Context Protocol |
| 5 | skills | Capacités spécialisées |
| 6 | plugins | Système d'extensibilité modulaire |
| 7 | agents | Sub-agents & orchestration |
| 8 | workflows | Pipelines automatisés |
| 9 | best-practices | Stratégies production |
| 10 | interactive-ui | AskUserQuestion avancé |
| 11 | vs-code-extension | Extension VS Code |
| 12 | statusline | Dashboard temps réel |


---

## 📚 Ressources Complémentaires

### 📄 Documentation Officielle

- 📄 [Claude Code Docs](https://code.claude.com/docs)
- 📄 [Memory](https://code.claude.com/docs/en/memory)
- 📄 [Commands](https://code.claude.com/docs/en/slash-commands)
- 📄 [Hooks](https://code.claude.com/docs/en/hooks)
- 📄 [MCP Protocol](https://modelcontextprotocol.io/)
- 📄 [Plugins](https://code.claude.com/docs/en/plugins)

### 🎥 Vidéos Analysées

Voir [ressources/videos/](./ressources/videos/) pour fiches complètes.

- 🎥 **NetworkChuck** - Terminal AI Workflow (33 min)
- 🎥 **Solo Swift Crafter** - Skills vs MCP vs Subagents (9 min)
- 🎥 **Edmund Yong** - 800h Claude Code (27 oct 2025)

### 📄 Articles Techniques 🆕

Voir [ressources/articles/](./ressources/articles/) pour fiches complètes.

- *À venir* - Documentation officielle
- *À venir* - Best practices communauté
- *À venir* - Guides techniques avancés

### 🔗 Repos Communautaires

- 🔗 [Weston Hobson Commands](https://github.com/wshobson/commands)
- 🔗 [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code)
- 🔗 [Awesome Sub-Agents](https://github.com/VoltAgent/awesome-claude-code-subagents)

---

## 🎓 Philosophie du Projet

### Principes d'Apprentissage

1. **📖 Progressivité** : Du débutant à l'expert, pas de raccourcis
2. **💡 Pratique** : Exemples concrets, pas que théorie
3. **🎨 Visuel** : Schémas ASCII, emojis, clarté maximale
4. **🇫🇷 Accessibilité** : Français clair, exemples du quotidien
5. **📚 Complétude** : Tous les aspects de Claude Code couverts
6. **🔄 Maintenu** : À jour avec dernières versions

### Quote Inspirante

> "D.R.Y. (Don't Repeat Yourself) - Let Claude remember your preferences"
>
> — Edmund Yong (800h Claude Code)

---

## ⚠️ Statut de la Documentation

Voir [STATUS.md](./STATUS.md) pour :
- ✅ Sections à jour
- ⚠️ Features deprecated
- 🔄 Changelog complet

---

## 🤝 Contribution

Ce projet est personnel mais open source pour la communauté francophone.

**Suggestions ?** Ouvrez une issue ou PR !

---

## 📝 License

MIT License - Libre d'utilisation et modification.

---

**🚀 Bonne formation !** Commencez par [themes/1-memory/guide.md](./themes/1-memory/guide.md) 🎓
