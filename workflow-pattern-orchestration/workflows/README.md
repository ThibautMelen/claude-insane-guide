# Workflows - Vue d'Ensemble

**Mission** : Maîtriser les 4 types de workflows Claude Code pour créer des processus systématiques, reproductibles et scalables.

> 📊 **Workflow** = Processus structuré en étapes pour accomplir une tâche complexe avec qualité consistante

---

## 📚 Types de Workflows

Claude Code supporte **4 types de workflows** selon le contexte et la complexité :

```
╔═══════════════════════════════════════════════════════════╗
║              TYPES DE WORKFLOWS                            ║
╚═══════════════════════════════════════════════════════════╝

1️⃣ SÉQUENTIEL (EPCT - Explore-Plan-Code-Test)
   ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
   │ EXPLORE │───>│  PLAN   │───>│  CODE   │───>│  TEST   │
   └─────────┘    └─────────┘    └─────────┘    └─────────┘

   Usage      : Features complexes, refactoring
   Avantage   : Contexte optimal, validation humaine
   Limitation : Plus lent (4 phases)
   📖 Voir    : epct.md, sequential.md

2️⃣ PARALLÈLE (Multi-agents - Concurrent)
   ┌──────────┐
   │ Agent 1  │ ──┐
   ├──────────┤   │
   │ Agent 2  │ ──┤──> Agrégation
   ├──────────┤   │
   │ Agent 3  │ ──┘
   └──────────┘

   Usage      : Tâches indépendantes (fix 10 files)
   Avantage   : 5-10x plus rapide
   Limitation : Nécessite isolation (no shared state)
   📖 Voir    : parallel.md

3️⃣ CONDITIONNEL (Decision Trees - If/Else)
   ┌─────────────┐
   │  Condition  │
   └─────────────┘
        ├─YES──> Branch A
        └─NO───> Branch B

   Usage      : Validation, fallback chains
   Avantage   : Adaptabilité, robustesse
   Limitation : Complexité logic
   📖 Voir    : conditional.md

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

   Usage      : Workflows production complexes
   Avantage   : Flexible, robuste, scalable
   Limitation : Complexité architecture
   📖 Voir    : hybrid.md ⭐
```

---

## 🎯 Quand Utiliser Chaque Type ?

### Decision Tree

```
Quelle est la tâche ?
│
├─ FEATURE COMPLEXE (nouvelle page, migration tech)
│  └─→ SÉQUENTIEL (EPCT)
│     ✅ Comprendre contexte existant
│     ✅ Valider approche avant code
│     ✅ Implémenter qualité
│     ✅ Tester automatiquement
│
├─ TÂCHES RÉPÉTITIVES INDÉPENDANTES (fix 50 files, generate locales)
│  └─→ PARALLÈLE (Multi-agents)
│     ✅ 2-10 items : Single wave
│     ✅ 11-50 items : Batch (waves of 10)
│     ✅ >50 items : Batch (waves of 20)
│
├─ API AVEC FALLBACK (documentation fetch, data enrichment)
│  └─→ CONDITIONNEL (Decision trees)
│     ✅ Primary source → Fallback 1 → Fallback 2 → User
│     ✅ Retry logic intelligent
│     ✅ Exit codes standardisés
│
└─ PRODUCTION WORKFLOW (multi-aspects, robustesse critique)
   └─→ HYBRIDE (Orchestration)
      ✅ Combine EPCT + Parallel + Conditional
      ✅ Commands + Agents + Skills + Hooks
      ✅ Enterprise-grade
```

---

## 📊 Comparaison des Workflows

| Critère | Séquentiel | Parallèle | Conditionnel | Hybride |
|---------|-----------|----------|--------------|---------|
| **Complexité setup** | 🟢 Simple | 🟡 Moyenne | 🟡 Moyenne | 🔴 Élevée |
| **Vitesse execution** | 🟡 Normale | 🟢 5-10x rapide | 🟡 Normale | 🟢 Optimale |
| **Robustesse** | 🟢 Élevée | 🟡 Dépend isolation | 🟢 Très élevée | 🟢 Maximum |
| **Validation humaine** | 🟢 Oui (Plan phase) | 🟡 Optionnelle | 🟢 Oui (User validation) | 🟢 Multi-checkpoints |
| **Scalabilité** | 🟡 Limitée | 🟢 Excellente | 🟡 Moyenne | 🟢 Production-ready |
| **Coût tokens** | 🟡 Moyen | 🟢 Optimisé (haiku) | 🟡 Moyen | 🟡 Variable |
| **Cas d'usage** | Features | Batch processing | API fallback | Production |

---

## 🚀 Guide de Démarrage Rapide

### Niveau 1 : Débutant

**Commencer par** : EPCT (Explore-Plan-Code-Test)

```bash
# 1. Créer commande EPCT
# Fichier : .claude/commands/epct.md
# 📖 Voir : epct.md pour template complet

# 2. Utiliser
/epct "Créer page About avec sections Mission, Team, Contact"

# 3. Observer workflow
# - Phase EXPLORE : Claude lit architecture existante
# - Phase PLAN : Propose approche, ATTEND validation
# - Phase CODE : Implémente selon plan approuvé
# - Phase TEST : Vérifie build + tests
```

### Niveau 2 : Intermédiaire

**Ajouter** : Parallel Multi-agents

```bash
# 1. Créer agent spécialisé
# Fichier : .claude/agents/fix-grammar.md
# 📖 Voir : parallel.md pour template

# 2. Créer command coordinator
# Fichier : .claude/commands/fix-grammar.md

# 3. Utiliser
/fix-grammar file1.md file2.md ... file10.md

# 4. Observer speedup
# Séquentiel : 10 × 12s = 120s
# Parallèle : max(12s) = 12s (10x faster!)
```

### Niveau 3 : Avancé

**Ajouter** : Conditional Fallback Chains

```bash
# 1. Créer command avec fallbacks
# Fichier : .claude/commands/fetch-docs.md
# 📖 Voir : conditional.md pour template

# 2. Utiliser
/fetch-docs "Next.js"

# 3. Observer fallback chain
# - Try Context7 MCP
# - If fails → Try Perplexity
# - If fails → Try Firecrawl
# - If fails → Ask user for manual URL
```

### Niveau 4 : Expert

**Combiner tout** : Hybrid Orchestration

```bash
# 1. Créer command hybride
# Fichier : .claude/commands/generate-locales.md
# 📖 Voir : hybrid.md pour exemples complets

# 2. Utiliser
/generate-locales all

# 3. Observer orchestration
# - EPCT : Explore data sources, plan strategy
# - PARALLEL : Batch (9 waves × 20 agents)
# - CONDITIONAL : Context7 → Perplexity → Firecrawl
# - HOOKS : Validation PostToolUse
# - REPORT : Aggregation metrics
```

---

## 📖 Contenu de cette Section

### [epct.md](./epct.md)
**Explore-Plan-Code-Test** : Méthodologie structurée en 4 phases pour features complexes.

**Points clés** :
- Phase EXPLORE : Contexte optimal (docs + code)
- Phase PLAN : Validation humaine OBLIGATOIRE
- Phase CODE : Implémentation selon plan
- Phase TEST : Vérification automatique
- **Impact** : 95% succès vs 50% sans workflow

### [sequential.md](./sequential.md)
**Step-by-Step Chaining** : Workflows séquentiels simples sans validation intermédiaire.

**Points clés** :
- Pattern linéaire : Étape 1 → Étape 2 → Étape 3
- Use cases : Scripts automation, migrations simples
- Quand utiliser vs EPCT

### [parallel.md](./parallel.md)
**Multi-agents Concurrent** : Traitement parallèle de tâches indépendantes.

**Points clés** :
- Task tool : ALL agents in SINGLE message
- Batch size : 10-20 optimal
- Aggregation results
- **Impact** : 5-10x speedup garanti

### [conditional.md](./conditional.md)
**Decision Trees & Fallbacks** : Workflows adaptatifs avec validation et recovery.

**Points clés** :
- Fallback chains : Primary → Fallback 1 → 2 → User
- Retry logic : 1 seule fois, avec contexte amélioré
- Exit codes : 0=ok, 1=warn, 2=block
- User validation checkpoints

### [hybrid.md](./hybrid.md) ⭐
**Orchestration Complexe** : Combinaison de tous les patterns pour production.

**Points clés** :
- EPCT + Parallel + Conditional
- Commands + Agents + Skills + Hooks + MCP
- Exemples complets production-ready :
  - Generate 174 Locales
  - PR Review Workflow
  - Migration Cloud Complete
  - Monorepo Setup
- **Impact** : Enterprise-grade robustness

---

## 🎯 Best Practices Workflows

### ✅ DO

```
1. CHOISIR LE BON TYPE
   ├─ Feature complexe → EPCT (validation humaine)
   ├─ Batch processing → Parallel (speedup)
   ├─ API externe → Conditional (fallback)
   └─ Production → Hybrid (robuste)

2. VALIDER AVANT CODER
   ├─ EPCT : Phase PLAN obligatoire
   ├─ Hybrid : User validation checkpoints
   └─ Éviter hallucinations

3. PARALLÉLISER QUAND POSSIBLE
   ├─ Task tool, même message
   ├─ Batch size 10-20
   └─ 5-10x speedup

4. FALLBACK CHAINS POUR APIS
   ├─ Primary → Fallback 1 → 2 → User
   ├─ Retry une fois max
   └─ Transparence sources

5. RAPPORTS DÉTAILLÉS
   ├─ Success rate
   ├─ Timing metrics
   ├─ Sources utilisées
   └─ Next steps actionables
```

### ❌ DON'T

```
1. CODER SANS PLAN (features complexes)
   ❌ Prompt direct → 50% succès
   ✅ EPCT → 95% succès

2. SÉQUENTIEL POUR TÂCHES INDÉPENDANTES
   ❌ 10 files × 12s = 120s
   ✅ Parallel : 12s (10x faster)

3. RETRY INFINI
   ❌ Boucles infinies, coût explosion
   ✅ 1 retry max, puis user validation

4. IGNORER FALLBACKS
   ❌ API down → workflow bloqué
   ✅ Fallback chains → robustesse

5. RAPPORTS VAGUES
   ❌ "Something failed"
   ✅ Détails + suggestions
```

---

## 📊 Benchmarks Réels

### EPCT vs Direct Prompting

```
Feature : Créer page pricing avec tiers + Stripe

Direct Prompting:
├─ Temps : 8 minutes
├─ Succès : 50% (hallucinations fréquentes)
└─ Qualité : Variable

EPCT Workflow:
├─ Temps : 12 minutes (+4min exploration/planning)
├─ Succès : 95% (contexte optimal)
└─ Qualité : Consistante
```

### Parallel vs Sequential

```
Tâche : Fix grammar 10 fichiers markdown

Sequential:
├─ Temps : 120s (10 × 12s)
├─ Coût : $0.20 (10 × sonnet)
└─ Speedup : 1x (baseline)

Parallel:
├─ Temps : 12s (max durée)
├─ Coût : $0.02 (10 × haiku)
└─ Speedup : 10x faster + 10x cheaper! ✅
```

### Hybrid Orchestration (Production)

```
Tâche : Generate 50 locales avec API enrichment

Baseline (séquentiel naïf):
├─ Temps : 25 minutes (50 × 30s)
├─ Coût : $2.50 (50 × sonnet)
├─ Succès : 70% (no retry)
└─ Speedup : 1x

Hybrid Orchestré:
├─ Temps : 3 minutes (5 waves × 10 agents)
├─ Coût : $0.35 (haiku + retry + fallbacks)
├─ Succès : 99.5% (retry + fallback chains)
└─ Speedup : 8.3x faster + 7x cheaper ✅
```

---

## 🔗 Ressources

### Documentation Interne
- 📄 [../patterns/command-agent-skill.md](../patterns/command-agent-skill.md) - Architecture hiérarchique
- 📄 [../patterns/error-handling.md](../patterns/error-handling.md) - Fallback chains
- 📄 [../patterns/parallel-execution.md](../patterns/parallel-execution.md) - Batching
- 📄 [../best-practices/performance.md](../best-practices/performance.md) - Optimisations

### Documentation Externe
- 📄 [Claude Code Docs](https://code.claude.com/docs)
- 📄 [Engineering Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)

### Vidéos & Formations
- 🎥 **Melvynx - Formation Claude Code 2.0** : https://www.youtube.com/watch?v=bDr1tGskTdw
  - 30:00 - Workflow EPCT (méthodologie complète)
  - 27:00 - Background Tasks (serveurs, builds)

---

## 🎓 Conclusion

Les **4 types de workflows** offrent une palette complète pour toute situation :

1. **EPCT** : Features complexes avec validation
2. **Parallel** : Batch processing avec speedup
3. **Conditional** : Fallback chains robustes
4. **Hybrid** : Production-ready orchestration

**Prochaine étape** :
1. Choisir workflow selon votre use case
2. Lire guide détaillé correspondant
3. Implémenter command/agent selon template
4. Benchmarker et optimiser

**Impact global** :
- ✅ **95% success rate** (vs 50% sans workflow)
- ✅ **5-10x speedup** (parallel vs sequential)
- ✅ **10x cost savings** (haiku vs opus)
- ✅ **Production-ready** robustness

🚀 **Maîtrisez les workflows, maîtrisez Claude Code !**
