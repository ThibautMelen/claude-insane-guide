# 🤖 Agents - Sub-Agents et Orchestration Multi-Agents

> **Déléguer des tâches complexes à des agents spécialisés pour gagner en performance et en clarté**

## 📚 Contenu

```
themes/6-agents/
┣━━ 📖 guide.md           ← Guide complet théorique + pratique
┣━━ ⚡ cheatsheet.md      ← Référence rapide (syntaxe, patterns)
┣━━ 📁 examples/          ← Exemples pratiques d'agents
┃   ┣━━ code-reviewer-agent.md
┃   ┣━━ test-generator-agent.md
┃   ┣━━ security-auditor-agent.md
┃   ┣━━ parallel-agents-video-production.md
┃   └━━ verdent-deck-worktrees.md
┗━━ 📄 README.md          ← Ce fichier
```

## 🎯 À quoi servent les Agents ?

Les **Agents** = instances de Claude avec **missions spécifiques**, capables d'agir de manière **autonome** pour accomplir des tâches complexes.

```
╔══════════════════════════════════════════╗
║     AGENTS - VUE D'ENSEMBLE              ║
╚══════════════════════════════════════════╝

👤 Utilisateur
     │
     ▼
┌────────────────────────────────────────┐
│  🤖 MAIN AGENT (Claude Principal)      │
│  → Session interactive                 │
│  → Orchestrateur                       │
└────────┬───────────────────────────────┘
         │
         ├──> 🤖 Sub-Agent 1 (Explore Code)
         ├──> 🤖 Sub-Agent 2 (Analyze Deps)
         ├──> 🤖 Sub-Agent 3 (Security Audit)
         └──> 🤖 Sub-Agent 4 (Write Tests)
                   │
                   ▼
            Résultats agrégés
```

## 🚀 Pourquoi Utiliser des Agents ?

**3 Bénéfices Majeurs** :

### 1. 🎯 Spécialisation
```
Chaque agent = expertise spécifique
├── Code reviewer : Qualité & sécurité
├── Test generator : Coverage complet
├── Security auditor : OWASP Top 10
└── Performance analyzer : Bottlenecks
```

### 2. ⚡ Parallélisation
```
❌ Séquentiel : Agent1 → Agent2 → Agent3
   Total : 90s

✅ Parallèle : Agent1 ┐
                Agent2 ├─> Total : 30s
                Agent3 ┘

🚀 Gain : 66% de temps !
```

### 3. 💰 Optimisation Coût
```
Mix de modèles selon complexité :
├── Haiku (fast & cheap) : Transcription, formatting
├── Sonnet (balanced) : Code writing, analysis
└── Opus (premium) : Architecture, security audit

→ Meilleur ratio qualité/coût
```

## 📖 Commencer

### 🟢 Débutant
1. Lire [guide.md](./guide.md) section "Qu'est-ce qu'un Agent ?"
2. Regarder exemples dans [examples/code-reviewer-agent.md](./examples/code-reviewer-agent.md)
3. Consulter [cheatsheet.md](./cheatsheet.md) pour syntaxe rapide

### 🟡 Intermédiaire
1. Lire section "Patterns d'Orchestration" dans [guide.md](./guide.md)
2. Étudier [examples/parallel-agents-video-production.md](./examples/parallel-agents-video-production.md)
3. Créer votre premier agent custom

### 🔴 Expert
1. Lire section "Verdent Deck - Parallel Agents" dans [guide.md](./guide.md)
2. Implémenter [examples/verdent-deck-worktrees.md](./examples/verdent-deck-worktrees.md)
3. Consulter [agentic-workflow patterns](../../agentic-workflow/6-composable-patterns/)

## 🎓 Concepts Clés

| Concept | Description | Gain |
|---------|-------------|------|
| **Sub-Agent** | Agent spécialisé avec contexte isolé | Clarté |
| **Parallélisation** | Agents exécutés simultanément | Temps (66%+) |
| **Spécialisation Modèle** | Haiku/Sonnet/Opus selon complexité | Coût optimal |
| **Verdent Deck** | Agents en worktrees Git isolés (2025) | Isolation complète |

## ⚡ Quick Start

### Invoquer un Agent

```bash
# Via Task tool (automatique)
claude
> "Lance un agent pour explorer le code et trouver les fichiers de config"

# Agents parallèles (IMPORTANT!)
> "Lance agents EN PARALLÈLE : security-audit, perf-check, a11y-review"
```

### Définir un Agent (Plugin)

```typescript
// .claude/plugins/my-agents/index.ts
export default {
  subAgents: {
    'code-reviewer': {
      systemPrompt: `You are an expert code reviewer.
      Check for: quality, security, performance.`,
      description: 'Reviews code quality and security',
      model: 'opus'
    }
  }
};
```

### Définir un Agent (Settings)

```json
{
  "agents": {
    "my-reviewer": {
      "prompt": "Tu es un expert code reviewer...",
      "tools": ["Read", "Grep", "Edit"],
      "model": "sonnet"
    }
  }
}
```

## 📊 Patterns Communs

### Pattern 1 : Séquentiel (Pipeline)
```
Agent1 (Research) → Agent2 (Write) → Agent3 (Review)
Use case : Documentation, blog posts
```

### Pattern 2 : Parallèle (Fan-Out) ⭐
```
Main Agent
    ├─> Agent A (Security)
    ├─> Agent B (Performance)
    └─> Agent C (Accessibility)
         └─> Compile Results

Use case : Code review, audits complets
Gain : 66%+ temps
```

### Pattern 3 : Spécialisé (Model Mix)
```
Haiku (fast) + Sonnet (standard) + Opus (complex)
Use case : Production vidéo, refactoring massif
Gain : Coût optimal
```

## 🔗 Liens Connexes

### Dans ce Projet
- 📚 [Agentic Workflows](../../agentic-workflow/) - Patterns d'orchestration
- 🎓 [Skills](../4-skills/) - Skills vs Agents : comparaison
- 🔌 [Plugins](../7-plugins/) - Packager agents dans plugins
- 🔗 [MCP](../5-mcp/) - Agents avec intégrations MCP
- 💾 [Memory](../1-memory/) - Memory pour agents
- ⚡ [Commands](../2-commands/) - Commands qui lancent agents

### Patterns Agentic Workflow
- [Pattern 3: Parallelization](../../agentic-workflow/6-composable-patterns/3-parallelization.md) - 9.7x speedup
- [Pattern 4: Orchestrator-Workers](../../agentic-workflow/6-composable-patterns/4-orchestrator-workers.md) - Command orchestre
- [Startup Stack 5: Agent Orchestration](../../agentic-workflow/4-workflows/startup-stack.md) - Workflows agents

## 📚 Ressources Officielles

- 📄 [Claude Sub-Agents](https://docs.anthropic.com/claude/docs/sub-agents) (inféré)
- 📄 [Engineering Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- 📝 [Writing Tools for Agents](https://www.anthropic.com/engineering/writing-tools-for-agents)
- 🎥 [Formation Claude Code 2.0 - Melvynx](https://www.youtube.com/watch?v=bDr1tGskTdw) (45:00 - Agents Parallèles)

## 🔗 Communauté

- 🔗 [Weston Hobson Agents](https://github.com/wshobson/agents) ⭐ 21K
- 🔗 [Awesome Sub-Agents](https://github.com/VoltAgent/awesome-claude-code-subagents) ⭐ 100+
- 🔗 [Disler Multi-Agent Observability](https://github.com/disler/claude-code-hooks-multi-agent-observability) ⭐ 766

## 💡 Règles d'Or

1. **Paralléliser** autant que possible (tâches indépendantes)
2. **Spécialiser** par modèle (Haiku/Sonnet/Opus)
3. **Nommer** clairement (rôle explicite)
4. **Limiter** à 3-7 agents max (clarté)
5. **Isoler** contextes (pas de leakage)

---

**🚀 Prêt à orchestrer vos agents ?** → Commencez par [guide.md](./guide.md) !

**💡 Quote Melvynx** :
> "Les agents parallèles permettent d'exécuter plusieurs tâches simultanément. Workflow complexe traité en minutes au lieu d'heures."
