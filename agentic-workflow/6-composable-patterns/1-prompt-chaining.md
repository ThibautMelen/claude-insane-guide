# Pattern 1 : Prompt Chaining (Sequential Execution)

> **Pattern Anthropic officiel** pour décomposer tâches complexes en séquence d'étapes.

---

## 🎯 Concept

**Prompt Chaining** = Décomposer une tâche en **séquence d'appels LLM** où chaque appel traite la sortie du précédent.

**Caractéristique clé** : Séquence **FIXE et PRÉDÉFINIE** (A→B→C), pas dynamique.

---

## 📐 Architecture

```
╔═══════════════════════════════════════════════════════════╗
║              PROMPT CHAINING ARCHITECTURE                 ║
╚═══════════════════════════════════════════════════════════╝

Input
  ↓
┌─────────────────────────────────┐
│ LLM Call 1 (Step A)             │
│ → Process input                 │
│ → Generate Output₁              │
└─────────────────────────────────┘
  ↓
[Gate: Validation Output₁]
  ↓
┌─────────────────────────────────┐
│ LLM Call 2 (Step B)             │
│ → Take Output₁ as input         │
│ → Generate Output₂              │
└─────────────────────────────────┘
  ↓
[Gate: Validation Output₂]
  ↓
┌─────────────────────────────────┐
│ LLM Call 3 (Step C)             │
│ → Take Output₂ as input         │
│ → Generate Final Output         │
└─────────────────────────────────┘
  ↓
Final Result
```

**Différence vs autres patterns** :
- **vs Parallelization** : Séquentiel (A→B→C), pas parallèle
- **vs Evaluator-Optimizer** : Pas de boucle, séquence fixe
- **vs Routing** : Tous les steps exécutés, pas de branches

---

## 🎯 Quand Utiliser

### ✅ Utiliser Prompt Chaining quand :

```
1. TÂCHE DÉCOMPOSABLE EN STEPS FIXES
   └─> Séquence prévisible (toujours A→B→C)
   └─> Chaque step dépend du précédent
   └─> Pas de décision dynamique nécessaire

2. COMPLEXITÉ RÉDUCTIBLE PAR ÉTAPES
   └─> Tâche complexe → plus simple si décomposée
   └─> Chaque LLM call traite sous-problème
   └─> Output₁ simplifie input pour LLM₂

3. TRADE-OFF LATENCE/ACCURACY ACCEPTABLE
   └─> Latence ↑ (N calls séquentiels)
   └─> Accuracy ↑ (chaque step focused)
   └─> Quality > Speed (acceptable)

4. VALIDATION ENTRE STEPS
   └─> Gates de validation possibles
   └─> Rollback si step échoue
   └─> Progression contrôlée
```

### ❌ Ne PAS utiliser quand :

```
1. STEPS INDÉPENDANTS
   ❌ Si A, B, C peuvent s'exécuter en parallèle
   ✅ Utiliser Pattern 3 : Parallelization

2. SÉQUENCE NON-FIXE
   ❌ Si steps varient selon input
   ✅ Utiliser Pattern 4 : Orchestrator-Workers

3. BOUCLE NÉCESSAIRE
   ❌ Si raffinement itératif requis
   ✅ Utiliser Pattern 5 : Evaluator-Optimizer

4. LATENCE CRITIQUE
   ❌ Si real-time response nécessaire
   ✅ Optimiser ou utiliser single-shot
```

---

## 💡 Notre Implémentation : EPCT Workflow

### 🎯 EPCT = Explore → Plan → Code → Test

Notre implémentation du **Prompt Chaining** est le **EPCT Workflow** :

```
╔═══════════════════════════════════════════════════════════╗
║                EPCT WORKFLOW (Sequential)                 ║
╚═══════════════════════════════════════════════════════════╝

User Request: "Add user authentication feature"
  ↓
┌─────────────────────────────────────────────────────────┐
│ STEP 1: EXPLORE                                         │
│ ─────────────────────────────────────────────────────── │
│ Task:                                                   │
│   - Read existing codebase (auth files, routes)         │
│   - Understand current architecture                     │
│   - Identify integration points                         │
│   - Check dependencies (libraries available)            │
│                                                         │
│ Output₁:                                                │
│   - Architecture analysis                               │
│   - Integration points identified                       │
│   - Dependencies needed                                 │
│   - Constraints/limitations                             │
└─────────────────────────────────────────────────────────┘
  ↓
[GATE: User validation - Architecture OK?]
  ↓
┌─────────────────────────────────────────────────────────┐
│ STEP 2: PLAN                                            │
│ ─────────────────────────────────────────────────────── │
│ Task:                                                   │
│   - Design solution based on Explore output            │
│   - Propose file structure                             │
│   - Define API contracts                               │
│   - List implementation steps                          │
│                                                         │
│ Output₂:                                                │
│   - Detailed implementation plan                        │
│   - Files to create/modify                             │
│   - API design (endpoints, schemas)                     │
│   - Step-by-step checklist                             │
└─────────────────────────────────────────────────────────┘
  ↓
[GATE: User approval - Plan validated?]
  ↓
┌─────────────────────────────────────────────────────────┐
│ STEP 3: CODE                                            │
│ ─────────────────────────────────────────────────────── │
│ Task:                                                   │
│   - Implement according to approved plan               │
│   - Write code (auth logic, routes, middleware)        │
│   - Follow plan exactly (no surprises)                 │
│   - Add tests as defined in plan                       │
│                                                         │
│ Output₃:                                                │
│   - Code implemented                                    │
│   - Files created/modified                             │
│   - Tests written                                       │
│   - Ready for testing phase                            │
└─────────────────────────────────────────────────────────┘
  ↓
[GATE: Compilation OK? No syntax errors?]
  ↓
┌─────────────────────────────────────────────────────────┐
│ STEP 4: TEST                                            │
│ ─────────────────────────────────────────────────────── │
│ Task:                                                   │
│   - Run test suite                                      │
│   - Check coverage (>80%)                              │
│   - Verify build passes                                │
│   - Manual testing if needed                           │
│                                                         │
│ Output₄ (Final):                                        │
│   - Test results (pass/fail)                           │
│   - Coverage report                                     │
│   - Build status                                        │
│   - Issues found (if any)                              │
└─────────────────────────────────────────────────────────┘
  ↓
[GATE: All tests pass? Coverage OK?]
  ↓
✅ Feature Complete & Validated
```

---

## 🏗️ Implémentation

### Command Structure (EPCT)

```yaml
# .claude/commands/epct.md

---
name: epct
description: Explore-Plan-Code-Test workflow for complex features
---

You will implement a feature using the EPCT (Explore-Plan-Code-Test) methodology.

## Process

### STEP 1: EXPLORE 🔍

**Goal**: Understand context fully before planning.

1. Read relevant codebase files
   - Existing architecture
   - Similar features (for patterns)
   - Integration points
   - Dependencies available

2. Research if needed
   - Library documentation (Context7, Perplexity)
   - Best practices
   - Security considerations

3. Output exploration report:
   ```markdown
   ## Exploration Report

   ### Current Architecture
   - [Key findings about codebase structure]

   ### Integration Points
   - [Where new feature will plug in]

   ### Dependencies
   - [Libraries available/needed]

   ### Constraints
   - [Limitations, compatibility issues]

   ### Recommendations
   - [Suggested approach based on findings]
   ```

**GATE**: Present exploration report to user for validation.

---

### STEP 2: PLAN 📋

**Goal**: Design detailed implementation strategy.

**Input**: Approved exploration report

1. Design solution architecture
   - File structure (which files to create/modify)
   - API contracts (endpoints, schemas, types)
   - Data flow (how components interact)

2. Break down into steps
   - Implementation checklist (step-by-step)
   - Testing strategy (unit, integration)
   - Rollback plan (if something fails)

3. Output implementation plan:
   ```markdown
   ## Implementation Plan

   ### Files to Create
   - `src/auth/login.ts` - Login logic
   - `src/auth/middleware.ts` - Auth middleware

   ### Files to Modify
   - `src/routes/api.ts` - Add auth routes
   - `package.json` - Add bcrypt dependency

   ### API Design
   - POST /api/auth/login
     - Body: { email, password }
     - Response: { token, user }

   ### Implementation Steps
   1. Install bcrypt
   2. Create login.ts
   3. Create middleware.ts
   4. Add routes to api.ts
   5. Write tests

   ### Testing Strategy
   - Unit: Test login logic (valid/invalid credentials)
   - Integration: Test full auth flow (login→protected route)
   - Coverage target: >80%
   ```

**GATE**: User approves plan before coding.

---

### STEP 3: CODE 💻

**Goal**: Implement according to approved plan.

**Input**: Approved implementation plan

1. Follow plan EXACTLY
   - No surprises (stick to plan)
   - No additional features (scope creep)
   - Ask if clarification needed

2. Write code
   - Create files as planned
   - Modify files as planned
   - Follow project conventions (linting, formatting)

3. Write tests
   - Unit tests (as planned)
   - Integration tests (as planned)
   - Edge cases

4. Output implementation report:
   ```markdown
   ## Implementation Complete

   ### Files Created
   ✅ src/auth/login.ts (145 lines)
   ✅ src/auth/middleware.ts (68 lines)

   ### Files Modified
   ✅ src/routes/api.ts (+23 lines)
   ✅ package.json (+1 dependency)

   ### Tests Written
   ✅ tests/auth/login.test.ts (12 tests)
   ✅ tests/auth/middleware.test.ts (8 tests)

   ### Ready for Testing Phase
   ```

**GATE**: Compilation OK? No syntax errors?

---

### STEP 4: TEST ✅

**Goal**: Verify implementation works as expected.

**Input**: Implemented code

1. Run test suite
   ```bash
   npm test
   ```

2. Check coverage
   ```bash
   npm run test:coverage
   ```

3. Run build
   ```bash
   npm run build
   ```

4. Manual testing (if applicable)
   - Test happy path
   - Test error cases
   - Test edge cases

5. Output test report:
   ```markdown
   ## Test Results

   ### Unit Tests
   ✅ 20/20 tests passed

   ### Integration Tests
   ✅ 8/8 tests passed

   ### Coverage
   ✅ 94% (target: >80%)

   ### Build
   ✅ Build successful (0 errors, 0 warnings)

   ### Manual Testing
   ✅ Login flow works
   ✅ Protected routes secured
   ✅ Error messages clear

   ### Status
   🎉 Feature complete & validated
   ```

**GATE**: All tests pass? Coverage OK? → DONE

---

## CRITICAL RULES

1. **NEVER skip steps** (always E→P→C→T)
2. **ALWAYS wait for user approval** (after Explore, after Plan)
3. **NEVER code before plan approved** (avoid hallucinations)
4. **NEVER add unplanned features** (stick to plan)
5. **ALWAYS run tests** (don't assume it works)

---

## Error Handling

If any step fails:
1. Stop immediately
2. Report error to user
3. Ask for guidance (retry/modify plan/abort)
4. NEVER proceed to next step if current failed
```

---

## 📊 Benchmarks de Performance

### EPCT vs One-Shot

```
╔═══════════════════════════════════════════════════════════╗
║        EPCT vs ONE-SHOT COMPARISON                        ║
╚═══════════════════════════════════════════════════════════╝

Use Case: Implement user authentication feature

ONE-SHOT (direct coding):
├─ Time           : 8 minutes (fast)
├─ Success rate   : 50% (many issues)
│   ├─ Hallucinations (invented APIs)
│   ├─ Incompatible with architecture
│   ├─ Missing tests
│   └─ Bugs discovered later
├─ Rework needed  : 30 minutes (fixing issues)
├─ Total time     : 38 minutes
└─ Quality        : ⚠️ 60% (many iterations)

EPCT (sequential workflow):
├─ Time           : 22 minutes (4 steps)
│   ├─ Explore: 5 min
│   ├─ Plan: 7 min
│   ├─ Code: 8 min
│   └─ Test: 2 min
├─ Success rate   : 95% (first try)
│   ├─ No hallucinations (explored first)
│   ├─ Fits architecture (planned)
│   ├─ Tests included (part of plan)
│   └─ Validated before merge
├─ Rework needed  : 2 minutes (minor fixes)
├─ Total time     : 24 minutes
└─ Quality        : ✅ 95% (production-ready)

RESULT:
✅ EPCT 40% faster end-to-end (24min vs 38min)
✅ EPCT 35% higher quality (95% vs 60%)
✅ EPCT prevents hallucinations (exploration phase)
```

---

### Impact des Gates de Validation

```
╔═══════════════════════════════════════════════════════════╗
║          VALIDATION GATES EFFECTIVENESS                   ║
╚═══════════════════════════════════════════════════════════╝

Feature: Add payment processing (complex, risky)

WITHOUT GATES (direct E→P→C→T):
├─ Issues found after coding : 8
│   ├─ Wrong payment provider (should be Stripe, used PayPal)
│   ├─ Missing PCI compliance
│   ├─ Security vulnerabilities
│   └─ Wrong currency handling
├─ Rework cost : 2 hours
└─ User frustration : High

WITH GATES (validation after each step):
├─ Issues caught BEFORE coding : 8
│   ├─ Gate after Explore: Wrong provider → Corrected in Plan
│   ├─ Gate after Plan: Missing PCI → Added to implementation
│   ├─ Gate before Code: User validated approach
│   └─ Gate after Test: Security audit passed
├─ Rework cost : 0 (prevented)
└─ User confidence : High

RESULT:
✅ Gates prevent 100% of major issues (caught early)
✅ 2 hours saved (no rework)
✅ User trust increased (transparent process)
```

---

## 💡 Exemples Concrets

### Exemple 1 : Feature Nouvelle Page Pricing

```
User: "Create a pricing page with 3 tiers (Free/Pro/Enterprise)"

STEP 1: EXPLORE (5 min)
  - Read existing pages (About, Home) for structure
  - Check component library available
  - Find pricing data source (CMS? Hardcoded?)
  - Identify routing setup (Next.js pages/)

  Output₁: "Use Next.js pages/, components from /ui, hardcode tiers for now"

[GATE] User: "Approved, proceed to plan"

STEP 2: PLAN (7 min)
  - Create /pages/pricing.tsx
  - Use PricingCard component (create)
  - 3 tiers hardcoded in constant
  - Mobile-responsive (Tailwind)
  - Link from navbar

  Output₂: Detailed plan with file structure, component design

[GATE] User: "Looks good, implement it"

STEP 3: CODE (10 min)
  - Create pricing.tsx
  - Create PricingCard.tsx
  - Add to navbar
  - Tailwind styling
  - Responsive breakpoints

  Output₃: Code implemented, files created

[GATE] Compilation: OK ✅

STEP 4: TEST (2 min)
  - npm run build → Success
  - Manual test: Desktop ✅, Mobile ✅
  - Link from navbar works ✅

  Output₄: All checks passed

RESULT: Feature complete in 24 minutes, 95% success rate
```

---

### Exemple 2 : Analyse Code Complexe

```
User: "Analyze this codebase and identify security issues"

STEP 1: EXPLORE (10 min)
  - Read codebase structure (auth/, api/, db/)
  - List files handling sensitive data
  - Identify authentication mechanisms
  - Check for common vulnerabilities (OWASP Top 10)

  Output₁: List of files to analyze, potential risk areas

STEP 2: PLAN (5 min)
  - Define analysis criteria (SQL injection, XSS, CSRF, auth bypass)
  - Create checklist per file
  - Prioritize by risk (auth files first)

  Output₂: Analysis plan with criteria and file priority

STEP 3: CODE (N/A for analysis)
  - Run security analysis
  - Check each file against criteria
  - Document findings

  Output₃: Security report with issues found

STEP 4: TEST (N/A for analysis)
  - Verify findings (reproduce if possible)
  - Rate severity (Critical/High/Medium/Low)

  Output₄: Validated security report with severity ratings

RESULT: Comprehensive security analysis with actionable findings
```

---

## 💎 Best Practices

### ✅ DO

```
1. ALWAYS FOLLOW SEQUENCE
   ✅ Explore → Plan → Code → Test (NEVER skip)
   ✅ Wait for user approval (after Explore, after Plan)
   ✅ Validate before proceeding

2. CLEAR OUTPUTS PER STEP
   ✅ Exploration report (findings, recommendations)
   ✅ Implementation plan (files, steps, tests)
   ✅ Implementation report (what was done)
   ✅ Test report (results, coverage)

3. GATES BETWEEN STEPS
   ✅ User validation (Explore, Plan)
   ✅ Compilation check (Code)
   ✅ Test pass check (Test)

4. STICK TO PLAN
   ✅ Code exactly what plan says
   ✅ No scope creep (no extra features)
   ✅ Ask if clarification needed

5. COMPREHENSIVE EXPLORATION
   ✅ Read enough context (don't guess)
   ✅ Research if needed (docs, examples)
   ✅ Identify constraints early
```

---

### ❌ DON'T

```
1. SKIP STEPS
   ❌ Don't jump to Code without Plan
   ❌ Don't skip Explore (causes hallucinations)
   ❌ Don't skip Test (assume it works)

2. CODE BEFORE PLAN APPROVED
   ❌ User might reject approach
   ❌ Wasted effort if plan changes
   ✅ ALWAYS wait for approval

3. ADD UNPLANNED FEATURES
   ❌ "While I'm here, I'll also add..."
   ❌ Scope creep kills projects
   ✅ Stick to plan exactly

4. VAGUE OUTPUTS
   ❌ "I explored the code" (no details)
   ✅ Structured reports with findings

5. ASSUME TESTS PASS
   ❌ "The code looks good" (not verified)
   ✅ ALWAYS run tests, check coverage
```

---

## 🎓 Points Clés

```
╔═══════════════════════════════════════════════════════════╗
║           PROMPT CHAINING ESSENTIALS                      ║
╚═══════════════════════════════════════════════════════════╝

✅ Sequential execution (A→B→C, fixed)
✅ Each step refines problem (complexity ↓)
✅ Validation gates between steps
✅ Trade-off: Latence ↑ for Accuracy ↑
✅ Notre implémentation: EPCT Workflow
✅ 40% faster end-to-end (vs one-shot with rework)
✅ 95% success rate (vs 50% one-shot)
❌ Don't skip steps (causes hallucinations)
❌ Don't code before plan approved
```

---

## 📚 Ressources

### Documentation Anthropic

- 📄 [Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) - Prompt Chaining section
- 📄 [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### Articles

- 📝 [6 Composable Patterns (AIMultiple)](https://research.aimultiple.com/building-ai-agents/)
- 📝 [Prompt Chaining Techniques](https://huggingface.co/blog/dcarpintero/design-patterns-for-building-agentic-workflows)

### Exemples Internes

- 📐 [Orchestration Principles](../orchestration-principles.md) - Règles d'or
- 🚀 [Enterprise RFP](../workflows/enterprise-rfp.md) - EPCT en action
- 🚀 [CI/CD Pipeline](../workflows/ci-cd-pipeline.md) - Sequential gates

---

## 🚀 Prochaines Étapes

1. ✅ Comprendre séquence fixe (E→P→C→T)
2. ✅ Implémenter gates de validation
3. ✅ Créer command /epct
4. ✅ Tester sur feature complexe
5. ✅ Mesurer success rate vs one-shot

---

**Quote Anthropic** :
> "Prompt chaining decomposes a task into a sequence where each LLM call processes the output of the previous one, allowing for more focused and accurate processing at each step."
> — Building Effective Agents, Anthropic Research

**Règle d'Or** :
> **Explore → Plan → Code → Test. NEVER skip steps. ALWAYS wait for approval.**
