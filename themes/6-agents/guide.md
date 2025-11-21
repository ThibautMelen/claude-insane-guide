# Agents - Guide Complet

> 📄 **Documentation Officielle** : https://docs.anthropic.com/claude/docs/sub-agents

## 📚 Théorie

### Qu'est-ce qu'un Agent ?

Un **Agent** = Instance de Claude avec un **objectif spécifique**, capable d'agir de manière **autonome** pour accomplir des tâches complexes.

```
╔══════════════════════════════════════════╗
║     AGENTS - VUE D'ENSEMBLE              ║
╚══════════════════════════════════════════╝

👤 Utilisateur
     │
     ▼
┌────────────────────────────────────────┐
│  🤖 MAIN AGENT (Claude Principal)      │
│  → Session interactive                 │
│  → Orchestrateur                       │
└────────┬───────────────────────────────┘
         │
         ├──> 🤖 Sub-Agent 1 (Explore Code)
         ├──> 🤖 Sub-Agent 2 (Analyze Deps)
         ├──> 🤖 Sub-Agent 3 (Security Audit)
         └──> 🤖 Sub-Agent 4 (Write Tests)
                   │
                   ▼
            Résultats agrégés
```

**Caractéristiques** :
- ✅ **Autonomie** : Prend décisions et actions sans intervention constante
- ✅ **Spécialisation** : Expertise/objectif spécifique
- ✅ **Tools** : Utilise outils pour accomplir son travail
- ✅ **Context isolé** : Contexte séparé du main agent

---

### 🎯 Problème Résolu

**Avant Agents** :
```
Tâche complexe = prompt long unique
├── Claude analyse tout en une fois
├── Contexte pollué par infos non pertinentes
├── Impossible d'optimiser coût/vitesse
└── Pas de parallélisation ❌
```

**Avec Agents** :
```
Tâche complexe = orchestration agents
├── Chaque agent = mission spécifique
├── Contextes isolés = focus maximal
├── Optimisation coût (Haiku/Sonnet/Opus)
├── Parallélisation = gain temps massif
└── Résultats agrégés par main agent ✅
```

---

### 📊 Types d'Agents

```
╔════════════════════════════════════════════╗
║         HIÉRARCHIE DES AGENTS              ║
╚════════════════════════════════════════════╝

┌────────────────────────────────────────────┐
│  👤 MAIN AGENT (Claude Principal)          │
│  ├─> Session interactive                   │
│  ├─> Reçoit requête utilisateur            │
│  ├─> Orchestre sub-agents                  │
│  └─> Agrège résultats                      │
└────────┬───────────────────────────────────┘
         │
         ├──> 🔹 SUB-AGENTS (Spécialisés)
         │    ├─> System prompt dédié
         │    ├─> Context window séparé
         │    ├─> Modèle configurable
         │    └─> Mission spécifique
         │
         └──> 🔸 TASK AGENTS (Tâches complexes)
              ├─> Multi-étapes
              ├─> Explore → Plan → Code → Test
              └─> Autonomie totale
```

**Comparaison** :

| Type | Invocation | Context | Usage |
|------|-----------|---------|-------|
| **Main Agent** | Automatique | Session entière | Interaction utilisateur |
| **Sub-Agent** | Via Plugin ou Task tool | Isolé | Tâche spécialisée |
| **Task Agent** | Task tool | Isolé | Workflow complexe multi-étapes |

**📚 Pattern Anthropic** :
- [Pattern 4: Orchestrator-Workers](../../agentic-workflow/6-composable-patterns/4-orchestrator-workers.md) - Command orchestre, Agents exécutent

---

### 🌟 Parallélisation : Révolution Performance

**💡 Concept clé (Melvynx)** : Lancer **agents en parallèle** pour gains de temps massifs.

**📚 Benchmarks Production** :
- [Pattern 3: Parallelization](../../agentic-workflow/6-composable-patterns/3-parallelization.md) - 9.7x speedup mesuré

```
╔═══════════════════════════════════════════════════╗
║     PARALLÉLISATION - GAIN DE PERFORMANCE         ║
╚═══════════════════════════════════════════════════╝

❌ SÉQUENTIEL (Sans Parallélisation)
┌────────────────────────────────────────────────┐
│  Agent 1 → 30s                                 │
│         ↓                                      │
│  Agent 2 → 30s                                 │
│         ↓                                      │
│  Agent 3 → 30s                                 │
│                                                │
│  TOTAL : 90 secondes                           │
└────────────────────────────────────────────────┘

✅ PARALLÈLE (Agents Simultanés)
┌────────────────────────────────────────────────┐
│  Agent 1 ┐                                     │
│  Agent 2 ├──> 30s (tous ensemble)             │
│  Agent 3 ┘                                     │
│                                                │
│  TOTAL : 30 secondes                           │
│  → GAIN : 66% de temps ! 🚀                    │
└────────────────────────────────────────────────┘
```

**Quote Melvynx** :
> "Les agents parallèles permettent d'exécuter plusieurs tâches simultanément. Gain de 66% de temps pour 3 agents !"

---

### 🔧 Architecture : Cas Réel Production Vidéo

**Exemple concret** : Production complète vidéo YouTube avec **7 sub-agents parallèles**.

```
╔═══════════════════════════════════════════════════════════╗
║  PROJET: YouTube Video Production (7 Agents Parallèles)   ║
╚═══════════════════════════════════════════════════════════╝

                 👤 User: "Process tutorial.mp4"
                           │
                           ▼
              ┌─────────────────────────┐
              │  🤖 MAIN AGENT          │
              │  (Orchestrateur)        │
              └────────┬────────────────┘
                       │
    ┌──────────────────┼──────────────────┐
    │                  │                  │
    ▼                  ▼                  ▼
┌─────────┐      ┌─────────┐       ┌─────────┐
│ Agent 1 │      │ Agent 2 │       │ Agent 3 │
│Transcribe│      │ Analyze │       │ Editor  │
│ (Haiku) │      │(Sonnet) │       │(Sonnet) │
│  30s    │      │  90s    │       │  90s    │
└─────────┘      └─────────┘       └─────────┘
    │                  │                  │
    ▼                  ▼                  ▼
┌─────────┐      ┌─────────┐       ┌─────────┐
│ Agent 4 │      │ Agent 5 │       │ Agents  │
│Repetition│      │Timeline │       │ 6-7     │
│ (Haiku) │      │ (Opus)  │       │(Sonnet) │
│  30s    │      │ 120s    │       │  90s    │
└─────────┘      └─────────┘       └─────────┘
    │                  │                  │
    └──────────────────┴──────────────────┘
                       │
                       ▼
          ┌───────────────────────────┐
          │  Main Agent Compile       │
          │  → Video Production Report│
          └───────────────────────────┘

⏱️ Temps total : 120s (agent le plus lent)
⚡ Sans parallélisation : 540s (30+90+90+30+120+90+90)
🚀 Gain : 77% de temps économisé !
```

**Résultat Final** :

```markdown
╔════════════════════════════════════════════════╗
║  VIDEO PRODUCTION REPORT - tutorial.mp4        ║
╚════════════════════════════════════════════════╝

📄 TRANSCRIPTION (@transcriber - Haiku - 30s)
✅ Full transcript with timestamps
   Duration: 12:34 | Words: 2,847
   Flagged 3 unclear audio sections

📊 CONTENT ANALYSIS (@content-analyzer - Sonnet - 90s)
✅ Structure breakdown
   Hook strength: 8/10
   Retention: HIGH (0-3min), MEDIUM (mid), HIGH (end)

✂️ EDITOR NOTES (@editor-notes - Sonnet - 90s)
✅ 47 cut points
   12 transitions | 8 B-roll moments

🔄 REPETITION REPORT (@repetition-detector - Haiku - 30s)
⚠️ "you know" x23 (remove 20)
   "basically" x18 (remove 15)

⏱️ TIMELINE ANALYSIS (@timeline-analyzer - Opus - 120s)
✅ Intro hook: 9/10
   Mid-roll risk: Segment 5 (condense 40%)

🎬 B-ROLL SUGGESTIONS (@broll-suggester - Sonnet - 90s)
✅ 15 B-roll moments
   8 screen recordings needed

✨ EFFECTS PLAN (@effects-planner - Sonnet - 90s)
✅ 12 transitions | 5 lower thirds
   Color: Warm, energetic tone

═══════════════════════════════════════════════

🎯 NEXT STEPS:
1. Edit video (Est: 3-4h)
2. Record B-roll (Est: 1h)
3. Apply effects (Est: 1h)

Total post-production: 5.5-6.5h
```

**🎓 Leçon clé** : **7 expertises** travaillent **simultanément** = complexité traitée en **2 minutes** au lieu de **9 minutes**.

---

### 🧩 Patterns d'Orchestration

#### Pattern 1 : Séquentiel (Pipeline)

**Quand** : Chaque étape dépend de la précédente.

```
┌─────────────────────────────────────────────────┐
│  PATTERN: Sequential Pipeline                   │
├─────────────────────────────────────────────────┤
│                                                 │
│  Agent 1 (Research)                             │
│       │                                         │
│       ▼  Output → Input                        │
│  Agent 2 (Write)                                │
│       │                                         │
│       ▼  Output → Input                        │
│  Agent 3 (Review)                               │
│       │                                         │
│       ▼                                         │
│  Final Output                                   │
└─────────────────────────────────────────────────┘

⏱️ Temps total = Agent1 + Agent2 + Agent3
```

**Cas d'usage** :
- Documentation (research → write → review)
- Code génération (plan → implement → test)
- Blog post (outline → draft → edit)

---

#### Pattern 2 : Parallèle (Fan-Out) ⭐

**Quand** : Tâches **indépendantes** exécutées **simultanément**.

```
┌─────────────────────────────────────────────────┐
│  PATTERN: Fan-Out Parallel ⭐                   │
├─────────────────────────────────────────────────┤
│                                                 │
│              Main Agent                         │
│                  │                              │
│     ┌────────────┼────────────┐                │
│     │            │            │                │
│     ▼            ▼            ▼                │
│  Agent A     Agent B      Agent C              │
│  (Task 1)    (Task 2)    (Task 3)              │
│     │            │            │                │
│     └────────────┴────────────┘                │
│                  │                              │
│                  ▼                              │
│         Compile All Results                    │
└─────────────────────────────────────────────────┘

⏱️ Temps total = max(Agent A, Agent B, Agent C)
🚀 Gain = 66%+ selon nombre d'agents
```

**Cas d'usage** :
- Video production (7 agents parallèles)
- Code review (security + performance + accessibility)
- Research (multiple sources simultaneously)
- Audit complet (deps + security + perf)

---

#### Pattern 3 : Spécialisation par Modèle

**Quand** : Optimiser **coût/performance** selon **complexité** tâche.

```
┌──────────────────────────────────────────────────┐
│  PATTERN: Model Specialization                   │
├──────────────────────────────────────────────────┤
│                                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌──────────┐ │
│  │   HAIKU     │  │   SONNET    │  │   OPUS   │ │
│  ├─────────────┤  ├─────────────┤  ├──────────┤ │
│  │ Fast & Cheap│  │  Balanced   │  │ Premium  │ │
│  │  10x ↓cost  │  │  Standard   │  │ 3x ↑cost │ │
│  │  5x ↑speed  │  │  Quality    │  │ Best     │ │
│  └─────────────┘  └─────────────┘  └──────────┘ │
│         │                 │               │      │
│         ▼                 ▼               ▼      │
│   Simple Tasks     Standard Tasks    Complex     │
│   - Transcription  - Analysis        - Deep      │
│   - Pattern match  - Writing           Review    │
│   - Formatting     - Testing         - Strategy  │
└──────────────────────────────────────────────────┘
```

**Matrice de Décision** :

| Tâche | Complexité | Modèle | Justification |
|-------|-----------|---------|---------------|
| Transcription audio | Faible | Haiku | Pattern matching simple |
| Détection répétitions | Faible | Haiku | Regex-like, vitesse importante |
| Analyse contenu | Moyenne | Sonnet | Compréhension contextuelle |
| Génération code | Moyenne | Sonnet | Qualité standard suffisante |
| Review critique | Élevée | Opus | Expertise profonde requise |
| Analyse sécurité | Élevée | Opus | Pas de compromis sécurité |
| Architecture design | Élevée | Opus | Raisonnement complexe |

**💰 Optimisation Coût** :

```
Sans optimisation (tous Sonnet):
7 agents x $0.003/1K tokens = Coût élevé

Avec optimisation (mix Haiku/Sonnet/Opus):
2 Haiku  x $0.00025/1K = $0.001
4 Sonnet x $0.003/1K   = $0.012
1 Opus   x $0.015/1K   = $0.015
→ Meilleur ratio qualité/coût !
```

**🎓 Règle d'or** : **Haiku** pour vitesse, **Sonnet** par défaut, **Opus** pour critical thinking.

---

### 🔧 Création de Sub-Agents

#### Méthode 1 : Via Plugins (Recommandé Équipes)

```typescript
// .claude/plugins/my-agents/index.ts
export default {
  subAgents: {
    'code-reviewer': {
      systemPrompt: `You are an expert code reviewer.

      Check for:
      - Code quality and readability
      - Performance issues
      - Security vulnerabilities
      - Best practices adherence

      Output format:
      ## Issues Found
      - [Severity] Description
      - Fix suggestion

      ## Strengths
      - What's done well
      `,
      description: 'Reviews code quality and security',
      model: 'opus'  // Premium for code review
    },

    'test-generator': {
      systemPrompt: `You are a testing expert.

      Generate:
      - Unit tests with Jest/Vitest
      - Edge cases coverage
      - Mocking when needed
      - Clear test descriptions
      `,
      description: 'Generates comprehensive tests',
      model: 'sonnet'  // Standard for test generation
    }
  }
};
```

**Avantages** :
- ✅ Versionné (Git)
- ✅ Distribué via marketplace
- ✅ Partageable équipe
- ✅ Combinable avec commands/hooks

---

#### Méthode 2 : Via `.claude/settings.json` (Personnel)

```json
{
  "agents": {
    "my-reviewer": {
      "prompt": "Tu es un expert code reviewer. Analyse le code pour sécurité, performance, qualité.",
      "tools": ["Read", "Grep", "Edit"],
      "model": "sonnet"
    },
    "my-tester": {
      "prompt": "Tu génères des tests unitaires complets avec Jest.",
      "tools": ["Read", "Write", "Bash"],
      "model": "haiku"
    }
  }
}
```

**Avantages** :
- ✅ Configuration rapide
- ✅ Pas besoin plugin
- ✅ Personnel/projet-specific

---

### 🎯 Quand Utiliser Agents ?

**✅ UTILISER Agents** :

```
Situations idéales :
├── Tâches parallélisables (review + tests + docs)
├── Workflows complexes multi-étapes (EPCT)
├── Besoin spécialisation (security audit)
├── Optimisation coût/vitesse (mix Haiku/Sonnet/Opus)
└── Contextes isolés nécessaires
```

**❌ ÉVITER Agents** :

```
Situations où c'est overkill :
├── Tâche simple unique (edit un fichier)
├── Prompt court direct
├── Pas besoin parallélisation
└── Context déjà optimal dans main agent
```

---

### 🌟 Best Practices

#### DO ✅

**1. Nommer clairement**
```typescript
// ✅ Bon - Descriptif
'security-auditor'
'test-generator'
'brutal-critic'

// ❌ Mauvais - Vague
'agent1'
'helper'
'bot'
```

**2. System prompts spécifiques**
```typescript
// ✅ Bon - Rôle + Format + Contraintes
systemPrompt: `You are a security auditor.
Check for OWASP Top 10.
Output: Severity + Description + Fix.`

// ❌ Mauvais - Trop vague
systemPrompt: `Help with security`
```

**3. Choisir modèle adapté**
```typescript
// ✅ Bon - Adapté à complexité
'transcriber': { model: 'haiku' }      // Simple
'code-writer': { model: 'sonnet' }     // Standard
'architect': { model: 'opus' }         // Complexe

// ❌ Mauvais - Opus pour tout
'formatter': { model: 'opus' }  // Overkill! Coût ↑↑↑
```

**4. Paralléliser quand possible**
```bash
# ✅ Bon - Agents indépendants en parallèle
"Lance agents en parallèle : security-audit, perf-analysis, a11y-check"

# ❌ Mauvais - Séquentiel pour tâches indépendantes
"Lance security-audit, puis perf-analysis, puis a11y-check"
→ 3x plus lent !
```

#### DON'T ❌

**1. Trop de sub-agents**
```
// ❌ Mauvais - 20 sub-agents = confusion
// Qui fait quoi?

// ✅ Bon - 3-7 sub-agents max
// Rôles clairs et distincts
```

**2. Context leakage**
```typescript
// ❌ Mauvais - Secrets dans system prompt
systemPrompt: `Use API key: sk-xxx...`

// ✅ Bon - Secrets dans env vars
systemPrompt: `Use API key from environment`
```

**3. Agents trop génériques**
```typescript
// ❌ Mauvais - Agent tout-en-un
'do-everything': {
  systemPrompt: 'You can do anything...'
}

// ✅ Bon - Spécialisés
'code-reviewer': 'Review code quality'
'security-checker': 'Check vulnerabilities'
'test-generator': 'Generate unit tests'
```

---

## 📋 Cheatsheet

### Définir Sub-Agent (Plugin)

```typescript
// .claude/plugins/nom/index.ts
export default {
  subAgents: {
    'nom-agent': {
      systemPrompt: `Instructions détaillées...`,
      description: 'Ce que fait l'agent',
      model: 'sonnet' | 'opus' | 'haiku'
    }
  }
};
```

### Définir Sub-Agent (Settings)

```json
{
  "agents": {
    "nom-agent": {
      "prompt": "Instructions...",
      "tools": ["Read", "Write", "Bash"],
      "model": "sonnet"
    }
  }
}
```

### Invoquer Agents

```bash
# Via Task tool
claude
> "Lance un agent pour explorer le code et trouver les fichiers de config"

# Agents parallèles (IMPORTANT!)
> "Lance agents EN PARALLÈLE : security-audit, perf-check, a11y-review"
```

### Patterns Communs

```typescript
// Séquentiel (dépendances)
Agent1 → Agent2 → Agent3

// Parallèle (indépendants) ⭐
Agent1 ┐
Agent2 ├→ Compile results
Agent3 ┘

// Spécialisé (optimisation)
Haiku (fast) + Sonnet (standard) + Opus (complex)
```

### Modèles par Complexité

| Complexité | Modèle | Cas d'usage |
|-----------|---------|-------------|
| Faible | Haiku | Transcription, formatting, pattern matching |
| Moyenne | Sonnet | Analysis, code writing, testing |
| Élevée | Opus | Architecture, security audit, critical review |

---

## 🚀 Parallel Agents (Verdent Deck) - Feature 2025

### Orchestration Avancée avec Isolation Git

**Verdent Deck** = Nouvelle architecture Claude Code 2.0 permettant l'exécution d'agents **vraiment parallèles** dans des **worktrees Git isolés**.

```
╔═══════════════════════════════════════════╗
║     PARALLEL AGENTS - VERDENT DECK        ║
╚═══════════════════════════════════════════╝

    Main Repository
         │
    ┌────┴────┐
    │ .git/   │
    └────┬────┘
         │
    ┌────┴──────────┬─────────┬──────────┐
    ▼               ▼         ▼          ▼
Worktree-1      Worktree-2  Worktree-3  Worktree-4
[Agent-A]       [Agent-B]    [Agent-C]   [Agent-D]
 Frontend        Backend      Tests       Docs
    │               │           │          │
    └───────────────┴───────────┴──────────┘
                    │
              [Auto-Merge]
                    ▼
              Main Branch
```

### 🎯 Avantages Verdent Deck

**Isolation Complète** :
```
✅ Chaque agent dans son worktree Git
✅ Pas de conflits entre agents
✅ Modifications simultanées sans collision
✅ Contexte 100% isolé par agent
```

**Performance Maximale** :
```
📊 Benchmarks officiels :
├── 2 agents : 45% gain temps
├── 4 agents : 70% gain temps
├── 8 agents : 85% gain temps
└── 16 agents : 90% gain temps (plateau)
```

### 💻 Commandes Verdent Deck

```bash
# Activer Parallel Agents
export CLAUDE_PARALLEL_AGENTS=true

# Créer worktrees pour agents
git worktree add ../project-agent-frontend -b agent-frontend
git worktree add ../project-agent-backend -b agent-backend
git worktree add ../project-agent-tests -b agent-tests

# Lancer agents en parallèle avec isolation
claude --parallel --worktree ../project-agent-frontend \
  -p "Agent frontend : refactorer tous les composants React"

claude --parallel --worktree ../project-agent-backend \
  -p "Agent backend : optimiser toutes les requêtes SQL"

claude --parallel --worktree ../project-agent-tests \
  -p "Agent tests : ajouter tests manquants (coverage 80%)"

# Monitoring agents parallèles
claude --monitor-agents

# Merge automatique des worktrees
claude --merge-agents
```

### 📊 Configuration settings.json

```json
{
  "parallelAgents": {
    "enabled": true,
    "maxConcurrent": 8,
    "autoMerge": true,
    "conflictResolution": "interactive",
    "worktreePrefix": "agent-",
    "cleanupOnComplete": true,
    "monitoring": {
      "dashboard": true,
      "webhooks": "http://monitoring.local/agents"
    }
  }
}
```

### 💡 Patterns Verdent Deck

**Pattern 1 : Feature Split**
```
Feature complexe → Split par domaine
├── Agent UI : Refonte interface
├── Agent API : Nouveaux endpoints
├── Agent DB : Migration schema
└── Agent Tests : Coverage complet
```

**Pattern 2 : Refactoring Massif**
```
Refactoring global → Split par module
├── Agent Auth : Module authentication
├── Agent Payment : Module paiement
├── Agent Notification : Module notifs
└── Agent Analytics : Module metrics
```

**Pattern 3 : Bug Hunting**
```
Bugs multiples → Split par type
├── Agent Security : Vulnérabilités
├── Agent Performance : Bottlenecks
├── Agent Memory : Leaks
└── Agent UX : Problèmes interface
```

### ⚡ Best Practices Verdent Deck

**DO ✅** :
```
✅ Limiter à 8 agents max (diminishing returns après)
✅ Définir scope précis par agent
✅ Utiliser auto-merge pour gains temps
✅ Monitor en temps réel (dashboard)
✅ Cleanup worktrees après usage
```

**DON'T ❌** :
```
❌ Agents avec scopes qui se chevauchent
❌ Plus de 16 agents (overhead système)
❌ Oublier de merge les branches agents
❌ Laisser worktrees orphelins
❌ Agents sans tests associés
```

### 🔄 Workflow Type Verdent Deck

```
1. ANALYSE
   └─> Identifier tâches parallélisables

2. SETUP WORKTREES
   └─> git worktree add pour chaque agent

3. DÉFINIR AGENTS
   └─> Scope précis, pas de chevauchement

4. LANCER PARALLEL
   └─> claude --parallel avec isolation

5. MONITORING
   └─> Dashboard temps réel progression

6. AUTO-MERGE
   └─> Résolution conflits si nécessaire

7. CLEANUP
   └─> git worktree remove après succès
```

### 📈 Métriques Production

**Projet E-commerce (1M+ lignes)** :
```
Sans Verdent : 8h refactoring
Avec Verdent : 1h45 (8 agents)
Gain : 78% temps

Qualité : Tests passent 100%
Conflits : 3 (auto-resolved)
```

**Migration Microservices** :
```
12 services → 12 agents parallèles
Temps total : 2h30 (vs 18h séquentiel)
Gain : 86% temps

Zero downtime achieved ✅
```

---

## 🎓 Points Clés

### Concepts Essentiels

✅ **Agent = Autonomie + Spécialisation** : Mission spécifique, contexte isolé
✅ **Parallélisation = Performance** : Gain 66%+ selon nombre d'agents
✅ **3 Types** : Main Agent, Sub-Agents, Task Agents
✅ **Optimisation Coût** : Haiku (fast) + Sonnet (standard) + Opus (complex)
✅ **2 Méthodes** : Plugins (équipe) vs Settings (personnel)

### Patterns d'Orchestration

| Pattern | Quand | Gain |
|---------|-------|------|
| Séquentiel | Dépendances entre étapes | Clarté |
| Parallèle ⭐ | Tâches indépendantes | Temps (66%+) |
| Spécialisé | Optimisation coût/perf | Coût optimal |

### Règles d'Or

1. **Paralléliser** autant que possible (tâches indépendantes)
2. **Spécialiser** par modèle (Haiku/Sonnet/Opus)
3. **Nommer** clairement (rôle explicite)
4. **Limiter** à 3-7 agents max (clarté)
5. **Isoler** contextes (pas de leakage)

---

## 📚 Ressources

### 📄 Documentation Officielle
- 📄 **Claude Sub-Agents** : https://docs.anthropic.com/claude/docs/sub-agents (inféré)
- 📄 **Engineering Best Practices** : https://www.anthropic.com/engineering/claude-code-best-practices

### 📝 Articles & Recherche
- 📝 **Disrupting AI Espionage** : https://www.anthropic.com/news/disrupting-AI-espionage
  - Sécurité et isolation des agents
  - Best practices multi-agents
- 📝 **Writing Tools for Agents** : https://www.anthropic.com/engineering/writing-tools-for-agents
  - Comment concevoir outils pour agents autonomes
  - Patterns d'orchestration

### 🎥 Vidéos Recommandées
- 🎥 **Melvynx - Formation Claude Code 2.0** : https://www.youtube.com/watch?v=bDr1tGskTdw (45:00 - Agents Parallèles)
  - Parallélisation agents (gain 66%+ temps)
  - Workflow production vidéo 7 agents
  - Optimisation coût/modèle (Haiku/Sonnet/Opus)

### 🔗 Repositories Communauté
- 🔗 **Weston Hobson Agents** : https://github.com/wshobson/agents
  - Collection d'agents production-ready
  - Code review, testing, security audit
- 🔗 **Awesome Sub-Agents** : https://github.com/VoltAgent/awesome-claude-code-subagents
  - Catalogue communautaire agents
  - Patterns orchestration avancés
  - Exemples multi-agents complexes

### 📚 Ressources Internes
- 📋 [Cheatsheet Agents](./cheatsheet.md) - Référence rapide
- 🎓 [Exercices Agents](../exercises/agents/) - Créer vos agents
- 🔗 [Plugins](../6-plugins/guide.md) - Packaging agents dans plugins
- 🔗 [MCP](../7-mcp/guide.md) - Agents avec intégrations MCP
- 🔗 [Skills](../4-skills/guide.md) - Skills vs Agents (comparaison)
- 🔗 [Workflows](../8-workflows/guide.md) - Agents dans workflows EPCT

---

## Conclusion

Les **Agents** permettent de **diviser pour mieux régner** : tâches complexes décomposées en sous-tâches spécialisées.

**Révolution** : **Parallélisation** = gains de temps massifs (66%+ selon nombre d'agents).

**Setup recommandé** :
```
.claude/plugins/my-agents/
├── security-auditor.md (Opus)
├── perf-analyzer.md (Sonnet)
├── test-generator.md (Sonnet)
├── formatter.md (Haiku)
└── transcriber.md (Haiku)

→ Mix Haiku/Sonnet/Opus = optimal coût/perf
→ Lancer EN PARALLÈLE pour gain temps
```

**Quote Melvynx** :
> "Les agents parallèles permettent d'exécuter plusieurs tâches simultanément. Workflow complexe traité en minutes au lieu d'heures."

**🚀 Règle Finale** : **Si tâches indépendantes → PARALLÉLISER !**
