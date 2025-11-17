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
🎯 PARCOURS DÉBUTANT (8-10 heures)
1️⃣ MEMORY
   ↓ Base - Persistance des instructions
2️⃣ COMMANDS
   ↓ Automatisation - Prompts réutilisables
3️⃣ HOOKS
   ↓ Événements - Automatisation lifecycle
4️⃣ SKILLS
   ↓ Capacités - Connaissances spécialisées
5️⃣ AGENTS
   ↓ Orchestration - Délégation tâches isolées
6️⃣ PLUGINS
   ↓ Empaquetage - Extensions modulaires
7️⃣ MCP
   └─> Intégration - Protocol externe

🚀 PARCOURS INTERMÉDIAIRE → EXPERT (6-8 heures)
WORKFLOW-PATTERN-ORCHESTRATION
   ├─> Workflows (EPCT, Parallel, Sequential, Hybrid)
   ├─> Patterns (Command coordination, Hooks automation)
   └─> Best Practices (Performance, Cost, Resilience)

💪 PARCOURS EXPERT (4-6 heures)
PATTERNS & ADVANCED
   ├─> Patterns (Orchestration réutilisables)
   └─> Advanced (Multi-dialog, Enterprise, AI orchestration)

🔧 OPTIONNEL
ADD-ONS
   ├─> VS Code Extension
   └─> Statusline Dashboard
```

---

## 📁 Structure du Projet

```
claude-anthropic-comprhension/
┃
┣━━ 📁 themes/                  🎯 FEATURES CORE (1-7 uniquement)
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
┃   ┣━━ 📁 4-skills/
┃   ┃   ├── 📄 guide.md         → Capacités spécialisées
┃   ┃   └── 📄 cheatsheet.md    → Structure skills
┃   ┃
┃   ┣━━ 📁 5-agents/
┃   ┃   ├── 📄 guide.md         → Sub-agents & orchestration
┃   ┃   └── 📄 cheatsheet.md    → Agents built-in
┃   ┃
┃   ┣━━ 📁 6-plugins/
┃   ┃   ├── 📄 guide.md         → Système d'extensibilité modulaire
┃   ┃   └── 📄 cheatsheet.md    → Marketplaces & distribution
┃   ┃
┃   ┗━━ 📁 7-mcp/
┃       ├── 📄 guide.md         → Model Context Protocol
┃       └── 📄 cheatsheet.md    → Serveurs populaires
┃
┣━━ 📁 workflow-pattern-orchestration/  🚀 ORCHESTRATION AVANCÉE
┃   ┣━━ 📁 workflows/           → EPCT, Parallel, Sequential, Hybrid
┃   ┣━━ 📁 patterns/            → Coordination commands, hooks automation
┃   ┣━━ 📁 best-practices/      → Performance, Cost, Resilience
┃   └── 📄 README.md            → Navigation orchestration
┃
┣━━ 📁 patterns/                🏗️ PATTERNS RÉUTILISABLES
┃   ├── 📄 command-agent-skill.md → Hierarchical orchestration
┃   ├── 📄 error-handling.md    → Fallback chains & recovery
┃   ├── 📄 parallel-execution.md → Concurrent agents (5-10x speedup)
┃   ├── 📄 state-management.md  → Context persistence
┃   └── 📄 README.md            → Navigation patterns
┃
┣━━ 📁 advanced/                💪 GUIDES EXPERT
┃   ├── 📄 multi-dialog-patterns.md → Sequential, Conditional, Parallel dialogs
┃   ├── 📄 interactive-ui.md    → AskUserQuestion workflows complexes 🆕
┃   ├── 📄 enterprise-patterns.md → Governance, RBAC, Compliance
┃   ├── 📄 ai-orchestration.md  → Multi-LLM routing (70-85% cost savings)
┃   ├── 📄 decision-trees.md    → Framework sélection features
┃   └── 📄 README.md            → Navigation advanced
┃
┣━━ 📁 add-ons/                 🔧 EXTENSIONS OPTIONNELLES
┃   ┣━━ 📁 vs-code-extension/
┃   ┃   └── 📄 guide.md         → Extension VS Code
┃   ┗━━ 📁 statusline/
┃       ├── 📄 guide.md         → Dashboard temps réel
┃       └── 📄 cheatsheet.md    → Templates & config
┃
┣━━ 📁 ressources/              📹📄 Vidéos & articles
┃   ┣━━ 📁 videos/
┃   ┃   ├── terminal-ai-workflow.md
┃   ┃   ├── skills-vs-mcp-vs-subagents.md
┃   ┃   └── 800h-claude-code-edmund-yong.md
┃   └── 📁 articles/
┃
┣━━ 📁 .claude/                 ⚙️ Configuration projet
┃   ├── 📄 CLAUDE.md            → Memory & règles projet
┃   └── 📁 commands/
┃
┣━━ 📄 README.md                📚 Ce fichier
┣━━ 📄 STATUS.md                ⚠️ État de la documentation
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

## 🗺️ Navigation

### 🎯 Themes Core (Features Essentielles - 1 à 7)

**Ordre pédagogique optimal** :

1. [Memory](themes/1-memory/guide.md) - Mémoire persistante (.claude/CLAUDE.md)
2. [Commands](themes/2-commands/guide.md) - Commandes slash automatisées
3. [Hooks](themes/3-hooks/guide.md) - Automation lifecycle events
4. [Skills](themes/4-skills/guide.md) - Capacités spécialisées auto-activées
5. [Agents](themes/5-agents/guide.md) - Sub-agents pour travail isolé
6. [Plugins](themes/6-plugins/guide.md) - Extensions modulaires combinées
7. [MCP](themes/7-mcp/guide.md) - Model Context Protocol integration

**🎓 Parcours débutant** : Maîtrise 1-7 (~8-10 heures)

---

### 🚀 Orchestration Avancée

#### [Workflow-Pattern-Orchestration](workflow-pattern-orchestration/README.md)
**Coordination intelligente de Memory + Commands + Hooks + Skills + Agents + Plugins**

**Contenu** :
- 📋 [Workflows](workflow-pattern-orchestration/workflows/README.md) - EPCT, Parallel, Sequential, Conditional, Hybrid
- 🏗️ [Patterns](workflow-pattern-orchestration/patterns/README.md) - Command coordination, Hook automation, Agent orchestration
- ⚡ [Best Practices](workflow-pattern-orchestration/best-practices/README.md) - Performance, Cost, Resilience, Team collaboration

**Exemples production** :
- 174 locales generation (8.3x speedup)
- PR review automation (4 parallel agents)
- Documentation generator (Skills + MCP)
- Monorepo setup wizard (20+ decision branches)

**🆕 Workflows Startup** (Production-Ready) :
- 📝 [Blog Automation](workflow-pattern-orchestration/workflows/blog-automation-startup.md) - Pipeline complet création/publication (96% time reduction)
- 🌍 [Multi-Language Content](workflow-pattern-orchestration/workflows/multi-language-content-startup.md) - 13-15 langues simultanées (99% time reduction)
- 📱 [Social Media Automation](workflow-pattern-orchestration/workflows/social-media-automation-startup.md) - 5 plateformes multi-posts (86% time reduction)
- 👥 [Community Management](workflow-pattern-orchestration/workflows/community-management-startup.md) - Monitoring + auto-réponse (76% time reduction)
- ♻️ [Content Repurposing](workflow-pattern-orchestration/workflows/content-repurposing-startup.md) - 1 contenu → 10+ formats (92% time reduction)

**Validation** : ✅ [Rapport de validation complet](workflow-pattern-orchestration/VALIDATION_REPORT.md) (100% conforme docs Anthropic)

**🎓 Parcours intermédiaire → expert** (~6-8 heures)

---

### 🎓 Patterns & Advanced

#### [Patterns](patterns/README.md) - Architecture & Orchestration
**Patterns réutilisables pour coordonner features Claude Code**

- [Command-Agent-Skill](patterns/command-agent-skill.md) - Hierarchical orchestration
- [Error Handling](patterns/error-handling.md) - Fallback chains & recovery (3 niveaux)
- [Parallel Execution](patterns/parallel-execution.md) - Concurrent agents (5-10x speedup)
- [State Management](patterns/state-management.md) - Context persistence & memory

#### [Advanced](advanced/README.md) - Expert-Level Guides
**Guides niveau expert pour use cases complexes**

- [Multi-Dialog Patterns](advanced/multi-dialog-patterns.md) - Sequential, Conditional, Parallel, Validation
- [Interactive UI](advanced/interactive-ui.md) - AskUserQuestion workflows complexes
- [Enterprise Patterns](advanced/enterprise-patterns.md) - Governance, RBAC, Compliance (GDPR/SOC2)
- [AI Orchestration](advanced/ai-orchestration.md) - Multi-LLM routing (70-85% cost savings)
- [Decision Trees](advanced/decision-trees.md) - Framework complet de sélection features

**🎓 Parcours expert** (~4-6 heures)

---

### 🔧 Add-ons (Optionnel)

- [VS Code Extension](add-ons/vs-code-extension/guide.md) - Intégration IDE
- [Statusline](add-ons/statusline/guide.md) - Dashboard temps réel

---

## 🧭 Quel Outil Utiliser ?

**Quick Guide** :
- **Context permanent** → [Memory](themes/1-memory/guide.md)
- **Action répétitive** → [Command](themes/2-commands/guide.md)
- **Automation lifecycle** → [Hook](themes/3-hooks/guide.md)
- **Connaissance partagée** → [Skill](themes/4-skills/guide.md)
- **Travail isolé complexe** → [Agent](themes/5-agents/guide.md)
- **Package combiné** → [Plugin](themes/6-plugins/guide.md)
- **Orchestration multi-features** → [Workflow-Pattern-Orchestration](workflow-pattern-orchestration/README.md)

**Pour approfondir** :
- 📊 [Decision Trees](advanced/decision-trees.md) - Arbre de décision complet
- 🏗️ [Patterns](patterns/README.md) - Patterns d'orchestration
- 🚀 [Workflows](workflow-pattern-orchestration/README.md) - Workflows production-ready

---

## 📊 Statistiques Documentation

- 📚 **7 themes core** (features essentielles)
- 🚀 **1 dossier orchestration** (workflows + patterns + best-practices)
  - 🆕 **5 workflows startup** production-ready (150 KB)
  - 📋 **1 rapport validation** (100% conforme Anthropic)
- 🎓 **5 guides advanced** (expert-level)
- 🏗️ **4 patterns** réutilisables
- 🔧 **2 add-ons** optionnels
- 📝 **~450 KB** documentation totale
- 🔗 **60+ ressources** externes
- 💾 **~25,000 lignes** de contenu pédagogique

**Total apprentissage** : ~20-28 heures (débutant → expert)


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
