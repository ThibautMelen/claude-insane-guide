# Pattern 1 : Prompt Chaining (Sequential Execution)

> **📚 Vue d'ensemble complète** : Voir [6 Patterns README](./README.md)

## 🎯 En Bref

**Concept**: Décomposer tâche en séquence fixe d'appels LLM (A→B→C) où chaque step traite output du précédent.

**Notre implémentation**: EPCT Workflow (Explore → Plan → Code → Test)

**ROI**: 40% plus rapide end-to-end vs one-shot avec rework (24min vs 38min), 95% success rate

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
- 📐 [Architecture Details EPCT](../architecture/epct-workflow.md)
- 🚀 [Workflow Example: Enterprise RFP](../workflows/enterprise-rfp.md)
- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents)
