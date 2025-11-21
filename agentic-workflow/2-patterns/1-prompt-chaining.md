# Pattern 1 : Prompt Chaining (Sequential Execution)

> **📚 Vue d'ensemble complète** : Voir [6 Patterns README](./README.md)

## 🎯 En Bref

**Concept**: Décomposer tâche en séquence fixe d'appels LLM (A→B→C) où chaque step traite output du précédent.

**Notre implémentation**: EPCT Workflow (Explore → Plan → Code → Test)

**ROI**: 40% plus rapide end-to-end vs one-shot avec rework (24min vs 38min), 95% success rate

---

## 🧩 Pattern vs Workflow

**Ce fichier documente un PATTERN** (brique technique réutilisable).

| Aspect | Description |
|--------|-------------|
| 🔧 **Type** | Pattern architectural (technique) |
| 🎯 **Problème résolu** | Séquence fixe d'étapes interdépendantes |
| 🧩 **Combinable avec** | Parallelization (étape Code), Evaluator (étape Test) |
| 🚀 **Utilisé dans workflows** | EPCT, CI/CD Pipeline, Enterprise RFP |

**Voir** : [Pattern vs Workflow Définition](../README.md#-pattern-vs-workflow--quelle-différence-)

## 📐 Architecture

```
Input → [STEP A] → [Gate] → [STEP B] → [Gate] → [STEP C] → Result
        Explore    Approve   Plan      Approve   Code       Test
```

**vs Autres patterns**:
- vs Parallelization: Séquentiel (pas parallèle)
- vs Evaluator-Optimizer: Pas de boucle (séquence fixe)
- vs Routing: Tous steps (pas de branches)

## ⚡ Quick Start

```bash
# .claude/commands/epct.md
/epct "Add user authentication"

# Steps auto:
# 1. Explore codebase → Report
# 2. Plan implementation → User approval
# 3. Code feature → Compilation check
# 4. Test → Coverage validation
```

## 🎯 Quand Utiliser Ce Pattern

### ✅ Utiliser Prompt Chaining SI :

```
✅ Tâche complexe nécessitant contexte progressif
   → Ex: Feature développement, migration code, architecture

✅ Séquence logique fixe (ordre immuable)
   → Ex: Explore AVANT Plan, Plan AVANT Code

✅ Validation humaine requise entre étapes
   → Ex: Approbation plan avant coding

✅ Contexte s'accumule (chaque step enrichit)
   → Ex: Explore → insights → Plan utilise insights

✅ Quality > Speed (accepter latence pour accuracy)
   → Ex: Production features, pas prototypes jetables
```

### ❌ NE PAS Utiliser SI :

```
❌ Tâche simple one-shot suffit
   → Ex: "Write README section" → Pas besoin EPCT

❌ Steps indépendants (pas de dépendances)
   → Ex: Traduire 10 files → Use Parallelization

❌ Ordre flexible/dynamique
   → Ex: Depends on runtime conditions → Use Orchestrator

❌ Speed critique (latence inacceptable)
   → Ex: Real-time responses → One-shot ou Routing
```

---

## ⚖️ Trade-offs

| Avantage ⬆️ | Inconvénient ⬇️ |
|------------|----------------|
| **+35% Accuracy** (95% vs 60% one-shot) | **+Latence** (22min vs 8min one-shot) |
| **-40% Rework** (2min vs 30min fixes) | **+Coût tokens** (4 appels vs 1 appel) |
| **Gates validation** (moins hallucinations) | **Rigidité** (séquence fixe) |
| **Auditabilité** (logs chaque step) | **Overkill** (si tâche simple) |

**Verdict** : Privilégier pour features production-ready où **quality > speed**.

---

## 💡 EPCT Workflow (Notre Implémentation)

```yaml
# Séquence fixe : E→P→C→T

STEP 1: EXPLORE
  - Read codebase (architecture, integration points)
  - Identify constraints
  → Output: Architecture analysis
  → Gate: User validates approach

STEP 2: PLAN
  - Design solution (files, API, steps)
  - Based on Explore output
  → Output: Implementation plan
  → Gate: User approves plan

STEP 3: CODE
  - Implement plan exactly
  - No scope creep
  → Output: Code + tests
  → Gate: Compilation passes

STEP 4: TEST
  - Run tests, check coverage
  → Output: Test report
  → Gate: Tests pass → DONE
```

## 🎯 Best Practices

### ✅ DO
- ALWAYS follow sequence (E→P→C→T)
- Wait user approval (after Explore, Plan)
- Stick to plan exactly (Code step)
- Run tests before marking done

### ❌ DON'T
- Skip steps (causes hallucinations)
- Code before plan approved
- Add unplanned features (scope creep)
- Assume tests pass (always run)

## 🎓 Points Clés

```
✅ Séquence fixe (E→P→C→T)
✅ Gates validation (prevent hallucinations)
✅ 40% faster end-to-end vs one-shot
✅ 95% success rate (vs 50% one-shot)
❌ Never skip steps
❌ Never code before plan approved
```

## 🔗 Ressources

- 📄 [Vue d'ensemble 6 Patterns](./README.md)
- 📐 [Architecture Details EPCT](../3-architecture/epct-workflow.md)
- 🚀 [Workflow Example: Enterprise RFP](../4-workflows/enterprise-rfp.md)
- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents)
