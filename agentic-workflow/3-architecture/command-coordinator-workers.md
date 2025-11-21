# Command Coordination - Orchestration Pattern

**Niveau** : Production
**Prérequis** : Orchestration Principles, Commands

---

## 📚 Vue d'Ensemble

Le **Command Coordination Pattern** implémente le principe fondamental d'Anthropic :

> **"COMMAND orchestrate, NEVER execute. Agents execute, NEVER coordinate."**

Ce pattern définit comment un COMMAND doit coordonner plusieurs agents sans jamais exécuter de tâches lui-même.

```
╔══════════════════════════════════════════════════╗
║         COMMAND = CHEF D'ORCHESTRE               ║
╚══════════════════════════════════════════════════╝
                      ↓
        ┌─────────────┴─────────────┐
        │  Responsibilities:         │
        │  ✅ Parse arguments        │
        │  ✅ Validate inputs        │
        │  ✅ Launch agents          │
        │  ✅ Aggregate results      │
        │  ✅ Report to user         │
        │                            │
        │  ❌ Execute tasks          │
        │  ❌ Read/Write files       │
        │  ❌ Call APIs              │
        └────────────────────────────┘
```

---

## 🏗️ Anatomy of a COMMAND

### Structure Template

```yaml
# .claude/commands/my-orchestrator.md
---
description: Coordinate [N] agents to [accomplish goal]
allowed-tools: Task, AskUserQuestion, Bash (git only)
---

## Phase 1: PARSE & VALIDATE
Parse user input and validate requirements.

Use AskUserQuestion if inputs are unclear or missing.

## Phase 2: ORCHESTRATE
Launch agents based on execution strategy:
- Parallel for independent tasks
- Sequential for dependent tasks
- Batch for large datasets (10-20 items/wave)

## Phase 3: AGGREGATE
Collect results from all agents.
Handle failures gracefully (retry once, then report).

## Phase 4: REPORT
Provide user summary:
- ✅ Successes (count + details)
- ❌ Failures (count + reasons)
- 📊 Metrics (time, cost, speedup)
```

---

## 📊 Execution Strategies

### 1. Parallel Execution (Independent Tasks)

**When**: Tasks don't depend on each other
**Speedup**: 5-20x
**Example**: Translation 15 languages

```yaml
## ORCHESTRATE: Parallel Strategy

Launch all agents concurrently:

Task(
  subagent_type="translator-es",
  description="Translate to Spanish",
  prompt="Translate content to Spanish using Translation-Memory skill"
)

Task(
  subagent_type="translator-fr",
  description="Translate to French",
  prompt="Translate content to French using Translation-Memory skill"
)

# ... 13 more agents in parallel

⚡ Speedup: 15x (15 languages × 20min = 300min → 20min)
```

**Implementation**:
```
┌──────────────────────────────────────────────┐
│              COMMAND                         │
│                                              │
│  Parse: ["es", "fr", "de", "it", ...]       │
│  Validate: All locales exist in mapping     │
│                                              │
│  Launch (PARALLEL):                          │
│         ┌──────────────────────────┐        │
│         ↓         ↓         ↓      ↓        │
│     ┌───────┐ ┌───────┐ ┌───────┐ ...      │
│     │Agent1 │ │Agent2 │ │Agent3 │          │
│     │  ES   │ │  FR   │ │  DE   │          │
│     └───────┘ └───────┘ └───────┘          │
│         ↓         ↓         ↓                │
│         └─────────┴─────────┘                │
│                   ↓                          │
│         Aggregate: 15/15 success ✅         │
│         Report: "Translated 15 languages"   │
└──────────────────────────────────────────────┘
```

---

### 2. Sequential Execution (Dependent Tasks)

**When**: Tasks must complete in order
**Speedup**: 1x (quality over speed)
**Example**: CI/CD pipeline (Build → Test → Deploy)

```yaml
## ORCHESTRATE: Sequential Strategy

Phase 1: BUILD
Task(
  subagent_type="builder",
  description="Build application",
  prompt="Run npm run build. BLOCK if fails."
)

✅ Wait for completion before Phase 2

Phase 2: TEST
Task(
  subagent_type="tester",
  description="Run test suite",
  prompt="Run npm test. Require coverage >80%. BLOCK if fails."
)

✅ Wait for completion before Phase 3

Phase 3: DEPLOY
Task(
  subagent_type="deployer",
  description="Deploy to production",
  prompt="Deploy to production. Auto-rollback if health checks fail."
)
```

**Implementation**:
```
┌────────────────────────────────────────────┐
│             COMMAND                        │
│                                            │
│  Phase 1: BUILD                            │
│       ↓                                    │
│  ┌─────────┐                               │
│  │ Builder │ → Success ✅                  │
│  └─────────┘                               │
│       ↓                                    │
│  Phase 2: TEST (only if build success)    │
│       ↓                                    │
│  ┌─────────┐                               │
│  │ Tester  │ → Coverage 85% ✅            │
│  └─────────┘                               │
│       ↓                                    │
│  Phase 3: DEPLOY (only if tests pass)     │
│       ↓                                    │
│  ┌──────────┐                              │
│  │ Deployer │ → Deployed ✅               │
│  └──────────┘                              │
│       ↓                                    │
│  Report: "Pipeline complete (60min)"      │
└────────────────────────────────────────────┘
```

---

### 3. Batch Processing (Large Datasets)

**When**: 100+ items to process
**Speedup**: 10-15x
**Batch Size**: 10-20 items per wave

```yaml
## ORCHESTRATE: Batch Strategy

Total: 200 locales
Batch size: 20 locales per wave
Waves: 10 waves (200 ÷ 20 = 10)

Wave 1: Locales 1-20
  Launch 20 agents in parallel
  Wait for completion

Wave 2: Locales 21-40
  Launch 20 agents in parallel
  Wait for completion

...

Wave 10: Locales 181-200 (20 agents)
  Launch 14 agents in parallel
  Wait for completion

Aggregate: 200/200 success ✅
```

**Implementation**:
```
┌──────────────────────────────────────────────────┐
│                  COMMAND                         │
│                                                  │
│  Parse: 200 locale codes                        │
│  Batch: Split into 10 waves (20 items each)      │
│                                                  │
│  ┌──────────────────────────────────────────┐  │
│  │ Wave 1 (Locales 1-20)                    │  │
│  │   Agent1 Agent2 ... Agent20 (parallel)   │  │
│  │   ✅ 20/20 success                        │  │
│  └──────────────────────────────────────────┘  │
│         ↓                                        │
│  ┌──────────────────────────────────────────┐  │
│  │ Wave 2 (Locales 21-40)                   │  │
│  │   Agent21 Agent22 ... Agent40 (parallel) │  │
│  │   ✅ 20/20 success                        │  │
│  └──────────────────────────────────────────┘  │
│         ↓                                        │
│       ... 7 more waves ...                      │
│         ↓                                        │
│  ┌──────────────────────────────────────────┐  │
│  │ Wave 9 (Locales 181-200)                 │  │
│  │   Agent161 ... Agent174 (parallel)       │  │
│  │   ✅ 14/14 success                        │  │
│  └──────────────────────────────────────────┘  │
│         ↓                                        │
│  Aggregate: 200/200 success ✅                  │
│  Report: "Generated 200 locales (3.5h)"        │
└──────────────────────────────────────────────────┘
```

---

## 🔄 Coordination Lifecycle

```
┌─────────────────────────────────────────────────┐
│              COMMAND LIFECYCLE                  │
└─────────────────────────────────────────────────┘
                      ↓
        ┌─────────────────────────┐
        │  1️⃣ PARSE ARGUMENTS    │
        │                         │
        │  • Extract inputs       │
        │  • Validate format      │
        │  • Set defaults         │
        └─────────────────────────┘
                      ↓
        ┌─────────────────────────┐
        │  2️⃣ VALIDATE INPUTS     │
        │                         │
        │  • Check requirements   │
        │  • Verify data sources  │
        │  • Ask user if unclear  │
        └─────────────────────────┘
                      ↓
        ┌─────────────────────────┐
        │  3️⃣ ORCHESTRATE AGENTS  │
        │                         │
        │  • Choose strategy      │
        │    (Parallel/Seq/Batch) │
        │  • Launch agents        │
        │  • Monitor progress     │
        └─────────────────────────┘
                      ↓
        ┌─────────────────────────┐
        │  4️⃣ AGGREGATE RESULTS   │
        │                         │
        │  • Collect outputs      │
        │  • Handle failures      │
        │  • Retry once (if fail) │
        └─────────────────────────┘
                      ↓
        ┌─────────────────────────┐
        │  5️⃣ REPORT TO USER      │
        │                         │
        │  • Summary stats        │
        │  • Success/Fail counts  │
        │  • Metrics (time/cost)  │
        └─────────────────────────┘
```

---

## 💡 Implementation Examples

### Example 1: RFP Orchestrator (3-Level Hierarchy)

```yaml
# .claude/commands/rfp-orchestrator.md
---
description: Automated RFP response with legal, technical, financial analysis
allowed-tools: Task, AskUserQuestion, Bash(git)
---

## PARSE
Extract RFP requirements:
- RFP document path
- Submission deadline
- Required sections

## VALIDATE
Verify inputs:
- RFP doc exists and readable
- Deadline is future date
- Required sections complete

Use AskUserQuestion if missing or unclear.

## ORCHESTRATE

### Phase 1: ANALYSIS (Parallel)
Launch 3 subcommands concurrently:

Task(
  subagent_type="rfp-analysis-subcommand",
  prompt="Coordinate legal, technical, financial analysis"
)

This subcommand launches 3 agents in parallel:
- Legal analyzer
- Technical analyzer
- Financial analyzer

### Phase 2: WRITING (Sequential after analysis)
Launch writing subcommand:

Task(
  subagent_type="rfp-writing-subcommand",
  prompt="Coordinate proposal writing based on analysis"
)

This subcommand launches 3 agents in parallel:
- Executive summary writer
- Technical proposal writer
- Pricing proposal writer

### Phase 3: REVIEW (Sequential after writing)
Launch review subcommand:

Task(
  subagent_type="rfp-review-subcommand",
  prompt="Coordinate quality review and compliance check"
)

This subcommand launches 3 agents in parallel:
- Legal reviewer
- Technical reviewer
- Final editor

## AGGREGATE
Collect all outputs:
- Analysis reports (3)
- Proposal sections (3)
- Review reports (3)

Total: 9 agent outputs

## REPORT
Provide user summary:
- ✅ RFP response complete
- 📊 Sections: 9/9 complete
- ⏱️ Time: 3.5 hours
- 💰 Cost: $750 (vs $25,500 manual)
- 🚀 Speedup: 96x
```

**Architecture**:
```
┌────────────────────────────────────────────────────────┐
│              RFP-ORCHESTRATOR (Main Command)           │
│                                                        │
│  ┌──────────────────────────────────────────────┐    │
│  │ Phase 1: ANALYSIS (Parallel)                 │    │
│  │   ↓                                          │    │
│  │ ┌──────────────────────────────────────────┐│    │
│  │ │ Analysis Subcommand                      ││    │
│  │ │   ├─ Legal Analyzer                      ││    │
│  │ │   ├─ Technical Analyzer                  ││    │
│  │ │   └─ Financial Analyzer                  ││    │
│  │ └──────────────────────────────────────────┘│    │
│  └──────────────────────────────────────────────┘    │
│                       ↓                               │
│  ┌──────────────────────────────────────────────┐    │
│  │ Phase 2: WRITING (Sequential)                │    │
│  │   ↓                                          │    │
│  │ ┌──────────────────────────────────────────┐│    │
│  │ │ Writing Subcommand                       ││    │
│  │ │   ├─ Executive Summary Writer            ││    │
│  │ │   ├─ Technical Proposal Writer           ││    │
│  │ │   └─ Pricing Proposal Writer             ││    │
│  │ └──────────────────────────────────────────┘│    │
│  └──────────────────────────────────────────────┘    │
│                       ↓                               │
│  ┌──────────────────────────────────────────────┐    │
│  │ Phase 3: REVIEW (Sequential)                 │    │
│  │   ↓                                          │    │
│  │ ┌──────────────────────────────────────────┐│    │
│  │ │ Review Subcommand                        ││    │
│  │ │   ├─ Legal Reviewer                      ││    │
│  │ │   ├─ Technical Reviewer                  ││    │
│  │ │   └─ Final Editor                        ││    │
│  │ └──────────────────────────────────────────┘│    │
│  └──────────────────────────────────────────────┘    │
│                       ↓                               │
│  Aggregate: 9/9 sections complete ✅                 │
│  Report: "RFP complete (3.5h, $750, 96x speedup)"   │
└────────────────────────────────────────────────────────┘
```

---

### Example 2: CI/CD Pipeline (Sequential)

```yaml
# .claude/commands/ci-cd-pipeline.md
---
description: Automated build, test, deploy pipeline with quality gates
allowed-tools: Task, Bash(git)
---

## PARSE
Extract deployment config:
- Target environment (staging/production)
- Branch to deploy
- Rollback strategy

## VALIDATE
Verify:
- Branch exists and up-to-date
- No uncommitted changes
- Environment config valid

## ORCHESTRATE

### Phase 1: BUILD
Launch build subcommand:

Task(
  subagent_type="build-subcommand",
  prompt="Coordinate parallel build for frontend and backend"
)

This launches 2 agents in parallel:
- Frontend builder (npm run build)
- Backend builder (cargo build --release)

🚨 BLOCK if either build fails

### Phase 2: TEST
Launch test subcommand:

Task(
  subagent_type="test-subcommand",
  prompt="Run comprehensive test suite"
)

This launches 3 agents in parallel:
- Unit tester (coverage >80%)
- Integration tester
- E2E tester

🚨 BLOCK if any test fails or coverage <80%

### Phase 3: DEPLOY
Launch deploy subcommand:

Task(
  subagent_type="deploy-subcommand",
  prompt="Deploy to environment with health checks"
)

This launches 3 agents sequentially:
1. Pre-deploy (backup current version)
2. Deploy (push to environment)
3. Post-deploy (health checks)

🚨 Auto-rollback if health checks fail

## AGGREGATE
Collect metrics:
- Build time
- Test coverage
- Deployment status
- Health check results

## REPORT
Provide user summary:
- ✅ Pipeline complete
- 🏗️ Built: Frontend + Backend
- 🧪 Tests: 247 passed, 0 failed (Coverage: 87%)
- 🚀 Deployed: Production
- ⏱️ Total time: 60 minutes
- 💰 Cost: $15 (vs $100 manual)
```

---

## 🎯 Best Practices

### ✅ DO

**1. COMMAND coordinates only**
```yaml
✅ Correct:
## ORCHESTRATE
Launch agents to process data:
Task(subagent_type="data-processor", ...)

❌ Incorrect:
## PROCESS DATA
Read data/input.json
Transform data
Write data/output.json
```

**2. Validate before orchestrating**
```yaml
✅ Correct:
## VALIDATE
Verify inputs exist and are valid.
Use AskUserQuestion if unclear.

## ORCHESTRATE
(only after validation)

❌ Incorrect:
## ORCHESTRATE
Launch agents immediately
(no validation)
```

**3. Aggregate results explicitly**
```yaml
✅ Correct:
## AGGREGATE
Collect results from all agents:
- Successes: [list]
- Failures: [list]
- Metrics: [stats]

❌ Incorrect:
(no aggregation, assumes agents report directly)
```

**4. Report comprehensive summary**
```yaml
✅ Correct:
## REPORT
Summary:
- ✅ Successes: 15/15 locales
- ❌ Failures: 0
- ⏱️ Time: 30 minutes
- 💰 Cost: $50
- 🚀 Speedup: 15x

❌ Incorrect:
## REPORT
"Done."
```

---

### ❌ DON'T

**1. Never execute tasks directly**
```yaml
❌ WRONG:
allowed-tools: Read, Write, Edit, Grep, Glob

❌ WRONG:
## PROCESS FILES
Read all markdown files
Update headers
Write changes
```

**2. Never launch agents from agents**
```yaml
❌ WRONG (in agent):
Task(subagent_type="another-agent", ...)

✅ CORRECT:
Only COMMANDS can launch agents
```

**3. Never skip error handling**
```yaml
❌ WRONG:
Launch 10 agents
Report success

✅ CORRECT:
Launch 10 agents
Handle failures (retry once)
Report successes AND failures
```

**4. Never hardcode configuration**
```yaml
❌ WRONG:
const API_KEY = "sk-xxx"
const locales = ["en", "fr", "de"]

✅ CORRECT:
Use Memory (.claude/CLAUDE.md) for config
Use AskUserQuestion for dynamic inputs
```

---

## 📊 Decision Framework

### Choosing Execution Strategy

```
┌─────────────────────────────────────────────┐
│         DECISION FRAMEWORK                  │
└─────────────────────────────────────────────┘
                    ↓
         Tasks independent?
                    ↓
              ┌─────┴─────┐
              │           │
            YES          NO
              ↓           ↓
        ┌─────────┐  ┌─────────┐
        │PARALLEL │  │SEQUENTIAL│
        └─────────┘  └─────────┘
              ↓           ↓
        Large dataset?  Validation needed?
              ↓           ↓
          ┌───┴───┐   ┌───┴───┐
          │       │   │       │
        YES      NO  YES      NO
          ↓       ↓   ↓       ↓
        BATCH  PARALLEL Sequential  Sequential
                       with gates  without gates
```

### Examples:

| Use Case | Tasks | Dependency | Dataset | Strategy |
|----------|-------|------------|---------|----------|
| Translation | 15 languages | None | Medium | **Parallel** |
| CI/CD | Build→Test→Deploy | Sequential | Small | **Sequential** |
| Locale Gen | 200 files | None | Large | **Batch (20/wave)** |
| RFP Response | Analysis→Writing→Review | Sequential | Medium | **Sequential (3 phases)** |
| Security Response | Triage→Contain→Recover | Sequential | Small | **Sequential with gates** |

---

## 🎓 Points Clés

✅ **COMMAND = Coordinator** - Never executes, only orchestrates
✅ **Parse → Validate → Orchestrate → Aggregate → Report** - Standard lifecycle
✅ **Choose strategy** - Parallel (speedup) vs Sequential (quality)
✅ **Batch large datasets** - 10-20 items per wave
✅ **Handle errors gracefully** - Retry once, then report
✅ **Use AskUserQuestion** - For unclear or missing inputs
✅ **Respect flat hierarchy** - Only COMMANDS launch agents

**Impact** : Orchestration claire = 5-96x speedup avec 0 erreur ✨

---

## 📚 Ressources

### Documentation Interne
- 🎓 [Orchestration Principles](../orchestration-principles.md)
- 🔗 [Hook Automation](./hook-automation.md)
- 🔗 [Agent Orchestration](./agent-orchestration.md)
- 🚀 [Workflows](../4-workflows/README.md)

### Documentation Officielle
- 📄 [Sub-Agents Coordination](https://code.claude.com/docs/en/sub-agents#coordination)
- 📄 [Commands Guide](https://code.claude.com/docs/en/slash-commands)

### Workflows Utilisant Ce Pattern
- 🎯 [Enterprise RFP](../4-workflows/enterprise-rfp.md) - 3-level hierarchy
- 🎯 [CI/CD Pipeline](../4-workflows/ci-cd-pipeline.md) - Sequential phases
- 🎯 [Global Localization](../4-workflows/global-localization.md) - Batch processing

---

**Prochaines Étapes** :
1. Lire [Hook Automation](./hook-automation.md) pour automatiser lifecycle
2. Expérimenter avec [Agent Orchestration](./agent-orchestration.md) pour optimiser execution
3. Appliquer dans vos workflows personnalisés
