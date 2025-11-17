# Workflows - Guide Complet

> 📄 **Documentation Officielle** : https://code.claude.com/docs

## 📚 Théorie

### Qu'est-ce qu'un Workflow ?

Un **Workflow** = Processus structuré en **étapes** pour accomplir une tâche complexe de manière **systématique** et **reproductible**.

```
╔══════════════════════════════════════════╗
║     WORKFLOWS - VUE D'ENSEMBLE           ║
╚══════════════════════════════════════════╝

Tâche Complexe Sans Workflow:
├── Approche désordonnée
├── Étapes oubliées
├── Résultats incohérents
└── Difficile à reproduire ❌

Tâche Complexe Avec Workflow:
├── Étapes claires définies
├── Ordre logique respecté
├── Résultats consistants
├── Facilement reproductible
└── Optimisé pour succès ✅
```

**Source** : Formation Melvynx Claude Code 2.0

---

### 🎯 Problème Résolu

**Avant Workflows** :
```
Feature complexe :
├── "Claude, crée une page de pricing"
├── Claude code directement
├── Hallucinations possibles (architecture inconnue)
├── Pas de validation avant implémentation
├── Tests oubliés
└── Résultat : 50% de chances de succès ❌
```

**Avec Workflow Structuré** :
```
Feature complexe :
├── EXPLORE : Comprendre architecture existante
├── PLAN : Proposer approche + validation
├── CODE : Implémenter selon plan validé
├── TEST : Vérifier fonctionnement
└── Résultat : 95% de chances de succès ✅
```

---

### 🔀 Types de Workflows

Claude Code supporte **4 types de workflows** selon le contexte :

```
╔════════════════════════════════════════════════════════╗
║              TYPES DE WORKFLOWS                        ║
╚════════════════════════════════════════════════════════╝

1️⃣ SÉQUENTIEL (EPCT - Explore-Plan-Code-Test)
   ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
   │ EXPLORE │───>│  PLAN   │───>│  CODE   │───>│  TEST   │
   └─────────┘    └─────────┘    └─────────┘    └─────────┘

   Usage : Features complexes, refactoring
   Avantage : Contexte optimal, validation humaine
   Limitation : Plus lent (4 phases)

2️⃣ PARALLÈLE (Multi-agents - Concurrent)
   ┌──────────┐
   │ Agent 1  │ ──┐
   ├──────────┤   │
   │ Agent 2  │ ──┤──> Agrégation
   ├──────────┤   │
   │ Agent 3  │ ──┘
   └──────────┘

   Usage : Tâches indépendantes (fix 10 files)
   Avantage : 5-10x plus rapide
   Limitation : Nécessite isolation (no shared state)

3️⃣ CONDITIONNEL (Decision Trees - If/Else)
   ┌─────────────┐
   │  Condition  │
   └─────────────┘
        ├─YES──> Branch A
        └─NO───> Branch B

   Usage : Validation, fallback chains
   Avantage : Adaptabilité, robustesse
   Limitation : Complexité logic

4️⃣ HYBRIDE (Orchestration - Combinaison)
   COMMAND (orchestrateur)
       ↓
   ┌─────────────────────────────┐
   │ EPCT (séquentiel)           │
   │   ↓                         │
   │ Parallel agents (batch)     │
   │   ↓                         │
   │ Error handling (fallback)   │
   └─────────────────────────────┘

   Usage : Workflows production complexes
   Avantage : Flexible, robuste, scalable
   Limitation : Complexité architecture
```

**Quand utiliser quoi ?**

| Type | Use Case | Exemple |
|------|----------|---------|
| **Séquentiel** | Feature complexe | EPCT : nouvelle page, migration |
| **Parallèle** | Tâches indépendantes | Fix grammar 50 files |
| **Conditionnel** | Validation/fallback | Check API → Fallback cache |
| **Hybride** | Production workflows | /generate-locales (50 locales) |

---

## 🔍 Workflow EPCT (Explore-Plan-Code-Test)

### Méthodologie Structurée

**EPCT** est une **méthodologie en 4 phases** pour créer des features complexes avec **contexte optimal**, **validation humaine** et **qualité maximale**.

```
╔════════════════════════════════════════════════════════╗
║              WORKFLOW EPCT DÉTAILLÉ                    ║
╚════════════════════════════════════════════════════════╝

┌──────────────────────────────────────────────────────┐
│  PHASE 1 : 🔍 EXPLORE (Exploration)                  │
├──────────────────────────────────────────────────────┤
│  Objectif : Comprendre contexte existant             │
│                                                       │
│  Actions :                                            │
│  • Rechercher documentation (WebFetch/Context7)       │
│  • Lire fichiers projet pertinents (Read, Grep)      │
│  • Analyser architecture existante                   │
│  • Identifier dépendances nécessaires                │
│                                                       │
│  Outils : WebSearch, Grep, Read, Context7            │
│  Résultat : Contexte complet pour décision éclairée  │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 2 : 📋 PLAN (Planification)                   │
├──────────────────────────────────────────────────────┤
│  Objectif : Proposer architecture et valider         │
│                                                       │
│  Actions :                                            │
│  • Proposer plan structuré en étapes                 │
│  • ⚠️ STOP : Demander validation utilisateur         │
│  • Poser questions sur points ambigus                │
│  • Ajuster plan selon feedback                       │
│                                                       │
│  ⚠️ CRITIQUE : Validation OBLIGATOIRE                │
│  Résultat : Plan approuvé par l'utilisateur          │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 3 : 💻 CODE (Implémentation)                  │
├──────────────────────────────────────────────────────┤
│  Objectif : Développer selon plan validé             │
│                                                       │
│  Actions :                                            │
│  • Implémenter selon plan validé                     │
│  • Respecter conventions CLAUDE.md                   │
│  • Modifier/créer fichiers multiples                 │
│  • Installer dépendances (npm install)               │
│                                                       │
│  Outils : Write, Edit, Bash                          │
│  Résultat : Feature complète implémentée             │
└────────────────────┬─────────────────────────────────┘
                     ▼
┌──────────────────────────────────────────────────────┐
│  PHASE 4 : ✅ TEST (Vérification)                    │
├──────────────────────────────────────────────────────┤
│  Objectif : Vérifier fonctionnement                  │
│                                                       │
│  Actions :                                            │
│  • Lire package.json pour tests configurés          │
│  • Exécuter tests existants UNIQUEMENT              │
│  • Linting (ESLint) si configuré                    │
│  • Build de vérification                            │
│                                                       │
│  ❌ Ne pas créer tests inexistants                  │
│  ✅ Exécuter tests existants seulement              │
│  Résultat : Feature testée et fonctionnelle          │
└──────────────────────────────────────────────────────┘

        ✅ Feature complète, testée, qualité maximale
```

---

### 💡 Avantages EPCT

```
✅ Réduit hallucinations     → Exploration donne contexte
✅ Validation humaine        → Plan approuvé avant code
✅ Contexte optimal          → Décisions architecturales éclairées
✅ Tests automatiques        → Qualité vérifiée
✅ Reproductible             → Workflow systématique
✅ Qualité consistante       → Toujours mêmes étapes
```

**Quote Melvynx** :
> "Le workflow EPCT permet d'éviter les hallucinations en donnant à Claude le contexte complet avant de coder."

---

### ⚠️ Limitations EPCT

```
❌ Plus lent                 → 4 phases vs code direct
❌ Consomme plus tokens      → Exploration + thinking
❌ Overkill pour simple      → Utiliser pour features complexes
❌ Nécessite bon prompt      → Commande EPCT bien rédigée
```

**Quand utiliser** :
- ✅ Features complexes (nouvelle page, intégration API)
- ✅ Refactoring architecture
- ✅ Migration technologique
- ❌ Modifications simples (typo, CSS tweak)
- ❌ One-liners

---

### 🛠️ Créer Commande /epct

**Fichier** : `.claude/commands/epct.md`

```markdown
# EPCT Workflow : Explore-Plan-Code-Test

Quand l'utilisateur demande une feature avec /epct "description", suis ce workflow :

## Phase 1 : 🔍 EXPLORE

Explore le contexte pour comprendre le projet :

1. **Documentation** :
   - Utilise Context7 si framework connu (Next.js, Vite, React)
   - Sinon WebSearch pour documentation officielle

2. **Architecture Existante** :
   - Lis package.json pour comprendre stack
   - Lis fichiers pertinents (Grep pour patterns)
   - Identifie structure dossiers (src/, components/, etc.)

3. **Dépendances** :
   - Note librairies déjà installées
   - Identifie besoins nouveaux

**Output** : Résumé contexte avec fichiers lus et dépendances identifiées.

---

## Phase 2 : 📋 PLAN

Propose un plan structuré :

1. **Architecture** :
   - Fichiers à créer/modifier
   - Composants/fonctions nécessaires
   - Dépendances à installer

2. **Étapes** :
   - Liste numérotée d'étapes claires
   - Ordre logique de développement

3. **⚠️ STOP - Validation OBLIGATOIRE** :
   - Demande : "Ce plan vous convient-il ?"
   - Pose questions sur points ambigus
   - Ajuste selon feedback utilisateur

**NE PAS CODER** avant validation !

---

## Phase 3 : 💻 CODE

Implémente selon plan validé :

1. **Respect Conventions** :
   - Applique règles CLAUDE.md automatiquement
   - Follow project structure existante

2. **Installation Dépendances** :
   - npm install si nouvelles dépendances
   - Vérifie package.json mis à jour

3. **Implémentation** :
   - Crée/modifie fichiers selon plan
   - Code quality (error handling, types, etc.)

---

## Phase 4 : ✅ TEST

Vérifie fonctionnement :

1. **Tests Existants** :
   - Lis package.json pour scripts test
   - Lance tests SEULEMENT s'ils existent
   - ❌ Ne crée PAS de tests inexistants

2. **Linting** :
   - Lance ESLint si configuré
   - Fix erreurs automatiquement

3. **Build** :
   - Lance build de vérification
   - Vérifie pas d'erreurs TypeScript

**Résultat Final** : Feature complète, testée, fonctionnelle.

---

## Exemple d'Usage

```bash
/epct "Créer une page About avec sections Mission, Team, Contact utilisant TailwindCSS"
```

Workflow :
1. EXPLORE : Lis structure projet, package.json, pages existantes
2. PLAN : Propose fichier About.tsx, sections, layout
3. VALIDATION : Utilisateur approuve
4. CODE : Crée About.tsx avec Tailwind
5. TEST : Build + ESLint
```

**Sauvegarder** dans `.claude/commands/epct.md` puis redémarrer Claude.

---

## 🔄 Autres Workflows Courants

### 🔄 Workflow Parallèle (Multi-agents)

**Pattern** : Lancer plusieurs agents **simultanément** pour traiter tâches indépendantes.

```
╔════════════════════════════════════════════════════════╗
║         PARALLEL WORKFLOW (Task Tool)                  ║
╚════════════════════════════════════════════════════════╝

COMMAND /fix-grammar file1.md file2.md ... file10.md
    ↓
┌────────────────────────────────────────┐
│ VALIDATE FILES (10 files)              │
│ Strategy: 2-10 files → PARALLEL        │
└────────────────────────────────────────┘
    ↓
Launch ALL agents in SINGLE message:
┌──────────────────────────────────────┐
│ Task(@fix-grammar, file1.md)  ──┐   │
│ Task(@fix-grammar, file2.md)  ──┤   │
│ Task(@fix-grammar, file3.md)  ──┤   │
│ Task(@fix-grammar, file4.md)  ──┤──>│ Parallel
│ Task(@fix-grammar, file5.md)  ──┤   │ Execution
│ Task(@fix-grammar, file6.md)  ──┤   │ (simultané)
│ Task(@fix-grammar, file7.md)  ──┤   │
│ Task(@fix-grammar, file8.md)  ──┤   │
│ Task(@fix-grammar, file9.md)  ──┤   │
│ Task(@fix-grammar, file10.md) ──┘   │
└──────────────────────────────────────┘
    ↓ Durée : ~12s (au lieu de 120s séquentiel!)
    ↓
┌────────────────────────────────────────┐
│ AGGREGATE RESULTS                      │
│ ✅ Success: 8/10                       │
│ ❌ Failed: 2/10                        │
└────────────────────────────────────────┘
    ↓
┌────────────────────────────────────────┐
│ RETRY FAILURES (once)                  │
│ Task(@fix-grammar, file3.md)           │
│ Task(@fix-grammar, file7.md)           │
└────────────────────────────────────────┘
    ↓
REPORT : 9/10 success (1 failed permanently)
```

**Avantages** :
- ⚡ **5-10x plus rapide** que séquentiel
- 🔒 **Isolation** : Chaque agent indépendant
- 📊 **Scalable** : Batch processing pour large scale

**Batch Processing** (>10 items) :
```
50 items → 5 waves de 10 agents
Wave 1 : 10 agents parallel (30s)
Wave 2 : 10 agents parallel (30s)
...
Total : ~2min 30s (vs 25min séquentiel!)
```

**📚 Ressource** : [Parallel Execution Pattern](../../patterns/parallel-execution.md)

---

### 🌳 Workflow Conditionnel (Fallback Chains)

**Pattern** : **Chaînes de secours** pour gérer les erreurs et basculer vers alternatives.

```
╔════════════════════════════════════════════════════════╗
║      CONDITIONAL WORKFLOW (Error Recovery)             ║
╚════════════════════════════════════════════════════════╝

COMMAND /fetch-docs "Next.js"
    ↓
┌────────────────────────────────────────┐
│ PRIMARY: MCP Context7                  │
│ Try: Get official docs                 │
└────────────────────────────────────────┘
    ↓
  [Success?] ────YES───> ✅ EXIT 0 (success)
    │
    NO (rate limit, offline)
    ↓
┌────────────────────────────────────────┐
│ FALLBACK 1: Perplexity Search         │
│ Try: Search web for docs               │
└────────────────────────────────────────┘
    ↓
  [Success?] ────YES───> ⚠️ EXIT 1 (warning: fallback used)
    │
    NO (API key missing)
    ↓
┌────────────────────────────────────────┐
│ FALLBACK 2: Firecrawl Scraping        │
│ Try: Scrape official website           │
└────────────────────────────────────────┘
    ↓
  [Success?] ────YES───> ⚠️ EXIT 1 (warning: fallback 2 used)
    │
    NO (scraping failed)
    ↓
┌────────────────────────────────────────┐
│ USER VALIDATION                        │
│ AskUserQuestion:                       │
│ "All failed. Provide manual URL?"      │
│   - Yes → Retry Firecrawl              │
│   - No → EXIT 2 ❌ (block)             │
└────────────────────────────────────────┘
```

**Exit Codes Convention** :

| Code | Signification | Action |
|------|--------------|--------|
| `0` | ✅ Succès complet | Continue workflow |
| `1` | ⚠️ Warning (fallback utilisé) | Continue, mais review recommandée |
| `2` | ❌ Échec bloquant | Stop, intervention manuelle |

**Retry Logic** :
```
Retry au niveau COMMAND (pas agent):
- 1 seule retry (max 2 tentatives total)
- Améliorer contexte/prompt au retry
- User validation si retry échoue
```

**📚 Ressource** : [Error Handling Pattern](../../patterns/error-handling.md)

---

### 🎯 Workflow Hybride (Orchestration Complexe)

**Pattern** : Combiner **EPCT + Parallel + Conditional** pour workflows production.

```
╔════════════════════════════════════════════════════════╗
║    HYBRID WORKFLOW : /generate-locales (50 locales)    ║
╚════════════════════════════════════════════════════════╝

COMMAND /generate-locales all
    ↓
┌────────────────────────────────────────┐
│ PHASE 1: EXPLORE (EPCT)                │
│ - Check existing locales               │
│ - Validate API access                  │
│ - Read template files                  │
└────────────────────────────────────────┘
    ↓
┌────────────────────────────────────────┐
│ PHASE 2: PLAN (EPCT)                   │
│ - List 50 locales to generate          │
│ - Strategy: BATCH (5 waves × 10)       │
│ - User validation: "Generate 50?"      │
└────────────────────────────────────────┘
    ↓
  [User approves?] ────NO───> EXIT 0 (cancelled)
    │
   YES
    ↓
┌────────────────────────────────────────┐
│ PHASE 3: CODE (PARALLEL + CONDITIONAL) │
│                                        │
│ FOR EACH wave (5 waves):              │
│   ├─> PARALLEL: 10 agents             │
│   │   ├─> PRIMARY: Context7           │
│   │   └─> FALLBACK: Perplexity        │
│   ├─> AGGREGATE results                │
│   └─> RETRY failures                   │
└────────────────────────────────────────┘
    ↓
Wave 1: 9/10 success (1 retry → 10/10)
Wave 2: 10/10 success
Wave 3: 8/10 success (2 retries → 9/10)
Wave 4: 10/10 success
Wave 5: 10/10 success
    ↓
┌────────────────────────────────────────┐
│ PHASE 4: TEST (EPCT)                   │
│ - Validate generated files             │
│ - Check JSON schema                    │
│ - Build verification                   │
└────────────────────────────────────────┘
    ↓
REPORT FINAL:
✅ 49/50 locales generated (98%)
⚠️ 1 failure: locale 'ar-SA' (API timeout)
💡 Next step: Retry manually /generate-locales ar-SA
```

**Composants utilisés** :
- ✅ EPCT (Explore, Plan, Code, Test)
- ✅ Parallel agents (5 waves × 10)
- ✅ Fallback chains (Context7 → Perplexity)
- ✅ Retry logic (1 retry per failure)
- ✅ User validation (before launch)
- ✅ Error aggregation (detailed report)

**📚 Ressource** : [AI Orchestration Guide](../../advanced/ai-orchestration.md)

---

## 🆕 Nouvelles Fonctionnalités 2025

### ✅ Checkpoints Automatiques

Claude Code sauvegarde automatiquement l'état avant chaque édition :

```
╔═══════════════════════════════════════════╗
║     CHECKPOINTS SYSTEM                    ║
╚═══════════════════════════════════════════╝

Avant chaque Edit/Write:
├── 📸 Snapshot automatique
├── 💾 État sauvegardé
└── 🔄 Retour possible

Commandes:
├── Esc+Esc : Annuler dernière action
├── /rewind : Retour au checkpoint
└── /checkpoint : Créer manuel

Bénéfices:
✅ Expérimentation sans risque
✅ Recovery rapide
✅ Historique complet
```

## 🔄 Tâches Background & Todo Dynamique

### Tâches Background Améliorées (2025)

Claude Code peut **exécuter commandes longues en arrière-plan** (serveurs, builds) pour continuer à travailler pendant l'exécution.

```
╔═══════════════════════════════════════════╗
║     TÂCHES BACKGROUND                     ║
╚═══════════════════════════════════════════╝

Commande : npm run dev (exemple)
           ↓
┌───────────────────────────────────────────┐
│  🔄 Background Task Started               │
│  → Process ID : #1234                     │
│  → Commande : npm run dev                 │
│  → Status : Running                       │
└───────────────────────────────────────────┘
           ↓ Flèche ↓ pour voir logs

Nouvelles Commandes 2025:
├── /bashes : Lister toutes les tâches
├── /kill [id] : Terminer une tâche
└── /logs [id] : Voir logs complets

┌───────────────────────────────────────────┐
│  📊 Logs en Temps Réel                    │
│  > vite v5.0.0 dev server running at:     │
│  > http://localhost:5173                  │
│  > Cmd+Click pour ouvrir                  │
└───────────────────────────────────────────┘
           ↓ K pour kill
┌───────────────────────────────────────────┐
│  ❌ Process Killed                        │
└───────────────────────────────────────────┘
```

**Avantages** :
```
✅ Serveurs dev continuent pendant qu'on code
✅ Builds longs en arrière-plan
✅ Kill processus depuis Claude (touche K)
✅ Logs en temps réel disponibles
```

---

### Todo Dynamique

Claude génère **automatiquement** des **todo-lists** suivies en temps réel durant l'exécution de workflows complexes.

```
╔═══════════════════════════════════════════╗
║       TODO DYNAMIQUE                      ║
╚═══════════════════════════════════════════╝

Affichage : Ctrl+T

📋 Todo List Active
┣━━ ✅ Lire fichier about.html
┣━━ ✅ Ajouter lien navigation
┣━━ 🔄 Modifier style header
┣━━ ⏳ Tester responsive mobile
┗━━ ⏳ Build de vérification

Statuts :
• ✅ Terminé
• 🔄 En cours
• ⏳ En attente
```

**Utilité** :
```
✅ Visualisation progression sur tâches complexes
✅ Transparence sur ce que Claude fait
✅ Estimation temps restant
✅ Tracking automatique (pas de TodoWrite manuel)
```

**Limitations** :
```
❌ Todo disparaît après session (pas de persistance)
❌ Pas d'export vers outils externes (Notion, Jira)
❌ Gestion limitée de processus multiples
```

---

### 🎯 Cas d'Usage

**Scenario 1 : Dev Server + Feature** :
```bash
# 1. Lancer serveur en background
claude
> "Lance npm run dev en background"
→ Serveur démarre, continue en arrière-plan

# 2. Développer pendant que serveur tourne
> "/epct 'Créer page contact'"
→ EPCT workflow exécuté
→ Serveur toujours actif

# 3. Hot reload automatique
→ Changements visibles immédiatement
```

**Scenario 2 : Build Long** :
```bash
# Build Next.js (peut prendre 2-5 min)
> "Lance build production en background"
→ Build démarre
→ Ctrl+T : Voir progression
→ Continue à coder autre chose

# Build terminé
→ Notification
→ Vérifier résultats
```

**Scenario 3 : Workflow Complexe avec Todo** :
```bash
> "/epct 'Migration TypeScript → strict mode'"

📋 Todo Auto-Généré:
┣━━ 🔄 Analyser fichiers TypeScript existants
┣━━ ⏳ Activer strict mode dans tsconfig.json
┣━━ ⏳ Fixer erreurs type fichier par fichier
┣━━ ⏳ Vérifier build passe
┗━━ ⏳ Lancer tests

→ Progression visible en temps réel
→ Ctrl+T pour voir état
```

---

## 📋 Cheatsheet

### Types de Workflows

```bash
# 1️⃣ SÉQUENTIEL (EPCT)
/epct "Description feature"
→ Features complexes, refactoring
→ Explore → Plan → Code → Test

# 2️⃣ PARALLÈLE (Multi-agents)
/fix-grammar file1.md file2.md file3.md
→ Tâches indépendantes (2-50 items)
→ Task tool, même message (5-10x speedup)

# 3️⃣ CONDITIONNEL (Fallback)
/fetch-docs "Next.js"
→ Primary → Fallback1 → Fallback2 → User
→ Exit codes: 0=ok, 1=warn, 2=block

# 4️⃣ HYBRIDE (Orchestration)
/generate-locales all
→ EPCT + Parallel + Conditional
→ Production workflows complexes
```

### Commande EPCT (Séquentiel)

```bash
# Utilisation
/epct "Description de la feature"

# Exemples
/epct "Créer formulaire contact avec validation email et téléphone"
/epct "Intégrer Stripe pour paiements"
/epct "Ajouter dark mode avec toggle"
/epct "Migration TypeScript strict mode"
```

### Parallel Agents (Multi-agents)

```bash
# Pattern Selection
1 item       → Direct processing (no agent)
2-10 items   → PARALLEL (single wave)
11-50 items  → BATCH (waves of 10)
>50 items    → BATCH (waves of 20)

# Syntaxe Task Tool
# ✅ BON: All in same message
Task({ subagent: '@agent', task: 'item1', context: {...} })
Task({ subagent: '@agent', task: 'item2', context: {...} })
Task({ subagent: '@agent', task: 'item3', context: {...} })

# ❌ MAUVAIS: Sequential
Task(...) → Wait → Task(...) → Wait → Task(...)
```

### Fallback Chains (Conditionnel)

```bash
# Pattern
TRY primary_source
  → CATCH error → TRY fallback_1
    → CATCH error → TRY fallback_2
      → CATCH error → USER_VALIDATION

# Exit Codes
0 = ✅ Success (continue)
1 = ⚠️ Warning (continue but review)
2 = ❌ Blocked (stop, manual intervention)

# Retry Logic
LAUNCH agents → COLLECT results
  → IF failures: RETRY once with improved context
    → IF still failures: REPORT + USER_VALIDATION
```

### Background Tasks

```bash
# Lancer en background
"Lance npm run dev en background"
"Build production en background"

# Contrôles
Flèche ↓ : Voir logs
K        : Kill process

# Commandes
/bashes  : Lister toutes les tâches
/kill [id] : Terminer une tâche
/logs [id] : Voir logs complets
```

### Todo Dynamique

```bash
# Afficher
Ctrl+T

# Auto-généré par workflows
/epct → Todo automatique
Workflows multi-étapes → Todo tracking
```

---

## 🎓 Points Clés

### Types de Workflows

✅ **Séquentiel (EPCT)** : Explore → Plan → Code → Test (features complexes)
✅ **Parallèle** : Multi-agents simultanés (5-10x speedup)
✅ **Conditionnel** : Fallback chains + retry logic (robustesse)
✅ **Hybride** : Orchestration complexe (production workflows)

### Concepts Essentiels

✅ **EPCT** : Validation critique AVANT code (95% succès)
✅ **Parallel agents** : Task tool, même message (5-10x rapide)
✅ **Fallback chains** : Primary → Fallback 1 → Fallback 2 → User
✅ **Exit codes** : 0=success, 1=warning, 2=blocked
✅ **Batch processing** : Waves de 10-20 agents pour large scale
✅ **Background tasks** : Serveurs/builds en arrière-plan
✅ **Todo dynamique** : Tracking automatique progression

### Commandes Clés

| Commande | Description |
|----------|-------------|
| `/epct "feature"` | Workflow séquentiel complet |
| `/fix-grammar file1 file2...` | Workflow parallèle (exemple) |
| `/generate-locales all` | Workflow hybride (exemple) |
| `Ctrl+T` | Afficher todo dynamique |
| `Flèche ↓` | Voir logs background task |
| `K` | Kill background process |

### Patterns Clés

**EPCT (Séquentiel)** :
```
1. EXPLORE : Contexte complet (docs + code)
2. PLAN    : Architecture proposée + VALIDATION
3. CODE    : Implémentation selon plan
4. TEST    : Vérification automatique
```

**Parallel (Multi-agents)** :
```
1. VALIDATE : Check args, determine strategy
2. LAUNCH   : All agents in SINGLE message (Task tool)
3. AGGREGATE: Collect results, identify failures
4. RETRY    : Once, with improved context
5. REPORT   : Detailed metrics + next steps
```

**Conditional (Fallback)** :
```
TRY primary → CATCH → TRY fallback1
            → CATCH → TRY fallback2
                   → CATCH → USER VALIDATION
```

**Résultat** : 95% succès vs 50% sans workflow

---

## 📚 Ressources

### 📄 Documentation Officielle
- 📄 **Claude Code Workflows** : https://code.claude.com/docs/en/common-workflows (inféré)
- 📄 **Engineering Best Practices** : https://www.anthropic.com/engineering/claude-code-best-practices
- 📄 **Task Tool** : https://code.claude.com/docs/task-tool (parallel agents)

### 🎥 Vidéos & Formations
- 🎥 **Melvynx - Formation Claude Code 2.0** : https://www.youtube.com/watch?v=bDr1tGskTdw
  - 30:00 - Workflow EPCT (méthodologie complète)
  - 27:00 - Background Tasks (serveurs, builds)
  - 39:00 - Todo Dynamique (tracking automatique)
- 🎥 **Melvynx - EPCT Deep Dive** : https://www.youtube.com/watch?v=kFpLzCVLA20
  - Explore-Plan-Code-Test en détail
  - Cas réels production
  - Optimisations avancées

### 📚 Ressources Internes

**Guides Thèmes** :
- 📋 [Cheatsheet Workflows](./cheatsheet.md) - Référence rapide
- 🔗 [Commands](../2-commands/guide.md) - Créer commande `/epct`
- 🔗 [Sub-Agents](../7-subagents/guide.md) - Task tool pour parallélisation
- 🔗 [Hooks](../6-hooks/guide.md) - Automation workflows
- 🔗 [Best Practices](../9-best-practices/guide.md) - Workflow production

**Patterns Avancés** :
- 🎯 [Parallel Execution Pattern](../../patterns/parallel-execution.md) - Multi-agents, batching, performance
- 🎯 [Error Handling Pattern](../../patterns/error-handling.md) - Fallback chains, retry logic
- 🎯 [Command/Agent/Skill Pattern](../../patterns/command-agent-skill.md) - Orchestration architecture
- 🎯 [State Management Pattern](../../patterns/state-management.md) - Context entre agents

**Advanced Guides** :
- 🚀 [AI Orchestration](../../advanced/ai-orchestration.md) - Workflows hybrides complexes
- 🚀 [Decision Trees](../../advanced/decision-trees.md) - Quand utiliser quel workflow
- 🚀 [Multi-Dialog Patterns](../../advanced/multi-dialog-patterns.md) - Conversations multi-étapes
- 🚀 [Enterprise Patterns](../../advanced/enterprise-patterns.md) - Production workflows

### 🔗 Repos Communauté
- 🔗 **fix-grammar** (parallel pattern) : https://github.com/wshobson/commands
- 🔗 **generate-locales** (batch pattern) : https://github.com/edmund-io/edmunds-claude-code
- 🔗 **pr-review-toolkit** (hybrid workflow) : https://github.com/VoltAgent/awesome-claude-code-subagents

---

## Conclusion

Les **Workflows** transforment tâches complexes en processus **systématiques**, **reproductibles** et **scalables**.

### 4 Types de Workflows Maîtrisés

**1️⃣ SÉQUENTIEL (EPCT)** :
- **Explore** : Contexte optimal
- **Plan** : Validation humaine
- **Code** : Implémentation qualité
- **Test** : Vérification automatique
- **Impact** : 95% succès sur features complexes

**2️⃣ PARALLÈLE (Multi-agents)** :
- Task tool, même message
- 5-10x speedup vs séquentiel
- Batch processing pour large scale
- **Impact** : 50 files en 2min vs 25min

**3️⃣ CONDITIONNEL (Fallback)** :
- Chaînes de secours robustes
- Exit codes standardisés (0/1/2)
- Retry logic intelligent
- **Impact** : Robustesse production

**4️⃣ HYBRIDE (Orchestration)** :
- Combine EPCT + Parallel + Conditional
- Workflows production complexes
- Scalable et maintenable
- **Impact** : Production-ready

### Setup Recommandé

```
.claude/commands/
├── epct.md              → Workflow séquentiel (features)
├── fix-grammar.md       → Workflow parallèle (batch)
├── fetch-docs.md        → Workflow conditionnel (fallback)
├── generate-locales.md  → Workflow hybride (orchestration)
├── commit.md            → Git conventionnel
└── deploy.md            → Déploiement automatisé

Workflow quotidien:
1. /epct pour features → Plan validé → Implémentation
2. Parallel agents pour batch → 5-10x speedup
3. Fallback chains → Robustesse API externes
4. Background tasks → Dev sans interruption
5. Todo dynamique → Transparence progression
```

### Quotes Inspirantes

**Melvynx** :
> "Le workflow EPCT permet d'éviter les hallucinations et d'avoir un résultat de qualité à chaque fois."

**Parallel Pattern** :
> "Launch ALL agents in SINGLE message. Do NOT wait between calls. → 10x speedup"

### Impact Global

- **EPCT** : 95% succès vs 50% sans workflow
- **Parallel** : 5-10x speedup sur batch processing
- **Conditional** : 0 downtime avec fallback chains
- **Hybrid** : Production workflows scalables

**Prochaine étape** : Implémenter vos propres workflows en combinant ces 4 patterns selon vos besoins !
