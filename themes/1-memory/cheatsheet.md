# 🧠 Memory - Cheatsheet

> Référence rapide pour Memory Claude Code

## 📍 Emplacements (par ordre de priorité)

```
╔════════════════════════════════════════════════════════════╗
║  Hiérarchie : 🏢 Enterprise > 📁 Project > 👤 User        ║
╚════════════════════════════════════════════════════════════╝

🏢 /Library/Application Support/ClaudeCode/CLAUDE.md  # 1. Enterprise
📁 ./.claude/CLAUDE.md                                 # 2. Projet ⭐ RECOMMANDÉ
📁 ./CLAUDE.md                                         # 2. Projet (ancienne)
👤 ~/.claude/CLAUDE.md                                 # 3. Utilisateur
⚠️  ./CLAUDE.local.md                                  # Local (DÉPRÉCIÉ)
```

## ⚡ Commandes Rapides

### 🆕 Initialiser Projet
```bash
/init
# → Crée .claude/CLAUDE.md avec template
```

### ➕ Ajout Rapide
```bash
# Ma règle de mémoire
```
**Raccourci** : Presse `#️⃣` → tape ta règle → ✅

### ✏️ Éditer Mémoire
```bash
/memory
```
**Ouvre** le fichier CLAUDE.md pour édition

## 🔗 Imports & Modularité

```markdown
@~/.claude/preferences.md
@.claude/config/style.md
@.claude/standards/typescript.md
```

```
┌────────────────────────────────┐
│  📊 Limite : 5 niveaux max     │
│                                │
│  CLAUDE.md                     │
│    └─> config/style.md (1)    │
│         └─> shared/ts.md (2)  │
│              └─> ... (3-5)    │
└────────────────────────────────┘
```

## 📝 Template CLAUDE.md

```markdown
# Mémoire du Projet

## Style de Code
- Indentation : 2 espaces
- Quotes : simple quotes
- Semicolons : oui

## Préférences
- TypeScript strict mode
- Functional programming

## Imports
@.claude/config/style.md

## Notes
...
```

## 🗂️ Organisation Recommandée

```
📦 .claude/
┣━━ 📄 CLAUDE.md              ⭐ Mémoire principale
┃
┣━━ 📁 config/                ⚙️ Configurations
┃   ┣━━ 📝 style.md           → Style de code
┃   ┣━━ 📝 standards.md       → Standards d'équipe
┃   ┗━━ 📝 typescript.md      → Config TypeScript
┃
┣━━ 📁 commands/              ⚡ Slash commands
┃   ┗━━ ...
┃
┗━━ 📁 workflows/             🔄 Workflows projet
    ┗━━ ...
```

## ✅ Best Practices

✅ **Être spécifique** : "Indentation 2 espaces"  
❌ **Vague** : "Bien formater"

✅ **Organisation** : Sections et listes  
❌ **Bloc de texte** dense

✅ **Révision régulière**  
❌ **Fixer et oublier**

## 🔍 Vérifier la Mémoire

```bash
# Projet
cat .claude/CLAUDE.md

# Global
cat ~/.claude/CLAUDE.md

# Enterprise (macOS)
cat "/Library/Application Support/ClaudeCode/CLAUDE.md"
```

## 🎯 Quick Reference

| Action | Commande |
|--------|----------|
| Initialiser | `/init` |
| Ajouter mémoire | `#` + règle |
| Éditer mémoire | `/memory` |
| Vérifier projet | `cat .claude/CLAUDE.md` |
| Vérifier global | `cat ~/.claude/CLAUDE.md` |
| Import | `@chemin` |

## 💡 Use Cases Rapides

### Préférences Globales (~/.claude/CLAUDE.md)
```markdown
# Global Preferences
- TypeScript strict mode
- Async/await over promises
- Functional components only
```

### Projet Spécifique (.claude/CLAUDE.md)
```markdown
# Project: E-commerce
- Next.js 14 + Supabase
- Zod validation required
- 80% test coverage minimum
```

### Équipe (partagé via Git)
```markdown
# Team Guidelines
- Conventional commits
- 2 reviewers minimum
- PR template obligatoire
```

## 🔄 Workflow Typique

```
1. /init                    # Setup projet
2. /memory                  # Configurer
3. # ajouter règles         # Rapide add
4. Coder normalement        # Memory auto
5. git add .claude/         # Share team
```

## 🌍 Multi-AI Setup

```
mon-projet/
├── .claude/CLAUDE.md   # 🤖 Claude
├── gemini.md           # 💎 Gemini  
└── agent.md            # 💬 ChatGPT
```

**Chacun lit son fichier, tous travaillent sur même code !**

---

## 📚 Ressources

### 📄 Documentation Officielle
- [Memory Docs](https://code.claude.com/docs/en/memory) - Guide officiel Anthropic
- [Best Practices](https://code.claude.com/docs/en/memory#best-practices) - Patterns recommandés

### 🎥 Vidéos Recommandées
- [Formation Claude Code 2.0](../../ressources/videos/formation-claude-code-2-0-melvynx.md) ([🔗 YouTube](https://www.youtube.com/watch?v=bDr1tGskTdw)) - Melvynx | 🟢 Débutant
  - Setup complet et Memory
- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) ([🔗 YouTube](https://www.youtube.com/watch?v=Ffh9OeJ7yxw)) - Edmund Yong | 🔴 Expert
  - "D.R.Y. - Let Claude remember your preferences"
  - Optimisation Memory avancée

### 📝 Articles
- [Skills, Commands, Subagents, Plugins](../../ressources/articles/skills-commands-subagents-plugins-youngleaders.md) ([🔗 Source](https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins)) - YoungLeaders
  - Contexte Memory dans l'écosystème
- [Understanding Claude Code's Full Stack](../../ressources/articles/full-stack-orchestration-opalic.md) ([🔗 Source](https://alexop.dev/posts/understanding-claude-code-full-stack/)) - Alexander Opalic
  - Memory Hierarchy : Enterprise → User → Project → Directory

### 🔗 Communauté
- [Awesome Claude Code](https://github.com/VoltAgent/awesome-claude-code) - Exemples de CLAUDE.md
- [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Config complète

---

**💡 Pro tip** : Imprimez cette cheatsheet ! 📋
