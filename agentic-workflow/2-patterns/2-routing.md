# Pattern 2 : Routing (Classification & Spécialisation)

> **📚 Vue d'ensemble complète** : Voir [6 Patterns README](./README.md)

## 🎯 En Bref

**Concept**: Classifier input et diriger vers specialist adapté (A **OU** B **OU** C), permettant separation of concerns.

**Notre implémentation**: Skills Auto-Invocation (LLM reasoning via descriptions WHEN/WHEN NOT)

**ROI**: 22% accuracy improvement vs generalist, 50% cost savings (right model per task)

---

## 🧩 Pattern vs Workflow

**Ce fichier documente un PATTERN** (brique technique réutilisable).

| Aspect | Description |
|--------|-------------|
| 🔧 **Type** | Pattern architectural (classification) |
| 🎯 **Problème résolu** | Diriger vers le bon specialist selon contexte |
| 🧩 **Combinable avec** | Chaining (après routing), Orchestrator (routing dynamique) |
| 🚀 **Utilisé dans workflows** | Customer Support, Content Automation, Security Incident |

**Voir** : [Pattern vs Workflow Définition](../README.md#-pattern-vs-workflow--quelle-différence-)

## 📐 Architecture

```
Input → [CLASSIFIER] → Decision → [Path A OU B OU C] → Selected Specialist → Result
                        LLM/Algo    Specialists             Executes
```

**vs Autres patterns**:
- vs Prompt Chaining: Choix (A OU B), pas séquence (A→B→C)
- vs Parallelization: UN seul path, pas tous en parallèle
- vs Orchestrator: Classification statique, pas dynamique

## ⚡ Quick Start

```yaml
# .claude/skills/pdf/SKILL.md
---
description: |
  WHAT: Extract text from PDFs, fill forms

  WHEN: Auto-invoke when:
    - User mentions "PDF"
    - "extract from document"

  WHEN NOT: Do NOT if:
    - File is NOT PDF
    - Simple text file (use Read)
---
```

## 🎯 Quand Utiliser Ce Pattern

### ✅ Utiliser Routing SI :

```
✅ Plusieurs specialists avec expertises distinctes
   → Ex: Customer support (refund/help/technical/sales)

✅ Classification claire des inputs
   → Ex: PDF → pdf skill, Image → image skill

✅ Économie contexte (progressive disclosure)
   → Ex: Load ONLY specialist prompt (not all)

✅ Accuracy > Generalist (spécialisation gagne)
   → Ex: 95% refund specialist vs 70% generalist

✅ Cost optimization (right model per task)
   → Ex: Simple tasks → haiku, Complex → sonnet
```

### ❌ NE PAS Utiliser SI :

```
❌ Tâche générique (pas de spécialisation)
   → Ex: "Summarize text" → One-shot generalist suffit

❌ Frontières floues entre specialists
   → Ex: Overlapping domains → Confusion routing

❌ <3 specialists (overhead pas justifié)
   → Ex: 2 paths → Simple if/else suffit

❌ Classification coûteuse vs bénéfice
   → Ex: LLM reasoning slow → Direct specialist call
```

---

## ⚖️ Trade-offs

| Avantage ⬆️ | Inconvénient ⬇️ |
|------------|----------------|
| **+22% Accuracy** vs generalist | **Maintenance** (plusieurs specialists) |
| **-50% Cost** (right model/task) | **Overhead routing** (classification step) |
| **Économie contexte** (load specialist only) | **Frontières floues** (ambiguous inputs) |
| **Spécialisation** (focused expertise) | **Fallback requis** (unknown category) |

**Verdict** : Idéal pour domains avec **specialists clairement définis** (customer support, document types).

---

## 💡 Skills Auto-Invocation (Notre Implémentation)

```yaml
# LLM reasoning process:
User: "Extract contract terms from this PDF"

Claude analyzes:
  - Keywords: "extract", "PDF"
  - Match skills descriptions
  - pdf skill: STRONG MATCH (WHEN "extract", "PDF")
  - legal skill: PARTIAL MATCH (secondary)

→ Decision: Invoke pdf skill
→ Load full prompt (isMeta: true)
→ Execute with context
```

## 🎯 Best Practices

### ✅ DO
- Clear WHEN/WHEN NOT descriptions
- Specialist focused (ONE expertise)
- Test routing accuracy (edge cases)
- Always have fallback (default specialist)

### ❌ DON'T
- Vague descriptions ("Handles documents")
- Overlapping specialists (maintain boundaries)
- Too many specialists (5-10 max)
- No fallback (always have default)

## 🎓 Points Clés

```
✅ Classifier → Path A/B/C (ONE selected)
✅ Skills auto-invocation (description matching)
✅ WHEN/WHEN NOT pattern (critical)
✅ 22% accuracy improvement vs generalist
✅ 50% cost savings (right model/task)
❌ Don't overlap specialists
❌ Don't skip fallback
```

## 🔗 Ressources

- 📄 [Vue d'ensemble 6 Patterns](./README.md)
- 📐 [Skills Progressive Disclosure](../3-architecture/skills-progressive-disclosure.md)
- 📄 [Orchestration Principles](../orchestration-principles.md)
- 📄 [Skills Deep Dive (Lee Hanchung)](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)

**Voir** : [Skills Guide Complet](../../themes/4-skills/guide.md) - Implémentation technique détaillée
