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

📖 [Guide Complet](./guide.md) | 🧪 [Exercices](./exercices/niveau-1.md)
