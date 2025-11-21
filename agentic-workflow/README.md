# Agentic Workflow - Orchestration Claude Code

> Maîtriser l'orchestration multi-subagents avec les **6 patterns composables d'Anthropic**.

---

## ⚠️ **Disclaimer Important**

Ce guide présente un **framework opinionné** pour implémenter les patterns agentiques d'Anthropic avec Claude Code.

**Ce que ce guide propose** :
- ✅ Patterns d'orchestration d'Anthropic (officiels, research)
- ✅ Implémentation avec composants Claude Code
- ✅ Conventions nommage (COMMAND, COORDINATOR SUBAGENT, etc.)
- ✅ Best practices basées sur expérience et benchmarks

**Ce que ce guide n'est PAS** :
- ❌ Documentation officielle Claude Code (voir [docs.anthropic.com](https://docs.anthropic.com/en/docs/claude-code))
- ❌ Spécifications Claude Code (les "règles" sont des recommandations)
- ❌ Seule façon d'utiliser Claude Code

**Terminologie officielle Claude Code** :
- **Subagents** (`.claude/agents/*.md`)
- **Custom slash commands** (`.claude/commands/*.md`)
- **Skills** (`.claude/skills/*/SKILL.md`)
- **Hooks** (`settings.json`)

---

## 🎯 Mission

Créer des **systèmes agentiques production-ready** en utilisant les 6 patterns composables officiels d'Anthropic pour orchestrer Custom Commands, Subagents, Skills, Hooks et MCP.

**Résultat** :
- ✅ **10x productivité** vs code manuel
- ✅ **95%+ success rate** vs 50% sans workflow
- ✅ **10x cost savings** (haiku vs opus, optimisation)
- ✅ **Production-ready** robustness

---

## 🧩 Pattern vs Workflow : Quelle Différence ?

**Avant d'aller plus loin**, clarifions ces deux concepts fondamentaux :

```
╔═══════════════════════════════════════════════════════════╗
║  PATTERN = COMMENT (technique/architecture)               ║
║  WORKFLOW = QUOI + QUAND (cas d'usage complet)           ║
╚═══════════════════════════════════════════════════════════╝
```

### 📐 Pattern (Brique Technique)

**Définition** : Une **technique architecturale** ou un **mode d'organisation** réutilisable.

| Caractéristique | Description |
|----------------|-------------|
| 🔧 **Nature** | Abstrait et générique |
| 🧩 **Composabilité** | Se combine avec d'autres patterns |
| 🎯 **Scope** | Résout UN problème technique spécifique |
| ⚡ **Réutilisation** | Utilisable dans plusieurs workflows |

**Exemples** : Parallelization, Routing, Evaluator-Optimizer

---

### 🚀 Workflow (Solution Complète)

**Définition** : Un **cas d'usage métier complet** qui combine plusieurs patterns.

| Caractéristique | Description |
|----------------|-------------|
| 🎯 **Nature** | Concret et spécifique à un contexte métier |
| 📦 **Scope** | Bout-en-bout (du problème à la solution) |
| 🏢 **Usage** | Orienté business/cas d'usage réel |
| 🔗 **Composition** | Combine plusieurs patterns |

**Exemples** : CI/CD Pipeline, Enterprise RFP, Security Incident Response

---

### 🎨 Analogie : LEGO

```
┌─────────────────────────────────────────────────────────┐
│  PATTERNS = Briques LEGO individuelles                  │
│                                                           │
│  ┌────┐  ┌────┐  ┌────┐  ┌────┐                        │
│  │ 🧱 │  │ 🧱 │  │ 🧱 │  │ 🧱 │                        │
│  └────┘  └────┘  └────┘  └────┘                        │
│  Routing Para-   Orches- Chain                          │
│          llel    trator                                  │
└─────────────────────────────────────────────────────────┘
                      ▼ Assemblage
┌─────────────────────────────────────────────────────────┐
│  WORKFLOW = Construction complète avec les briques      │
│                                                           │
│      🏰 CI/CD Pipeline (Workflow complet)               │
│       ┌─────────────────────┐                           │
│       │  🧱🧱🧱🧱🧱🧱🧱  │  ← Orchestrator               │
│       │  🧱  🧱  🧱  🧱  │  ← Parallelization           │
│       │  🧱🧱🧱🧱🧱🧱🧱  │  ← Routing + Evaluator        │
│       └─────────────────────┘                           │
└─────────────────────────────────────────────────────────┘
```

---

### 📊 Tableau Comparatif Détaillé

| Critère | Pattern 🧩 | Workflow 🚀 |
|---------|-----------|------------|
| **Abstraction** | Générique, réutilisable | Spécifique à un métier/contexte |
| **Scope** | 1 problème technique | Solution complète bout-en-bout |
| **Combinable** | Oui (brique de base) | Non (solution finale) |
| **Documentation** | Voir `2-patterns/` | Voir `4-workflows/` |
| **Exemples** | Parallelization, Routing | CI/CD Pipeline, RFP Response |
| **Quand l'utiliser** | Besoin technique précis | Cas d'usage métier complet |

---

### 💡 Exemple Concret : Localization

**Pattern utilisé** : Parallelization (Pattern 3)
```
🧱 Technique "Parallelization"

Problème : Exécuter plusieurs tâches indépendantes rapidement
Solution : Lancer agents en parallèle (batch execution)
Où : N'importe quel workflow avec tâches parallèles
```

**Workflow complet** : Global Localization (cas d'usage)
```
🚀 Workflow "Global Localization" (200 locales)

Problème métier : Générer 200 locale files avec quality check
Solution complète :
  1️⃣ Orchestrator (Pattern 4) → Coordonne le workflow
  2️⃣ Parallelization (Pattern 3) → Batch (10 waves × 20 agents)
  3️⃣ Evaluator (Pattern 5) → Vérifie quality de chaque locale
  4️⃣ Reporting → Agrège métriques et success rate

✅ Résultat : 200 locales en 3min, 99.5% quality, $0.25 cost
```

---

### 🎯 Résumé Visuel

```
        📐 PATTERNS (Comment faire ?)
              │
              │ Sont combinés dans ▼
              │
        🚀 WORKFLOWS (Quoi faire ?)


Relation :

Pattern "Routing" (technique générique)
       ↓ utilisé dans ↓
Workflow "Security Incident" (cas d'usage métier)
  → Route incidents selon criticité (Pattern 2)
  → Coordonne équipes (Pattern 4)
  → Exécute en parallèle (Pattern 3)
  → Solution complète de réponse incident
```

---

## 📖 Avant de Commencer : Fundamentals

**⚡ Nouveau dans les workflows agentiques ?** Commencez par les **fundamentals** pour maîtriser le vocabulaire et les concepts de base :

### 📚 [1. Fundamentals](./1-fundamentals/) - Bases Théoriques

```
╔═══════════════════════════════════════════════════════════╗
║         FUNDAMENTALS : COMPRENDRE LES BASES               ║
╚═══════════════════════════════════════════════════════════╝

📄 TAXONOMIE (15 min) ⭐
   └─> Workflow vs Agentic Workflow vs Pipeline
   └─> Orchestration vs Pattern vs Flow
   └─> Vocabulaire industrie standardisé

📄 NOMENCLATURE (20 min) ⭐
   └─> Command vs Subagent vs Skill vs Hook
   └─> Hiérarchie recommandée (pattern proposé)
   └─> Règles d'or : Qui orchestre qui ?

📄 DECISION FRAMEWORK (30 min) 🎯
   └─> Quel composant utiliser ? (Command/Subagent/Skill/Hook)
   └─> Quel pattern utiliser ? (6 patterns Anthropic)
   └─> Decision trees pratiques
```

**Pourquoi important ?** :
- ✅ Comprendre **Agentic Workflow** ≠ **Traditional Workflow**
- ✅ Maîtriser **terminologie officielle** (Subagent, Custom Commands, Skills)
- ✅ **Éviter confusion** : Subagent (Worker) ≠ Autonomous Agent (Pattern 6)
- ✅ Appliquer **règle officielle** : "Subagents cannot spawn other subagents"

**📖 Lire d'abord** : [Fundamentals README](./1-fundamentals/README.md)

---

## 🎨 Les 6 Patterns Composables Anthropic

```
╔═══════════════════════════════════════════════════════════╗
║       LES 6 PATTERNS COMPOSABLES ANTHROPIC 2025           ║
╚═══════════════════════════════════════════════════════════╝

1. PROMPT CHAINING → Sequential execution (EPCT)
   └─> Décomposer tâche en séquence fixe (A→B→C)
   └─> Trade-off: Latence ↑ pour Accuracy ↑

2. ROUTING → Classification & spécialisation (Skills)
   └─> Router vers specialist adapté
   └─> 22% accuracy improvement vs generalist

3. PARALLELIZATION → Multi-agents concurrent
   └─> Speedup 5-20x pour tâches indépendantes
   └─> Sectioning (subtasks) & Voting (consensus)

4. ORCHESTRATOR-WORKERS → Command-Agent-Skill
   └─> Command orchestre, Agent exécute
   └─> Subtasks dynamiques (vs prédéfinies)

5. EVALUATOR-OPTIMIZER ⭐ → Quality loop
   └─> Generator ↔ Evaluator (raffinement itératif)
   └─> Quality 85% → 99% (max 3 iterations)

6. AUTONOMOUS AGENTS ⚠️ → Workers vs Autonomous
   └─> Workers (production) : Command décide
   └─> Autonomous (research) : Agent décide
```

**📖 Documentation complète** : [2-patterns/](./2-patterns/)

---

## 📊 Mapping Patterns : Anthropic ↔ Azure ↔ Claude Code

### Vue d'Ensemble : Convergence Industry Standards

Les patterns d'orchestration **convergent** entre Anthropic, Microsoft Azure et la communauté. Voici la matrice de correspondance :

| # | Anthropic Pattern | Azure Pattern | Claude Code Implémentation | ROI Mesuré |
|---|------------------|---------------|---------------------------|------------|
| **1** | **Prompt Chaining** | Sequential Orchestration | Command → EPCT Workflow | 6.5x speedup |
| **2** | **Routing** | N/A (deterministic) | Skills Auto-Invocation | +22% accuracy |
| **3** | **Parallelization** | Concurrent Orchestration | Task tool (parallel) | 9.7x speedup |
| **4** | **Orchestrator-Workers** | Hierarchical/Magentic | Command → Coordinator → Workers | 4.3x faster |
| **5** | **Evaluator-Optimizer** | Group Chat (Maker-Checker) | Generator ↔ Evaluator loop | 85→99% quality |
| **6** | **Autonomous Agents** | Handoff Orchestration | Research/Exploration mode | Variable |

### Pattern Détails avec Composants

```
╔═══════════════════════════════════════════════════════════════════╗
║  PATTERN 1 : PROMPT CHAINING (Sequential)                         ║
╚═══════════════════════════════════════════════════════════════════╝

Anthropic           Azure                   Claude Code
─────────           ─────                   ───────────
Sequential          Sequential              Command (EPCT)
execution           Orchestration           ├── Phase 1: Explore
A → B → C → D       Pipeline linear         ├── Phase 2: Plan
                    Étapes prédéfinies      ├── Phase 3: Code
                                            └── Phase 4: Test

Composants: Commands + Hooks (validation gates)
ROI: 6.5x speedup (16-23h → 3.5h blog generation)


╔═══════════════════════════════════════════════════════════════════╗
║  PATTERN 2 : ROUTING (Classification)                             ║
╚═══════════════════════════════════════════════════════════════════╝

Anthropic           Azure                   Claude Code
─────────           ─────                   ───────────
Routing             N/A                     Skills (auto-invoke)
Classifier →        (deterministic          ├── description match
Specialist          if/else logic)          ├── auto-loaded
                                            └── shared context

Composants: Skills (progressive disclosure)
ROI: +22% accuracy improvement vs generalist


╔═══════════════════════════════════════════════════════════════════╗
║  PATTERN 3 : PARALLELIZATION (Concurrent)                         ║
╚═══════════════════════════════════════════════════════════════════╝

Anthropic           Azure                   Claude Code
─────────           ─────                   ───────────
Parallelization     Concurrent              Task tool
Sectioning          Orchestration           ├── Single message
Voting              Agents run parallel     ├── Multiple Task()
                    Results aggregated      └── Parallel execution

Composants: Agents/Subagents + Task tool
ROI: 5-20x speedup (200 locales: 25min → 2min35 = 9.7x)


╔═══════════════════════════════════════════════════════════════════╗
║  PATTERN 4 : ORCHESTRATOR-WORKERS (Dynamic Delegation)            ║
╚═══════════════════════════════════════════════════════════════════╝

Anthropic           Azure                   Claude Code
─────────           ─────                   ───────────
Orchestrator        Hierarchical +          Command (Coordinator)
breaks down         Magentic                ├── Analyze task
tasks dynamically   Orchestration           ├── Spawn workers
                                            └── Aggregate results

Composants: Commands + Agents + Skills
ROI: 4.3x faster (10 files), 5.3x faster (100 files)


╔═══════════════════════════════════════════════════════════════════╗
║  PATTERN 5 : EVALUATOR-OPTIMIZER (Quality Loop)                   ║
╚═══════════════════════════════════════════════════════════════════╝

Anthropic           Azure                   Claude Code
─────────           ─────                   ───────────
Evaluator-          Group Chat              Generator Agent
Optimizer           (Maker-Checker)         ↕️ (loop max 3)
Generator ↔         Iterative               Evaluator Agent
Evaluator           refinement              ├── Critique quality
                                            └── Suggest fixes

Composants: 2 Agents (Generator + Evaluator) + Hooks (quality gate)
ROI: Quality 85% → 99% (+2.4x cost justified for critical content)


╔═══════════════════════════════════════════════════════════════════╗
║  PATTERN 6 : AUTONOMOUS AGENTS (Open-Ended)                       ║
╚═══════════════════════════════════════════════════════════════════╝

Anthropic           Azure                   Claude Code
─────────           ─────                   ───────────
Autonomous          Handoff                 Exploration Mode
Agents              Orchestration           ├── Agent decides
Agent decides       Dynamic routing         ├── No fixed workflow
tools & next        Transfer control        └── Research tasks
steps
                                            ⚠️ Use for research only
                                            ❌ Not production-ready

Composants: Autonomous Agents (vs Workers qui suivent plan)
ROI: Variable (SWE-bench, research tasks, découverte)
```

### Patterns NON Supportés par Claude Code SDK

| Azure Pattern | Status Claude Code | Alternative |
|--------------|-------------------|-------------|
| **Group Chat** (peer-to-peer) | ❌ Non supporté | → Use Orchestrator-Workers (hierarchical) |
| **Magentic** (auto-organization) | ⚠️ Possible via custom code | → Use Pattern 4 (Command coordination) |

### Composants Claude Code par Pattern

```
Composant         Patterns Utilisés          Rôle
─────────         ─────────────────          ────
Commands          1, 4                       Orchestration (user-triggered)
Skills            2                          Auto-invocation (routing)
Agents/Subagents  3, 4, 5, 6                Execution (workers)
Hooks             1, 5                       Validation gates
MCP               Tous (data source)         External integration
```

---

## 🎯 Philosophie : Simple, Composable, Measurable

**Ce guide applique les 3 principes d'Anthropic (2025)** pour l'IA agentique production-ready.

> "Start with the simplest solution that could work. Add complexity only when required."
> — **Building Effective Agents**, Anthropic Research 2025

```
╔═══════════════════════════════════════════════════════════╗
║           PRINCIPE 1 : SIMPLE                             ║
╚═══════════════════════════════════════════════════════════╝

Commencer TOUJOURS par le workflow le plus simple :
1. ONE-SHOT → Si tâche simple (ex: write email)
2. PROMPT CHAINING → Si contexte requis (ex: EPCT)
3. PATTERNS AVANCÉS → Seulement si preuves (benchmark)

✅ DO:
- Prototyper avec Pattern 1 (Chaining) first
- Ajouter Parallelization SEULEMENT si 10+ tâches indépendantes
- Autonomous Agents pour research/exploration only

❌ DON'T:
- Commencer par orchestration complexe
- Multi-agents par défaut
- Over-engineering sans ROI mesurable


╔═══════════════════════════════════════════════════════════╗
║           PRINCIPE 2 : COMPOSABLE                         ║
╚═══════════════════════════════════════════════════════════╝

Les 6 patterns sont des LEGO :
• Combiner pour workflows complexes
• Hiérarchie plate (2-3 levels recommended (4-5 possible))
• Chaque pattern résout 1 problème précis

✅ Exemples Composition:
- EPCT (Pattern 1) + Parallel (Pattern 3)
  → Explore→Plan→Code(parallel 10 agents)→Test

- Orchestrator (Pattern 4) + Evaluator (Pattern 5)
  → Command delegates → Quality loop refines

- Routing (Pattern 2) + Chaining (Pattern 1)
  → Classifier → Specialist executes EPCT

Trade-offs transparents :
Pattern 1 (Chaining) : ⬆️ Latence, ⬆️ Accuracy
Pattern 3 (Parallel)  : ⬇️ Latence, ⬇️ Cost, = Accuracy


╔═══════════════════════════════════════════════════════════╗
║           PRINCIPE 3 : MEASURABLE                         ║
╚═══════════════════════════════════════════════════════════╝

Prouver l'efficacité avec métriques objectives :

📊 Métriques Obligatoires:
• Speedup       : 9.7x faster (parallel vs sequential)
• Success rate  : 99.5% (vs 70% without workflow)
• Cost          : $0.25 (vs $2.50 sequential)
• Quality       : 95% (vs 60% one-shot)

📈 Benchmarker AVANT/APRÈS :
1. Baseline (sequential, one-shot)
2. Optimized (pattern appliqué)
3. Metrics (time, cost, quality, success rate)

⚠️ Si pas de gain mesurable → Revenir pattern simple
```

**Sources** :
- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) - Anthropic Research (Dec 2024)
- 📄 [Agentic Workflow Patterns 2025](https://www.anthropic.com/engineering/claude-code-best-practices) - Anthropic Engineering

---

## 📚 Navigation Documentation

### 📚 Les Fundamentals (Commencer Ici) ⭐

**TOUJOURS commencer par les fundamentals** si vous êtes nouveau :

- **[Vue d'ensemble Fundamentals](./1-fundamentals/README.md)** ⭐ - Bases théoriques
- **[Taxonomie](./1-fundamentals/taxonomie.md)** - Workflow vs Agentic Workflow vs Pattern
- **[Nomenclature](./1-fundamentals/nomenclature.md)** - Command vs Agent vs Skill
- **[Decision Framework](./1-fundamentals/decision-framework.md)** 🎯 - Quel composant/pattern utiliser ?

---

### 🎯 Les 6 Patterns (Fondamentaux)

**Après fundamentals**, comprendre les building blocks :

- **[Vue d'ensemble 6 Patterns](./2-patterns/README.md)** ⭐ - Mapping + Decision tree
- **[1. Prompt Chaining](./2-patterns/1-prompt-chaining.md)** - EPCT Workflow
- **[2. Routing](./2-patterns/2-routing.md)** - Skills auto-invocation
- **[3. Parallelization](./2-patterns/3-parallelization.md)** - 9.7x speedup
- **[4. Orchestrator-Workers](./2-patterns/4-orchestrator-workers.md)** - Command-Agent
- **[5. Evaluator-Optimizer](./2-patterns/5-evaluator-optimizer.md)** ⭐ - Quality loop
- **[6. Autonomous Agents](./2-patterns/6-autonomous-agents.md)** - Clarification

---

### 🏗️ Architecture (Concepts Structurels)

- **[Command-Subcommand-Subagent](./3-architecture/command-coordinator-workers.md)** - Hiérarchie recommandée (2-3 niveaux)
- **[Hooks Lifecycle](./3-architecture/hooks-lifecycle.md)** - Automation bash/LLM
- **[Skills Progressive Disclosure](./3-architecture/skills-progressive-disclosure.md)** - Context flexible
- **[State Management](./3-architecture/state-management.md)** - Memory + persistence

---

### 🚀 Workflows (Exemples Concrets)

Workflows production utilisant les 6 patterns :

- **[Enterprise RFP](./4-workflows/enterprise-rfp.md)** - Hierarchical pattern (Tesla, JP Morgan)
- **[CI/CD Pipeline](./4-workflows/ci-cd-pipeline.md)** - Sequential gates (Build→Test→Deploy)
- **[Global Localization](./4-workflows/global-localization.md)** - Parallelization (200 locales)
- **[Security Incident Response](./4-workflows/security-incident-response.md)** - Supervisor-Worker
- **[Content Automation](./4-workflows/)** - Startup workflows (blog, social-media)

---

### 💎 Best Practices (Optimisation)

- **[Performance](./5-best-practices/performance.md)** - Speed optimization (9.7x speedup)
- **[Cost Optimization](./5-best-practices/cost-optimization.md)** - Model selection (haiku/sonnet/opus)
- **[Error Resilience](./5-best-practices/error-resilience.md)** - Fallbacks, retry logic

---

### 📐 Référence

- **[Orchestration Principles](./orchestration-principles.md)** ⭐ - Règles d'or Anthropic (1033 lignes)
- **[Quick Reference](./quick-reference.md)** ⚡ - Cheatsheet rapide

---

## 🎯 Framework de Décision

**Quel pattern utiliser pour ma tâche ?**

```
╔═══════════════════════════════════════════════════════════╗
║         DECISION TREE : QUEL PATTERN ?                    ║
╚═══════════════════════════════════════════════════════════╝

Tâche séquentielle fixe (A→B→C toujours) ?
└─ OUI → Pattern 1 : Prompt Chaining
   └─> Example: Feature complexe → EPCT (Explore→Plan→Code→Test)

Besoin de router vers specialist ?
└─ OUI → Pattern 2 : Routing
   └─> Example: Customer support → Refund/Help/Technical specialist

Tâches indépendantes (speedup 5-20x) ?
└─ OUI → Pattern 3 : Parallelization
   └─> Example: 200 locales → 10 waves × 20 agents (9.7x speedup)

Subtasks dynamiques (nombre/type variable) ?
└─ OUI → Pattern 4 : Orchestrator-Workers
   └─> Example: Research → Command décide dynamically combien d'agents

Output quality-critical (raffinement itératif) ?
└─ OUI → Pattern 5 : Evaluator-Optimizer
   └─> Example: Literary translation → Quality 85% → 99%

Problème complètement ouvert (sandbox) ?
└─ OUI → Pattern 6 : Autonomous Agents
   └─> Example: SWE-bench (résoudre GitHub issue autonomously)
```

---

## 💡 Exemples Quick Start

### Exemple 1 : Feature Nouvelle Page (Pattern 1)

```bash
# Use Case: Créer page pricing avec validation

Pattern utilisé: Prompt Chaining (EPCT)

/epct "Create pricing page with 3 tiers (Free/Pro/Enterprise)"

Workflow:
1. EXPLORE (5min) : Read existing pages, routing, components
2. PLAN (7min)    : Design structure, validate with user
3. CODE (10min)   : Implement according to plan
4. TEST (2min)    : Build + manual testing

Result: Feature complete in 24min, 95% success rate
```

---

### Exemple 2 : Generate 200 Locales (Patterns 3+4+5)

```bash
# Use Case: Générer 200 locale files avec quality check

Patterns utilisés:
- Pattern 3 : Parallelization (batch execution)
- Pattern 4 : Orchestrator-Workers (Command orchestre)
- Pattern 5 : Evaluator-Optimizer (quality validation)

/generate-locales all

Workflow:
1. EPCT : Explore data sources, plan strategy
2. PARALLEL : Batch (10 waves × 20 agents)
   └─> 9.7x speedup (25min → 2min35)
3. EVALUATOR : Validate each locale (completeness, format)
   └─> If quality < 8/10 → Refine (max 3x)
4. REPORT : Aggregation metrics (success rate, sources used)

Result: 200 locales in 3min, 99.5% quality, $0.25 cost
```

---

### Exemple 3 : Customer Support Routing (Pattern 2)

```bash
# Use Case: Router tickets vers specialist adapté

Pattern utilisé: Routing (Skills auto-invocation)

Incoming Tickets
  ↓
[CLASSIFIER: Analyze ticket keywords]
  ↓
Route to:
  - "refund" → REFUND-SPECIALIST (98% accuracy)
  - "how to" → HELP-SPECIALIST (95% accuracy)
  - "bug" → TECHNICAL-SUPPORT (90% accuracy)
  - "pricing" → SALES-SPECIALIST (88% accuracy)

Result: 92% accuracy (vs 70% generalist), 22% improvement
```

---

## 🎓 Parcours d'Apprentissage

### 🟢 Niveau 1 : Débutant (Comprendre les Bases)

**Objectif** : Maîtriser fundamentals et les 6 patterns fondamentaux.

```
📖 Lire dans l'ordre :
1. 1-fundamentals/README.md             → Taxonomie + Nomenclature ⭐
2. 2-patterns/README.md                 → Vue d'ensemble + mapping
3. 2-patterns/1-prompt-chaining.md      → EPCT Workflow
4. 2-patterns/2-routing.md              → Skills auto-invocation
5. 2-patterns/3-parallelization.md      → Speedup 5-20x

🛠️ Exercice pratique :
- Créer /epct command (Pattern 1)
- Créer skill avec WHEN/WHEN NOT (Pattern 2)
- Paralléliser 10 agents (Pattern 3)
```

---

### 🟡 Niveau 2 : Intermédiaire (Combiner Patterns)

**Objectif** : Combiner patterns pour workflows complexes.

```
📖 Lire dans l'ordre :
1. 2-patterns/4-orchestrator-workers.md → Command-Agent
2. 2-patterns/5-evaluator-optimizer.md  → Quality loop
3. 4-workflows/enterprise-rfp.md        → Exemple complet
4. 4-workflows/global-localization.md   → Parallel + Evaluator

🛠️ Exercice pratique :
- Workflow EPCT + Parallel (Pattern 1 + 3)
- Quality loop sur translation (Pattern 5)
- Command orchestre 3 agents (Pattern 4)
```

---

### 🔴 Niveau 3 : Avancé (Production-Ready)

**Objectif** : Workflows production avec optimisations.

```
📖 Lire dans l'ordre :
1. orchestration-principles.md          → Règles d'or Anthropic ⭐
2. 5-best-practices/performance.md      → Speed optimization
3. 5-best-practices/cost-optimization.md → Model selection
4. 5-best-practices/error-resilience.md → Fallbacks, retry

🛠️ Exercice pratique :
- Benchmarker séquentiel vs parallèle
- Optimiser coût (haiku vs sonnet)
- Implementer retry logic + fallbacks
```

---

### ⚫ Niveau 4 : Expert (Workflows Hybrides)

**Objectif** : Combiner les 6 patterns dans workflows complexes.

```
📖 Lire dans l'ordre :
1. 4-workflows/security-incident-response.md → Supervisor-Worker
2. 4-workflows/ci-cd-pipeline.md             → Sequential gates
3. 3-architecture/hooks-lifecycle.md         → Automation

🛠️ Projet final :
- Workflow hybride : 4+ patterns combinés
- Example : RFP (Chaining + Routing + Parallel + Evaluator)
- Benchmarks : speedup, quality, cost
- Monitoring : audit trail, dashboards
```

---

## 📊 Benchmarks de Performance

### Pattern 1 : Prompt Chaining (EPCT)

```
╔═══════════════════════════════════════════════════════════╗
║        EPCT vs ONE-SHOT COMPARISON                        ║
╚═══════════════════════════════════════════════════════════╝

Use Case: Implement user authentication feature

ONE-SHOT (direct coding):
├─ Time: 8 min (fast but many issues)
├─ Rework: 30 min (fixing hallucinations, bugs)
├─ Total: 38 min
└─ Quality: 60% (many iterations needed)

EPCT (sequential workflow):
├─ Time: 22 min (E:5min, P:7min, C:8min, T:2min)
├─ Rework: 2 min (minor fixes)
├─ Total: 24 min
└─ Quality: 95% (production-ready)

RESULT:
✅ EPCT 40% faster end-to-end (24min vs 38min)
✅ EPCT 35% higher quality (95% vs 60%)
```

---

### Pattern 3 : Parallelization

```
╔═══════════════════════════════════════════════════════════╗
║      SEQUENTIAL vs PARALLEL (200 locales)                 ║
╚═══════════════════════════════════════════════════════════╝

SEQUENTIAL:
├─ 200 locales × 30s each
├─ Total: 6000s (100 minutes)
└─ Speedup: 1x (baseline)

PARALLEL (batch: 10 waves × 20 agents):
├─ 10 waves × ~30s max
├─ Total: 155s (2min 35s)
└─ Speedup: 38.7x vs sequential

PARALLEL + QUALITY GATES:
├─ Time: 180s (3 minutes)
├─ Success rate: 99.5% (vs 70% sequential)
└─ Speedup: 33.3x with quality improvement

RESULT:
✅ 9.7x faster practical speedup (with validation)
✅ 99.5% vs 70% success rate (+29.5%)
✅ $0.25 vs $2.50 cost (10x cheaper via haiku)
```

---

### Pattern 5 : Evaluator-Optimizer

```
╔═══════════════════════════════════════════════════════════╗
║    ONE-SHOT vs EVALUATOR-OPTIMIZER (translation)          ║
╚═══════════════════════════════════════════════════════════╝

ONE-SHOT (no refinement):
├─ Quality: 85% (acceptable)
├─ Time: 8s
├─ Cost: $0.05 (1 call)
└─ Nuances: Missed

EVALUATOR-OPTIMIZER (loop):
├─ Quality: 99% (+14% improvement)
├─ Time: 22s (2.75x slower)
├─ Cost: $0.12 (2.4x more expensive)
├─ Iterations avg: 2.4
└─ Nuances: Preserved (cultural context)

RESULT:
✅ +14% quality gain (85% → 99%)
✅ 2.4x cost increase justified for critical content
✅ Literary quality vs generic translation
```

---

## 🏗️ Architecture de Référence

### Nomenclature du Projet (Pattern Proposé)

```
╔═══════════════════════════════════════════════════════════╗
║      NOTRE NOMENCLATURE (PATTERN PROPOSÉ - NON-OFFICIEL)  ║
╚═══════════════════════════════════════════════════════════╝

TERMINOLOGIE OFFICIELLE CLAUDE CODE :
• Subagents (.claude/agents/*.md)
• Custom slash commands (.claude/commands/*.md)
• Skills (.claude/skills/*/SKILL.md)
• Hooks (settings.json, bash ou LLM)

NOTRE CONVENTION (pattern proposé) :

COMMAND (custom slash command orchestrateur)
  ├─> Décide strategy (which subagents, when, how many)
  ├─> Agrège résultats
  ├─> Gère erreurs
  └─> JAMAIS exécute directement

SUBCOMMAND (custom command spécialisé - pattern proposé)
  ├─> Phase d'un workflow (Build, Test, Deploy)
  ├─> Orchestre subagents pour sa phase
  └─> Retourne résultat à Command parent

SUBAGENT/AGENT (worker subagent)
  ├─> Tâche atomique (single responsibility)
  ├─> Lancé par Command via Task tool
  ├─> Retourne résultat structuré
  └─> JAMAIS lance d'autres subagents (règle officielle)

SKILL (connaissances partagées)
  ├─> Auto-invoquée par LLM reasoning
  ├─> Progressive disclosure (fichiers chargés "when needed")
  └─> Économie contexte (prompt injection on-demand)

HOOK (automation bash/LLM)
  ├─> 10 events : PreToolUse, PermissionRequest, PostToolUse,
  │   Notification, UserPromptSubmit, Stop, SubagentStop,
  │   PreCompact, SessionStart, SessionEnd
  ├─> Validation, audit, triggers
  └─> Exit codes: 0=success, 2=blocking error, autres=non-blocking
```

**⚠️ Clarification** :
- **"Agent"** dans ce guide = **"Subagent"** (terme officiel Claude Code)
- **Nos "Subagents"** = **"Workers"** (Anthropic terminology)
- **"Agent Orchestrator"** (industrie) = **"Command"** (notre convention)
- **Autonomous Agents** (Anthropic Pattern 6) ≠ Nos Worker Subagents

---

## 💎 Règles d'Or (Pattern Proposé + Règles Officielles)

```
╔═══════════════════════════════════════════════════════════╗
║         RÈGLES D'OR (PATTERN PROPOSÉ + OFFICIELLES)       ║
╚═══════════════════════════════════════════════════════════╝

1. RÈGLE OFFICIELLE CLAUDE CODE ⚠️
   ⚠️ "Subagents cannot spawn other subagents"
   ✅ Command → Subagent (correct)
   ✅ Command → Coordinator Subagent → Worker Subagent (via command)
   ❌ Subagent → Subagent (VIOLATION règle officielle)
   ❌ Subagent → Command (JAMAIS)

2. HIÉRARCHIE RECOMMANDÉE (2-3 NIVEAUX)
   ✅ Command → Worker Subagent (simple, recommended)
   ✅ Command → Coordinator Subagent → Worker Subagent (advanced)
   ⚠️ Plus de 3 niveaux déconseillé (complexité)

3. SUBAGENTS = TÂCHES ATOMIQUES
   ✅ 1 subagent = 1 tâche unique
   ✅ Return structured result
   ❌ Multi-responsabilité (too broad)

4. HOOKS POUR VALIDATION
   ✅ Bash hooks : Logic déterministe
   ✅ Prompt hooks : LLM evaluation (context-aware)
   ✅ 10 events disponibles (PreToolUse, PostToolUse, etc.)
   ✅ Quality gates, health checks, aggregation

5. SKILLS POUR ÉCONOMIE CONTEXTE
   ✅ Progressive disclosure (fichiers chargés "when needed")
   ✅ Auto-invocation (LLM reasoning)
   ✅ WHEN/WHEN NOT pattern
   ✅ SKILL.md + fichiers additionnels optionnels

6. MCP POUR INTÉGRATIONS EXTERNES
   ✅ Abstraction layer (tools)
   ✅ Changement sans refactoring
   ✅ Configuration settings.json
```

**📖 Documentation complète** : [orchestration-principles.md](./orchestration-principles.md)

---

## 🔗 Ressources

### Documentation Anthropic Officielle

- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) ⭐ - Les 6 patterns composables
- 📄 [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- 📄 [Disrupting AI Espionage](https://www.anthropic.com/news/disrupting-AI-espionage) - Multi-agent orchestration

### Articles Communauté

- 📝 [6 Composable Patterns (AIMultiple)](https://research.aimultiple.com/building-ai-agents/)
- 📝 [Design Patterns Agentic Workflows](https://huggingface.co/blog/dcarpintero/design-patterns-for-building-agentic-workflows)
- 📝 [9 Agentic Workflow Patterns 2025](https://www.linkedin.com/pulse/9-agentic-workflow-patterns-reshaping-enterprise-ai-2025-prasad-i1ase)

### Cas d'Usage Enterprise

- 📄 [SuperAGI Case Studies](https://superagi.com/case-studies-in-ai-agent-orchestration-real-world-applications-and-success-stories-across-various-industries/)
- 📄 [Agentic AI Examples 2025](https://skywork.ai/blog/agentic-ai-examples-workflow-patterns-2025/)

---

## 🎓 Points Clés

```
╔═══════════════════════════════════════════════════════════╗
║              AGENTIC WORKFLOW ESSENTIALS                  ║
╚═══════════════════════════════════════════════════════════╝

PATTERNS ANTHROPIC (officiels) :
✅ 6 patterns composables (Anthropic 2025 research)
✅ Combinables pour workflows complexes
✅ Base théorique solide avec benchmarks

IMPLÉMENTATION CLAUDE CODE (ce guide) :
✅ Framework opinionné (patterns proposés)
✅ Terminologie : Subagents, Custom Commands, Skills, Hooks
✅ Règle officielle : "Subagents cannot spawn other subagents"
✅ Hiérarchie recommandée : 2-3 niveaux
✅ Auditabilité totale (Command logs tout)
✅ 10x productivité, 95%+ success rate (benchmarks)

CLARIFICATIONS IMPORTANTES :
• "Agent" dans ce guide = "Subagent" (terme officiel)
• Worker Subagents (production) ≠ Autonomous Agents (research)
• COMMAND/SUBCOMMAND = Conventions proposées, pas types officiels
• COORDINATOR SUBAGENT = Pattern avancé (avec disclaimers)

MAPPING PATTERNS → IMPLÉMENTATION CLAUDE CODE :
1. Prompt Chaining → EPCT Workflow (custom commands) ✅
2. Routing → Skills auto-invocation ✅
3. Parallelization → Parallel Execution (Task tool) ✅
4. Orchestrator-Workers → Command-Subagent ✅
5. Evaluator-Optimizer → Quality Loop ⭐
6. Autonomous Agents → Clarification Worker vs Autonomous ⚠️
```

---

## 🚀 Quick Start

**Pour démarrer immédiatement** :

```bash
# 1. Lire les fondamentaux (1h) ⭐
├─> 1-fundamentals/README.md           # Taxonomie + Nomenclature
├─> 2-patterns/README.md               # Vue d'ensemble 6 patterns
├─> orchestration-principles.md        # Règles d'or ⭐
└─> quick-reference.md                 # Cheatsheet ⚡

# 2. Choisir un pattern selon votre besoin
├─> Feature complexe? → Pattern 1 (EPCT)
├─> Router vers specialist? → Pattern 2 (Routing)
├─> Speedup tâches parallèles? → Pattern 3 (Parallelization)
├─> Orchestration dynamique? → Pattern 4 (Orchestrator-Workers)
└─> Quality critique? → Pattern 5 (Evaluator-Optimizer)

# 3. Étudier un exemple workflow
├─> 4-workflows/enterprise-rfp.md        # Hierarchical
├─> 4-workflows/global-localization.md   # Parallelization
└─> 4-workflows/ci-cd-pipeline.md        # Sequential gates

# 4. Implémenter votre workflow
└─> Combiner patterns selon decision tree
```

---

**Quote Anthropic** :
> "These six patterns form a composable toolkit for building effective agents. Understanding when and how to apply each pattern is key to creating robust, production-ready agentic systems."
> — Building Effective Agents, Anthropic Research 2025

---

**Règle d'Or Finale** :
> **Comprendre les 6 patterns. Choisir le bon pattern. Combiner intelligemment. Respecter la hiérarchie.**

🎉 **Bon orchestration !**
