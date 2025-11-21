# Workflows - Vue d'Ensemble

**Mission** : Maîtriser les 4 types de workflows Claude Code pour créer des processus systématiques, reproductibles et scalables.

> 📊 **Workflow** = Processus structuré en étapes pour accomplir une tâche complexe avec qualité consistante

---

## 📋 Workflows Catalogue

| Workflow | Type | Use Case | ROI | Fichier |
|----------|------|----------|-----|---------|
| **Startup Content Stack** | Hybrid | Blog + Social + Localization | 1040x speedup (40j→55min) | [📄](./startup-content-stack.md) |
| **EPCT Séquentiel** | Sequential | Features complexes, refactoring | 95% succès vs 50% direct | [📄](./epct.md) |
| **Multi-agents Parallèle** | Parallel | Batch processing (10-50 tasks) | 5-10x speedup, 10x cheaper | [📄](./parallel.md) |
| **Decision Trees** | Conditional | API avec fallbacks, robustesse | 75% faster error recovery | [📄](./conditional.md) |
| **Orchestration Hybride** | Hybrid | Production complexe, multi-aspects | 8.3x faster + 7x cheaper | [📄](./hybrid.md) ⭐ |

---

## 🎯 Decision Tree - Quel Workflow Choisir ?

```
Quelle est la tâche ?
│
├─ FEATURE COMPLEXE (page, migration tech)
│  └─→ SÉQUENTIEL (EPCT) ✅ Contexte optimal, validation humaine
│
├─ 10-50 TÂCHES INDÉPENDANTES (fix files, generate locales)
│  └─→ PARALLÈLE (Multi-agents) ✅ 5-10x speedup, batch processing
│
├─ API/DATA AVEC FALLBACKS (doc fetch, enrichment)
│  └─→ CONDITIONNEL (Decision trees) ✅ Primary→Fallback→User
│
└─ PRODUCTION MULTI-ASPECTS (robustesse critique)
   └─→ HYBRIDE (Orchestration) ✅ EPCT + Parallel + Conditional
```

---

## 📚 Types de Workflows (Quick Reference)

### 1️⃣ SÉQUENTIEL (EPCT)
**4 phases structurées** : Explore → Plan → Code → Test
- **Avantages** : Contexte optimal, validation humaine, 95% succès
- **Usage** : Features complexes, migrations, refactoring
- **Limitation** : Plus lent (4 phases)

### 2️⃣ PARALLÈLE (Multi-agents)
**Tâches indépendantes concurrentes** (ALL agents in SINGLE message)
- **Avantages** : 5-10x speedup, token-efficient (haiku), agrégation automatique
- **Usage** : Batch processing (10-50 items), fix multiples files
- **Limitation** : Nécessite isolation (no shared state)

### 3️⃣ CONDITIONNEL (Decision Trees)
**If/Else avec fallback chains** : Primary → Fallback 1 → 2 → User
- **Avantages** : Robustesse maximale, adaptabilité, recovery intelligent
- **Usage** : API externes, data enrichment, validation chains
- **Limitation** : Complexité logique à gérer

### 4️⃣ HYBRIDE (Orchestration)
**Combinaison intelligente** : EPCT + Parallel + Conditional
- **Avantages** : Flexible, robuste, scalable, production-ready
- **Usage** : Workflows production complexes, multi-aspects
- **Limitation** : Complexité architecture

---

## 🚀 Benchmarks Réels

```
EPCT vs Direct Prompting (Feature: pricing page with Stripe)
├─ Direct : 8min, 50% succès ❌
└─ EPCT  : 12min, 95% succès ✅

Parallel vs Sequential (Fix grammar: 10 files)
├─ Sequential : 120s, $0.20 ❌
└─ Parallel   : 12s, $0.02 (10x faster + cheaper) ✅

Hybrid Orchestration (Generate 50 locales + API)
├─ Sequential : 25min, $2.50, 70% succès ❌
└─ Hybrid     : 3min, $0.35, 99.5% succès ✅ (8.3x faster + 7x cheaper)
```

---

## 🎓 Points Clés

### ✅ TOUJOURS

1. **Choisir le bon type** : Feature→EPCT, Batch→Parallel, API→Conditional, Prod→Hybrid
2. **Valider avant coder** : Plan phase obligatoire (EPCT + Hybrid)
3. **Paralléliser indépendants** : Task tool même message, batch 10-20
4. **Fallback chains** : Primary → Fallback 1 → 2 → User validation
5. **Rapports détaillés** : Success rate, timings, sources, next steps

### ❌ JAMAIS

1. **Coder sans plan** : Direct prompt = 50% vs EPCT = 95%
2. **Séquentiel pour tâches indépendantes** : 120s vs Parallel = 12s
3. **Retry infini** : 1 max, puis user validation
4. **Ignorer fallbacks** : API down = bloqué sans fallbacks
5. **Rapports vagues** : "Failed" ≠ détails + suggestions

---

## 📖 Documentation

**Détails complets par workflow** :
- [epct.md](./epct.md) - Explore-Plan-Code-Test méthodologie
- [sequential.md](./sequential.md) - Step-by-step chaining simple
- [parallel.md](./parallel.md) - Multi-agents concurrent
- [conditional.md](./conditional.md) - Decision trees & fallbacks
- [hybrid.md](./hybrid.md) ⭐ - Orchestration complexe production-ready

**Stack production-ready** :
- [startup-content-stack.md](./startup-content-stack.md) 📦 - 5 workflows interconnectés

**Ressources connexes** :
- [../2-patterns/4-orchestrator-workers.md](../2-patterns/4-orchestrator-workers.md) - Architecture hiérarchique
- [../5-best-practices/error-resilience.md](../5-best-practices/error-resilience.md) - Fallback chains
- [../2-patterns/3-parallelization.md](../2-patterns/3-parallelization.md) - Batching strategies
- [../5-best-practices/performance.md](../5-best-practices/performance.md) - Optimisations

---

## 🎯 Conclusion

Les **4 types de workflows** offrent une palette complète :

1. **EPCT** (Séquentiel) → Features complexes, validation humaine
2. **Parallel** (Multi-agents) → Batch processing, 5-10x speedup
3. **Conditional** (Decision trees) → Fallbacks robustes, APIs externes
4. **Hybrid** (Orchestration) → Production-ready, multi-aspects

**Impact global** :
- ✅ 95% success rate (vs 50% sans workflow)
- ✅ 5-10x speedup (parallel vs sequential)
- ✅ 10x cost savings (haiku vs opus)
- ✅ Production-ready robustness

🚀 **Maîtrisez les workflows, maîtrisez Claude Code !**
