# 🤖 Agents - Cheatsheet

> **Référence rapide Sub-Agents**

## ⚡ Quick Start

Agents = délégation de tâches spécialisées

**Invocation** : Via Task tool, automatique ou @agent-name

## 📋 Agents Built-in

- `general-purpose` - Recherche & tâches générales
- `Explore` - Exploration codebase

## 🎯 Custom Agent

```markdown
---
name: code-reviewer
description: Review code for quality
---

Review code for:
- Best practices
- Security
- Performance
```

---

📖 [Guide](./guide.md)

---

## 📚 Ressources

### 📄 Documentation Officielle

- [Sub-Agents Docs](https://code.claude.com/docs/en/subagents) - Guide officiel Anthropic
- [Task Tool Reference](https://code.claude.com/docs/en/tools#task) - Référence Task tool
- [Claude Code Overview](https://docs.anthropic.com/en/docs/claude-code/overview) - Documentation complète

### 🎥 Vidéos Recommandées

- [Formation Claude Code 2.0](../../ressources/videos/formation-claude-code-2-0-melvynx.md) ([🔗 YouTube](https://www.youtube.com/watch?v=bDr1tGskTdw)) - Melvynx | 🟢 Débutant
  - Introduction aux sub-agents
- [Skills vs MCP vs Subagents](../../ressources/videos/skills-vs-mcp-vs-subagents.md) ([🔗 YouTube](https://youtu.be/ZroGqu7GyXM)) - Solo Swift Crafter | 🟢 Débutant
  - Comparaison claire agents vs autres features
- [5 Claude Skills Game-Changers](../../ressources/videos/5-claude-skills-game-changers-sean-allen.md) ([🔗 YouTube](https://www.youtube.com/watch?v=901VMcZq8X4)) - Sean Allen | 🟡 Intermédiaire
  - Skills vs Subagents : quand utiliser quoi (progressive disclosure vs isolation)
- [Skills vs Slash Commands vs Sub-Agents vs MCP - Le Guide Complet](../../ressources/videos/skills-vs-slash-commands-vs-subagents-vs-mcp-dan.md) ([🔗 YouTube](https://www.youtube.com/watch?v=kFpLzCVLA20)) - Dan | 🟠 Avancé
  - Sub-agents pour parallelization et isolation, quand utiliser vs autres features
- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) ([🔗 YouTube](https://www.youtube.com/watch?v=Ffh9OeJ7yxw)) - Edmund Yong | 🔴 Expert
  - Patterns avancés d'orchestration agents
- [Multi-Agent Orchestration : L'Orchestrator Agent](../../ressources/videos/multi-agent-orchestration-orchestrator-agent.md) ([🔗 YouTube](https://www.youtube.com/watch?v=p0mrXfwAbCg)) - Agentic Horizon | 🔴 Expert
  - Pattern Orchestrator Agent : CRUD agents + Observability + Single Interface pour gérer flottes d'agents à l'échelle

### 📝 Articles

- [Skills, Commands, Subagents, Plugins](../../ressources/articles/skills-commands-subagents-plugins-youngleaders.md) ([🔗 Source](https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins)) - YoungLeaders
  - Quand utiliser Agents vs autres features
- [Orchestration Workflows Enterprise](../../ressources/articles/orchestration-workflows-enterprise-perplexity.md) ([🔗 Source](https://www.perplexity.ai/search/summarize-the-current-webpage-YqEO3MquRBSTWbbJgkZWIw#0)) - Perplexity
  - Orchestration multi-agents en entreprise
- [Understanding Claude Code's Full Stack](../../ressources/articles/full-stack-orchestration-opalic.md) ([🔗 Source](https://alexop.dev/posts/understanding-claude-code-full-stack/)) - Alexander Opalic
  - Subagents : parallel execution, isolated contexts, prevent context pollution

### 🔗 Communauté

- [Wshobson Agents](https://github.com/wshobson/agents) ⭐ 21K - Automation intelligente et orchestration multi-agents
- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code) ⭐ 17K - Liste curée commands & workflows
- [Awesome Claude Code Sub-Agents](https://github.com/VoltAgent/awesome-claude-code-subagents) ⭐ 100+ - Collection d'agents custom
- [Awesome Claude Code](https://github.com/VoltAgent/awesome-claude-code#subagents) - Exemples et best practices
- [Disler Multi-Agent Observability](https://github.com/disler/claude-code-hooks-multi-agent-observability) ⭐ 766 - Monitoring real-time agents via hooks
- [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Configuration agents

---

**💡 Tip** : Un agent = une responsabilité claire ! 🎯
