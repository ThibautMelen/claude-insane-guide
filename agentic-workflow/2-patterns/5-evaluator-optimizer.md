# Pattern 5 : Evaluator-Optimizer Loop

> **📚 Vue d'ensemble complète** : Voir [6 Patterns README](./README.md)

## 🎯 En Bref

**Concept**: Generator LLM crée output, Evaluator LLM évalue en boucle jusqu'à quality satisfaisante (Generate→Evaluate→Refine→Loop).

**Use cases**: Literary translation, complex research, brand voice consistency (quality-critical content)

**ROI**: +14% quality improvement (85%→99%), 2.4x cost increase, max 3 iterations optimal

---

## 🧩 Pattern vs Workflow

**Ce fichier documente un PATTERN** (brique technique réutilisable).

| Aspect | Description |
|--------|-------------|
| 🔧 **Type** | Pattern architectural (quality loop) |
| 🎯 **Problème résolu** | Amélioration itérative de la qualité d'output |
| 🧩 **Combinable avec** | Chaining (étape Test avec loop), Parallelization (evaluate batch) |
| 🚀 **Utilisé dans workflows** | Enterprise RFP (quality critical), Global Localization (translation) |

**Voir** : [Pattern vs Workflow Définition](../README.md#-pattern-vs-workflow--quelle-différence-)

## 📐 Architecture

```
Input → [GENERATOR] → Draft v1
         ↓
       [EVALUATOR] → Score + Feedback
         ↓
       Quality met? ─YES→ Final Output
         ↓ NO
       [GENERATOR] → Draft v2 (with feedback)
         ↓
       [EVALUATOR] → Score + Feedback
         ↓
       (Loop max 3-5 iterations)
```

**vs Autres patterns**:
- vs Prompt Chaining: Boucle dynamique (pas séquence fixe)
- vs Parallelization: Itérative improvement (pas voting)

## ⚡ Quick Start

```yaml
# Literary Translation Example
Generator Agent:
  - Translate French → English (v1)

Evaluator Agent:
  - Score: Accuracy, Cultural nuance, Tone, Literary quality
  - Feedback: "Replace 'raining heavily' with idiom 'cats and dogs'"

Generator Agent (with feedback):
  - Translate v2 (apply feedback)

Loop until score ≥ 8/10 OR max 3 iterations
```

## 🎯 Quand Utiliser Ce Pattern

### ✅ Utiliser Evaluator-Optimizer SI :

```
✅ Quality absolument critique (literary, legal, branding)
   → Ex: Literary translation, RFP response, marketing copy

✅ Scoring objectif possible (metrics clairs)
   → Ex: Translation (accuracy, cultural nuance, tone, literary quality)

✅ Feedback actionable identifiable
   → Ex: "Replace X with Y", "Add cultural context Z"

✅ Coût acceptable vs quality gain
   → Ex: 2.4x cost pour +14% quality = justified

✅ Iterations limitées (diminishing returns après 3)
   → Ex: Max 3-5 iterations suffisent
```

### ❌ NE PAS Utiliser SI :

```
❌ Quality "good enough" acceptable
   → Ex: Internal docs, prototypes → One-shot suffit

❌ Scoring subjectif (pas de métriques claires)
   → Ex: "Make it better" → Vague, pas actionable

❌ Feedback non actionable
   → Ex: "Improve tone" → Pas spécifique

❌ Budget serré (coût 2-5x inacceptable)
   → Ex: High volume, low budget → One-shot

❌ Speed critique (latence 2-3x inacceptable)
   → Ex: Real-time responses → One-shot
```

---

## ⚖️ Trade-offs

| Avantage ⬆️ | Inconvénient ⬇️ |
|------------|----------------|
| **+14% Quality** (85%→99%) | **2.4x Cost** (4 API calls vs 1) |
| **Iterative refinement** (feedback loop) | **2-3x Latence** (22s vs 8s) |
| **Actionable feedback** (specific improvements) | **Diminishing returns** (après 3 iterations) |
| **Best version guarantee** (track improvements) | **Overhead scoring** (evaluation cost) |

**Verdict** : **Must-have pour quality-critical content** où 85%→99% justifie 2.4x cost.

---

## 💡 Implementation Pattern

```yaml
Iteration 0 (one-shot):
  Quality: 85%
  Cost: 1x

Iteration 1 (first refinement):
  Quality: 92% (+7%)
  Cost: 2x

Iteration 2 (second refinement):
  Quality: 97% (+5%)
  Cost: 3x

Iteration 3 (third refinement):
  Quality: 99% (+2%)
  Cost: 4x

Iteration 4+ (diminishing returns):
  Quality: 99.5% (+0.5%)
  Cost: 5x+

✅ Recommendation: MAX 3 ITERATIONS
   - Sweet spot quality/cost
   - After 3: diminishing returns
```

## 🎯 Best Practices

### ✅ DO
- Set clear scoring criteria (1-10, objective)
- Max 3-5 iterations (sweet spot: 3)
- Return BEST version always (even if threshold not met)
- Actionable feedback ("Add emoji 🎉 here", not "improve tone")
- Track improvements per iteration

### ❌ DON'T
- Vague criteria ("Make it better")
- Infinite loops (no max iterations)
- Ignore cost (monitor API usage)
- Skip best version fallback
- Vague feedback (not actionable)

## 🎓 Points Clés

```
✅ Generator ↔ Evaluator LOOP
✅ Clear scoring (1-10, objective)
✅ Max 3 iterations (diminishing returns after)
✅ Return BEST version (even if failed)
✅ Quality > Speed trade-off (2-3x slower)
✅ +14% quality (85%→99%), 2.4x cost
❌ Don't: vague criteria, infinite loops
```

## 🔗 Ressources

- 📄 [Vue d'ensemble 6 Patterns](./README.md)
- 🚀 [Enterprise RFP (Quality Loops)](../4-workflows/enterprise-rfp.md)
- 🚀 [Global Localization (Translation Quality)](../4-workflows/global-localization.md)
- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents)

**Voir** : [Multi-Dialog Patterns](../../themes/8-advanced/multi-dialog-patterns.md) - AskUserQuestion avancé
