# Decision Framework - Quel Composant et Pattern Utiliser ?

> Framework de décision complet pour choisir le bon composant (Command/Agent/Skill) et le bon pattern (Chaining/Parallel/Orchestrator-Workers/etc.)

---

## 🎯 Objectif

Répondre aux questions :
1. **Composant** : Command, Agent, Skill, ou Hook ?
2. **Pattern** : Quel pattern parmi les 6 patterns Anthropic ?
3. **Orchestration** : Hiérarchie à 2 ou 3 niveaux ?

---

## 📊 Decision Tree : Composant

```
╔═══════════════════════════════════════════════════════════╗
║         DECISION TREE : QUEL COMPOSANT ?                  ║
╚═══════════════════════════════════════════════════════════╝

QUESTION 1 : Qui invoque ?
├─ 👤 USER (explicit /command)
│   └─> COMMAND
│
├─ 🤖 CLAUDE (auto-invocation via reasoning)
│   └─> SKILL
│
├─ ⚙️ COMMAND (via Task tool)
│   └─> AGENT
│
└─ 🔔 EVENT (automatic trigger)
    └─> HOOK


QUESTION 2 : Orchestration ou Exécution ?
├─ 🎯 Orchestre plusieurs tâches
│   └─> COMMAND
│
├─ ⚡ Tâche atomique unique
│   └─> AGENT
│
├─ 📚 Base de connaissances
│   └─> SKILL
│
└─ ✅ Validation / Automation
    └─> HOOK


QUESTION 3 : Complexité de l'orchestration ?
├─ Simple (2-5 agents séquentiels)
│   └─> COMMAND (2 niveaux)
│
├─ Complexe (10+ agents, multi-domaines)
│   └─> COMMAND + COORDINATOR SUBAGENTS (3 niveaux)
│
└─> Très complexe (100+ agents, multi-phases)
    └─> COMMAND + SUBCOMMANDS + AGENTS
```

---

## 🎨 Decision Tree : Pattern

```
╔═══════════════════════════════════════════════════════════╗
║         DECISION TREE : QUEL PATTERN ?                    ║
╚═══════════════════════════════════════════════════════════╝

QUESTION 1 : Tâche séquentielle fixe (A→B→C toujours) ?
└─ OUI → Pattern 1 : Prompt Chaining
   └─> Example : EPCT (Explore→Plan→Code→Test)
   └─> Trade-off : ⬆️ Latence, ⬆️ Accuracy

QUESTION 2 : Besoin de router vers specialist ?
└─ OUI → Pattern 2 : Routing
   └─> Example : Customer support → Refund/Help/Technical
   └─> Trade-off : +22% accuracy vs generalist

QUESTION 3 : Tâches indépendantes (speedup 5-20x) ?
└─ OUI → Pattern 3 : Parallelization
   └─> Example : 200 locales → 10 waves × 20 agents
   └─> Trade-off : 9.7x speedup, ⬇️ Cost (haiku)

QUESTION 4 : Subtasks dynamiques (nombre/type variable) ?
└─ OUI → Pattern 4 : Orchestrator-Workers
   └─> Example : Research → Command décide dynamically
   └─> Trade-off : Flexibilité vs Complexité

QUESTION 5 : Output quality-critical (raffinement itératif) ?
└─ OUI → Pattern 5 : Evaluator-Optimizer
   └─> Example : Literary translation → 85% → 99%
   └─> Trade-off : +2.4x cost, +14% quality

QUESTION 6 : Problème complètement ouvert (sandbox) ?
└─ OUI → Pattern 6 : Autonomous Agents
   └─> Example : SWE-bench (résoudre GitHub issue)
   └─> Trade-off : ⚠️ Research only, pas production
```

---

## 🔍 Exemples Détaillés par Use Case

### Use Case 1 : Feature Nouvelle Page Pricing

**Contexte** : Créer page pricing avec 3 tiers (Free/Pro/Enterprise)

**Analyse** :
```
QUESTION : Orchestration ou exécution ?
└─> Orchestration (multiple étapes)

QUESTION : Invoqué par qui ?
└─> User (/epct)

QUESTION : Séquence fixe ou dynamique ?
└─> Fixe (Explore→Plan→Code→Test)

DÉCISION :
├─ Composant : COMMAND
└─ Pattern : Pattern 1 (Prompt Chaining - EPCT)
```

**Implémentation** :
```bash
/epct "Create pricing page with 3 tiers"

Workflow :
1. EXPLORE (5min) : Lire pages existantes, routing, components
2. PLAN (7min)    : Design structure, valider avec user
3. CODE (10min)   : Implémenter selon plan
4. TEST (2min)    : Build + tests manuels

Result : Feature complète en 24min, 95% success rate
```

---

### Use Case 2 : Générer 200 Locale Files

**Contexte** : Générer 200 locale files avec quality check

**Analyse** :
```
QUESTION : Tâches indépendantes ?
└─> OUI (200 locales indépendants)

QUESTION : Quality critique ?
└─> OUI (validations nécessaires)

DÉCISION :
├─ Composant : COMMAND + AGENTS
├─ Pattern primaire : Pattern 3 (Parallelization)
├─ Pattern secondaire : Pattern 5 (Evaluator-Optimizer)
└─ Pattern tertiaire : Pattern 4 (Orchestrator-Workers)
```

**Implémentation** :
```bash
/generate-locales all

Workflow :
1. EPCT : Explore sources, plan strategy
2. PARALLEL : Batch (10 waves × 20 agents)
   └─> 9.7x speedup (25min → 2min35)
3. EVALUATOR : Valider chaque locale (completeness, format)
   └─> If quality < 8/10 → Refine (max 3x)
4. REPORT : Aggregation metrics

Result : 200 locales en 3min, 99.5% quality, $0.25 cost
```

---

### Use Case 3 : Customer Support Ticket Routing

**Contexte** : Router tickets vers specialist adapté

**Analyse** :
```
QUESTION : Besoin de router ?
└─> OUI (4 types tickets : refund/help/bug/pricing)

QUESTION : Invoqué par qui ?
└─> Auto-invocation (quand ticket arrive)

DÉCISION :
├─ Composant : SKILL (auto-invoquée)
└─ Pattern : Pattern 2 (Routing)
```

**Implémentation** :
```markdown
# .claude/skills/ticket-router.md

WHEN:
- Incoming customer ticket
- Support request
- User inquiry

WHEN NOT:
- Internal tasks
- Development requests

Process:
1. Analyze ticket keywords and intent
2. Route to appropriate specialist:
   - "refund" → REFUND-SPECIALIST (98% accuracy)
   - "how to" → HELP-SPECIALIST (95% accuracy)
   - "bug" → TECHNICAL-SUPPORT (90% accuracy)
   - "pricing" → SALES-SPECIALIST (88% accuracy)

Result : 92% accuracy (vs 70% generalist), +22% improvement
```

---

### Use Case 4 : Enterprise RFP Analysis

**Contexte** : Analyser RFP (Request for Proposal) complexe multi-domaines

**Analyse** :
```
QUESTION : Multi-domaines (legal, technical, financial) ?
└─> OUI

QUESTION : Besoin de sous-orchestration ?
└─> OUI (chaque domaine a 3-5 agents)

DÉCISION :
├─ Composant : COMMAND + COORDINATOR SUBAGENTS + AGENTS
├─ Pattern : Pattern 4 (Orchestrator-Workers)
└─ Hiérarchie : 3 niveaux
```

**Implémentation** :
```bash
/analyze-rfp tesla-rfp.pdf

Workflow (3 niveaux) :

COMMAND (Level 1) :
├─ 1. @legal-coordinator
├─ 2. @technical-coordinator
└─ 3. @financial-coordinator

COORDINATOR SUBAGENTS (Level 2) :
├─ Legal Coordinator
│   ├─ @contract-analyzer
│   ├─ @compliance-checker
│   └─ @risk-assessor
│
├─ Technical Coordinator
│   ├─ @architecture-evaluator
│   ├─ @scalability-analyzer
│   ├─ @security-auditor
│   └─ @integration-checker
│
└─ Financial Coordinator
    ├─ @cost-estimator
    └─ @roi-calculator

Result : Analyse complète en 15min, rapport structuré par domaine
```

---

### Use Case 5 : Literary Translation (Quality-Critical)

**Contexte** : Traduire texte littéraire avec nuances culturelles

**Analyse** :
```
QUESTION : Quality critique ?
└─> OUI (nuances, contexte culturel)

QUESTION : Raffinement itératif nécessaire ?
└─> OUI (evaluate → refine loop)

DÉCISION :
├─ Composant : COMMAND + 2 AGENTS (Generator + Evaluator)
└─ Pattern : Pattern 5 (Evaluator-Optimizer)
```

**Implémentation** :
```bash
/translate-literary text.txt en→fr

Workflow (loop max 3 iterations) :

1. GENERATOR AGENT
   └─> Traduit texte (première version)

2. EVALUATOR AGENT
   ├─> Score quality (1-10)
   ├─> Identifie problèmes (nuances, contexte)
   └─> Suggest improvements

3. IF quality < 9/10
   └─> Generator refine (based on feedback)
   └─> Loop to step 2

4. ELSE
   └─> Return final translation

Result : Quality 85% → 99% (+14%), 2.4x cost justified
```

---

## 📊 Matrice Décision Rapide

### Composants

| Use Case | Invoqué Par | Orchestration ? | Atomique ? | → Composant |
|----------|-------------|-----------------|------------|-------------|
| Feature nouvelle page | User `/command` | Oui (multi-steps) | Non | **COMMAND** |
| Traduire texte | Command (Task) | Non | Oui | **AGENT** |
| Docs React hooks | Claude (auto) | N/A | N/A | **SKILL** |
| Valider format JSON | Event (PostToolUse) | N/A | N/A | **HOOK** |

---

### Patterns

| Use Case | Séquentiel Fixe ? | Indépendant ? | Dynamic ? | Quality Loop ? | → Pattern |
|----------|-------------------|---------------|-----------|----------------|-----------|
| EPCT Workflow | ✅ Oui | ❌ | ❌ | ❌ | **1. Prompt Chaining** |
| Support Routing | ❌ | ❌ | ✅ Classifier | ❌ | **2. Routing** |
| 200 Locales | ❌ | ✅ Oui | ❌ | ⚠️ Optional | **3. Parallelization** |
| RFP Analysis | ❌ | ❌ | ✅ Multi-domaines | ❌ | **4. Orchestrator-Workers** |
| Literary Translation | ❌ | ❌ | ❌ | ✅ Oui | **5. Evaluator-Optimizer** |
| SWE-bench | ❌ | ❌ | ✅ Open-ended | ⚠️ Research | **6. Autonomous Agents** |

---

## 🎯 Règles de Décision Synthétiques

### Composant : Quick Rules

```
USE COMMAND WHEN:
✅ User invokes explicitly (/command)
✅ Orchestration multi-steps
✅ Décision stratégique nécessaire

USE AGENT WHEN:
✅ Command launches via Task tool
✅ Tâche atomique unique
✅ Retourne résultat structuré

USE SKILL WHEN:
✅ Auto-invocation by Claude reasoning
✅ Base de connaissances partagée
✅ Économie contexte (vs memory)

USE HOOK WHEN:
✅ Event-driven automation
✅ Validation déterministe
✅ Quality gates / Security checks
```

---

### Pattern : Quick Rules

```
PATTERN 1 (Prompt Chaining) WHEN:
✅ Séquence FIXE A→B→C
✅ Context building requis
✅ Trade-off : ⬆️ Latence OK pour ⬆️ Accuracy

PATTERN 2 (Routing) WHEN:
✅ Classification input → Specialist
✅ 4+ specialists différents
✅ Trade-off : +22% accuracy vs generalist

PATTERN 3 (Parallelization) WHEN:
✅ 10+ tâches INDÉPENDANTES
✅ Speedup critical (5-20x possible)
✅ Trade-off : ⬇️ Latence, ⬇️ Cost (haiku)

PATTERN 4 (Orchestrator-Workers) WHEN:
✅ Subtasks DYNAMIQUES (nombre/type variable)
✅ Multi-domaines (legal, tech, finance)
✅ Trade-off : Flexibilité vs Complexité

PATTERN 5 (Evaluator-Optimizer) WHEN:
✅ Quality CRITIQUE (literary, legal, medical)
✅ Raffinement itératif nécessaire
✅ Trade-off : +2-3x cost OK pour +14-30% quality

PATTERN 6 (Autonomous Agents) WHEN:
✅ Problème OUVERT (research, exploration)
✅ Agent décide autonomously
⚠️  Trade-off : Research only, PAS production
```

---

## 🎓 Points Clés

```
╔═══════════════════════════════════════════════════════════╗
║         DECISION FRAMEWORK ESSENTIALS                     ║
╚═══════════════════════════════════════════════════════════╝

✅ TOUJOURS commencer SIMPLE (Pattern 1 - Chaining)
✅ Ajouter complexité SEULEMENT si preuves (benchmark)
✅ Parallelization si 10+ tâches indépendantes
✅ Evaluator-Optimizer si quality critique
✅ Autonomous Agents pour research ONLY

QUESTION-DRIVEN :
1. Qui invoque ? → Composant
2. Orchestration ou atomique ? → Command ou Agent
3. Séquence fixe ou dynamique ? → Pattern 1 ou 4
4. Tâches indépendantes ? → Pattern 3
5. Quality critique ? → Pattern 5

TRADE-OFFS TRANSPARENTS :
├─ Latence ↑ pour Accuracy ↑ (Pattern 1)
├─ Cost ↑ pour Quality ↑ (Pattern 5)
└─ Complexité ↑ pour Flexibilité ↑ (Pattern 4)
```

---

## 🔗 Navigation

- 📄 [Taxonomie](./taxonomie.md) - Workflow vs Agentic Workflow vs Pattern
- 📄 [Nomenclature](./nomenclature.md) - Command vs Agent vs Skill
- 📄 [6 Patterns](../2-patterns/README.md) - Patterns Anthropic détaillés
- 📄 [Workflows](../4-workflows/README.md) - Exemples concrets

---

**Quote Finale** :
> "Start with the simplest solution that could work. Add complexity only when measured benchmarks prove it's necessary."
> — Anthropic, Building Effective Agents 2025
