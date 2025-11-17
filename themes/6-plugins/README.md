# 🔌 Plugins Claude Code

> **Système d'extensibilité le plus puissant de Claude Code**

---

## 📚 Documentation Disponible

### 📖 [Guide Complet](./guide.md)
Documentation exhaustive couvrant :
- 🎯 Théorie fondamentale
- 🏗️ Architecture complète
- 📦 Création de plugins
- 🏪 Marketplaces
- 🌐 Écosystème global
- 📊 Tableaux comparatifs
- 🔄 Cycle de vie
- ✅ Best practices
- 🔧 Variables d'environnement

**🕐 Temps de lecture** : ~45 minutes

---

### 📋 [Cheatsheet](./cheatsheet.md)
Référence rapide pour :
- ⚡ Commandes CLI essentielles
- 📝 Templates JSON (plugin.json, marketplace.json, hooks.json, .mcp.json)
- 🌍 Variables d'environnement
- 🎯 Événements hooks
- 🗂️ Quick start examples
- ✅ Checklist complète
- 🚨 Erreurs courantes

**🕐 Temps de lecture** : ~10 minutes

---

### 🌍 [Scopes et Marketplaces](./scopes-et-marketplaces.md)
Guide complet sur l'organisation :
- 🎯 Les 3 scopes (User, Project, Local)
- 🔧 Deux méthodes activation marketplace
- 🔌 Plugins standalone vs marketplace
- 📊 Organisation marketplaces (combien par scope)
- ❌ Copie plugins entre marketplaces (impossible → solutions)
- 💡 Exemples concrets et FAQ

**🕐 Temps de lecture** : ~20 minutes

---

### 📥 [Workflow Installation](./workflow-installation.md)
Guide visuel des workflows d'installation :
- ⚠️ Règle d'or (marketplace avant plugins)
- 🔧 Installation CLI (manuelle globale)
- ⚙️ Installation Config (automatique via config.json)
- 💻 Installation Locale (projet spécifique)
- 🍴 Fork Plugin Community (personnalisation)
- 🚨 Erreurs courantes et solutions
- 🌳 Decision tree complet

**🕐 Temps de lecture** : ~15 minutes

---

### 🎯 [Cas d'Usage Réels](./cas-usage.md)
Exemples production-ready :
- 🚀 **DevOps Toolkit** - Déploiements, rollbacks, monitoring
- 📊 **Data Platform** - ETL, validation, ML-Ops
- 🧪 **Testing Suite** - Tests unitaires, E2E, load testing

Chaque cas inclut :
- Structure complète du plugin
- Workflow visuel détaillé
- Code exemples fonctionnels
- Integration patterns

**🕐 Temps de lecture** : ~25 minutes

---

## 🎯 Par Où Commencer ?

### 🆕 Débutant
1. Lire [Scopes et Marketplaces](./scopes-et-marketplaces.md) pour comprendre l'organisation
2. Lire [Guide Complet](./guide.md) sections "Théorie" et "Architecture"
3. Pratiquer [Exercice Niveau 1](./exercices/niveau-1.md)
4. Garder [Cheatsheet](./cheatsheet.md) sous la main

### 🔧 Développeur
1. **Comprendre organisation**: [Scopes et Marketplaces](./scopes-et-marketplaces.md)
2. Parcourir [Cas d'Usage Réels](./cas-usage.md) pour inspiration
3. Lire [Guide Complet](./guide.md) section "Best Practices"
4. Pratiquer [Exercices Niveau 2-3](./exercices/)
5. Utiliser [Cheatsheet](./cheatsheet.md) comme référence

### 🏢 Enterprise
1. **CRITICAL**: Lire [Scopes et Marketplaces](./scopes-et-marketplaces.md) sections organisation
2. Étudier [Cas d'Usage](./cas-usage.md) "DevOps Toolkit" et "Data Platform"
3. Lire [Guide Complet](./guide.md) sections "Écosystème" et "Gouvernance"
4. Implémenter marketplace organisation (user + project scopes)
5. Consulter [Cheatsheet](./cheatsheet.md) section "Configuration Équipe"

---

## 🔗 Navigation Écosystème

### Composants Related
- 🔧 [Commands](../commands/guide.md) - Slash commands réutilisables
- 🤖 [Agents](../agents/guide.md) - Sub-agents spécialisés
- 💡 [Skills](../skills/guide.md) - Capacités autonomes
- 🔌 [MCP](../mcp/guide.md) - Connexions services externes
- 🧠 [Memory](../memory/guide.md) - Configuration persistante

### Guides Transversaux
- 📚 [Best Practices](../best-practices/guide.md) - Workflows recommandés
- 🎓 [Exercices](../exercices/) - Pratique globale

---

## 💡 Concepts Clés

### Qu'est-ce qu'un Plugin ?
Un **plugin** est un **package réutilisable** qui bundle :
- Commands (actions utilisateur)
- Agents (orchestration)
- Skills (expertise métier)
- Hooks (automation événements)
- MCP Servers (intégrations externes)

### Pourquoi les Plugins ?
✅ **Standardisation** workflows équipe
✅ **Partage** facilité (Git, GitHub, marketplaces)
✅ **Versioning** sémantique (1.0.0 → 2.0.0)
✅ **Distribution** automatisée
✅ **Modularité** et réutilisabilité

### Structure Minimale
```
my-plugin/
├─ .claude-plugin/
│  └─ plugin.json          # { "name": "my-plugin" }
└─ commands/               # Vos commandes .md
   └─ hello.md
```

---

## 🚀 Quick Start

```bash
# 1. Créer plugin minimal
mkdir my-plugin
cd my-plugin
mkdir -p .claude-plugin commands

# 2. plugin.json
echo '{"name":"my-plugin"}' > .claude-plugin/plugin.json

# 3. Command
cat > commands/hello.md << 'EOF'
---
name: hello
---
Hello World!
EOF

# 4. Installer
/plugin marketplace add ./
/plugin install my-plugin

# 5. Utiliser
/hello
```

---

## 📊 Ressources

### Documentation Officielle
- 📄 [Claude Code Plugins](https://code.claude.com/docs/en/plugins)
- 📄 [Marketplaces](https://code.claude.com/docs/en/plugins#marketplaces)

### Communauté
- 🔗 [Awesome Plugins](https://github.com/VoltAgent/awesome-claude-plugins)
- 🔗 [Examples](https://github.com/wshobson/commands)

---

**Version** : 3.0.0 (enrichie avec guide exhaustif)
**Dernière mise à jour** : 2025-11-06
