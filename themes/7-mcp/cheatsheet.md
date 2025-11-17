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

- [Model Context Protocol](https://modelcontextprotocol.io/) - Site officiel MCP
- [MCP Specification](https://modelcontextprotocol.io/specification) - Spécification complète
- [MCP with Claude Code](https://code.claude.com/docs/en/mcp) - Intégration Claude Code
- [MCP Servers Registry](https://github.com/modelcontextprotocol/servers) - Serveurs officiels
- 📖 [Guide Complet](./guide.md) - Guide local détaillé

### 🎥 Vidéos Recommandées

- [MCP Servers Setup](../../ressources/videos/mcp-servers-claude-code-setup.md) - Weston Hobson | 🟡 Intermédiaire
  - Configuration MCP step-by-step
- [Skills vs MCP vs Subagents](../../ressources/videos/skills-vs-mcp-vs-subagents.md) - Solo Swift Crafter | 🟢 Débutant
  - Quand utiliser MCP vs autres features
- [Formation Claude Code 2.0](../../ressources/videos/formation-claude-code-2-0-melvynx.md) - Melvynx | 🟢 Débutant
  - Introduction aux MCP servers
- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) - Edmund Yong | 🔴 Expert
  - MCP avancés et cas d'usage entreprise

### 📝 Articles

- [Skills, Commands, Subagents, Plugins](../../ressources/articles/skills-commands-subagents-plugins-youngleaders.md) - YoungLeaders
  - Comparaison MCP vs autres features
- [Orchestration Workflows Enterprise](../../ressources/articles/orchestration-workflows-enterprise-perplexity.md) - Perplexity
  - MCP dans workflows entreprise

### 🔗 Communauté

- [Awesome Claude Code MCP](https://github.com/VoltAgent/awesome-claude-code#mcp-servers) - MCP servers communautaires
- [MCP Servers Registry](https://github.com/modelcontextprotocol/servers) - Serveurs officiels Anthropic
- [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Configuration MCP
- [Community MCP Servers](https://github.com/topics/mcp-server) - GitHub topic

---

**💡 Tip** : MCP = connexion aux services externes ! 🌐
