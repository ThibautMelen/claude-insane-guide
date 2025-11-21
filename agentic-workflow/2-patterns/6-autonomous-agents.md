# Pattern 6 : Autonomous Agents (Clarification Terminologie)

> **📚 Vue d'ensemble complète** : Voir [6 Patterns README](./README.md)

## 🎯 En Bref

**Concept**: LLM contrôle dynamiquement son processus (Plan→Execute→Observe→Evaluate→Loop), décisions stratégiques autonomes.

**vs Workers (notre implémentation)**: Workers = tasks atomiques orchestrées par Command. Autonomous = agent décide tout.

**Notre choix**: Workers pour production (contrôle total), Autonomous pour research (flexibility)

---

## 🧩 Pattern vs Workflow

**Ce fichier documente un PATTERN** (brique technique réutilisable).

| Aspect | Description |
|--------|-------------|
| 🔧 **Type** | Pattern architectural (autonomie décisionnelle) |
| 🎯 **Problème résolu** | Tâches ouvertes où steps sont imprévisibles |
| 🧩 **Combinable avec** | Pattern 4 (Workers) pour production, Evaluator pour validation |
| 🚀 **Utilisé dans workflows** | SWE-bench, Research exploration, Unknown bug resolution |

**Voir** : [Pattern vs Workflow Définition](../README.md#-pattern-vs-workflow--quelle-différence-)

⚠️ **Note importante** : Ce pattern documente la distinction **Workers (production) vs Autonomous (research)**.

## 📐 Deux Architectures

```
╔═════════════════════════════════════════════════╗
║ WORKERS (Command orchestre) ✅ Production       ║
╚═════════════════════════════════════════════════╝

Command décide:
  ├─> "Launch Agent A, then B"
  ├─> Agent A (task atomique) → Return result
  └─> Agent B (task atomique) → Return result

Control: Command
Decision: Command
Production-ready: ✅ YES

───────────────────────────────────────────────────

╔═════════════════════════════════════════════════╗
║ AUTONOMOUS (Agent décide) ⚠️ Research           ║
╚═════════════════════════════════════════════════╝

Agent décide:
  ├─> Plan: "I need to read, write, test"
  ├─> Execute: Use tools autonomously
  ├─> Observe: Ground truth (tests pass?)
  └─> Evaluate: "Continue? Stop?"

Control: Agent
Decision: Agent
Production-ready: ⚠️ NO (requires sandbox)
```

## 💡 Différences Clés

```
Dimension         | Workers ✅       | Autonomous ⚠️
──────────────────|──────────────────|──────────────
Control           | Command décide   | Agent décide
Planning          | Prédéfini        | Dynamique (LLM)
Tool usage        | Fixé par Command | Agent choisit
Loop logic        | Command loop     | Agent loop
Stop condition    | Command décide   | Agent self-evaluate
Autonomie         | Faible (worker)  | Haute (autonomous)
Production ready  | ✅ OUI           | ⚠️ Requires sandbox
```

## 🎯 Quand Utiliser Quoi

```yaml
Tâche prévisible (steps connus)?
  → Workers ✅
    Example: Generate 200 locales

Tâche ouverte (steps imprévisibles)?
  → Autonomous Agents ⚠️
    Example: Solve unknown GitHub bug

Production (audit, control)?
  → Workers ✅

Research (exploration, prototype)?
  → Autonomous Agents ⚠️ (avec sandbox)
```

## ⚖️ Trade-offs : Workers vs Autonomous

| Dimension | Workers ✅ (Production) | Autonomous ⚠️ (Research) |
|-----------|------------------------|-------------------------|
| **Control** | ⬆️ Command décide tout | ⬇️ Agent décide autonome |
| **Predictability** | ⬆️ Steps prédéfinis | ⬇️ Steps dynamiques |
| **Auditability** | ⬆️ Logs complets, traçabilité | ⬇️ Décisions opaques LLM |
| **Scalability** | ⬆️ Parallel workers facile | ⬇️ Autonomous agents complexe |
| **Production-ready** | ✅ OUI (robuste) | ⚠️ NON (requires sandbox) |
| **Flexibility** | ⬇️ Rigide (steps fixes) | ⬆️ Adaptatif (open-ended) |
| **Use case** | Tâches prévisibles | Problèmes ouverts |

**Verdict** :
- ✅ **Workers (Pattern 4)** : Default pour production (contrôle, audit, scalabilité)
- ⚠️ **Autonomous (Pattern 6)** : Seulement research avec sandbox (flexibility, exploration)

---

## 🎯 Best Practices

### ✅ DO (Workers - Production)
- Command orchestre toujours
- Tâches atomiques (1 worker = 1 task)
- Context isolé (no shared state)
- Production standards (error handling, logs)

### ⚠️ DO (Autonomous - Research)
- Sandbox obligatoire
- Stopping conditions (max iterations, timeout)
- Monitoring temps réel
- Trust but verify (human validation)

### ❌ DON'T
- Confondre terminologie (spécifier "Worker" vs "Autonomous")
- Autonomous en production sans sandbox
- Workers sans Command (jamais agent→agent)
- Autonomous sans limits (max iterations obligatoire)

## 🎓 Points Clés

```
WORKERS (nos "Agents") ✅
├─ Tasks atomiques prédéfinies
├─ Command orchestre (control total)
├─ Production-ready (audit + scalable)
└─ Use: Tâches prévisibles, production

AUTONOMOUS (Anthropic definition) ⚠️
├─ LLM contrôle dynamiquement
├─ Plan→Execute→Observe→Loop
├─ Requires sandbox + guardrails
└─ Use: Problèmes ouverts, research

NOTRE CHOIX ✅
├─ Workers pour production
├─ Autonomous pour futur (avec sandbox)
└─ Clarté terminologie (Worker > Agent)
```

## 🔗 Ressources

- 📄 [Vue d'ensemble 6 Patterns](./README.md)
- 📐 [Pattern 4: Orchestrator-Workers](./4-orchestrator-workers.md) (notre implémentation)
- 📐 [Command-Subcommand-Agent](../3-architecture/command-coordinator-workers.md)
- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents)
