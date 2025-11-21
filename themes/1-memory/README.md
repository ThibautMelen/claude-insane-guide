# 🧠 Memory - Claude Code

> La fondation d'un workflow efficace avec Claude Code

## 📚 Documentation

- **[Guide Complet](./guide.md)** - Théorie détaillée, cas d'usage, best practices (30 min)
- **[Cheatsheet](./cheatsheet.md)** - Référence rapide, commandes essentielles (5 min)

## 🎯 Qu'est-ce que la Memory ?

La Memory de Claude Code permet de **persister vos préférences et instructions** dans un fichier `.claude/CLAUDE.md` pour ne jamais avoir à les répéter.

```
┌─────────────────────────────────────────────────────────┐
│  AVANT Memory                  AVEC Memory              │
├─────────────────────────────────────────────────────────┤
│  Répéter à chaque session ❌   Une seule fois ✅         │
│  "Use TypeScript strict"       Sauvé dans CLAUDE.md     │
│  "Follow Airbnb style"         Auto-appliqué toujours   │
│  "Add error handling"          Plus de répétition       │
└─────────────────────────────────────────────────────────┘
```

### Quick Start

```bash
# 1️⃣ Initialiser un projet
/init

# 2️⃣ Ajouter une règle rapidement
# Toujours utiliser TypeScript strict mode

# 3️⃣ Éditer la mémoire
/memory
```

## 📖 Parcours Recommandé

```
1. 📚 [Guide Complet](./guide.md)
   └─> Lire théorie complète (30 min)

2. ⚡ [Cheatsheet](./cheatsheet.md)
   └─> Référence rapide à garder sous les yeux

3. 🎬 [Vidéo Edmund Yong](https://www.youtube.com/watch?v=Ffh9OeJ7yxw)
   └─> 800h d'expérience condensées (27 min)

4. 💼 [Exemples Réels](./examples/)
   └─> Templates prêts à l'emploi
```

## 🗂️ Structure du Thème

```
1-memory/
┣━━ 📄 README.md              ← Vous êtes ici
┣━━ 📚 guide.md               ← Guide théorique complet
┣━━ ⚡ cheatsheet.md          ← Référence rapide
┗━━ 📁 examples/              ← Templates et exemples réels
    ┣━━ starter-template.md   ← Template de démarrage
    ┣━━ fullstack-nextjs-supabase.md
    ┣━━ agency-global.md
    ┣━━ agency-project.md
    └━━ open-source.md
```

## 🎯 Hiérarchie Memory (par ordre de priorité)

```
╔════════════════════════════════════════════════════════════╗
║  🏢 Enterprise > 📁 Project > 👤 User                      ║
╚════════════════════════════════════════════════════════════╝

🏢 /Library/Application Support/ClaudeCode/CLAUDE.md  # 1. Enterprise
📁 ./.claude/CLAUDE.md                                 # 2. Projet ⭐ RECOMMANDÉ
👤 ~/.claude/CLAUDE.md                                 # 3. Utilisateur
```

**Principe** : Projet override User, Enterprise override tout.

## 💡 Cas d'Usage Typiques

### 👤 Développeur Solo
```
~/.claude/CLAUDE.md (global)
└─> Préférences personnelles
    - TypeScript strict mode
    - Functional programming
    - Testing avec Vitest
```

### 👥 Équipe/Startup
```
.claude/CLAUDE.md (projet)
└─> Guidelines partagées (Git)
    - Tech stack: Next.js + Supabase
    - Conventions d'équipe
    - PR process
```

### 🏢 Enterprise
```
/Library/.../CLAUDE.md (enterprise)
└─> Standards organisation
    - Security policies
    - Compliance requirements
    - Corporate guidelines
```

## 🔗 Thèmes Liés

**Complémentaires** :
- **[Commands](../2-commands/)** - Prompts réutilisables (slash commands)
- **[Hooks](../3-hooks/)** - Automatisations lifecycle
- **[Skills](../4-skills/)** - Progressive disclosure

**Différence clé** :
- **Memory** : Instructions **toujours actives** (background)
- **Commands** : Actions **déclenchées manuellement** (foreground)

## 📚 Ressources Externes

### 📄 Documentation Officielle
- [Memory Docs](https://code.claude.com/docs/en/memory) - Guide officiel Anthropic
- [Best Practices](https://code.claude.com/docs/en/memory#best-practices) - Patterns recommandés

### 🎥 Vidéos Recommandées
- [Formation Claude Code 2.0](../../ressources/videos/formation-claude-code-2-0-melvynx.md) - Melvynx | 🟢 Débutant
- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) - Edmund Yong | 🔴 Expert

### 🔗 Communauté
- [Awesome Claude Code](https://github.com/VoltAgent/awesome-claude-code) - Exemples CLAUDE.md
- [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Config production

## 🚀 Quick Commands

| Action | Commande |
|--------|----------|
| Initialiser | `/init` |
| Ajouter mémoire | `#` + règle |
| Éditer mémoire | `/memory` |
| Vérifier projet | `cat .claude/CLAUDE.md` |
| Vérifier global | `cat ~/.claude/CLAUDE.md` |

## 💬 Citation

> "D.R.Y. (Don't Repeat Yourself) - Let Claude remember your preferences"
>
> — Edmund Yong (800h Claude Code)

---

**⭐ Commencez par** : [Guide Complet](./guide.md) ou [Cheatsheet](./cheatsheet.md)
