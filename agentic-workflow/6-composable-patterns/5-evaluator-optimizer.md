# Pattern 5 : Evaluator-Optimizer Loop

> **Pattern Anthropic officiel** pour raffinement itératif de qualité.

---

## 🎯 Concept

Un **Generator LLM** crée un output initial, puis un **Evaluator LLM** l'évalue en boucle jusqu'à atteindre une qualité satisfaisante.

**Différence clé vs autres patterns** :
- **Prompt Chaining** : Séquence fixe (A→B→C), pas de boucle
- **Evaluator-Optimizer** : Boucle dynamique (Generate→Evaluate→Refine→Loop)

---

## 📐 Architecture

```
╔═══════════════════════════════════════════════════════════╗
║           EVALUATOR-OPTIMIZER LOOP                        ║
╚═══════════════════════════════════════════════════════════╝

Input
  ↓
┌─────────────────────────────────┐
│ Generator LLM                   │
│ → Generate Draft v1             │
└─────────────────────────────────┘
  ↓
┌─────────────────────────────────┐
│ Evaluator LLM                   │
│ → Score (1-10) + Feedback       │
└─────────────────────────────────┘
  ↓
[Quality criteria met?]
  │
  ├─ NO (score < 8)
  │    ↓
  │  ┌─────────────────────────────────┐
  │  │ Generator (with feedback)       │
  │  │ → Refine Draft v2               │
  │  └─────────────────────────────────┘
  │    ↓
  │  [Loop back to Evaluator]
  │  (max 3-5 iterations)
  │
  └─ YES (score ≥ 8)
       ↓
     Final Output (best version)
```

---

## 🎯 Quand Utiliser

### ✅ Utiliser Evaluator-Optimizer quand :

```
1. CRITÈRES D'ÉVALUATION CLAIRS
   └─> Scoring objectif possible (1-10, métriques précises)
   └─> Evaluator peut articuler feedback actionnable
   └─> Improvements mesurables à chaque itération

2. QUALITÉ > VITESSE
   └─> Trade-off latence acceptable (2-3x plus lent)
   └─> Quality-critical outputs (legal, medical, brand)
   └─> Coût justifié par amélioration qualité

3. RAFFINEMENT ITÉRATIF APPORTE VALEUR
   └─> Nuances subtiles (literary translation)
   └─> Completeness check (complex search, research)
   └─> Brand voice consistency (marketing, content)

4. CONTEXTE STABLE
   └─> Pas de nouvelles infos nécessaires entre iterations
   └─> Feedback suffit pour améliorer (pas besoin external data)
```

### ❌ Ne PAS utiliser quand :

```
1. CRITÈRES VAGUES
   ❌ "Make it better" (subjectif, non-actionnable)
   ❌ Pas de scoring objectif
   ❌ Evaluator ne peut pas donner feedback clair

2. TIME-SENSITIVE
   ❌ Real-time responses nécessaires
   ❌ Latence inacceptable (user waiting)

3. COST-PROHIBITIVE
   ❌ Budget API limité
   ❌ Volume élevé (1000+ items → prefer one-shot)

4. ONE-SHOT SUFFISANT
   ❌ Quality acceptable dès v1
   ❌ Improvement marginal (95% → 97% not worth 3x cost)
```

---

## 💡 Exemples Concrets

### Exemple 1 : Literary Translation

**Use Case** : Traduire roman français → anglais (préserver nuances, ton, culture).

```
┌─────────────────────────────────────────────────────────┐
│              LITERARY TRANSLATION LOOP                  │
└─────────────────────────────────────────────────────────┘

INPUT: "Il pleuvait des cordes ce jour-là."

Iteration 1:
  Generator → "It was raining heavily that day."
  Evaluator → Score 6/10
              Feedback: "Missing idiom intensity, cultural nuance"

Iteration 2:
  Generator → "It was raining cats and dogs that day."
  Evaluator → Score 9/10
              Feedback: "Good idiom match, captures intensity"

RESULT: Final output (score 9/10), 2 iterations
```

**Metrics** :
- Baseline quality (one-shot) : 85%
- After loop : 99%
- Iterations avg : 2.3
- Cost : 2.3x vs one-shot
- **ROI : +14% quality for 2.3x cost → JUSTIFIED**

---

### Exemple 2 : Complex Research Search

**Use Case** : Gather comprehensive info sur topic complexe multi-facettes.

```
┌─────────────────────────────────────────────────────────┐
│              RESEARCH SEARCH LOOP                       │
└─────────────────────────────────────────────────────────┘

QUERY: "What are the top 10 AI safety regulations in EU 2025?"

Iteration 1:
  Generator → Search APIs, gather 5 regulations
  Evaluator → Completeness 50% (missing 5)
              Feedback: "Add GDPR AI annex, UK post-Brexit, France AI Act"

Iteration 2:
  Generator → Further searches based on feedback
  Evaluator → Completeness 80% (8/10)
              Feedback: "Missing Germany AI Ethics Council"

Iteration 3:
  Generator → Targeted search Germany
  Evaluator → Completeness 95% (10/10 + context)
              Feedback: "Complete, verified sources"

RESULT: Comprehensive report, 3 iterations
```

**Metrics** :
- Baseline completeness : 60%
- After loop : 95%
- Iterations avg : 3.1
- **ROI : Critical use case, completeness mandatory**

---

### Exemple 3 : Marketing Copy (Brand Voice)

**Use Case** : Générer marketing copy avec brand voice strict.

```
┌─────────────────────────────────────────────────────────┐
│           MARKETING COPY QUALITY LOOP                   │
└─────────────────────────────────────────────────────────┘

BRIEF: "Product launch email, brand = playful + technical"

Iteration 1:
  Generator → Draft v1 (too technical, dry)
  Evaluator → Brand score 4/10, Engagement 5/10
              Feedback: "Add playfulness, emojis, casual tone"

Iteration 2:
  Generator → Draft v2 (playful but lost technical depth)
  Evaluator → Brand 7/10, Engagement 8/10, Technical 4/10
              Feedback: "Balance: keep playful, add technical proofs"

Iteration 3:
  Generator → Draft v3 (balanced)
  Evaluator → Brand 9/10, Engagement 9/10, Technical 8/10
              Feedback: "Excellent balance, ready to send"

RESULT: Brand-aligned copy, 3 iterations
```

**Metrics** :
- Brand alignment (one-shot) : Score 5/10
- After loop : Score 9/10
- Iterations avg : 2.8
- **ROI : Brand reputation > cost**

---

## 🏗️ Implémentation

### Command Structure

```yaml
# .claude/commands/literary-translate.md

---
name: literary-translate
description: Translate with literary quality (Evaluator-Optimizer loop)
---

You will translate text with literary quality using iterative refinement.

## Process

1. Parse arguments
   - source_text (required)
   - target_language (required)
   - quality_threshold (default: 8/10)
   - max_iterations (default: 3)

2. Generator Agent → Initial translation
   - Use Translation-Skill (cultural context)
   - Preserve tone, idioms, nuances

3. Evaluator Agent → Score + Feedback
   - Criteria:
     * Accuracy (1-10)
     * Cultural nuance (1-10)
     * Tone preservation (1-10)
     * Idiom matching (1-10)
   - Overall score = avg(4 criteria)
   - Feedback: Specific improvements needed

4. Loop Logic
   IF overall_score >= quality_threshold:
     → Return final translation
   ELIF iterations >= max_iterations:
     → Return best version (with warning)
   ELSE:
     → Generator Agent (with evaluator feedback)
     → Loop back to step 3

5. Report
   - Final score breakdown
   - Iterations count
   - Improvements per iteration
   - Best version (even if threshold not met)
```

---

### Hooks Nécessaires

#### Hook 1 : Evaluator Loop Gate

```bash
# .claude/hooks/evaluator-loop-gate.md

---
name: evaluator-loop-gate
when: after_evaluator_score
---

# Quality Decision Hook

# Parse evaluator output
score=$(echo "$TOOL_OUTPUT" | jq -r '.overall_score')
iterations=$(echo "$TOOL_OUTPUT" | jq -r '.iterations')
threshold=8
max_iterations=3

# Decision logic
if (( $(echo "$score >= $threshold" | bc -l) )); then
  echo "✅ Quality threshold met (score: $score/$threshold)"
  exit 0  # Pass → Continue to final output
elif (( iterations >= max_iterations )); then
  echo "⚠️ Max iterations reached ($iterations/$max_iterations), using best version"
  exit 1  # Warning → Return best effort
else
  echo "🔄 Refining (score: $score, iteration: $iterations)"
  exit 0  # Continue → Loop back to generator
fi
```

---

#### Hook 2 : Max Iterations Guard

```bash
# .claude/hooks/max-iterations-guard.md

---
name: max-iterations-guard
when: before_generator_loop
---

# Prevent Infinite Loops

iterations=$(cat /tmp/evaluator_iterations.txt 2>/dev/null || echo "0")
max_iterations=5  # Hard limit (safety)

if (( iterations > max_iterations )); then
  echo "❌ ERROR: Max iterations exceeded ($iterations > $max_iterations)"
  echo "Possible causes:"
  echo "  - Vague evaluation criteria"
  echo "  - Impossible quality threshold"
  echo "  - Evaluator giving inconsistent feedback"
  exit 2  # Block → Abort workflow
fi

# Increment counter
echo $((iterations + 1)) > /tmp/evaluator_iterations.txt
exit 0
```

---

### Agent Structure

#### Generator Agent

```yaml
# .claude/agents/literary-translator-generator.md

---
name: literary-translator-generator
model: sonnet  # Need reasoning for nuances
---

You are a literary translator specialized in preserving tone, idioms, and cultural nuances.

## Input
- source_text: Text to translate
- target_language: Target language code
- evaluator_feedback: (optional) Feedback from previous iteration

## Task

1. If evaluator_feedback is provided:
   - Read feedback carefully
   - Focus on specific improvements mentioned
   - Preserve what worked in previous version

2. Translate with focus on:
   - Accuracy (meaning preservation)
   - Cultural context (idioms, references)
   - Tone matching (formal/casual, playful/serious)
   - Literary quality (flow, rhythm)

3. Use Translation-Skill for:
   - Cultural context databases
   - Idiom matching dictionaries
   - Tone preservation guidelines

## Output Format

```json
{
  "translation": "translated text here",
  "version": 2,
  "improvements": ["specific changes made based on feedback"],
  "reasoning": "why these choices were made"
}
```

## Quality Standards

- NEVER literal translation if idiom exists
- ALWAYS preserve tone (match formality level)
- ALWAYS explain cultural adaptations
```

---

#### Evaluator Agent

```yaml
# .claude/agents/literary-translator-evaluator.md

---
name: literary-translator-evaluator
model: sonnet  # Need reasoning for evaluation
---

You are a literary translation quality evaluator.

## Input
- source_text: Original text
- translation: Current translation version
- target_language: Language code
- version: Iteration number

## Task

Evaluate translation on 4 criteria (score 1-10 each):

1. **Accuracy** (1-10)
   - Meaning preservation
   - No omissions or additions
   - Context maintained

2. **Cultural Nuance** (1-10)
   - Idioms adapted (not literal)
   - Cultural references localized
   - Context-appropriate choices

3. **Tone Preservation** (1-10)
   - Formality level matched
   - Emotional tone maintained
   - Author voice preserved

4. **Literary Quality** (1-10)
   - Natural flow in target language
   - Rhythm and style
   - Readability

## Output Format

```json
{
  "scores": {
    "accuracy": 9,
    "cultural_nuance": 7,
    "tone_preservation": 8,
    "literary_quality": 9
  },
  "overall_score": 8.25,
  "version": 2,
  "iterations": 2,
  "feedback": "Specific actionable improvements needed (if score < threshold)",
  "strengths": ["what works well"],
  "ready": true/false
}
```

## Feedback Guidelines

- BE SPECIFIC: "Add playful emoji to match casual tone" (not "improve tone")
- BE ACTIONABLE: "Replace 'It was raining heavily' with idiom 'raining cats and dogs'"
- PRIORITIZE: Focus on 1-2 most critical improvements
- BE OBJECTIVE: Base on criteria, not subjective preference
```

---

## 📊 Benchmarks de Performance

### Comparaison One-Shot vs Evaluator-Optimizer

```
╔═══════════════════════════════════════════════════════════╗
║        PERFORMANCE METRICS (100 translations)             ║
╚═══════════════════════════════════════════════════════════╝

Approach: ONE-SHOT (baseline)
├─ Quality avg     : 85% (acceptable but not excellent)
├─ Time per item   : 8s
├─ Cost per item   : $0.05 (1 call)
└─ Failures        : 15% (quality issues)

Approach: EVALUATOR-OPTIMIZER (loop)
├─ Quality avg     : 99% (+14% improvement)
├─ Time per item   : 22s (2.75x slower)
├─ Cost per item   : $0.12 (2.4x more expensive)
├─ Iterations avg  : 2.4
└─ Failures        : 1% (only edge cases)

ROI Analysis:
├─ Quality gain    : +14% (85% → 99%)
├─ Cost increase   : 2.4x ($0.05 → $0.12)
├─ Time increase   : 2.75x (8s → 22s)
└─ Decision        : ✅ JUSTIFIED for quality-critical content
```

---

### Impact des Itérations

```
╔═══════════════════════════════════════════════════════════╗
║          QUALITY IMPROVEMENT PER ITERATION                ║
╚═══════════════════════════════════════════════════════════╝

Iteration 0 (one-shot):
├─ Quality     : 85%
├─ Cost        : 1x
└─ Time        : 1x

Iteration 1 (first refinement):
├─ Quality     : 92% (+7% gain)
├─ Cost        : 2x
└─ Time        : 2x

Iteration 2 (second refinement):
├─ Quality     : 97% (+5% gain)
├─ Cost        : 3x
└─ Time        : 3x

Iteration 3 (third refinement):
├─ Quality     : 99% (+2% gain)
├─ Cost        : 4x
└─ Time        : 4x

Iteration 4+ (diminishing returns):
├─ Quality     : 99.5% (+0.5% gain)
├─ Cost        : 5x+
└─ Time        : 5x+

Recommendation: MAX 3 ITERATIONS
├─ 85% → 97% gain = 12%
├─ Cost 3x vs 5x+ (diminishing returns after)
└─ Sweet spot: Quality/Cost balance
```

---

## 💎 Best Practices

### ✅ DO

```
1. SET CLEAR SCORING CRITERIA
   ✅ Objective metrics (1-10 scales)
   ✅ Multiple dimensions (accuracy, tone, style)
   ✅ Overall score = avg(dimensions)
   ✅ Threshold clear (e.g., 8/10)

2. MAX 3-5 ITERATIONS
   ✅ Sweet spot: 3 iterations (quality/cost balance)
   ✅ Hard limit: 5 iterations (safety guard)
   ✅ Diminishing returns after 3

3. RETURN BEST VERSION ALWAYS
   ✅ Even if threshold not met
   ✅ Never return nothing (best effort)
   ✅ Add warning if quality < threshold

4. LOG ITERATIONS + IMPROVEMENTS
   ✅ Track scores per iteration
   ✅ Document improvements made
   ✅ Measure ROI (quality gain vs cost)

5. ACTIONABLE FEEDBACK
   ✅ Specific: "Add emoji 🎉 here"
   ✅ Prioritized: 1-2 most critical items
   ✅ Objective: Based on criteria

6. COST-AWARE
   ✅ Monitor API usage
   ✅ Use haiku for simple evaluations
   ✅ Reserve sonnet for complex reasoning
```

---

### ❌ DON'T

```
1. VAGUE CRITERIA
   ❌ "Make it better" (non-actionnable)
   ❌ Subjective without metrics
   ❌ Inconsistent evaluation

2. INFINITE LOOPS
   ❌ No max iterations limit
   ❌ No stopping conditions
   ❌ Trust loop will converge (it won't always)

3. RETRY FOREVER
   ❌ Quality threshold impossible to reach
   ❌ Evaluator too strict (always rejects)
   ❌ Generator can't improve (stuck)

4. IGNORE COST
   ❌ No budget tracking
   ❌ Opus for simple tasks (overkill)
   ❌ Unlimited iterations

5. SKIP BEST VERSION FALLBACK
   ❌ Return nothing if threshold not met
   ❌ Discard all work if failed
   ❌ No graceful degradation

6. VAGUE FEEDBACK
   ❌ "This is not good" (not actionable)
   ❌ "Improve the style" (too broad)
   ❌ No specific examples
```

---

## 🔗 Relation avec Autres Patterns

### vs Pattern 1 : Prompt Chaining

```
Prompt Chaining:
├─ Séquence FIXE (A→B→C)
├─ Pas de boucle
├─ Chaque step différent
└─ Use: Decompose tâche complexe en steps

Evaluator-Optimizer:
├─ Boucle DYNAMIQUE (Generate→Evaluate→Loop)
├─ Même Generator, feedback évolue
├─ Stop when quality criteria
└─ Use: Raffiner quality iterativement
```

---

### vs Pattern 3 : Parallelization (Voting)

```
Parallelization (Voting):
├─ Générer N versions simultanées
├─ Vote pour meilleure version
├─ 1 iteration, N outputs
└─ Use: Consensus, redundancy

Evaluator-Optimizer:
├─ Générer 1 version, évaluer
├─ Raffiner basé sur feedback
├─ M iterations, 1 output final
└─ Use: Iterative improvement
```

**Quand combiner** :
- Voting pour draft initial (N versions parallèles)
- Evaluator-Optimizer sur meilleure version (refine)

---

### Avec Pattern 4 : Orchestrator-Workers

```
Command (orchestrator)
  ├─> Generator Agent (worker)
  ├─> Evaluator Agent (worker)
  └─> Loop logic (Command décide)

✅ Command orchestre loop
✅ Agents exécutent (atomic tasks)
✅ Hook evaluator-loop-gate (quality decision)
```

---

## 🎓 Points Clés

```
╔═══════════════════════════════════════════════════════════╗
║           EVALUATOR-OPTIMIZER ESSENTIALS                  ║
╚═══════════════════════════════════════════════════════════╝

✅ Generator → Evaluator → Refine LOOP
✅ Clear scoring criteria (1-10, objective)
✅ Max 3-5 iterations (diminishing returns)
✅ Return BEST version (even if threshold not met)
✅ Actionable feedback (specific, prioritized)
✅ Quality > Speed trade-off (2-3x slower)
✅ Use when: Quality-critical (legal, brand, literary)
❌ Don't: Vague criteria, infinite loops, ignore cost
```

---

## 📚 Ressources

### Documentation Anthropic

- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) - Evaluator-Optimizer section
- 📄 [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### Articles

- 📝 [6 Composable Patterns (AIMultiple)](https://research.aimultiple.com/building-ai-agents/)
- 📝 [Design Patterns Agentic Workflows (HuggingFace)](https://huggingface.co/blog/dcarpintero/design-patterns-for-building-agentic-workflows)

### Exemples Internes

- 🚀 [Enterprise RFP](../workflows/enterprise-rfp.md) - Quality loops dans legal analysis
- 🚀 [Global Localization](../workflows/global-localization.md) - Translation quality checks
- 📐 [Orchestration Principles](../orchestration-principles.md) - Règles d'or Anthropic

---

## 🚀 Prochaines Étapes

1. ✅ Comprendre architecture Generator ↔ Evaluator
2. ✅ Définir scoring criteria clairs (1-10)
3. ✅ Implémenter Command + 2 Agents + Hooks
4. ✅ Tester sur use case quality-critical
5. ✅ Mesurer ROI (quality gain vs cost increase)
6. ✅ Itérer : ajuster threshold, max iterations

---

**Quote Anthropic** :
> "Evaluator-Optimizer loops excel when you have clear evaluation criteria and iterative refinement adds measurable value."
> — Building Effective Agents, Anthropic Research

**Règle d'Or** :
> **Max 3 iterations = sweet spot qualité/coût. After 3, diminishing returns.**
