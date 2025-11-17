# 🔌 MCP - Cheatsheet

> **Référence rapide Model Context Protocol**

📄 **Docs** : [MCP Docs](https://modelcontextprotocol.io/)

## ⚡ Quick Start

```json
{
  "mcpServers": {
    "my-server": {
      "command": "npx",
      "args": ["-y", "@scope/mcp-server"]
    }
  }
}
```

**Location** : `~/.config/claude-code/config.json`

## 📋 Serveurs Populaires

- `@modelcontextprotocol/server-filesystem` - Accès fichiers
- `@modelcontextprotocol/server-postgres` - PostgreSQL
- `@context7/mcp-server` - Context7 search
- `@anthropic-ai/mcp-server-playwright` - Browser automation

## 🎯 Template Configuration

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "DATABASE_URL": "postgresql://..."
      }
    }
  }
}
```

## 📦 Convention MCP (npm-like)

**Principe** : Install global + documentation projet

```
Global: ~/.config/claude-code/config.json
  ↓ (installed once)
Project: .claude/CLAUDE.md
  → "Required MCP: postgres"
  → Setup snippet copier-coller
```

**Template .claude/CLAUDE.md** :

```markdown
## ⚠️ Required MCP Servers

### Postgres (database)
Add to `~/.config/claude-code/config.json`:
\```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {"DATABASE_URL": "postgresql://..."}
    }
  }
}
\```

**Why**: All DB queries use this MCP server
```

**Avantages** :
- ✅ Onboarding clair (clone → lit CLAUDE.md → sait quoi installer)
- ✅ Documentation centralisée
- ✅ Reproductibilité (même setup partout)

---

📖 [Guide Complet](./guide.md)

---

## 📚 Ressources

### 📄 Documentation Officielle

- [MCP with Claude Code](https://code.claude.com/docs/en/mcp) - Documentation officielle Claude Code
- [Model Context Protocol](https://modelcontextprotocol.io/) - Site officiel MCP
- [MCP Specification](https://modelcontextprotocol.io/specification) - Spécification complète
- [MCP Servers Registry](https://github.com/modelcontextprotocol/servers) - Serveurs officiels

### 🎥 Vidéos Recommandées

- [Formation Claude Code 2.0](../../ressources/videos/formation-claude-code-2-0-melvynx.md) ([🔗 YouTube](https://www.youtube.com/watch?v=bDr1tGskTdw)) - Melvynx | 🟢 Débutant
  - Introduction aux MCP servers
- [Skills vs MCP vs Subagents](../../ressources/videos/skills-vs-mcp-vs-subagents.md) ([🔗 YouTube](https://youtu.be/ZroGqu7GyXM)) - Solo Swift Crafter | 🟢 Débutant
  - Quand utiliser MCP vs autres features
- [5 Claude Skills Game-Changers](../../ressources/videos/5-claude-skills-game-changers-sean-allen.md) ([🔗 YouTube](https://www.youtube.com/watch?v=901VMcZq8X4)) - Sean Allen | 🟡 Intermédiaire
  - Skills vs MCPs : workflows procéduraux vs accès ressources externes
- [Skills vs Slash Commands vs Sub-Agents vs MCP - Le Guide Complet](../../ressources/videos/skills-vs-slash-commands-vs-subagents-vs-mcp-dan.md) ([🔗 YouTube](https://www.youtube.com/watch?v=kFpLzCVLA20)) - Dan | 🟠 Avancé
  - MCP pour intégrations externes, context bloat vs progressive disclosure, compositional hierarchy
- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) ([🔗 YouTube](https://www.youtube.com/watch?v=Ffh9OeJ7yxw)) - Edmund Yong | 🔴 Expert
  - MCP avancés et cas d'usage entreprise

### 📝 Articles

- [Skills, Commands, Subagents, Plugins](../../ressources/articles/skills-commands-subagents-plugins-youngleaders.md) ([🔗 Source](https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins)) - YoungLeaders
  - Comparaison MCP vs autres features
- [Orchestration Workflows Enterprise](../../ressources/articles/orchestration-workflows-enterprise-perplexity.md) ([🔗 Source](https://www.perplexity.ai/search/summarize-the-current-webpage-YqEO3MquRBSTWbbJgkZWIw#0)) - Perplexity
  - MCP dans workflows entreprise
- [Understanding Claude Code's Full Stack](../../ressources/articles/full-stack-orchestration-opalic.md) ([🔗 Source](https://alexop.dev/posts/understanding-claude-code-full-stack/)) - Alexander Opalic
  - MCP comme universal adapter : connexion databases, APIs, GitHub, cloud

### 🔗 Communauté

- [Awesome Claude Code](https://github.com/hesreallyhim/awesome-claude-code) ⭐ 17K - Liste curée commands & workflows
- [Awesome Claude Code MCP](https://github.com/VoltAgent/awesome-claude-code#mcp-servers) - MCP servers communautaires
- [MCP Servers Registry](https://github.com/modelcontextprotocol/servers) - Serveurs officiels Anthropic
- [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Configuration MCP
- [Community MCP Servers](https://github.com/topics/mcp-server) - GitHub topic

---

**💡 Tip** : MCP = connexion aux services externes ! 🌐
