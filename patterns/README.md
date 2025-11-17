# Patterns - Architecture & Orchestration

Patterns d'orchestration pour coordonner **Memory**, **Commands**, **Hooks**, **Skills**, **Agents** et **Plugins** dans des workflows complexes.

---

## 📚 Vue d'Ensemble

Ces patterns montrent **comment combiner les 6 features core** de Claude Code pour créer des systèmes puissants et maintenables.

```
Claude Code Features Coordination

       MEMORY (Context)
           ↓
    ┌──────┴──────┐
    ↓             ↓
COMMANDS      HOOKS
(Manual)      (Auto)
    ↓             ↓
    └──────┬──────┘
           ↓
    ┌──────┴──────┐
    ↓             ↓
 SKILLS       AGENTS
(Simple)    (Complex)
    ↓             ↓
    └──────┬──────┘
           ↓
       PLUGINS
    (All-in-one)
```

---

## 📋 Patterns Disponibles

### 🏗️ Architecture Patterns

#### [Command-Agent-Skill](./command-agent-skill.md)
**Hierarchical orchestration** : COMMAND coordonne → AGENT exécute → SKILL guide

**Use case** :
- Génération batch (174 locales)
- Multi-step workflows (EPCT)
- Parallel processing

**Structure** :
```
COMMAND (Coordinator)
  ├─ Parse args
  ├─ Validate inputs
  ├─ Launch AGENTS (parallel)
  │   └─ AGENTS read SKILL (shared knowledge)
  └─ Aggregate results

✅ Clear separation of concerns
✅ Scalable (1 to N items)
✅ Reusable (SKILL shared across agents)
```

---

#### [Error Handling](./error-handling.md) 🆕
**Fallback chains & recovery** : Stratégies pour gérer erreurs gracefully

**Patterns** :
- Fallback chains (MCP Context7 → Perplexity → Firecrawl)
- Retry logic (COMMAND level)
- User validation points (AskUserQuestion)
- Graceful degradation

**Use case** :
- MCP failures
- API rate limits
- Missing data
- Network errors

---

#### [State Management](./state-management.md) 🆕
**Context persistence** : Gérer état entre agents et sessions

**Patterns** :
- Memory hierarchy (Enterprise > User > Project)
- Session variables
- Cross-agent communication (SubagentStop hook)
- Checkpoints & recovery

**Use case** :
- Long-running workflows
- Multi-agent coordination
- Context preservation
- Resume after error

---

### 🔄 Execution Patterns

#### [Parallel Execution](./parallel-execution.md) 🆕
**Concurrent agents** : Maximiser performance avec parallelism

**Patterns** :
- Concurrent pattern (independent tasks)
- Batch pattern (large scale)
- Resource management (avoid overwhelm)
- Aggregation strategies

**Use case** :
```
Sequential : 10 locales × 30s = 300s (5min)
Parallel   : max(30s) = 30s (6x faster !)
```

---

#### [Sequential Chaining](../advanced/multi-dialog-patterns.md)
**Step-by-step flows** : Linear workflows avec validation

**Patterns** :
- Linear chaining (A → B → C)
- Conditional branching (if/else)
- Validation chains (verify before proceed)

**Use case** :
- Multi-step forms
- Progressive data collection
- Build pipelines

---

## 🎯 Quand Utiliser Quel Pattern ?

### Decision Tree

```
Task simple (1 étape) ?
└─ OUI → COMMAND direct
└─ NON → Continue

Task automatisable (lifecycle event) ?
└─ OUI → HOOKS
└─ NON → Continue

Task nécessite context complexe ?
└─ OUI → SKILL + AGENT
└─ NON → Continue

Task indépendante (parallélisable) ?
└─ OUI → Pattern PARALLEL
└─ NON → Pattern SEQUENTIAL

Task avec erreurs potentielles ?
└─ OUI → Pattern ERROR HANDLING
```

---

## 🏗️ Example Concret : Génération Locale

**Use case** : Générer 174 fichiers locale documentation

**Pattern utilisé** : Command-Agent-Skill + Parallel + Error Handling

```markdown
# Structure

.claude/
├── commands/
│   └── generate-locale-technical.md   ← COMMAND (coordinator)
├── agents/
│   └── locale-technical-generator.md  ← AGENT (worker)
└── skills/
    └── locale-technical-knowledge/    ← SKILL (shared knowledge)
        ├── skeleton.md
        ├── sources.yaml
        └── validation-rules.md

# Flow

1. COMMAND parse args (locale codes)
2. COMMAND validate data source
3. COMMAND launch AGENTS (parallel, batch 20)
4. Each AGENT reads SKILL (structure + sources)
5. Each AGENT generates locale file
6. COMMAND aggregates results
7. COMMAND reports (success/fail counts)

# Error Handling

AGENT level:
- Try local data → derived → Context7 → Perplexity → Firecrawl
- BLOCK if all fail

COMMAND level:
- Collect failures
- Retry once
- Report detailed errors
```

---

## 📚 Ressources

### Documentation Officielle
- 📄 [Common Workflows](https://code.claude.com/docs/en/common-workflows)
- 📄 [Sub-Agents Coordination](https://code.claude.com/docs/en/sub-agents#coordination)
- 📄 [Hooks Guide](https://code.claude.com/docs/en/hooks-guide)

### Articles
- 📝 [Anthropic Engineering - Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- 📝 [AI Orchestration 2025](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)

### Ressources Internes
- 🎓 [Workflows](../workflow-pattern-orchestration/README.md)
- 🎓 [Advanced Patterns](../advanced/multi-dialog-patterns.md)
- 🎓 [Best Practices](../workflow-pattern-orchestration/best-practices/README.md)

---

**Prochaines Étapes** :
1. Lire [Command-Agent-Skill Pattern](./command-agent-skill.md)
2. Expérimenter avec parallel execution
3. Créer votre premier workflow orchestré
