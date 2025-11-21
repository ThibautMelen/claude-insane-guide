# Fundamentals - Bases Théoriques de l'Orchestration

> Fondations conceptuelles pour maîtriser les **workflows agentiques** et l'orchestration Claude Code

---

## ⚠️ **Note Importante**

Ce guide utilise des **conventions proposées** pour organiser Claude Code. La terminologie officielle est :
- **Subagents** (`.claude/agents/*.md`)
- **Custom slash commands** (`.claude/commands/*.md`)
- **Skills** (`.claude/skills/*/SKILL.md`)

Les concepts comme "COMMAND", "COORDINATOR SUBAGENT" sont des patterns proposés, pas des types officiels.

---

## 🎯 Objectif de ce Dossier

Avant de plonger dans les **patterns** et les **workflows**, il est essentiel de comprendre :

1. **Taxonomie** : Qu'est-ce qu'un Workflow vs Agentic Workflow vs Pattern ?
2. **Nomenclature** : Custom Command vs Subagent vs Skill - définitions précises
3. **Decision Framework** : Quel composant et pattern utiliser pour mon use case ?

**Ce dossier établit le vocabulaire commun** pour tout le reste de la documentation.

---

## 📚 Contenu

### 📄 [Taxonomie](./taxonomie.md) ⭐

**Clarifie les termes de l'industrie** pour éviter la confusion terminologique.

```
╔═══════════════════════════════════════════════════════════╗
║           CE QUE VOUS APPRENDREZ                          ║
╚═══════════════════════════════════════════════════════════╝

✅ Workflow vs Agentic Workflow vs Pipeline
✅ Orchestration vs Flow vs Process
✅ Pattern vs Architecture vs Framework
✅ Hiérarchie taxonomique complète
✅ Quand utiliser quel terme
```

**Concepts clés** :
- **Workflow** (générique) : Séquence structurée de tâches
- **Agentic Workflow** ⭐ : Agents autonomes décident dynamiquement
- **Pipeline** : Transformation linéaire de données
- **Orchestration** : Coordination centralisée
- **Pattern** : Solution réutilisable

**Pourquoi important ?** : L'industrie utilise ces termes de manière interchangeable. Cette taxonomie établit des **définitions précises** basées sur Anthropic, Microsoft Azure et standards industrie.

---

### 📄 [Nomenclature](./nomenclature.md) ⭐

**Termes officiels Claude Code + Conventions proposées**

```
╔═══════════════════════════════════════════════════════════╗
║           CE QUE VOUS APPRENDREZ                          ║
╚═══════════════════════════════════════════════════════════╝

TERMINOLOGIE OFFICIELLE :
✅ SUBAGENT : Worker exécutant tâche atomique (.claude/agents/)
✅ CUSTOM SLASH COMMAND : Orchestrateur (.claude/commands/)
✅ SKILL : Base connaissances auto-invoquée (.claude/skills/)
✅ HOOK : Automation bash/LLM (settings.json)
✅ MCP : Interface outils externes

CONVENTIONS CE GUIDE (patterns proposés) :
• COMMAND = Custom slash command orchestrateur
• COORDINATOR SUBAGENT = Pattern avancé coordination
• Hiérarchie recommandée : 2-3 niveaux
```

**Concepts clés** :
- **Custom Command** : Décide stratégie, orchestre subagents
- **Subagent** : Exécute tâche unique, retourne résultat
- **Skill** : Auto-invoquée par LLM, économie contexte
- **Hook** : Bash (déterministe) ou Prompt (LLM), validation gates
- **Coordinator Subagent** : Pattern proposé pour sous-orchestration

**⚠️ CLARIFICATION CRITIQUE** :
```
Claude Code "Subagent" (Worker)
├─ Suit instructions Command
├─ Règle officielle : "cannot spawn other subagents"
└─ Production-ready ✅

≠

Anthropic "Autonomous Agent" (Pattern 6)
├─ Décide autonomously
└─ Research only ⚠️
```

**Pourquoi important ?** : Comprendre **qui orchestre qui** et respecter la règle officielle "subagents cannot spawn other subagents".

---

### 📄 [Decision Framework](./decision-framework.md) 🎯

**Framework de décision pratique** : Quel composant et pattern utiliser ?

```
╔═══════════════════════════════════════════════════════════╗
║           CE QUE VOUS APPRENDREZ                          ║
╚═══════════════════════════════════════════════════════════╝

✅ Decision Tree : Composant (Command/Agent/Skill/Hook)
✅ Decision Tree : Pattern (6 patterns Anthropic)
✅ Exemples concrets par use case
✅ Matrice de décision rapide
✅ Trade-offs transparents
```

**Concepts clés** :
- **Qui invoque ?** → Détermine composant (User=Command, Claude=Skill, etc.)
- **Orchestration ou atomique ?** → Command vs Agent
- **Séquence fixe ou dynamique ?** → Pattern 1 (Chaining) vs Pattern 4 (Orchestrator-Workers)
- **Tâches indépendantes ?** → Pattern 3 (Parallelization)
- **Quality critique ?** → Pattern 5 (Evaluator-Optimizer)

**Exemples use cases** :
1. Feature nouvelle page → Pattern 1 (EPCT)
2. 200 locales → Pattern 3 (Parallel) + Pattern 5 (Evaluator)
3. Ticket routing → Pattern 2 (Routing)
4. RFP analysis → Pattern 4 (Orchestrator-Workers, 3 niveaux)
5. Literary translation → Pattern 5 (Evaluator-Optimizer)

**Pourquoi important ?** : Éviter l'over-engineering. **Commencer simple** (Pattern 1), ajouter complexité **seulement si benchmarks prouvent** que c'est nécessaire.

---

## 🎯 Parcours d'Apprentissage

### Étape 1 : Comprendre la Taxonomie (15 min)

```bash
Lire : taxonomie.md

Questions à répondre :
1. Quelle est la différence entre Workflow et Agentic Workflow ?
2. Pipeline vs Workflow : quand utiliser quel terme ?
3. Orchestration = quoi exactement ?

✅ Vous saurez : Utiliser le bon vocabulaire dans discussions
```

---

### Étape 2 : Maîtriser la Nomenclature Claude Code (20 min)

```bash
Lire : nomenclature.md

Questions à répondre :
1. Qui orchestre qui dans Claude Code ?
2. Agent (Claude Code) vs Autonomous Agent : différence ?
3. Quand utiliser Skill vs Agent ?
4. Hiérarchie à 2 vs 3 niveaux : quand ?

✅ Vous saurez : Structurer workflows selon règles d'or Anthropic
```

---

### Étape 3 : Appliquer le Decision Framework (30 min)

```bash
Lire : decision-framework.md

Exercice pratique :
Pour VOTRE use case :
1. Quel composant ? (Command/Agent/Skill/Hook)
2. Quel pattern ? (1-6)
3. Hiérarchie ? (2 ou 3 niveaux)

✅ Vous saurez : Concevoir workflow optimal pour votre cas
```

---

## 📊 Schéma Récapitulatif

```
╔═══════════════════════════════════════════════════════════╗
║         FUNDAMENTALS : VUE D'ENSEMBLE                     ║
╚═══════════════════════════════════════════════════════════╝

TAXONOMIE (Industrie)
├─ Workflow (générique)
├─ Agentic Workflow ⭐ (autonomy + adaptation)
├─ Pipeline (linear data transformation)
├─ Orchestration (coordination)
└─ Pattern (reusable solution)
    │
    ▼
NOMENCLATURE (Claude Code)
├─ COMMAND (orchestrator)
├─ AGENT (worker)
├─ SKILL (auto-invoked context)
├─ HOOK (validation gate)
└─ MCP (external tools)
    │
    ▼
DECISION FRAMEWORK (Pratique)
├─ Qui invoque ? → Composant
├─ Orchestration ? → Command ou Agent
├─ Séquence fixe ? → Pattern 1 ou 4
├─ Indépendant ? → Pattern 3
└─ Quality critique ? → Pattern 5
    │
    ▼
PATTERNS (Implémentation)
├─ 6 Patterns Anthropic composables
└─ Workflows production-ready
```

---

## 🎓 Points Clés

```
╔═══════════════════════════════════════════════════════════╗
║              FUNDAMENTALS ESSENTIALS                      ║
╚═══════════════════════════════════════════════════════════╝

✅ TAXONOMIE : Vocabulaire industrie standardisé
✅ NOMENCLATURE : Hiérarchie Claude Code stricte
✅ DECISION FRAMEWORK : Question-driven composant/pattern

RÈGLE D'OR :
"Commencer SIMPLE (Pattern 1 - Chaining).
 Ajouter complexité SEULEMENT si benchmarks prouvent nécessité."
 — Anthropic, Building Effective Agents 2025

HIÉRARCHIE RECOMMANDÉE :
USER → COMMAND → [COORDINATOR SUBAGENT] → WORKER SUBAGENT
❌ JAMAIS Subagent → Subagent (règle officielle)
❌ JAMAIS Subagent → Command

PATTERNS COMPOSABLES :
1. Prompt Chaining (séquentiel fixe)
2. Routing (classifier → specialist)
3. Parallelization (indépendant, speedup 5-20x)
4. Orchestrator-Workers (subtasks dynamiques)
5. Evaluator-Optimizer (quality loop)
6. Autonomous Agents (research only ⚠️)
```

---

## 🔗 Navigation

### Après Fundamentals, Aller Vers :

**🟢 Débutant** :
- 📄 [6 Patterns Composables](../2-patterns/README.md) - Patterns Anthropic détaillés
- 📄 [Pattern 1 - Prompt Chaining](../2-patterns/1-prompt-chaining.md) - EPCT Workflow

**🟡 Intermédiaire** :
- 📄 [Architecture](../3-architecture/command-coordinator-workers.md) - Hiérarchie détaillée
- 📄 [Workflows Exemples](../4-workflows/README.md) - Use cases concrets

**🔴 Avancé** :
- 📄 [Orchestration Principles](../orchestration-principles.md) - Règles d'or complètes
- 📄 [Best Practices](../5-best-practices/README.md) - Performance, Cost, Resilience

---

## 📚 Ressources Complémentaires

### Documentation Officielle

- 📄 [Anthropic - Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) ⭐
- 📄 [IBM - Agentic Workflows](https://www.ibm.com/think/topics/agentic-workflows)
- 📄 [Microsoft - AI Agent Design Patterns](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/guide/ai-agent-design-patterns)

### Articles Communauté

- 📝 [Agents vs Workflows](https://intuitionlabs.ai/articles/ai-agent-vs-ai-workflow)
- 📝 [Agentic Orchestration Patterns](https://research.aimultiple.com/agentic-orchestration/)

---

**Quote Inspirante** :
> "Understanding the fundamentals—what workflows are, how agents differ, and when to use each pattern—is the foundation for building production-ready agentic systems."
> — Claude Code Guide 2025

---

**Prochaine Étape** : [Les 6 Patterns Composables Anthropic](../2-patterns/README.md) 🚀
