# 🌳 Exemple : Verdent Deck - Agents en Worktrees Git Isolés

> **Feature 2025 : Agents vraiment parallèles avec isolation Git complète**

## 🎯 Problème Résolu

**Avant Verdent Deck** :
```
❌ Agents parallèles = conflits potentiels
❌ Modifications simultanées même fichier = collision
❌ Contexte partagé = pollution croisée
❌ Merge manuel fastidieux
```

**Avec Verdent Deck** :
```
✅ Chaque agent = worktree Git isolé
✅ Modifications simultanées sans collision
✅ Contexte 100% séparé
✅ Auto-merge intelligent
```

## 📊 Architecture

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

## 🛠️ Configuration

### 📁 Fichier : `settings.json`

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

## 💻 Setup Worktrees

### Étape 1 : Activer Verdent Deck

```bash
export CLAUDE_PARALLEL_AGENTS=true
```

### Étape 2 : Créer Worktrees

```bash
# Structure projet
project/
├── .git/
├── src/
├── tests/
└── docs/

# Créer worktrees pour agents
git worktree add ../project-agent-frontend -b agent-frontend
git worktree add ../project-agent-backend -b agent-backend
git worktree add ../project-agent-tests -b agent-tests
git worktree add ../project-agent-docs -b agent-docs

# Vérifier worktrees
git worktree list
```

**Output** :
```
/Users/dev/project              abc1234 [main]
/Users/dev/project-agent-frontend  def5678 [agent-frontend]
/Users/dev/project-agent-backend   ghi9012 [agent-backend]
/Users/dev/project-agent-tests     jkl3456 [agent-tests]
/Users/dev/project-agent-docs      mno7890 [agent-docs]
```

## 🚀 Lancer Agents en Parallèle

### Via Claude CLI

```bash
# Terminal 1: Agent Frontend
cd ../project-agent-frontend
claude --parallel --worktree . \
  -p "Refactor all React components to use TypeScript strict mode"

# Terminal 2: Agent Backend
cd ../project-agent-backend
claude --parallel --worktree . \
  -p "Optimize all SQL queries and add connection pooling"

# Terminal 3: Agent Tests
cd ../project-agent-tests
claude --parallel --worktree . \
  -p "Add missing unit tests to reach 80% coverage"

# Terminal 4: Agent Docs
cd ../project-agent-docs
claude --parallel --worktree . \
  -p "Update all documentation with new API endpoints"
```

### Via Configuration Plugin

```typescript
// .claude/plugins/parallel-refactor/index.ts
export default {
  command: 'parallel-refactor',
  description: 'Launch 4 agents in parallel worktrees',

  async execute() {
    const agents = [
      {
        name: 'frontend',
        worktree: '../project-agent-frontend',
        task: 'Refactor React components to TypeScript strict'
      },
      {
        name: 'backend',
        worktree: '../project-agent-backend',
        task: 'Optimize SQL queries'
      },
      {
        name: 'tests',
        worktree: '../project-agent-tests',
        task: 'Add unit tests (80% coverage)'
      },
      {
        name: 'docs',
        worktree: '../project-agent-docs',
        task: 'Update documentation'
      }
    ];

    // Launch all agents in parallel
    await Promise.all(
      agents.map(agent =>
        launchAgentInWorktree(agent.worktree, agent.task)
      )
    );

    // Auto-merge results
    await autoMergeWorktrees(agents);
  }
};
```

## 📊 Monitoring Dashboard

### Temps Réel

```bash
claude --monitor-agents
```

**Output** :
```
╔═══════════════════════════════════════════════════╗
║     PARALLEL AGENTS DASHBOARD - Real-Time         ║
╚═══════════════════════════════════════════════════╝

Agent       | Worktree           | Status      | Progress
------------|--------------------|--------------|---------
Frontend    | agent-frontend     | IN PROGRESS | ████████░░ 80%
Backend     | agent-backend      | IN PROGRESS | ██████░░░░ 60%
Tests       | agent-tests        | IN PROGRESS | ███████░░░ 70%
Docs        | agent-docs         | COMPLETED   | ██████████ 100%

⏱️ Elapsed: 8m 23s
📊 Est. completion: 2m 15s

Recent Activity:
[08:23:45] Frontend: Refactored 23/28 components
[08:23:42] Tests: Generated 47 new tests
[08:23:40] Docs: Updated API reference
[08:23:38] Backend: Optimized 12/15 queries
```

## 🔄 Auto-Merge Workflow

### Merge Automatique

```bash
# Option 1: Merge tout automatiquement
claude --merge-agents

# Option 2: Merge avec review
claude --merge-agents --review

# Option 3: Merge sélectif
claude --merge-agents --only frontend,backend
```

### Résolution Conflits

```bash
# Si conflits détectés
claude --merge-agents --conflicts interactive
```

**Interactive Conflict Resolution** :
```
╔══════════════════════════════════════════╗
║  CONFLICT DETECTED - agent-frontend      ║
╚══════════════════════════════════════════╝

File: src/components/Button.tsx

<<<<<<< agent-frontend (Agent A)
export const Button: React.FC<Props> = ({ label, onClick }) => {
  return <button className="btn-primary" onClick={onClick}>{label}</button>;
};
=======
export const Button = ({ label, onClick }: Props) => {
  return <button className="btn-new-style" onClick={onClick}>{label}</button>;
};
>>>>>>> agent-backend (Agent B)

Choose resolution:
1. Keep Agent A changes (btn-primary)
2. Keep Agent B changes (btn-new-style)
3. Merge both (manual edit)
4. Skip this file

Your choice: _
```

## 📈 Cas Réel : Refactoring E-commerce

### Contexte

**Projet** : E-commerce 1M+ lignes
**Tâche** : Refactoring complet architecture
**Délai** : 1 sprint (2 semaines)

### Setup Agents

```bash
# 8 agents pour 8 modules
git worktree add ../ecom-agent-auth -b agent-auth
git worktree add ../ecom-agent-payment -b agent-payment
git worktree add ../ecom-agent-cart -b agent-cart
git worktree add ../ecom-agent-products -b agent-products
git worktree add ../ecom-agent-orders -b agent-orders
git worktree add ../ecom-agent-shipping -b agent-shipping
git worktree add ../ecom-agent-analytics -b agent-analytics
git worktree add ../ecom-agent-notifications -b agent-notifications
```

### Lancement Parallel

```typescript
// .claude/plugins/ecom-refactor/index.ts
const modules = [
  'auth', 'payment', 'cart', 'products',
  'orders', 'shipping', 'analytics', 'notifications'
];

await Promise.all(
  modules.map(module =>
    launchAgent({
      name: `agent-${module}`,
      worktree: `../ecom-agent-${module}`,
      task: `Refactor ${module} module to microservice architecture`,
      model: 'opus'  // Critical refactoring
    })
  )
);
```

### Résultats

```
╔═══════════════════════════════════════════════════╗
║  REFACTORING RESULTS - E-commerce Project         ║
╚═══════════════════════════════════════════════════╝

⏱️ TEMPS
═════════
Sans Verdent : 64h refactoring (8 modules x 8h)
Avec Verdent : 9h (8 agents parallèles)
Gain : 86% temps économisé

📊 QUALITÉ
═══════════
✅ Tests passent 100% (coverage maintenu 82%)
✅ Zero regression bugs
✅ Performance stable (+3% amélioration)

🔧 CONFLITS
════════════
Total conflits : 12
Auto-resolved : 9 (75%)
Manual resolution : 3 (25%)
Temps résolution : 45min

💰 COÛT
════════
8 agents Opus x 2h = $2.40
ROI : 55h développeur économisées
Valeur : $5,500 (à $100/h)

🚀 DÉPLOIEMENT
═══════════════
Zero downtime achieved ✅
Rollback plan tested ✅
Migration réussie 100%
```

## 🎯 Patterns Verdent Deck

### Pattern 1 : Feature Split

**Quand** : Feature complexe touchant plusieurs domaines

```
Feature "Checkout Multi-Step" → Split par couche
├── Agent UI : Frontend checkout flow
├── Agent API : Backend endpoints
├── Agent DB : Schema migrations
├── Agent Tests : E2E coverage
└── Agent Docs : User guide
```

### Pattern 2 : Refactoring Massif

**Quand** : Refactoring global architecture

```
Refactoring Monolith → Microservices
├── Agent Auth : Extract auth service
├── Agent Payment : Extract payment service
├── Agent Products : Extract catalog service
├── Agent Orders : Extract order service
└── Agent Gateway : API gateway setup
```

### Pattern 3 : Bug Hunting

**Quand** : Multiples bugs types différents

```
Bug Hunt Sprint → Split par catégorie
├── Agent Security : Vulnérabilités
├── Agent Performance : Bottlenecks
├── Agent Memory : Memory leaks
└── Agent UX : Interface bugs
```

### Pattern 4 : Migration

**Quand** : Migration technologie (ex: Vue → React)

```
Migration Vue → React (100+ components)
├── Agent Pages : Page components
├── Agent Forms : Form components
├── Agent UI : UI components library
├── Agent Tests : Test migration
└── Agent Router : Routing setup
```

## ⚡ Best Practices

### DO ✅

**1. Limiter Nombre Agents**
```bash
✅ 4-8 agents optimal
❌ 16+ agents = overhead système
```

**2. Scopes Bien Définis**
```typescript
✅ Frontend (UI only)
✅ Backend (API only)
✅ Tests (test files only)

❌ "Improve everything" (trop vague)
```

**3. Auto-Merge Activé**
```json
{
  "autoMerge": true,
  "conflictResolution": "interactive"
}
```

**4. Cleanup Systématique**
```bash
# Après merge success
git worktree remove ../project-agent-*
git branch -d agent-*
```

### DON'T ❌

**1. Scopes Qui Se Chevauchent**
```
❌ Agent A modifie src/utils/validation.ts
   Agent B modifie src/utils/validation.ts
   → Conflit garanti
```

**2. Plus de 16 Agents**
```
❌ 20 agents = overhead > gain temps
✅ Max 8-10 agents pour performance optimale
```

**3. Oublier Cleanup**
```bash
❌ Laisser worktrees orphelins
   → Occupation disque inutile
✅ Toujours cleanup après merge
```

## 📊 Benchmarks Production

### Projet 1 : SaaS Platform

```
Tâche : Refactoring complet frontend (React)
Agents : 6 (pages, components, hooks, styles, tests, docs)
Temps sans Verdent : 48h
Temps avec Verdent : 9h
Gain : 81%
```

### Projet 2 : API Migration

```
Tâche : Migration REST → GraphQL (45 endpoints)
Agents : 8 (resolvers, schema, queries, mutations, tests, docs, migration, types)
Temps sans Verdent : 72h
Temps avec Verdent : 12h
Gain : 83%
```

### Projet 3 : Microservices Split

```
Tâche : Monolith → 12 microservices
Agents : 12 (1 par service)
Temps sans Verdent : 160h
Temps avec Verdent : 24h
Gain : 85%
```

## 📚 Ressources

- 📖 [Guide Agents](../guide.md#parallel-agents-verdent-deck)
- ⚡ [Cheatsheet](../cheatsheet.md)
- 📄 [Git Worktree Docs](https://git-scm.com/docs/git-worktree)
- 📄 [Pattern Parallelization](../../../agentic-workflow/6-composable-patterns/3-parallelization.md)

---

**💡 Tip** : Verdent Deck = révolution pour refactorings massifs et migrations complexes !
