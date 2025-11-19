# ASCII Style Guide - Agentic Workflow

> **Standardisation des diagrammes ASCII** pour cohérence visuelle et compréhension optimale.

---

## 📐 Headers & Boxes

### High Importance (═ double lines)

```
╔═══════════════════════════════╗
║  High Priority Headers        ║
╚═══════════════════════════════╝
```

**Utilisation** : Section majeure, concept clé, avertissement important.

### Medium Importance (─ single lines)

```
┌───────────────────────────────┐
│  Medium Priority Boxes        │
└───────────────────────────────┘
```

**Utilisation** : Contenu standard, exemple, description détaillée.

### Code Blocks

````
┌─────────────────────────────────┐
│ ```bash                         │
│ command here                    │
│ ```                             │
└─────────────────────────────────┘
````

**Utilisation** : Code snippet, commande terminal, configuration.

---

## 🌳 Tree Structures

### File Trees

```
📦 Project/
┣━━ 📁 folder1/
┃   ┣━━ 📄 file1.md
┃   ┣━━ 📄 file2.md
┃   ┗━━ 📄 file3.md
┣━━ 📁 folder2/
┃   ┗━━ 📄 file4.md
┗━━ 📁 folder3/
    ┗━━ 📄 file5.md
```

**Règles** :
- ┣━━ pour branches non-finales
- ┗━━ pour dernière branche
- ┃   pour continuation vertical
- Toujours aligner les caractères

### Hierarchies (Command → Agent)

```
Orchestrator (CLI)
  ↓
Subcommand
  ↓
Agent (Worker)
  ↓
Task Execution
```

**Utilisation** : Chaîne de responsabilité, hiérarchie de commandes.

### Process Flows

```
Input
  ↓
Process (Transformation)
  ↓
Output
```

**Utilisation** : Flux simple, étape par étape, flux linéaire.

---

## 🔀 Flow Diagrams

### Linear Flow (→ arrows)

```
Input → LLM₁ → Output₁ → LLM₂ → Final Output
```

**Règles** :
- Utiliser → pour flux horizontal
- Garder une ligne par flux
- Max 5-6 étapes par ligne

### Sequential Steps

```
┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
│ EXPLORE │───>│  PLAN   │───>│  CODE   │───>│  TEST   │
└─────────┘    └─────────┘    └─────────┘    └─────────┘
```

**Utilisation** : Workflow EPCT, étapes orchestrées, séquence garantie.

### Parallel Flow (|| notation)

```
Input → Split Decision
         ↓
    [LLM₁ || LLM₂ || LLM₃]
         ↓
    Aggregate Results
```

**Utilisation** : Exécution parallèle, multi-agents, branches indépendantes.

**Règles** :
- || pour parallel execution
- Parenthèses pour grouper
- ↓ pour convergence

### Loop Flow (Iterative)

```
Input → Generator → Draft v1
         ↑              ↓
         └── Evaluator ←┘
         (max 3-5 iterations)
```

**Utilisation** : Boucles d'amélioration, itération, validation cyclique.

**Règles** :
- Boucle max 3-5 itérations
- Spécifier le critère d'arrêt
- ↑ ↓ pour directions

---

## 🎯 Decision Trees

### Simple If/Else

```
Question?
├─ ✅ OUI → Action A
└─ ❌ NON → Action B
```

**Utilisation** : Choix binaire, condition simple.

### Multi-Level Decision

```
Quelle tâche?
│
├─ 🟢 FEATURE SIMPLE
│  └─→ Direct Implementation
│
├─ 🟡 TÂCHES RÉPÉTITIVES
│  └─→ Parallel Agents Pattern
│
└─ 🔴 FEATURE COMPLEXE
   └─→ Full EPCT Workflow
```

**Utilisation** : Choix multiples, routing logique, chemins divergents.

**Règles** :
- Utiliser 🔴🟡🟢 pour priorité/complexité
- Limiter à 3-4 branches principales
- Flèches cohérentes (└─→ pour branche finale)

---

## 📊 Tables & Comparisons

### Simple Table

```
| Pattern | Use Case | Complexity |
|---------|----------|-----------|
| EPCT | Complex features | High |
| Prompt Chaining | Sequential tasks | Medium |
| Parallel Agents | Independent work | Medium |
```

**Utilisation** : Comparaison de patterns, référence rapide, synthèse.

### Before/After Comparison

```
AVANT:                              APRÈS:
❌ Workflow désorganisé             ✅ EPCT Structured
└─ Prompts chaotiques              └─ Prompts composables
└─ Pas de réutilisabilité          └─ Réutilisable facilement
└─ Tests ad-hoc                    └─ Tests systématiques
```

**Utilisation** : Impact d'amélioration, illustration de solution.

---

## 🔢 Numbered Lists (Étapes)

### Sequential Steps

```
1️⃣ EXPLORE
   └─> Analyse contexte & requirements

2️⃣ PLAN
   └─> Stratégie implémentation

3️⃣ CODE
   └─> Implémentation & intégration

4️⃣ TEST
   └─> Validation & vérification
```

**Utilisation** : Workflow EPCT, tutoriels, onboarding.

**Règles** :
- Utiliser 1️⃣ 2️⃣ 3️⃣ etc.
- Limiter à 5-7 étapes max
- Chaque étape une description (└─>)

---

## ✅ Status Indicators

### Completion & Validation

```
✅ Completed / Passed / Success
⚠️ Warning / Attention required
❌ Failed / Error / Not done
⏳ In Progress / Pending
```

### Priority Levels

```
🔴 CRITICAL / Haute priorité
🟡 MEDIUM / Priorité moyenne
🟢 LOW / Optionnel / Faible priorité
```

### Feature Tags

```
⭐ Recommended / Best practice
🌟 Very important / Key feature
💪 Advanced / Expert level
🔥 Hot / Trending / New
```

---

## 🎨 Best Practices

### DO ✅

```
✅ Use consistent box styles
   └─> Double (═) for headers
   └─> Single (─) for content

✅ Align arrows properly
   └─> → for horizontal
   └─> ↓ for vertical
   └─> Coherent through diagram

✅ Keep diagrams readable
   └─> Max 60 chars width
   └─> Clear hierarchy
   └─> Functional purpose

✅ Emojis pour clarté
   └─> 📦 📁 📄 pour files
   └─> 1️⃣ 2️⃣ 3️⃣ pour étapes
   └─> ✅ ❌ ⚠️ pour statut
```

### DON'T ❌

```
❌ Mix arrow styles inconsistently
   └─> Don't alternate → vs → vs -

❌ Create overly nested diagrams
   └─> Max 3 nesting levels
   └─> Use multiple simpler diagrams instead

❌ Use ASCII art for decoration
   └─> All ASCII must serve clarity
   └─> No fancy borders without purpose

❌ Exceed readable width
   └─> Max 80 characters line length
   └─> Ensures terminal compatibility
```

---

## 📝 Real Examples from Codebase

### EPCT Workflow (Prompt Chaining Pattern)

```
Orchestrator Input
      ↓
┌─────────────────────────┐
│ 1️⃣ EXPLORE             │
│ └─> Context extraction │
└─────────────────────────┘
      ↓
┌─────────────────────────┐
│ 2️⃣ PLAN                │
│ └─> Strategy design    │
└─────────────────────────┘
      ↓
┌─────────────────────────┐
│ 3️⃣ CODE                │
│ └─> Implementation     │
└─────────────────────────┘
      ↓
┌─────────────────────────┐
│ 4️⃣ TEST                │
│ └─> Validation         │
└─────────────────────────┘
      ↓
Final Output
```

**Caractéristiques** :
- Sequential step-by-step
- Medium boxes (─) pour chaque étape
- Numérotation claire (1️⃣ 2️⃣ 3️⃣ 4️⃣)
- Flèches verticales (↓) pour progression

### Orchestrator-Workers (Parallel Pattern)

```
╔════════════════════════════════╗
║  Orchestrator (LLM)            ║
║  [Analyze + Route Tasks]       ║
╚════════════════════════════════╝
         ↓
    ┌────────────────┐
    │ Route Decision │
    └────────────────┘
         ↓
[Worker₁ || Worker₂ || Worker₃]
         ↓
┌─────────────────────────┐
│ Orchestrator Synthesizes│
└─────────────────────────┘
         ↓
Final Aggregated Output
```

**Caractéristiques** :
- High importance (═) pour orchestrator
- Parallel notation ([A || B || C])
- Clear synchronization points
- Nested flow structure

### Decision Tree (Pattern Selection)

```
Quel problème résoudre?
│
├─ 🟢 Tâche simple (< 5 min)
│  └─→ Direct LLM Call
│
├─ 🟡 Tâche complexe structurée
│  └─→ Prompt Chaining (EPCT)
│
└─ 🔴 Tâche avec dépendances
   └─→ Orchestrator-Workers Pattern
```

**Caractéristiques** :
- Color coding (🔴 🟡 🟢)
- Clear decision points
- Action arrows (└─→)
- Compact format

---

## 🔧 Implementation Guidelines

### File Structure in Docs

```
Each documentation file should:

┌─────────────────────────────────┐
│ # Title                         │
│ > Subtitle/Context              │
├─────────────────────────────────┤
│ ## 📐 Section Title             │
│                                 │
│ ### Subsection                  │
│ [Diagram]                       │
│ [Description]                   │
├─────────────────────────────────┤
│ ## 🎯 Real Example              │
│ [Code/Diagram]                  │
├─────────────────────────────────┤
│ ## ✅ Key Takeaways             │
│ [Summary bullets]               │
└─────────────────────────────────┘
```

### Diagram Placement

```
Optimal structure:

1. Text introduction
   ↓
2. Diagram visualization
   ↓
3. Detailed explanation
   ↓
4. Code example (if applicable)
```

### Consistency Checklist

```
Before finalizing a diagram:

✅ Width: ≤ 80 characters
✅ Style: Consistent boxes (═ or ─)
✅ Arrows: Aligned & coherent
✅ Emojis: Purposeful, not decorative
✅ Nesting: Max 3 levels
✅ Clarity: Single clear message
✅ Context: Explained in text nearby
```

---

## 📚 Related Resources

- **Project CLAUDE.md**: Project philosophy & documentation rules
- **OPTIMIZATION-PLAN.md**: Full strategic plan (source of this guide)
- **README.md**: Navigation & project overview

---

**Application**: Tous les nouveaux diagrammes ASCII dans le projet agentic-workflow doivent respecter ce style guide pour cohérence visuelle et clarté optimale.
