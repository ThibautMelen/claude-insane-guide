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
├── 📄 cheatsheet.md     → ⚡ Référence rapide
└── 📁 exercices/        → ✏️ Pratique progressive
    ├── niveau-1.md      → 🟢 Découverte (10-15 min)
    ├── niveau-2.md      → 🟡 Utilisation (15-20 min)
    ├── niveau-3.md      → 🟠 Maîtrise (20-25 min)
    └── niveau-4.md      → 🔴 Expert (25-30 min) [thèmes principaux]
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
   └─> Dialogues - AskUserQuestion avancé

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
┃   ┣━━ 📁 1-memory/            🟢🟡🟠🔴 [4 niveaux - 60 min]
┃   ┃   ├── 📄 guide.md         → Persistance instructions (.claude/CLAUDE.md)
┃   ┃   ├── 📄 cheatsheet.md    → Référence rapide
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┣━━ 📁 2-commands/          🟢🟡🟠🔴 [4 niveaux - 90 min]
┃   ┃   ├── 📄 guide.md         → Slash commands réutilisables
┃   ┃   ├── 📄 cheatsheet.md    → Templates courants
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┣━━ 📁 3-hooks/             🟢🟡🟠 [3 niveaux - 60 min]
┃   ┃   ├── 📄 guide.md         → Gestionnaires d'événements système
┃   ┃   ├── 📄 cheatsheet.md    → Hooks bloquants & patterns
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┣━━ 📁 4-mcp/               🟢🟡🟠🔴 [4 niveaux - 90 min]
┃   ┃   ├── 📄 guide.md         → Model Context Protocol
┃   ┃   ├── 📄 cheatsheet.md    → Serveurs populaires
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┣━━ 📁 5-skills/            🟢🟡🟠 [3 niveaux - 60 min]
┃   ┃   ├── 📄 guide.md         → Capacités spécialisées
┃   ┃   ├── 📄 cheatsheet.md    → Structure skills
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┣━━ 📁 6-plugins/           🟢🟡🟠 [3 niveaux - 90 min]
┃   ┃   ├── 📄 guide.md         → Système d'extensibilité modulaire
┃   ┃   ├── 📄 cheatsheet.md    → Marketplaces & distribution
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┣━━ 📁 7-agents/            🟢🟡 [2 niveaux - 45 min]
┃   ┃   ├── 📄 guide.md         → Sub-agents & orchestration
┃   ┃   ├── 📄 cheatsheet.md    → Agents built-in
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┣━━ 📁 8-workflows/         🟢🟡 [2 niveaux - 45 min]
┃   ┃   ├── 📄 guide.md         → Pipelines automatisés
┃   ┃   ├── 📄 cheatsheet.md    → Patterns orchestration
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┣━━ 📁 9-best-practices/    🟢🟡🟠 [3 cas - 60 min]
┃   ┃   ├── 📄 guide.md         → Stratégies production
┃   ┃   ├── 📄 cheatsheet.md    → DO/DON'T essentiels
┃   ┃   └── 📁 exercices/
┃   ┃
┃   ┗━━ 📁 10-interactive-ui/   🟢🟡🟠🔴 [4 niveaux - 90 min] 🆕
┃       ├── 📄 guide.md         → AskUserQuestion avancé
┃       ├── 📄 cheatsheet.md    → Patterns dialogues
┃       └── 📁 exercices/
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
┣━━ 📁 ressources/              📹 Vidéos & ressources
┃   └── 📁 videos/
┃       ├── terminal-ai-workflow.md
┃       ├── skills-vs-mcp-vs-subagents.md
┃       └── 800h-claude-code-edmund-yong.md
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

# Premiers exercices
cat themes/1-memory/exercices/niveau-1.md
```

**Pourquoi commencer ici ?** Memory (.claude/CLAUDE.md) est la base pour persister vos préférences et instructions.

### 2️⃣ Suivre le Parcours Pédagogique

Progressez thème par thème dans l'ordre numéroté :

```
1-memory → 2-commands → 3-hooks → ... → 9-best-practices
```

Chaque thème **s'appuie sur les précédents**.

### 3️⃣ Pratiquer avec les Exercices

Chaque niveau d'exercice est **progressif** :
- 🟢 **Niveau 1** : Découverte du concept
- 🟡 **Niveau 2** : Utilisation pratique
- 🟠 **Niveau 3** : Maîtrise avancée
- 🔴 **Niveau 4** : Expert (thèmes principaux)

---

## ⏱️ Temps Total Estimé

| Thème | Niveaux | Temps Total |
|-------|---------|-------------|
| 1-memory | 🟢🟡🟠🔴 | 60 min |
| 2-commands | 🟢🟡🟠🔴 | 90 min |
| 3-hooks | 🟢🟡🟠 | 60 min |
| 4-mcp | 🟢🟡🟠🔴 | 90 min |
| 5-skills | 🟢🟡🟠 | 60 min |
| 6-plugins | 🟢🟡🟠 | 90 min |
| 7-agents | 🟢🟡 | 45 min |
| 8-workflows | 🟢🟡 | 45 min |
| 9-best-practices | 🟢🟡🟠 | 60 min |
| 10-interactive-ui | 🟢🟡🟠🔴 | 90 min |

**Total Formation** : **~12 heures** (théorie + pratique)

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

Voir [ressources.md](./ressources.md) pour liste complète avec timestamps.

- 🎥 **NetworkChuck** - Terminal AI Workflow (33 min)
- 🎥 **Solo Swift Crafter** - Skills vs MCP vs Subagents (9 min)
- 🎥 **Edmund Yong** - 800h Claude Code (27 oct 2025)

### 🔗 Repos Communautaires

- 🔗 [Weston Hobson Commands](https://github.com/wshobson/commands)
- 🔗 [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code)
- 🔗 [Awesome Sub-Agents](https://github.com/VoltAgent/awesome-claude-code-subagents)

---

## 🎓 Philosophie du Projet

### Principes d'Apprentissage

1. **📖 Progressivité** : Du débutant à l'expert, pas de raccourcis
2. **💡 Pratique** : Exercices concrets, pas que théorie
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
