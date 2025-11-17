# 💡 Skills - Cheatsheet

> **Référence rapide Skills Claude Code**

## ⚡ Quick Start

Skills = capacités spécialisées invoquées automatiquement

**Location** : `.claude/skills/nom-skill/SKILL.md`

## 📋 Structure

```
.claude/skills/
└── pdf-processor/
    └── SKILL.md
```

```markdown
# PDF Processor Skill

Process PDF files and extract content.

## Capabilities
- Read PDF
- Extract text
- Parse tables
```

---

📖 [Guide](./guide.md)

---

## 📚 Ressources

### 📄 Documentation Officielle

- [Skills Docs](https://code.claude.com/docs/en/skills) - Guide officiel Anthropic
- [Agent SDK - Skills](https://docs.claude.com/en/docs/agent-sdk/skills) - Documentation technique SDK
- [Skills Best Practices](https://code.claude.com/docs/en/skills#best-practices) - Patterns recommandés

### 🎥 Vidéos Recommandées

- [Formation Claude Code 2.0](../../ressources/videos/formation-claude-code-2-0-melvynx.md) ([🔗 YouTube](https://www.youtube.com/watch?v=bDr1tGskTdw)) - Melvynx | 🟢 Débutant
  - Introduction aux skills
- [Skills vs MCP vs Subagents](../../ressources/videos/skills-vs-mcp-vs-subagents.md) ([🔗 YouTube](https://youtu.be/ZroGqu7GyXM)) - Solo Swift Crafter | 🟢 Débutant
  - Comparaison claire des concepts
- [Claude Skills Complete Guide](../../ressources/videos/claude-skills-complete-guide-kenny-liao.md) ([🔗 YouTube](https://www.youtube.com/watch?v=421T2iWTQio)) - Kenny Liao | 🟡 Intermédiaire
  - Guide complet des skills
- [5 Claude Skills Game-Changers](../../ressources/videos/5-claude-skills-game-changers-sean-allen.md) ([🔗 YouTube](https://www.youtube.com/watch?v=901VMcZq8X4)) - Sean Allen | 🟡 Intermédiaire
  - 5 skills transformatrices : Skill Creator, Brainstorming, Debugging, Simplification Cascade
- [Skills vs Slash Commands vs Sub-Agents vs MCP - Le Guide Complet](../../ressources/videos/skills-vs-slash-commands-vs-subagents-vs-mcp-dan.md) ([🔗 YouTube](https://www.youtube.com/watch?v=kFpLzCVLA20)) - Dan | 🟠 Avancé
  - Comparaison approfondie : quand utiliser chaque feature, compositional hierarchy, prompts as primitives
- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) ([🔗 YouTube](https://www.youtube.com/watch?v=Ffh9OeJ7yxw)) - Edmund Yong | 🔴 Expert
  - Skills avancés et cas d'usage

### 📝 Articles

- [Agent Skills Progressive Disclosure](../../ressources/articles/agent-skills-progressive-disclosure-anthropic.md) ([🔗 Source](https://share.note.sx/8k50udm8#ME3MD6walWogaQZxAVIdsAMaYPFQvw694zbFb622c0Y)) - Kenny Liao
  - Article officiel sur la conception de skills
- [Claude Agent Skills: A First Principles Deep Dive](../../ressources/articles/skills-deep-dive-architecture-lee.md) ([🔗 Source](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)) - Han Lee
  - Architecture interne des Skills : meta-tool, message injection, context modification
- [Skills, Commands, Subagents, Plugins](../../ressources/articles/skills-commands-subagents-plugins-youngleaders.md) ([🔗 Source](https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins)) - YoungLeaders
  - Quand utiliser Skills vs autres features
- [Understanding Claude Code's Full Stack](../../ressources/articles/full-stack-orchestration-opalic.md) ([🔗 Source](https://alexop.dev/posts/understanding-claude-code-full-stack/)) - Alexander Opalic
  - Skills dans l'architecture full stack : autonomous behaviors, style enforcement

### 🔗 Communauté

- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code) ⭐ 17K - Liste curée commands & workflows
- [Claude Code Superpowers](https://github.com/obra/superpowers) ⭐ 7K - Core skills library
- [Skill Seekers](https://github.com/yusufkaraaslan/Skill_Seekers) ⭐ 4.1K - Convertir docs/repos/PDFs en skills Claude AI
- [Awesome Claude Skills (ComposioHQ)](https://github.com/ComposioHQ/awesome-claude-skills) ⭐ 3.8K - Collection complète skills & workflows
- [Awesome Claude Skills (BehiSecc)](https://github.com/BehiSecc/awesome-claude-skills) ⭐ 2.3K - Liste curée skills communautaires
- [Awesome Claude Skills (travisvn)](https://github.com/travisvn/awesome-claude-skills) ⭐ 2.1K - Liste curée skills (focus Claude Code)
- [Claude Skills Collection](https://github.com/alirezarezvani/claude-skills) ⭐ 160 - Skills usage réel : subagents, commands
- [Claude Pro Directory](https://github.com/JSONbored/claudepro-directory) ⭐ 120 - Configs, MCP servers, rules
- [Claude Code Skill Factory](https://github.com/alirezarezvani/claude-code-skill-factory) ⭐ 111 - Toolkit pour builder skills production-ready
- [AI Research Skills](https://github.com/zechenzhangAGI/AI-research-SKILLS) ⭐ 76 - Skills AI research pour agents
- [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Configuration avec skills

---

**💡 Tip** : Les skills sont automatiques, les commands sont manuelles ! 🚀
