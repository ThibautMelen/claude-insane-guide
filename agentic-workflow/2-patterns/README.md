# Les 6 Patterns Composables d'Anthropic

> **Building Effective Agents** : Les 6 patterns fondamentaux pour construire des agents robustes et scalables.

---

## 🎯 Vue d'Ensemble

Anthropic a identifié **6 patterns composables** pour construire des systèmes agentiques efficaces. Ces patterns peuvent être **combinés** pour créer des workflows complexes et production-ready.

```
╔═══════════════════════════════════════════════════════════╗
║       LES 6 PATTERNS COMPOSABLES ANTHROPIC 2025           ║
╚═══════════════════════════════════════════════════════════╝

1. PROMPT CHAINING
   └─> Décomposer tâche en séquence fixe (A→B→C)
   └─> Notre implémentation: EPCT Workflow

2. ROUTING
   └─> Classifier input et diriger vers specialist
   └─> Notre implémentation: Skills auto-invocation

3. PARALLELIZATION
   └─> Exécuter tâches indépendantes simultanément
   └─> Notre implémentation: Parallel Execution Pattern

4. ORCHESTRATOR-WORKERS
   └─> Orchestrateur délègue dynamiquement aux workers
   └─> Notre implémentation: Command-Subcommand-Agent

5. EVALUATOR-OPTIMIZER
   └─> Generator ↔ Evaluator loop (raffinement itératif)
   └─> Notre implémentation: Quality Loop Pattern

6. AUTONOMOUS AGENTS
   └─> LLM contrôle dynamiquement son propre processus
   └─> Notre implémentation: Workers (not fully autonomous)
```

---

## 📋 Les 6 Patterns en Détail

### 1. Prompt Chaining ✅

**Concept** : Séquence **fixe** d'appels LLM (A→B→C).

**Architecture** :
```
Input → LLM₁ → Output₁ → LLM₂ → Output₂ → LLM₃ → Final Output
```

**Quand utiliser** :
- Tâche décomposable en steps fixes
- Chaque step rend problème plus simple
- Trade-off latence/accuracy acceptable

**Notre implémentation** :
- ✅ **EPCT Workflow** (Explore→Plan→Code→Test)
- ✅ Gates de validation entre steps
- ✅ 95% success rate vs 50% one-shot

**Fichier** : [1-prompt-chaining.md](./1-prompt-chaining.md)

---

### 2. Routing ✅

**Concept** : Classifier input et diriger vers **specialist adapté**.

**Architecture** :
```
Input → Classifier → Path A/B/C → Selected Specialist → Result
```

**Quand utiliser** :
- Catégories distinctes (support/sales/refund)
- Chaque type mieux géré séparément
- Classification précise possible

**Notre implémentation** :
- ✅ **Skills auto-invocation** (LLM reasoning sur descriptions)
- ✅ **WHEN/WHEN NOT pattern** (clear boundaries)
- ✅ 22% accuracy improvement vs generalist

**Fichier** : [2-routing.md](./2-routing.md)

---

### 3. Parallelization ✅

**Concept** : Exécuter tâches **indépendantes simultanément**.

**Architecture** :
```
Input → Split → [LLM₁ || LLM₂ || LLM₃] → Aggregate → Result
```

**Variantes** :
- **Sectioning** : Sous-tâches parallèles (different inputs)
- **Voting** : Même tâche multiple fois (consensus)

**Quand utiliser** :
- Tâches indépendantes (parallélisables)
- Speedup critique (5-20x)
- Perspectives multiples (voting)

**Notre implémentation** :
- ✅ **Parallel Execution Pattern** (Task tool, same message)
- ✅ **Batch processing** (10-20 workers/wave)
- ✅ **9.7x speedup** (200 locales: 25min → 2min35)

**Fichier** : [3-parallelization.md](./3-parallelization.md)

---

### 4. Orchestrator-Workers ✅

**Concept** : Orchestrateur **décide dynamiquement** subtasks, délègue aux workers.

**Architecture** :
```
Orchestrator (LLM)
  ↓
[Analyze → Decide subtasks dynamically]
  ↓
Workers [A || B || C]
  ↓
Orchestrator synthesizes
```

**Différence clé vs Parallelization** :
- Parallelization : Subtasks **prédéfinies** (hardcoded)
- Orchestrator-Workers : Subtasks **dynamiques** (LLM décide)

**Quand utiliser** :
- Subtasks imprévisibles (nombre/type variable)
- Complexité empêche hardcoding
- Flexibilité > prédictibilité

**Notre implémentation** :
- ✅ **Command-Subcommand-Subagent** (hiérarchie recommandée)
- ✅ **Command orchestre, Subagent exécute** (règle officielle)
- ✅ **2-3 niveaux recommandés** (Command → Coordinator Subagent → Worker Subagent)

**Fichier** : [4-orchestrator-workers.md](./4-orchestrator-workers.md)

---

### 5. Evaluator-Optimizer ⭐ (NOUVEAU)

**Concept** : **Generator ↔ Evaluator loop** (raffinement itératif).

**Architecture** :
```
Input → Generator → Draft v1 → Evaluator → Score + Feedback
         ↑                                        ↓
         └─────────── [Refine loop] ─────────────┘
                  (max 3-5 iterations)
```

**Quand utiliser** :
- Critères d'évaluation clairs (scoring 1-10)
- Raffinement itératif apporte valeur mesurable
- Quality > Speed (trade-off latence acceptable)

**Notre implémentation** :
- ⭐ **Quality Loop Pattern** (NOUVEAU)
- ⭐ Generator + Evaluator agents
- ⭐ Max 3 iterations (sweet spot quality/cost)

**Exemples** :
- Literary translation (95% → 99% quality)
- Complex search (60% → 95% completeness)
- Marketing copy (score 6/10 → 9/10)

**Fichier** : [5-evaluator-optimizer.md](./5-evaluator-optimizer.md)

---

### 6. Autonomous Agents ⚠️ (Clarification)

**Concept** : LLM **contrôle dynamiquement** son propre processus.

**Architecture** :
```
User Instruction
  ↓
Autonomous Agent (LLM)
  ↓
[Plan → Execute → Observe → Self-Evaluate → Loop]
  ↓
Agent décide Stop or Continue
```

**Clarification terminologie** :
- **Workers** (notre implémentation) : Command décide
- **Autonomous Agents** (Anthropic) : Agent décide

**Quand utiliser** :
- Problèmes ouverts (steps imprévisibles)
- Confiance LLM decision-making
- Sandbox trusté + guardrails

**Notre implémentation** :
- ✅ **Workers** (Pattern 4 : Orchestrator-Workers)
- ⚠️ **Autonomous Agents** = Use case future (sandbox required)

**Fichier** : [6-autonomous-agents.md](./6-autonomous-agents.md)

---

## 🎯 Framework de Décision

**Quel pattern utiliser pour ma tâche ?**

```
╔═══════════════════════════════════════════════════════════╗
║          DECISION TREE : QUEL PATTERN ?                   ║
╚═══════════════════════════════════════════════════════════╝

Tâche séquentielle fixe (A→B→C toujours) ?
└─ OUI → Pattern 1 : Prompt Chaining (EPCT)

Besoin de router vers specialist ?
└─ OUI → Pattern 2 : Routing (Skills)

Tâches indépendantes (speedup 5-20x) ?
└─ OUI → Pattern 3 : Parallelization

Subtasks dynamiques (nombre/type variable) ?
└─ OUI → Pattern 4 : Orchestrator-Workers

Output quality-critical (raffinement itératif) ?
└─ OUI → Pattern 5 : Evaluator-Optimizer

Problème complètement ouvert (sandbox) ?
└─ OUI → Pattern 6 : Autonomous Agents
```

---

## 📊 Mapping : Patterns → Notre Implémentation

| Pattern Anthropic | Notre Implémentation | Status | Fichier |
|-------------------|---------------------|--------|---------|
| **1. Prompt Chaining** | EPCT Workflow | ✅ Bien couvert | [1-prompt-chaining.md](./1-prompt-chaining.md) |
| **2. Routing** | Skills auto-invocation | ✅ Bien couvert | [2-routing.md](./2-routing.md) |
| **3. Parallelization** | Parallel Execution Pattern | ✅ Bien couvert | [3-parallelization.md](./3-parallelization.md) |
| **4. Orchestrator-Workers** | Command-Subcommand-Agent | ✅ Bien couvert | [4-orchestrator-workers.md](./4-orchestrator-workers.md) |
| **5. Evaluator-Optimizer** | Quality Loop Pattern | ⭐ NOUVEAU | [5-evaluator-optimizer.md](./5-evaluator-optimizer.md) |
| **6. Autonomous Agents** | Workers (not autonomous) | ⚠️ Clarification | [6-autonomous-agents.md](./6-autonomous-agents.md) |

---

## 🔗 Combinaison de Patterns

Les patterns sont **composables** - vous pouvez les combiner pour créer workflows complexes.

### Exemple : Enterprise RFP Workflow

```
╔═══════════════════════════════════════════════════════════╗
║       ENTERPRISE RFP (4 patterns combinés)                ║
╚═══════════════════════════════════════════════════════════╝

Pattern 1: Prompt Chaining (EPCT structure)
  ├─> Explore RFP requirements
  ├─> Plan response strategy
  ├─> Code implementation
  └─> Test validation

Pattern 2: Routing (Skills)
  ├─> Legal-Skill (contract analysis)
  ├─> Technical-Skill (solution design)
  └─> Financial-Skill (pricing)

Pattern 3: Parallelization (Multi-agents)
  ├─> Legal-Agent (parallel)
  ├─> Tech-Agent (parallel)
  └─> Finance-Agent (parallel)

Pattern 4: Orchestrator-Workers
  └─> Command orchestre 3 agents
      (décide dynamiquement si besoin plus d'analyse)
```

### Exemple : Global Localization (200 locales)

```
Pattern 1: Prompt Chaining (EPCT)
  ├─> Explore data sources
  ├─> Plan locale strategy
  ├─> Code generation logic
  └─> Test outputs

Pattern 2: Routing (Skills)
  └─> Locale-Technical-Knowledge Skill (auto-invoked)

Pattern 3: Parallelization (Batch)
  ├─> 10 waves × 20 agents
  └─> 9.7x speedup (25min → 2min35)

Pattern 5: Evaluator-Optimizer (Quality)
  └─> Validate each locale (completeness, format)
      If quality < 8/10 → Refine (max 3x)
```

---

## 💎 Best Practices

### ✅ DO

```
1. COMBINER PATTERNS
   ✅ EPCT + Parallel + Routing (workflows complexes)
   ✅ Evaluator-Optimizer + Orchestrator-Workers (quality)

2. RESPECTER HIÉRARCHIE
   ✅ Command orchestre (Pattern 4)
   ✅ Agents exécutent (workers)
   ✅ JAMAIS agent → agent

3. CHOISIR PATTERN ADAPTÉ
   ✅ Decision tree (voir ci-dessus)
   ✅ Mesurer ROI (speedup, quality, cost)

4. DOCUMENTATION CLAIRE
   ✅ Expliquer quel pattern utilisé
   ✅ Justifier choix (why this pattern?)
```

---

### ❌ DON'T

```
1. UTILISER MAUVAIS PATTERN
   ❌ Parallelization pour steps séquentiels
   ❌ Prompt Chaining pour tâches indépendantes

2. SURCHARGER (over-engineering)
   ❌ Pattern 5 pour simple task (overkill)
   ❌ Pattern 6 sans sandbox (unsafe)

3. IGNORER TRADE-OFFS
   ❌ Pattern 1 : Latence ↑
   ❌ Pattern 3 : Coordination overhead
   ❌ Pattern 5 : Cost 2-3x

4. CONFONDRE PATTERNS
   ❌ Parallelization ≠ Orchestrator-Workers
   ❌ Workers ≠ Autonomous Agents
```

---

## 📚 Ressources

### Documentation Anthropic Officielle

- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) ⭐ - Source officielle des 6 patterns
- 📄 [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### Articles Communauté

- 📝 [6 Composable Patterns (AIMultiple)](https://research.aimultiple.com/building-ai-agents/)
- 📝 [Design Patterns Agentic Workflows (HuggingFace)](https://huggingface.co/blog/dcarpintero/design-patterns-for-building-agentic-workflows)

### Documentation Interne

- 📐 [Orchestration Principles](../orchestration-principles.md) ⭐ - Règles d'or Anthropic
- 🏗️ [Architecture](../3-architecture/) - Command/Agent/Skill/Hooks
- 🚀 [Workflows](../4-workflows/) - Exemples concrets (RFP, CI-CD, Localization)

---

## 🎓 Points Clés

```
╔═══════════════════════════════════════════════════════════╗
║           6 PATTERNS COMPOSABLES ESSENTIALS               ║
╚═══════════════════════════════════════════════════════════╝

✅ 6 patterns fondamentaux (Anthropic 2025)
✅ Composables (combinables pour workflows complexes)
✅ 5/6 bien implémentés (Pattern 5 nouveau)
✅ Notre nomenclature: Command > Subcommand > Agent
✅ Workers (notre implémentation) ≠ Autonomous Agents
✅ Decision tree (quel pattern quand?)
✅ Trade-offs documentés (latence, cost, quality)

MAPPING:
1. Prompt Chaining → EPCT Workflow ✅
2. Routing → Skills auto-invocation ✅
3. Parallelization → Parallel Execution ✅
4. Orchestrator-Workers → Command-Agent ✅
5. Evaluator-Optimizer → Quality Loop ⭐
6. Autonomous Agents → Workers (clarified) ⚠️
```

---

## 🚀 Prochaines Étapes

1. ✅ Lire chaque pattern individuellement
2. ✅ Comprendre decision tree (quel pattern quand?)
3. ✅ Étudier exemples workflows (RFP, Localization)
4. ✅ Implémenter Pattern 5 (Evaluator-Optimizer) sur use case réel
5. ✅ Combiner patterns (EPCT + Parallel + Routing)
6. ✅ Mesurer ROI (speedup, quality, cost)

---

**Quote Anthropic** :
> "These six patterns form a composable toolkit for building effective agents. You can combine them to create sophisticated workflows while maintaining clarity and predictability."
> — Building Effective Agents, Anthropic Research 2025

**Règle d'Or** :
> **Comprendre les 6 patterns. Choisir le bon pattern. Combiner intelligemment.**
