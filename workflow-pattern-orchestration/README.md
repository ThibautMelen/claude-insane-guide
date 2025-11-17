# Workflow Pattern Orchestration - Vue d'Ensemble

**Mission** : Maîtriser l'orchestration avancée de Claude Code en combinant workflows, patterns et best practices pour créer des systèmes production-ready complexes.

> 📐 **Architecture** : Workflows (séquences) + Patterns (structures) + Best Practices (optimisations) = Orchestration complète

---

## 🎯 Qu'est-ce que l'Orchestration ?

**Orchestration** = Coordination intelligente de **multiples fonctionnalités Claude Code** (Commands, Agents, Skills, Hooks, MCP) pour créer des workflows production complexes, robustes et scalables.

```
╔═══════════════════════════════════════════════════════════╗
║              ARCHITECTURE D'ORCHESTRATION                  ║
╚═══════════════════════════════════════════════════════════╝

Niveau 1 : WORKFLOWS (Comment séquencer)
   ├─ Séquentiel  : EPCT (Explore-Plan-Code-Test)
   ├─ Parallèle   : Multi-agents concurrent
   ├─ Conditionnel: Decision trees + fallbacks
   └─ Hybride     : Combinaison de tout

              ↓ utilise ↓

Niveau 2 : PATTERNS (Comment structurer)
   ├─ Command-Agent-Skill : Hiérarchie orchestration
   ├─ Error Handling      : Fallback chains + retry
   ├─ Parallel Execution  : Batching + aggregation
   └─ State Management    : Context + persistence

              ↓ optimise ↓

Niveau 3 : BEST PRACTICES (Comment optimiser)
   ├─ Performance      : Speed, tokens, modèles
   ├─ Cost             : API usage, caching
   ├─ Error Resilience : Recovery, validation
   └─ Team Collaboration: Conventions partagées

              ↓ résultat ↓

🚀 PRODUCTION-READY ORCHESTRATION
   ✅ Robuste, scalable, maintenable
   ✅ 10x productivité vs code manuel
   ✅ Enterprise-grade reliability
```

---

## 📚 Structure de cette Documentation

```
workflow-pattern-orchestration/
├── README.md (← vous êtes ici)
│
├── workflows/           📊 Comment exécuter
│   ├── README.md             Vue d'ensemble workflows
│   ├── epct.md               Explore-Plan-Code-Test détaillé
│   ├── parallel.md           Multi-agents concurrent
│   ├── sequential.md         Step-by-step chaining
│   ├── conditional.md        Decision trees & fallbacks
│   └── hybrid.md             Combined orchestration ⭐
│
├── patterns/            🏗️ Comment structurer
│   ├── README.md             Vue d'ensemble patterns
│   ├── command-coordination.md    Commands orchestration
│   ├── hook-automation.md         Lifecycle automation
│   ├── agent-orchestration.md     Multi-agent patterns
│   └── state-persistence.md       Memory + context
│
└── best-practices/      ⚡ Comment optimiser
    ├── README.md             Vue d'ensemble optimisations
    ├── performance.md        Speed optimization
    ├── cost-optimization.md  Token usage, model selection
    ├── error-resilience.md   Fallbacks, retries
    └── team-collaboration.md Shared conventions
```

---

## 🎓 Parcours d'Apprentissage

### 🟢 Niveau 1 : Débutant (Comprendre)

**Objectif** : Maîtriser les workflows de base.

```
📖 Lire dans l'ordre :
1. workflows/README.md       → Comprendre types de workflows
2. workflows/sequential.md   → EPCT (Explore-Plan-Code-Test)
3. workflows/parallel.md     → Multi-agents parallèles
4. workflows/conditional.md  → Decision trees basiques

🛠️ Exercice pratique :
- Créer commande /epct pour une feature simple
- Paralléliser traitement de 5 fichiers
- Implémenter fallback Context7 → Perplexity
```

### 🟡 Niveau 2 : Intermédiaire (Structurer)

**Objectif** : Maîtriser les patterns d'architecture.

```
📖 Lire dans l'ordre :
1. patterns/README.md                 → Architecture patterns
2. patterns/command-coordination.md   → Command/Agent/Skill
3. patterns/agent-orchestration.md    → Multi-agent patterns
4. patterns/hook-automation.md        → Lifecycle automation

🛠️ Exercice pratique :
- Créer command + agent + skill pour use case réel
- Implémenter hooks PreToolUse + PostToolUse
- Orchestrer 3 agents spécialisés en parallèle
```

### 🔴 Niveau 3 : Avancé (Optimiser)

**Objectif** : Production-ready workflows.

```
📖 Lire dans l'ordre :
1. best-practices/README.md           → Optimisations overview
2. best-practices/performance.md      → Speed + tokens
3. best-practices/cost-optimization.md → API usage, modèles
4. best-practices/error-resilience.md  → Robustesse

🛠️ Exercice pratique :
- Benchmarker séquentiel vs parallèle
- Optimiser coût 174 locales (haiku vs sonnet)
- Implémenter retry logic + fallback chains
```

### ⚫ Niveau 4 : Expert (Orchestrer)

**Objectif** : Workflows hybrides complexes.

```
📖 Lire dans l'ordre :
1. workflows/hybrid.md                → Orchestration complexe
2. ../../advanced/ai-orchestration.md → Enterprise patterns
3. best-practices/team-collaboration.md → Shared conventions

🛠️ Projet final :
- Créer workflow hybride : EPCT + Parallel + Conditional + Hooks
- Exemple : Generate 174 locales avec fallback chains
- Benchmarks, rapports, monitoring
```

---

## 🎯 Framework de Décision

**Comment choisir le bon workflow pour votre tâche ?**

```
╔═══════════════════════════════════════════════════════════╗
║         DECISION TREE : Quel Workflow ?                   ║
╚═══════════════════════════════════════════════════════════╝

Quelle est la nature de la tâche ?
│
├─ FEATURE COMPLEXE (nouvelle page, intégration API)
│  └─→ SÉQUENTIEL (EPCT)
│     ✅ Explore : Comprendre contexte
│     ✅ Plan : Valider architecture
│     ✅ Code : Implémenter
│     ✅ Test : Vérifier
│     📖 Voir : workflows/epct.md
│
├─ TÂCHES INDÉPENDANTES (fix 10 files, generate locales)
│  └─→ PARALLÈLE (Multi-agents)
│     ✅ 2-10 items : Parallel single wave
│     ✅ 11-50 items : Batch (waves of 10)
│     ✅ >50 items : Batch (waves of 20)
│     📖 Voir : workflows/parallel.md
│
├─ VALIDATION / FALLBACK (API avec alternatives)
│  └─→ CONDITIONNEL (Decision trees)
│     ✅ Primary → Fallback 1 → Fallback 2 → User
│     ✅ Exit codes : 0=ok, 1=warn, 2=block
│     ✅ Retry logic intelligent
│     📖 Voir : workflows/conditional.md
│
└─ PRODUCTION WORKFLOW (complexe, multi-aspects)
   └─→ HYBRIDE (Orchestration)
      ✅ EPCT + Parallel + Conditional
      ✅ Commands + Agents + Skills + Hooks + MCP
      ✅ Enterprise-grade robustness
      📖 Voir : workflows/hybrid.md ⭐
```

---

## 💡 Exemples Concrets

### Exemple 1 : Fix Grammar (Parallel)

**Use case** : Corriger grammaire de 10 fichiers markdown.

```bash
# Command
/fix-grammar file1.md file2.md ... file10.md

# Workflow
Sequential : 10 × 12s = 120s (2 minutes)
Parallel   : max(12s) = 12s (10x speedup!)

# Pattern utilisé
workflows/parallel.md → Task tool, same message
```

### Exemple 2 : Nouvelle Feature (EPCT)

**Use case** : Créer page pricing avec validation.

```bash
# Command
/epct "Créer page pricing avec tiers Free/Pro/Enterprise"

# Workflow
1. EXPLORE : Lire architecture existante, docs Stripe
2. PLAN    : Proposer structure, valider avec user
3. CODE    : Implémenter selon plan approuvé
4. TEST    : Vérifier build + tests

# Pattern utilisé
workflows/epct.md → Méthodologie structurée
```

### Exemple 3 : Generate Locales (Hybride)

**Use case** : Générer 174 locale files avec API enrichment.

```bash
# Command
/generate-locales all

# Workflow orchestré
1. EPCT : Explore data sources, plan stratégie
2. PARALLEL : Batch (9 waves × 20 agents)
3. CONDITIONAL : Context7 → Perplexity → Firecrawl
4. HOOKS : Validation PostToolUse
5. REPORT : Aggregation metrics

# Pattern utilisé
workflows/hybrid.md ⭐ → All patterns combined
```

---

## 🏗️ Architecture de Référence

### Command/Agent/Skill/Hook Pattern

```
╔═══════════════════════════════════════════════════════════╗
║       ARCHITECTURE PRODUCTION (Locale Generator)           ║
╚═══════════════════════════════════════════════════════════╝

COMMAND /generate-locales
    ↓
┌─────────────────────────────────────┐
│ 1. Parse arguments (ar,de,fr...)   │
│ 2. Validate data sources            │
│ 3. Decide strategy (batch)          │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ HOOK PreToolUse : Check MCP health  │
│ → Context7 available?               │
│ → Rate limit OK?                    │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ PARALLEL AGENTS (Wave 1: 20 agents) │
│ ┌──────┐ ┌──────┐ ┌──────┐         │
│ │Agent1│ │Agent2│ │Agent3│ ...     │
│ └──┬───┘ └──┬───┘ └──┬───┘         │
│    │        │        │              │
│    └────────┴────────┴─→ Results   │
└─────────────────────────────────────┘
    ↓
Each AGENT:
    ↓
┌─────────────────────────────────────┐
│ SKILL @locale-technical-knowledge   │
│ → Read skeleton.md                  │
│ → Read sources.yaml                 │
│ → Follow best-practices.md          │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ CONDITIONAL : Fallback Chains       │
│ 1. Try local_data                   │
│ 2. Try derivation                   │
│ 3. Try Context7 MCP                 │
│ 4. Fallback Perplexity              │
│ 5. Fallback Firecrawl               │
│ 6. Block if all fail                │
└─────────────────────────────────────┘
    ↓
┌─────────────────────────────────────┐
│ HOOK PostToolUse : Validate output  │
│ → Check 9 sections present          │
│ → ISO codes valid                   │
│ → No placeholders                   │
└─────────────────────────────────────┘
    ↓
COMMAND aggregates all waves
    ↓
┌─────────────────────────────────────┐
│ REPORT FINAL                        │
│ ✅ 47/50 locales (94%)              │
│ ⚠️ 2 warnings (fallback used)       │
│ ❌ 1 failure (API timeout)          │
│                                     │
│ Sources breakdown:                  │
│ - Local data    : 120 fields (40%) │
│ - Derived       : 64 fields (21%)  │
│ - Context7      : 80 fields (27%)  │
│ - Perplexity    : 30 fields (10%)  │
│ - Firecrawl     : 6 fields (2%)    │
│                                     │
│ Next steps: Retry failed, review   │
└─────────────────────────────────────┘
```

**Pattern combinés** :
- ✅ EPCT (Explore → Plan → Code → Test)
- ✅ Parallel (9 waves × 20 agents = 180 total)
- ✅ Conditional (5-level fallback chains)
- ✅ Command/Agent/Skill (hiérarchie claire)
- ✅ Hooks (validation automatique)
- ✅ Error handling (retry logic, rapports)

---

## 📊 Benchmarks de Performance

### Séquentiel vs Parallèle vs Hybride

```
╔═══════════════════════════════════════════════════════════╗
║         PERFORMANCE COMPARISON (50 locales)                ║
╚═══════════════════════════════════════════════════════════╝

📊 SÉQUENTIEL (ancien pattern)
   50 locales × 30s chacune
   Total : 1500s (25 minutes)
   Speedup : 1x (baseline)

⚡ PARALLÈLE BRUT (50 agents simultanés)
   Overhead + timeouts + crashes
   ❌ Non viable en production

💡 HYBRIDE OPTIMISÉ (batch + fallback)
   5 waves × 10 agents × ~30s
   Total : 155s (2min 35s)
   Speedup : 9.7x plus rapide! ✅

🎯 HYBRIDE + HOOKS (production)
   Validation automatique + retry
   Total : 180s (3 minutes)
   Speedup : 8.3x
   Robustesse : 99.5% success rate
```

### Impact des Optimisations

```
╔═══════════════════════════════════════════════════════════╗
║           OPTIMISATIONS PROGRESSIVES                       ║
╚═══════════════════════════════════════════════════════════╝

Baseline (séquentiel naïf):
├─ Temps : 25 min
├─ Coût  : $2.50 (50 × sonnet)
└─ Fiabilité : 70% (no retry)

+ Parallel batching:
├─ Temps : 2min 35s (9.7x speedup)
├─ Coût  : $2.50 (même)
└─ Fiabilité : 75%

+ Haiku model pour agents:
├─ Temps : 2min 35s (même)
├─ Coût  : $0.25 (10x cheaper!) ✅
└─ Fiabilité : 75%

+ Fallback chains:
├─ Temps : 2min 45s (+10s overhead)
├─ Coût  : $0.30 (quelques Perplexity calls)
└─ Fiabilité : 95% (fallback saved 20%) ✅

+ Retry logic:
├─ Temps : 3min (+15s retries)
├─ Coût  : $0.35 (retry ~5 items)
└─ Fiabilité : 99% (retry saved 4%) ✅

+ Hooks validation:
├─ Temps : 3min (+1s hooks)
├─ Coût  : $0.35 (même)
└─ Fiabilité : 99.5% (caught edge cases) ✅

RÉSULTAT FINAL:
✅ 8.3x plus rapide
✅ 7x moins cher
✅ 99.5% fiabilité (vs 70%)
```

---

## 🎯 Best Practices Globales

### ✅ DO

```
1. PLANIFIER AVANT CODER
   ├─ Utiliser EPCT pour features complexes
   ├─ Valider plan avec user avant implémentation
   └─ Éviter hallucinations par contexte optimal

2. PARALLÉLISER TÂCHES INDÉPENDANTES
   ├─ Task tool, même message (seule façon!)
   ├─ Batch size 10-20 pour large scale
   └─ 5-10x speedup garanti

3. FALLBACK CHAINS POUR APIS EXTERNES
   ├─ Primary → Fallback 1 → Fallback 2 → User
   ├─ Retry une seule fois (max 2 tentatives)
   └─ Transparence : logger sources utilisées

4. HOOKS POUR AUTOMATION DÉTERMINISTE
   ├─ Validation automatique (PostToolUse)
   ├─ Health checks (PreToolUse)
   └─ Exit codes standardisés (0/1/2)

5. OPTIMISER COÛT/VITESSE
   ├─ Haiku pour tâches simples (10x cheaper)
   ├─ Sonnet pour reasoning complexe
   └─ Opus rarement (cost prohibitif)

6. RAPPORTS DÉTAILLÉS
   ├─ Metrics : success rate, sources, timing
   ├─ Errors : détails + suggestions actionables
   └─ Next steps : que faire ensuite
```

### ❌ DON'T

```
1. CODER SANS PLAN
   ❌ Prompt direct → hallucinations fréquentes
   ✅ EPCT → contexte optimal → 95% succès

2. SÉQUENTIEL POUR TÂCHES PARALLÉLISABLES
   ❌ 10 files × 12s = 120s
   ✅ max(12s) = 12s (10x speedup)

3. RETRY INFINI
   ❌ Boucles infinies, coût explosion
   ✅ 1 retry max, puis user validation

4. IGNORER RATE LIMITS
   ❌ API bans, crashes
   ✅ Monitor + failfast + fallback

5. OPUS PARTOUT
   ❌ $50 pour 174 locales
   ✅ Haiku : $0.25 (même qualité pour tâches simples)

6. RAPPORTS VAGUES
   ❌ "Some errors occurred" (inutile)
   ✅ Détails précis + next steps
```

---

## 🔗 Ressources Complémentaires

### Documentation Interne

```
📚 Guides Thématiques
├─ themes/1-memory/         → Foundation (CLAUDE.md)
├─ themes/2-commands/       → Slash commands
├─ themes/5-agents/         → Sub-agents
├─ themes/6-hooks/          → Lifecycle automation
├─ themes/4-mcp/            → MCP servers
└─ themes/10-interactive-ui/ → AskUserQuestion (migré → advanced/)

🎯 Patterns Avancés
├─ patterns/command-agent-skill.md    → Architecture hiérarchique
├─ patterns/error-handling.md         → Fallback chains
├─ patterns/parallel-execution.md     → Batching + aggregation
└─ patterns/state-management.md       → Context + persistence

🚀 Advanced Guides
├─ advanced/ai-orchestration.md       → Enterprise patterns
├─ advanced/decision-trees.md         → Quand utiliser quoi
├─ advanced/interactive-ui.md         → Multi-dialog patterns (Theme 10 migré)
└─ advanced/enterprise-patterns.md    → Production workflows
```

### Documentation Externe

```
📄 Claude Code Docs
├─ https://code.claude.com/docs
├─ https://code.claude.com/docs/task-tool
├─ https://code.claude.com/docs/hooks
└─ https://www.anthropic.com/engineering/claude-code-best-practices

🔗 Repos Communauté
├─ fix-grammar (parallel pattern)
│  https://github.com/wshobson/commands
├─ generate-locales (batch pattern)
│  https://github.com/edmund-io/edmunds-claude-code
└─ pr-review-toolkit (hybrid workflow)
   https://github.com/VoltAgent/awesome-claude-code-subagents
```

---

## 🎓 Conclusion

L'**orchestration** de Claude Code combine :

1. **Workflows** → Comment exécuter (séquentiel/parallèle/conditionnel/hybride)
2. **Patterns** → Comment structurer (command/agent/skill/hook)
3. **Best Practices** → Comment optimiser (performance/coût/robustesse)

**Résultat** :
- ✅ **10x productivité** vs code manuel
- ✅ **95%+ success rate** vs 50% sans workflow
- ✅ **10x cost savings** (haiku vs opus)
- ✅ **Production-ready** robustness

**Prochaine étape** :
1. Choisir votre niveau (débutant/intermédiaire/avancé/expert)
2. Suivre parcours d'apprentissage
3. Implémenter votre premier workflow orchestré
4. Itérer et optimiser

**Quote inspirante** :
> "Le workflow EPCT permet d'éviter les hallucinations et d'avoir un résultat de qualité à chaque fois."
> — Melvynx, Formation Claude Code 2.0

> "D.R.Y. (Don't Repeat Yourself) - Let Claude remember your preferences"
> — Edmund Yong, 800h Claude Code

> "Launch ALL agents in SINGLE message. Do NOT wait between calls. → 10x speedup"
> — Parallel Execution Pattern

🚀 **Bon orchestration !**
