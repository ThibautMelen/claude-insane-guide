# Patterns - Orchestration Claude Code

Patterns d'implémentation pour orchestration de workflows avec Commands, Agents, Hooks, et Skills.

---

## 📚 Vue d'Ensemble

Ces patterns montrent **comment implémenter concrètement** les principes d'orchestration Anthropic dans vos workflows.

```
Patterns Hierarchy

COMMAND COORDINATION
       ↓
  Parse → Validate → Orchestrate → Aggregate
       ↓
HOOK AUTOMATION
       ↓
  Lifecycle → Validation → Audit → Trigger
       ↓
AGENT ORCHESTRATION
       ↓
  Parallel → Sequential → Conditional → Batch
```

---

## 📋 Patterns Disponibles

### [Command Coordination](./command-coordination.md)
**Rôle** : COMMAND orchestrate, never execute

**Key Patterns** :
- Argument parsing & validation
- Agent launch strategies (parallel/sequential/batch)
- Result aggregation
- Error handling & retry logic
- User reporting

**Use Cases** :
- RFP automation (3 subcommands → 9 agents)
- CI/CD pipelines (sequential phases)
- Batch processing (10-20 items/wave)

---

### [Hook Automation](./hook-automation.md)
**Rôle** : Lifecycle automation sans intervention manuelle

**Key Patterns** :
- PreToolUse validation
- PostToolUse audit
- SubagentStop aggregation
- SessionStart initialization
- Error triggers

**Use Cases** :
- Quality gates (coverage >80%)
- Security validation (P1 approval)
- Auto-rollback (deploy failed)
- Context persistence

---

### [Agent Orchestration](./agent-orchestration.md)
**Rôle** : Execution patterns pour agents

**Key Patterns** :
- Parallel execution (5-20x speedup)
- Sequential chaining (validation gates)
- Conditional branching (if/else flows)
- Batch processing (large datasets)
- Skill-guided execution

**Use Cases** :
- Multi-language translation (15 agents parallel)
- Security incident response (triage → response → recovery)
- Data processing (1000+ items in batches)

---

## 🎯 Quand Utiliser Quel Pattern ?

### Decision Tree

```
Besoin de coordonner plusieurs agents ?
└─ OUI → COMMAND COORDINATION
   └─ Tasks indépendantes ? → Parallel
   └─ Tasks séquentielles ? → Sequential
   └─ Large scale (100+ items) ? → Batch

Besoin d'automation lifecycle ?
└─ OUI → HOOK AUTOMATION
   └─ Validation avant action ? → PreToolUse
   └─ Audit après action ? → PostToolUse
   └─ Aggregation agents ? → SubagentStop

Besoin d'optimiser execution ?
└─ OUI → AGENT ORCHESTRATION
   └─ Speedup ? → Parallel (5-20x)
   └─ Validation ? → Sequential gates
   └─ Conditional logic ? → Branching
```

---

## 🏗️ Architecture Globale

```
┌─────────────────────────────────────────────────┐
│              COMMAND (Coordinator)              │
│                                                 │
│  ┌─────────────┐  ┌─────────────┐             │
│  │ Parse Args  │→ │  Validate   │             │
│  └─────────────┘  └─────────────┘             │
│                          ↓                      │
│              ┌──────────────────┐              │
│              │  Launch Agents   │              │
│              │  (Parallel/Seq)  │              │
│              └──────────────────┘              │
│                          ↓                      │
│         ┌────────────────┴────────────────┐   │
│         ↓                ↓                 ↓   │
│    ┌────────┐      ┌────────┐       ┌────────┐│
│    │ AGENT  │      │ AGENT  │  ...  │ AGENT  ││
│    │   1    │      │   2    │       │   N    ││
│    └────────┘      └────────┘       └────────┘│
│         ↓                ↓                 ↓   │
│         └────────────────┴────────────────┘   │
│                          ↓                      │
│              ┌──────────────────┐              │
│              │ Aggregate Results│              │
│              └──────────────────┘              │
│                          ↓                      │
│              ┌──────────────────┐              │
│              │  Report to User  │              │
│              └──────────────────┘              │
└─────────────────────────────────────────────────┘

             HOOKS (Automated Triggers)
                         ↓
        ┌────────────────┼────────────────┐
        ↓                ↓                 ↓
   PreToolUse      PostToolUse      SubagentStop
   (Validate)        (Audit)        (Aggregate)
```

---

## 📊 Comparaison Patterns

| Pattern | Speedup | Complexity | Use Case |
|---------|---------|------------|----------|
| **Parallel** | 5-20x | Medium | Independent tasks |
| **Sequential** | 1x (quality) | Low | Validation gates |
| **Batch** | 10-15x | High | Large datasets |
| **Conditional** | Varies | Medium | Dynamic workflows |

---

## 💡 Best Practices

### ✅ DO
- **Always COMMAND coordinates** - Never let agents spawn agents
- **Use hooks for automation** - Reduce manual intervention
- **Parallel when possible** - 5-20x speedup for independent tasks
- **Batch large datasets** - Process 10-20 items per wave
- **Skills for shared knowledge** - Avoid duplication

### ❌ DON'T
- **Never agent → agent** - Breaks flat hierarchy
- **Don't over-parallelize** - Respect resource limits
- **Don't skip validation** - Use quality gates
- **Don't hardcode** - Use Memory/Skills for config

---

## 🎓 Progression d'Apprentissage

```
1️⃣ Lire Orchestration Principles
    └─> Comprendre flat hierarchy

2️⃣ Étudier Command Coordination
    └─> Apprendre à orchestrer

3️⃣ Maîtriser Hook Automation
    └─> Automatiser lifecycle

4️⃣ Expérimenter Agent Orchestration
    └─> Optimiser execution (parallel/batch)

5️⃣ Appliquer dans Workflows
    └─> Combiner patterns dans RFP/CI-CD/etc.
```

---

## 📚 Ressources

### Documentation Interne
- 🎓 [Orchestration Principles](../orchestration-principles.md)
- 🚀 [Workflows](../workflows/README.md)
- 💎 [Best Practices](../best-practices/README.md)

### Documentation Officielle
- 📄 [Sub-Agents Coordination](https://code.claude.com/docs/en/sub-agents#coordination)
- 📄 [Hooks Guide](https://code.claude.com/docs/en/hooks-guide)
- 📄 [Skills Deep Dive](https://code.claude.com/docs/en/skills)

### Articles
- 📝 [Anthropic Engineering - Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- 📝 [AI Orchestration 2025](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)

---

## 🎯 Points Clés

✅ **COMMAND** = Coordinateur, jamais exécuteur
✅ **HOOKS** = Automation lifecycle (validation, audit, aggregation)
✅ **AGENTS** = Exécuteurs atomiques, jamais coordinateurs
✅ **Flat Hierarchy** = Jamais agent → agent, toujours COMMAND → agents
✅ **Parallel** = 5-20x speedup pour tasks indépendantes
✅ **Skills** = Shared knowledge pour éviter duplication

---

**Prochaines Étapes** :
1. Lire [Command Coordination](./command-coordination.md)
2. Expérimenter avec [Hook Automation](./hook-automation.md)
3. Optimiser avec [Agent Orchestration](./agent-orchestration.md)
