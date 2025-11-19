# Pattern 2 : Routing (Classification & Spécialisation)

> **Pattern Anthropic officiel** pour diriger requêtes vers spécialistes adaptés.

---

## 🎯 Concept

**Routing** = **Classifier** l'input et **diriger** vers une tâche de suivi spécialisée, permettant la **separation of concerns**.

**Caractéristique clé** : Décision **AVANT** exécution (route vers A **OU** B **OU** C), pas tous en même temps.

---

## 📐 Architecture

```
╔═══════════════════════════════════════════════════════════╗
║                ROUTING ARCHITECTURE                       ║
╚═══════════════════════════════════════════════════════════╝

Input
  ↓
┌─────────────────────────────────┐
│ CLASSIFIER                      │
│ (LLM or Algorithm)              │
│ → Analyze input                 │
│ → Decide category               │
└─────────────────────────────────┘
  ↓
[Classification Result: Category A/B/C]
  ↓
┌──────────┬──────────┬──────────┐
│ Path A   │ Path B   │ Path C   │
│Specialist│Specialist│Specialist│
└──────────┴──────────┴──────────┘
  ↓
Selected Specialist executes
  ↓
Result
```

**Différence vs autres patterns** :
- **vs Prompt Chaining** : Pas séquentiel (A→B→C), mais choix (A **OU** B **OU** C)
- **vs Parallelization** : UN seul path exécuté, pas tous en parallèle
- **vs Orchestrator-Workers** : Classification statique, pas dynamique

---

## 🎯 Quand Utiliser

### ✅ Utiliser Routing quand :

```
1. CATÉGORIES DISTINCTES
   └─> Input clairement classifiable (support/sales/refund)
   └─> Chaque catégorie = specialist différent
   └─> Separation of concerns (modularité)

2. OPTIMISATION PAR TYPE
   └─> Chaque type mieux géré séparément
   └─> Specialist focalisé (expertise unique)
   └─> Optimiser un type ne nuit pas aux autres

3. CLASSIFICATION PRÉCISE
   └─> LLM ou algo peut classifier avec confiance
   └─> Critères clairs (keywords, patterns, rules)
   └─> Peu d'ambiguïté (edge cases rares)

4. SCALABILITÉ
   └─> Ajouter nouveau specialist facile (nouveau path)
   └─> Maintenir specialists indépendamment
   └─> Tester chaque path isolément
```

### ❌ Ne PAS utiliser quand :

```
1. TOUS LES PATHS NÉCESSAIRES
   ❌ Si besoin d'exécuter A ET B ET C
   ✅ Utiliser Pattern 3 : Parallelization

2. SÉQUENCE REQUISE
   ❌ Si A→B→C obligatoire (steps dépendants)
   ✅ Utiliser Pattern 1 : Prompt Chaining

3. CLASSIFICATION IMPOSSIBLE
   ❌ Input trop ambigu (pas de pattern clair)
   ❌ Edge cases nombreux (overlap entre catégories)
   ✅ Fallback : généraliste (pas de routing)

4. UN SEUL TYPE D'INPUT
   ❌ Pas besoin de router si tout homogène
   ✅ Direct execution (pas de classifier)
```

---

## 💡 Notre Implémentation : Skills Auto-Invocation

### 🎯 Skills = Routing via Description Matching

**Notre implémentation du Routing** = **Skills avec auto-invocation basée sur LLM reasoning**.

```
╔═══════════════════════════════════════════════════════════╗
║          SKILLS AUTO-INVOCATION (Routing)                 ║
╚═══════════════════════════════════════════════════════════╝

User Request
  ↓
Claude (LLM reasoning)
  ↓
[Analyze request keywords, context, intent]
  ↓
[Match against Skills descriptions]
  ↓
┌──────────────────────────────────────────────────────────┐
│ Available Skills (from tools array):                     │
│                                                          │
│ - pdf (description: "Extract text from PDFs, fill forms")│
│ - legal (description: "Analyze contracts, legal risks") │
│ - translation (description: "Translate content")         │
│ - ... (all skills listed)                               │
└──────────────────────────────────────────────────────────┘
  ↓
[LLM selects best match]
  ↓
┌─────────────────────────────────┐
│ Selected Skill (e.g., "pdf")    │
│ → Load full prompt (isMeta)     │
│ → Execute with skill context    │
└─────────────────────────────────┘
  ↓
Result
```

**Mécanisme** :
1. **Classifier** = Claude (LLM reasoning sur descriptions)
2. **Paths** = Skills (chaque skill = specialist)
3. **Sélection** = Description matching (WHEN/WHEN NOT pattern)

---

## 🏗️ Implémentation

### Skill Structure (avec WHEN/WHEN NOT)

```markdown
# .claude/skills/pdf/SKILL.md

---
name: pdf
description: |
  WHAT: Extract text from PDFs, fill PDF forms, parse tables

  WHEN: Auto-invoke when user mentions:
    - "PDF" in request
    - "extract from document"
    - "fill form"
    - "parse table from file"

  WHEN NOT: Do NOT invoke if:
    - User wants to CREATE PDF (different skill)
    - File is NOT PDF (use appropriate skill)
    - Simple text file reading (use Read tool, not skill)

allowed-tools:
  - Read
  - Bash(pdftotext:*)
  - Bash(pdftk:*)

model: haiku  # Simple extraction, cheap
---

# PDF Processing Skill

You are a PDF processing specialist.

## Capabilities

1. **Text Extraction**
   - Extract text from PDF files
   - Preserve formatting (headings, lists)
   - Handle multi-column layouts

2. **Form Filling**
   - Fill PDF forms programmatically
   - Validate field types
   - Generate filled PDF

3. **Table Parsing**
   - Extract tables from PDFs
   - Convert to structured data (JSON, CSV)
   - Handle complex layouts

## Tools Available

- `pdftotext` - Extract text
- `pdftk` - Fill forms, merge PDFs
- `Read` - Read PDF files

## Process

1. Identify PDF operation (extract/fill/parse)
2. Use appropriate tool
3. Fallback chain:
   - Try pdftotext
   - If fail → Try alternative parser
   - If fail → Manual extraction (OCR if needed)
4. Return structured result

## Examples

### Extract Text
```bash
pdftotext document.pdf output.txt
```

### Fill Form
```bash
pdftk template.pdf fill_form data.fdf output filled.pdf
```

## Output Format
Always return structured data (JSON, Markdown, CSV).
```

---

### Routing Decision (LLM Reasoning)

```
╔═══════════════════════════════════════════════════════════╗
║         LLM ROUTING DECISION PROCESS                      ║
╚═══════════════════════════════════════════════════════════╝

User: "Extract the contract terms from this PDF"

Claude reasoning:
  ├─> Keywords detected: "extract", "PDF"
  ├─> Intent: Text extraction from PDF file
  ├─> Match against skills descriptions:
  │     ├─ pdf: ✅ "Extract text from PDFs" → STRONG MATCH
  │     ├─ legal: ⚠️ "Analyze contracts" → PARTIAL MATCH (but secondary)
  │     └─ translation: ❌ No match
  │
  └─> Decision: Invoke "pdf" skill (primary)
        → If legal analysis needed after extraction, invoke "legal" skill

[Skill Injection]
  ├─> Message 1 (isMeta: false): "The 'pdf' skill is loading"
  └─> Message 2 (isMeta: true): [Full pdf skill prompt injected]

Claude executes with PDF skill context
  ↓
Result: Extracted text + structured data
```

---

### Model Selection Routing

**Use case** : Router vers modèle adapté (haiku/sonnet/opus) selon complexité.

```yaml
# .claude/commands/smart-route.md

---
name: smart-route
description: Route task to optimal model based on complexity
---

You will analyze the task and route to the appropriate model.

## Routing Logic

### COMPLEXITY CLASSIFIER

Analyze task for:
1. Reasoning depth (simple/medium/complex)
2. Context length (small/medium/large)
3. Output precision (low/medium/high)
4. Cost constraints (budget available?)

### ROUTING DECISION

┌──────────────────────────────────────────────────────────┐
│ SIMPLE TASKS → HAIKU                                     │
├──────────────────────────────────────────────────────────┤
│ - Grammar fixes                                          │
│ - Format conversions                                     │
│ - Simple data extraction                                 │
│ - Repetitive operations                                  │
│                                                          │
│ Benefits: 10x cheaper, 2x faster                         │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ MEDIUM TASKS → SONNET (default)                          │
├──────────────────────────────────────────────────────────┤
│ - Code implementation                                    │
│ - API integration                                        │
│ - Analysis & reasoning                                   │
│ - Quality content writing                                │
│                                                          │
│ Benefits: Best balance quality/cost                      │
└──────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────┐
│ COMPLEX TASKS → OPUS                                     │
├──────────────────────────────────────────────────────────┤
│ - Deep research & synthesis                              │
│ - Complex architecture design                            │
│ - Critical decision-making                               │
│ - Long context (>50k tokens)                            │
│                                                          │
│ Benefits: Highest quality, longest context               │
│ Warning: 20x cost vs haiku                               │
└──────────────────────────────────────────────────────────┘

## Implementation

```typescript
function routeToModel(task: Task): Model {
  const complexity = analyzeComplexity(task);

  if (complexity.reasoning === 'simple' &&
      complexity.context < 10000) {
    return 'haiku';  // Fast & cheap
  }

  if (complexity.reasoning === 'complex' ||
      complexity.context > 50000) {
    return 'opus';  // Deep reasoning
  }

  return 'sonnet';  // Default (balanced)
}
```

## Examples

### Example 1: Grammar Fix (→ Haiku)
```
User: "Fix grammar in these 10 files"

Complexity:
  - Reasoning: Simple (pattern-based)
  - Context: 10 files × 200 lines = 2000 tokens
  - Precision: Medium (clear rules)

Route: HAIKU
Benefit: 10x cost savings ($0.02 vs $0.20)
```

### Example 2: Feature Implementation (→ Sonnet)
```
User: "Add user authentication with JWT"

Complexity:
  - Reasoning: Medium (design + code)
  - Context: 15k tokens (codebase)
  - Precision: High (production code)

Route: SONNET
Benefit: Quality code, reasonable cost
```

### Example 3: Architecture Design (→ Opus)
```
User: "Design microservices architecture for 1M users"

Complexity:
  - Reasoning: Complex (system design)
  - Context: 80k tokens (requirements)
  - Precision: Critical (business impact)

Route: OPUS
Benefit: Best quality, handles long context
```
```

---

## 💡 Exemples Concrets

### Exemple 1 : Customer Support Routing

```
╔═══════════════════════════════════════════════════════════╗
║         CUSTOMER SUPPORT TICKET ROUTING                   ║
╚═══════════════════════════════════════════════════════════╝

Incoming Tickets
  ↓
[CLASSIFIER: Analyze ticket content]
  ↓
┌──────────────────────────────────────────────────────────┐
│ ROUTING LOGIC                                            │
├──────────────────────────────────────────────────────────┤
│                                                          │
│ Keywords: "refund", "money back", "cancel order"        │
│ → Route to: REFUND-SPECIALIST                            │
│                                                          │
│ Keywords: "how to use", "tutorial", "guide"             │
│ → Route to: HELP-SPECIALIST                              │
│                                                          │
│ Keywords: "bug", "error", "not working"                  │
│ → Route to: TECHNICAL-SUPPORT                            │
│                                                          │
│ Keywords: "pricing", "upgrade", "enterprise"             │
│ → Route to: SALES-SPECIALIST                             │
│                                                          │
│ Default: GENERAL-SUPPORT                                 │
└──────────────────────────────────────────────────────────┘

Example Routing:

Ticket 1: "I want a refund for order #12345"
  → CLASSIFIER detects: "refund", "order"
  → ROUTE: REFUND-SPECIALIST
  → Response: "Refund processed in 3-5 business days"

Ticket 2: "How do I export my data to CSV?"
  → CLASSIFIER detects: "how to", "export"
  → ROUTE: HELP-SPECIALIST
  → Response: "Navigate to Settings → Export → CSV"

Ticket 3: "App crashes when I click Submit button"
  → CLASSIFIER detects: "crashes", "error", "button"
  → ROUTE: TECHNICAL-SUPPORT
  → Response: "Bug confirmed, fix deployed in v2.1.3"
```

**Benefits** :
- ✅ Fast response (specialist knowledge)
- ✅ Higher accuracy (focused expertise)
- ✅ Scalable (add new specialists easily)

---

### Exemple 2 : Multi-Language Translation Routing

```
User: "Translate this document"

[CLASSIFIER: Detect language pairs]
  ↓
Source: French → Target: Japanese
  ↓
┌──────────────────────────────────────────────────────────┐
│ LANGUAGE SPECIALISTS AVAILABLE                           │
├──────────────────────────────────────────────────────────┤
│ - fr-en (French-English specialist)                      │
│ - fr-es (French-Spanish specialist)                      │
│ - fr-ja (French-Japanese specialist) ✅ SELECTED         │
│ - en-de (English-German specialist)                      │
│ - ... (20+ language pairs)                              │
└──────────────────────────────────────────────────────────┘
  ↓
[ROUTE to: fr-ja specialist]
  ↓
Specialist uses:
  - French-Japanese dictionary
  - Cultural context (Japan-specific)
  - Idiom mappings (fr→ja)
  ↓
High-quality translation (cultural nuances preserved)
```

**Why Routing > Généraliste** :
- ✅ Specialist knows idioms (fr→ja)
- ✅ Cultural context (Japan-specific)
- ✅ Better quality vs generic translator

---

## 📊 Benchmarks de Performance

### Routing vs No-Routing

```
╔═══════════════════════════════════════════════════════════╗
║        ROUTING vs GENERALIST COMPARISON                   ║
╚═══════════════════════════════════════════════════════════╝

Use Case: 100 customer support tickets (mixed categories)

NO ROUTING (generalist handles all):
├─ Accuracy        : 70% (generalist not expert)
├─ Response time   : 8s avg (slow, broad context)
├─ Cost            : $5.00 (100 × sonnet)
└─ User satisfaction: 65% (generic answers)

WITH ROUTING (4 specialists):
├─ Accuracy        : 92% (+22% improvement)
│   ├─ Refund specialist: 98%
│   ├─ Help specialist: 95%
│   ├─ Technical specialist: 90%
│   └─ Sales specialist: 88%
├─ Response time   : 4s avg (specialists faster)
├─ Cost            : $2.50 (haiku for simple, sonnet for complex)
├─ User satisfaction: 88% (+23% improvement)
└─ Maintenance     : Easy (update specialists independently)

RESULT:
✅ Routing 22% more accurate
✅ Routing 2x faster
✅ Routing 50% cheaper (right model per task)
✅ Routing 23% higher user satisfaction
```

---

## 💎 Best Practices

### ✅ DO

```
1. CLEAR DESCRIPTIONS (WHEN/WHEN NOT)
   ✅ Explicit keywords (what triggers routing)
   ✅ Negative examples (what does NOT trigger)
   ✅ Avoid ambiguity

2. TEST ROUTING LOGIC
   ✅ Edge cases (ambiguous inputs)
   ✅ Overlap between categories
   ✅ Fallback when no match

3. MONITOR CLASSIFICATION ACCURACY
   ✅ Log routing decisions
   ✅ Track misroutes (wrong specialist)
   ✅ Improve descriptions based on data

4. SPECIALIST FOCUSED
   ✅ Each specialist = ONE expertise
   ✅ Separation of concerns
   ✅ Maintainable independently

5. FALLBACK STRATEGY
   ✅ Default specialist (general)
   ✅ Escalate to human if uncertain
   ✅ Never fail silently
```

---

### ❌ DON'T

```
1. VAGUE DESCRIPTIONS
   ❌ "Handles documents" (too broad)
   ✅ "Extract text from PDFs (not Word docs)"

2. OVERLAPPING SPECIALISTS
   ❌ pdf-reader + document-processor (overlap)
   ✅ Clear boundaries (pdf-only vs word-only)

3. TOO MANY SPECIALISTS
   ❌ 50 specialists (unmaintainable)
   ✅ 5-10 specialists (balanced)

4. NO FALLBACK
   ❌ Fail if no match
   ✅ Default to general specialist

5. IGNORE MISROUTES
   ❌ Wrong specialist selected, ignore
   ✅ Log, analyze, improve descriptions
```

---

## 🎓 Points Clés

```
╔═══════════════════════════════════════════════════════════╗
║              ROUTING ESSENTIALS                           ║
╚═══════════════════════════════════════════════════════════╝

✅ Classifier → Path A/B/C (ONE selected)
✅ Separation of concerns (specialists focused)
✅ Notre implémentation: Skills auto-invocation
✅ WHEN/WHEN NOT pattern (clear descriptions)
✅ LLM reasoning (description matching)
✅ 22% accuracy improvement vs generalist
✅ 50% cost savings (right model per task)
❌ Don't overlap specialists (maintain boundaries)
❌ Don't skip fallback (always have default)
```

---

## 📚 Ressources

### Documentation Anthropic

- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) - Routing section
- 📄 [Claude Skills](https://docs.claude.com/en/docs/claude-code/skills)

### Articles

- 📝 [Design Patterns Agentic Workflows](https://huggingface.co/blog/dcarpintero/design-patterns-for-building-agentic-workflows)
- 📝 [Skills Deep Dive (Lee Hanchung)](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)

### Exemples Internes

- 📐 [Skills Progressive Disclosure](../architecture/skills-progressive-disclosure.md)
- 📐 [Orchestration Principles](../orchestration-principles.md) - Règle 2 : Routing

---

## 🚀 Prochaines Étapes

1. ✅ Créer skills avec WHEN/WHEN NOT
2. ✅ Tester routing accuracy (edge cases)
3. ✅ Monitor misroutes (improve descriptions)
4. ✅ Add fallback specialist (default)
5. ✅ Measure accuracy vs generalist

---

**Quote Anthropic** :
> "Routing classifies inputs and directs them to specialized follow-up tasks, allowing for separation of concerns and better optimization per input type."
> — Building Effective Agents, Anthropic Research

**Règle d'Or** :
> **Clear WHEN/WHEN NOT descriptions. ONE specialist per expertise. ALWAYS have fallback.**
