# 🎯 Cas d'Usage Réels - Plugins Claude Code

> **Exemples concrets de plugins production-ready avec structures complètes et workflows**

---

## 📑 Table des Matières

1. [DevOps Toolkit](#-cas-1--devops-toolkit)
2. [Data Platform](#-cas-2--data-platform)
3. [Testing Suite](#-cas-3--testing-suite)

---

## 🚀 Cas 1 : DevOps Toolkit

### 🎯 Objectif

Plugin complet pour automatiser les workflows DevOps : déploiements, rollbacks, monitoring, et gestion d'incidents.

### 📂 Structure Complète

```
devops-toolkit/
│
├─ .claude-plugin/
│  └─ plugin.json
│     {
│       "name": "devops-toolkit",
│       "version": "2.1.0",
│       "description": "Suite complète d'automatisation DevOps",
│       "author": {
│         "name": "Équipe DevOps",
│         "email": "devops@entreprise.com"
│       },
│       "keywords": ["devops", "kubernetes", "monitoring", "deployment"],
│       "commands": ["./commands"],
│       "agents": "./agents",
│       "hooks": "./hooks/hooks.json",
│       "mcpServers": "./.mcp.json"
│     }
│
├─ commands/                        # 🔧 Slash Commands
│  ├─ deploy.md                     # /deploy → Déploiement complet
│  ├─ rollback.md                   # /rollback → Rollback rapide
│  ├─ health-check.md               # /health → Vérification santé
│  ├─ logs.md                       # /logs → Récupération logs
│  └─ scale.md                      # /scale → Scaling services
│
├─ agents/                          # 🤖 Sub-Agents Spécialisés
│  ├─ deployment-manager.md         # Orchestre les déploiements
│  ├─ incident-responder.md         # Gère les incidents
│  ├─ cost-optimizer.md             # Optimise les coûts cloud
│  └─ security-auditor.md           # Audits sécurité continus
│
├─ skills/                          # 💡 Skills Domaines
│  ├─ kubernetes/
│  │  ├─ SKILL.md                   # Expertise Kubernetes
│  │  └─ scripts/
│  │     ├─ scale.sh                # Scaling pods
│  │     ├─ restart.sh              # Restart deployments
│  │     └─ rollback.sh             # Rollback versions
│  │
│  └─ monitoring/
│     ├─ SKILL.md                   # Expertise Monitoring
│     └─ scripts/
│        ├─ metrics.py              # Collecte métriques
│        └─ alerts.py               # Gestion alertes
│
├─ hooks/
│  └─ hooks.json
│     {
│       "hooks": [
│         {
│           "event": "PreToolUse",
│           "tool": "Bash",
│           "pattern": "kubectl delete|rm -rf /",
│           "blocking": true,
│           "script": "echo '⚠️  Action destructive bloquée ! Confirmer avec sudo'"
│         },
│         {
│           "event": "PostToolUse",
│           "tool": "Bash",
│           "pattern": "kubectl apply",
│           "script": "bash scripts/notify-deployment.sh"
│         }
│       ]
│     }
│
├─ scripts/                         # 📜 Utilitaires
│  ├─ setup-kubectl.sh              # Configuration Kubernetes
│  ├─ deploy-pipeline.sh            # Pipeline CI/CD
│  ├─ health-check.py               # Monitoring santé
│  └─ notify-deployment.sh          # Notifications Slack
│
├─ .mcp.json                        # 🔌 MCP Servers
│  {
│    "mcpServers": {
│      "datadog": {
│        "type": "url",
│        "url": "https://mcp.datadoghq.com",
│        "env": {
│          "DATADOG_API_KEY": "${DATADOG_API_KEY}",
│          "DATADOG_APP_KEY": "${DATADOG_APP_KEY}"
│        }
│      },
│      "pagerduty": {
│        "type": "url",
│        "url": "https://mcp.pagerduty.com",
│        "env": {
│          "PAGERDUTY_API_KEY": "${PAGERDUTY_API_KEY}"
│        }
│      },
│      "kubernetes": {
│        "command": "npx",
│        "args": ["-y", "@modelcontextprotocol/server-kubernetes"],
│        "env": {
│          "KUBECONFIG": "${KUBECONFIG}"
│        }
│      }
│    }
│  }
│
├─ CLAUDE.md                        # 📝 Guidelines
│  # DevOps Expert Guidelines
│
│  Tu es un expert DevOps. Tes priorités :
│
│  **Safety First**:
│  - Toujours tester en staging avant production
│  - Vérifier health checks après déploiement
│  - Préparer rollback plan avant changement
│  - Logger toutes les actions critiques
│
│  **Automation**:
│  - Privilégier automation vs manuel
│  - Documenter tous les workflows
│  - Utiliser infrastructure-as-code
│
│  **Communication**:
│  - Notifier équipe avant/après déploiements
│  - Créer tickets incidents automatiquement
│  - Tenir logs détaillés (qui, quoi, quand)
│
├─ README.md                        # 📚 Documentation
├─ CHANGELOG.md                     # 📜 Historique versions
└─ LICENSE                          # ⚖️ MIT License
```

### 🔄 Workflow Typique

**Scénario** : Déployer nouvelle version en production

```
USER: /deploy production v2.3.0
         │
         ▼
┌─────────────────────────────────────────────────┐
│  Command: deploy.md                             │
│  Parse arguments (env, version)                 │
└────────────┬────────────────────────────────────┘
             │
             ▼
┌─────────────────────────────────────────────────┐
│  Agent: deployment-manager.md                   │
│  Orchestrate full deployment pipeline           │
└────────────┬────────────────────────────────────┘
             │
      ┌──────┴──────┬──────────────┬────────────┐
      │             │              │            │
      ▼             ▼              ▼            ▼
  ┌─────────┐  ┌─────────┐   ┌─────────┐  ┌─────────┐
  │ Skill:  │  │ Script: │   │  MCP:   │  │  Hook:  │
  │   K8s   │  │  health │   │Datadog  │  │  Post   │
  │ scale   │  │  check  │   │ metrics │  │ Deploy  │
  └─────────┘  └─────────┘   └─────────┘  └─────────┘
      │             │              │            │
      └─────────────┴──────────────┴────────────┘
                    │
                    ▼
             ✅ Deployment Success
             📊 Metrics updated
             💬 Team notified (Slack)
```

### 📄 Exemple : commands/deploy.md

```markdown
---
name: deploy
description: Déploie application sur environnement spécifié
---

# Deployment Command

Déploie l'application avec validation complète.

## Usage

/deploy [staging|production] [version]

## Steps Automatiques

1. **Pre-flight Checks**
   - Vérifier santé cluster actuel
   - Valider version Docker existe
   - Confirmer backup database récent

2. **Deployment**
   - Pull nouvelle image Docker
   - Update Kubernetes manifests
   - Rolling update (zero downtime)
   - Scale replicas si nécessaire

3. **Post-deployment**
   - Health checks (5 minutes)
   - Smoke tests automatiques
   - Métriques Datadog
   - Notification Slack équipe

4. **Rollback Auto si Échec**
   - Si health check fail
   - Rollback version précédente
   - Alert PagerDuty incident

## Sécurité

- Production requiert confirmation
- Logs audit automatiques
- Rollback plan préparé

## Exemple

```bash
/deploy production v2.3.0
# → Confirmer ? (y/N): y
# → ✅ Deployment started...
# → ✅ Image pulled: app:v2.3.0
# → ✅ Rolling update: 0/5 → 5/5
# → ✅ Health check: OK
# → ✅ Team notified
# → 🎉 Deployment complete!
```
\```

### 🤖 Exemple : agents/deployment-manager.md

```markdown
# Deployment Manager Agent

Tu es un gestionnaire de déploiement expert.

## Responsabilités

1. **Orchestration Pipeline**
   - Coordonner toutes les étapes du déploiement
   - Gérer les dépendances entre services
   - Paralléliser quand possible

2. **Safety Checks**
   - Valider cluster capacity (CPU, RAM, disk)
   - Vérifier aucun deployment en cours
   - Confirmer backup database < 1h

3. **Rollback Strategy**
   - Préparer rollback automatique
   - Garder 3 versions précédentes
   - Rollback si health check fail > 2 min

4. **Communication**
   - Notify Slack avant/après
   - Créer incident PagerDuty si échec
   - Logger timeline complète

## Tools Available

- Bash (kubectl, docker, aws cli)
- MCP: kubernetes, datadog, pagerduty
- Skills: kubernetes/*, monitoring/*
- Scripts: deploy-pipeline.sh, health-check.py

## Workflow Type

```
START
  ├─► Pre-flight (parallel checks)
  ├─► Backup database (si prod)
  ├─► Deploy (rolling update)
  ├─► Health check (5 min polling)
  └─► Report (metrics + notification)
```

**Toujours prioritiser la safety sur la vitesse.**
\```

### 💡 Skills Clés

**skills/kubernetes/SKILL.md** :

```markdown
# Kubernetes Management Skill

**Expertise** : Gestion complète de clusters Kubernetes

## Capabilities

- **Deployments** : Rolling updates, rollbacks, scaling
- **Services** : Load balancing, ingress configuration
- **ConfigMaps/Secrets** : Gestion configuration sécurisée
- **Monitoring** : Logs, métriques, health checks
- **Troubleshooting** : Debug pods, events, logs

## Scripts Disponibles

- `scale.sh <deployment> <replicas>` - Scale service
- `restart.sh <deployment>` - Restart rolling
- `rollback.sh <deployment>` - Rollback version

## Invocation Auto

Invoqué automatiquement quand :
- Keywords : kubectl, kubernetes, k8s, deployment, pods
- Commands : /deploy, /rollback, /scale
- Agents : deployment-manager, incident-responder

## Exemples

**Scale service** :
```bash
bash skills/kubernetes/scripts/scale.sh api-backend 10
# → Scaled deployment api-backend to 10 replicas
```

**Rollback** :
```bash
bash skills/kubernetes/scripts/rollback.sh api-backend
# → Rolled back api-backend to previous version
```
\```

---

## 📊 Cas 2 : Data Platform

### 🎯 Objectif

Plugin pour data engineers : ETL pipelines, validation données, ML-Ops, et data quality.

### 📂 Structure Complète

```
data-platform/
│
├─ .claude-plugin/
│  └─ plugin.json
│     {
│       "name": "data-platform",
│       "version": "3.0.0",
│       "description": "Plateforme complète data engineering & ML-Ops",
│       "keywords": ["data", "etl", "ml", "analytics", "pipeline"],
│       "commands": ["./commands"],
│       "agents": "./agents",
│       "skills": "./skills",
│       "mcpServers": "./.mcp.json"
│     }
│
├─ commands/
│  ├─ ingest.md                     # /ingest → Import données
│  ├─ transform.md                  # /transform → ETL
│  ├─ validate.md                   # /validate → Data quality
│  ├─ export.md                     # /export → Export résultats
│  └─ train-model.md                # /train-model → ML training
│
├─ agents/
│  ├─ data-orchestrator.md          # Coordonne pipelines
│  ├─ quality-guardian.md           # Assure data quality
│  ├─ lineage-tracker.md            # Track data lineage
│  └─ ml-pipeline-manager.md        # Gère ML workflows
│
├─ skills/
│  ├─ etl-processing/
│  │  ├─ SKILL.md
│  │  └─ scripts/
│  │     ├─ extract.py              # Extraction sources
│  │     ├─ transform.py            # Transformations
│  │     └─ load.py                 # Chargement warehouse
│  │
│  ├─ data-validation/
│  │  ├─ SKILL.md
│  │  └─ scripts/
│  │     ├─ schema-check.py         # Validation schémas
│  │     ├─ quality-metrics.py      # Métriques qualité
│  │     └─ outlier-detection.py    # Détection anomalies
│  │
│  └─ ml-ops/
│     ├─ SKILL.md
│     └─ scripts/
│        ├─ train-model.py          # Training modèles
│        ├─ evaluate.py             # Évaluation performance
│        └─ deploy-model.sh         # Déploiement production
│
├─ hooks/
│  └─ hooks.json
│     {
│       "hooks": [
│         {
│           "event": "SessionStart",
│           "script": "python scripts/init-database.py"
│         },
│         {
│           "event": "PreToolUse",
│           "tool": "Bash",
│           "pattern": "DROP TABLE|DELETE FROM",
│           "blocking": true,
│           "script": "echo '⚠️  Opération destructive ! Backup requis.'"
│         }
│       ]
│     }
│
├─ scripts/
│  ├─ init-database.py              # Setup connexions DB
│  ├─ backup.sh                     # Sauvegardes automatiques
│  └─ cleanup.py                    # Nettoyage données temporaires
│
├─ .mcp.json
│  {
│    "mcpServers": {
│      "snowflake": {
│        "type": "url",
│        "url": "https://mcp.snowflake.com",
│        "env": {
│          "SNOWFLAKE_ACCOUNT": "${SNOWFLAKE_ACCOUNT}",
│          "SNOWFLAKE_USER": "${SNOWFLAKE_USER}",
│          "SNOWFLAKE_PASSWORD": "${SNOWFLAKE_PASSWORD}"
│        }
│      },
│      "databricks": {
│        "type": "url",
│        "url": "https://mcp.databricks.com",
│        "env": {
│          "DATABRICKS_HOST": "${DATABRICKS_HOST}",
│          "DATABRICKS_TOKEN": "${DATABRICKS_TOKEN}"
│        }
│      },
│      "postgres": {
│        "command": "npx",
│        "args": ["-y", "@modelcontextprotocol/server-postgres"],
│        "env": {
│          "DATABASE_URL": "${DATABASE_URL}"
│        }
│      }
│    }
│  }
│
├─ CLAUDE.md
│  # Data Engineering Expert
│
│  Tu es un data engineer expert. Tes principes :
│
│  **Data Quality First**:
│  - Toujours valider schémas avant transformations
│  - Vérifier null rates, duplicates, outliers
│  - Logger métriques qualité à chaque étape
│  - Fail fast si données invalides
│
│  **Reproducibility**:
│  - Versionner pipelines (Git + DVC)
│  - Documenter transformations
│  - Tester avec datasets samples
│  - Conserver lineage data complète
│
│  **Performance**:
│  - Paralléliser transformations quand possible
│  - Utiliser partitioning intelligent
│  - Monitorer memory/CPU usage
│  - Optimiser requêtes SQL
│
└─ README.md
```

### 🔄 Pipeline Data Typique

```
    /ingest raw-data.csv
           │
           ▼
    ┌──────────────────┐
    │ Agent:           │
    │ Data Orchestrator│
    └──────┬───────────┘
           │
     ┌─────┴──────┬──────────────┬────────────┐
     │            │              │            │
     ▼            ▼              ▼            ▼
  Skill:      Skill:        Skill:       MCP:
   ETL      Validation     ML-Ops     Snowflake
  extract   schema-check   train      load data
     │            │              │            │
     └────────────┴──────────────┴────────────┘
                    │
                    ▼
            ┌───────────────┐
            │ Data Quality  │
            │  Validation   │
            └───────┬───────┘
                    │
                    ├─► ✅ Quality OK → Continue
                    │
                    └─► ❌ Quality Fail → Alert + Stop
```

### 📄 Exemple : commands/transform.md

```markdown
---
name: transform
description: Applique transformations ETL sur données
---

# Transform Command

Transforme données brutes en format analytique.

## Usage

/transform <source> <destination> [--validation-level strict|relaxed]

## Pipeline ETL

1. **Extract**
   - Lire source (CSV, JSON, Parquet, DB)
   - Valider format et encoding
   - Sample preview (first 100 rows)

2. **Transform**
   - Nettoyage (nulls, duplicates)
   - Enrichissement (joins, calculations)
   - Aggregations si nécessaire
   - Type conversions

3. **Load**
   - Write to destination (Snowflake, Databricks, S3)
   - Partitioning optimal
   - Compression (Parquet + Snappy)

4. **Validate**
   - Schema compliance (Great Expectations)
   - Quality metrics (null rate, uniqueness, ranges)
   - Lineage tracking
   - Alert si quality fail

## Exemple

```bash
/transform s3://raw/users.csv snowflake.analytics.users --validation-level strict
# → ✅ Extracted 1.2M rows from S3
# → ⚙️  Transforming (dedupe, enrich, aggregate)
# → ✅ Loaded 1.15M rows to Snowflake
# → 📊 Quality metrics:
#      • Null rate: 0.02% (✅ < 1%)
#      • Duplicates: 50K removed
#      • Schema: 100% compliant
# → 🎉 Transform complete!
```
\```

---

## 🧪 Cas 3 : Testing Suite

### 🎯 Objectif

Plugin complet pour QA : tests unitaires, E2E, load testing, coverage, et CI/CD integration.

### 📂 Structure Complète

```
testing-suite/
│
├─ .claude-plugin/
│  └─ plugin.json
│     {
│       "name": "testing-suite",
│       "version": "1.5.0",
│       "description": "Suite complète de testing et QA automation",
│       "keywords": ["testing", "qa", "ci", "coverage", "e2e"],
│       "commands": ["./commands"],
│       "agents": "./agents",
│       "skills": "./skills"
│     }
│
├─ commands/
│  ├─ run-tests.md                  # /test → Lance tous tests
│  ├─ coverage.md                   # /coverage → Rapport coverage
│  ├─ benchmark.md                  # /benchmark → Performance tests
│  ├─ integration.md                # /integration → Tests E2E
│  └─ ci-check.md                   # /ci-check → Validation CI
│
├─ agents/
│  ├─ test-coordinator.md           # Coordonne stratégie test
│  ├─ bug-hunter.md                 # Détecte patterns bugs
│  └─ performance-analyst.md        # Analyse performance
│
├─ skills/
│  ├─ unit-testing/
│  │  ├─ SKILL.md
│  │  └─ scripts/
│  │     ├─ pytest-runner.py        # Runner tests Python
│  │     └─ jest-runner.js          # Runner tests JavaScript
│  │
│  ├─ e2e-testing/
│  │  ├─ SKILL.md
│  │  └─ scripts/
│  │     ├─ playwright-suite.js     # Tests E2E navigateur
│  │     └─ api-tests.py            # Tests API
│  │
│  └─ load-testing/
│     ├─ SKILL.md
│     └─ scripts/
│        ├─ locust-benchmark.py     # Load testing
│        └─ k6-script.js             # Stress testing
│
├─ scripts/
│  ├─ setup-test-env.sh             # Setup environnement test
│  ├─ run-all-tests.sh              # Exécution complète
│  └─ generate-report.py            # Génération rapports
│
├─ CLAUDE.md
│  # QA Automation Expert
│
│  Tu es un expert QA automation. Tes priorités :
│
│  **Testing Pyramid**:
│  - 70% Unit tests (rapides, isolés)
│  - 20% Integration tests (services)
│  - 10% E2E tests (workflows complets)
│
│  **Quality Standards**:
│  - Coverage minimum : 80% (lignes), 70% (branches)
│  - Tests isolés (pas de dépendances externes)
│  - Fast feedback (< 5 min suite complète)
│  - Clear test names (given-when-then)
│
│  **CI/CD Integration**:
│  - Tests automatiques sur chaque PR
│  - Bloquer merge si tests fail
│  - Performance regression detection
│  - Security scans intégrés
│
└─ README.md
```

### 🔄 Workflow Test Complet

```
    /test --full
         │
         ▼
┌────────────────────┐
│ Agent:             │
│ Test Coordinator   │
└────────┬───────────┘
         │
    ┌────┴────┬────────────┬──────────┐
    │         │            │          │
    ▼         ▼            ▼          ▼
┌───────┐ ┌────────┐ ┌─────────┐ ┌────────┐
│ Skill │ │ Skill  │ │ Skill   │ │ Script │
│ Unit  │ │ E2E    │ │ Load    │ │ Report │
│ Tests │ │ Tests  │ │ Tests   │ │ Gen    │
└───┬───┘ └───┬────┘ └────┬────┘ └───┬────┘
    │         │           │          │
    └─────────┴───────────┴──────────┘
              │
              ▼
       ╔═════════════════╗
       ║  TEST PYRAMID   ║
       ╚═════════════════╝
              │
        ┌─────┴─────┐
        │           │
        ▼           ▼
    ✅ PASS     ❌ FAIL
        │           │
        │           └─► 📧 Alert team
        │           └─► 🚫 Block merge
        │
        └─► 📊 Coverage report
        └─► 📈 Performance metrics
        └─► ✅ CI check pass
```

### 📄 Exemple : commands/run-tests.md

```markdown
---
name: test
description: Lance suite de tests complète
---

# Test Command

Exécute tests selon stratégie définie.

## Usage

/test [--unit|--integration|--e2e|--full] [--watch]

## Test Pyramid

```
         /\
        /  \  E2E (10%)
       /────\  → Playwright, Selenium
      /  🔹  \  Integration (20%)
     /────────\  → API tests, DB tests
    /   🔹🔹   \  Unit (70%)
   /────────────\  → Jest, Pytest
  /_____🔹🔹🔹____\
```

## Steps

1. **Pre-checks**
   - Lint code (ESLint, Ruff)
   - Type check (TypeScript, mypy)
   - Format (Prettier, Black)

2. **Unit Tests** (parallélisés)
   - Jest (JavaScript/TypeScript)
   - Pytest (Python)
   - Coverage ≥ 80%

3. **Integration Tests**
   - API endpoints
   - Database queries
   - Service communications

4. **E2E Tests** (si --full)
   - User workflows
   - Cross-browser (Chrome, Firefox, Safari)
   - Mobile responsive

5. **Reports**
   - Coverage HTML
   - Performance benchmarks
   - Screenshots E2E failures

## Exemple

```bash
/test --full
# → 🔍 Running lint... ✅
# → 🔍 Type checking... ✅
# → 🧪 Unit tests: 1,247 passed (98.2% coverage) ✅
# → 🔗 Integration tests: 89 passed ✅
# → 🌐 E2E tests: 23 passed ✅
# → 📊 Total: 1,359 tests in 4m 32s
# → 📈 Coverage: 98.2% lines, 94.1% branches
# → 🎉 All tests passed!
```

**Watch mode** :
```bash
/test --unit --watch
# → 👀 Watching for changes...
# → 🔄 Re-running tests on file save
```
\```

---

## 🎓 Points Clés

### ✅ Patterns Communs

**Tous les plugins production-ready partagent** :

1. **Structure Cohérente**
   - `plugin.json` complet avec metadata
   - README.md détaillé
   - CHANGELOG.md versionné
   - CLAUDE.md avec guidelines

2. **Composants Modulaires**
   - Commands pour actions user
   - Agents pour orchestration
   - Skills pour expertise domaine
   - Hooks pour automation
   - MCP pour intégrations externes

3. **Sécurité Intégrée**
   - Hooks bloquants pour actions destructives
   - Variables d'environnement pour secrets
   - Validation inputs utilisateur
   - Logging actions critiques

4. **Testing & Quality**
   - Tests automatiques
   - Validation pre-commit
   - CI/CD integration
   - Monitoring production

5. **Documentation**
   - Exemples concrets dans commands
   - Guidelines claires dans CLAUDE.md
   - README avec quick start
   - CHANGELOG avec breaking changes

### 📊 Comparaison des 3 Cas

| Aspect | DevOps Toolkit | Data Platform | Testing Suite |
|--------|---------------|---------------|---------------|
| **Focus** | Infrastructure & deployment | Data pipelines & ML | Quality & testing |
| **Commands** | 5 (deploy, rollback, etc.) | 5 (ingest, transform, etc.) | 5 (test, coverage, etc.) |
| **Agents** | 4 (deployment, incident, etc.) | 4 (orchestrator, quality, etc.) | 3 (coordinator, hunter, etc.) |
| **Skills** | 2 (kubernetes, monitoring) | 3 (ETL, validation, ML-Ops) | 3 (unit, E2E, load) |
| **MCP Servers** | 3 (Datadog, PagerDuty, K8s) | 3 (Snowflake, Databricks, Postgres) | 0 (standalone) |
| **Hooks** | 2 (safety checks) | 2 (DB protection) | 0 (CI handles) |
| **Complexité** | 🟠 Moyenne-Haute | 🔴 Haute | 🟡 Moyenne |
| **Users** | DevOps engineers | Data engineers | QA engineers |

### 🚀 Prochaines Étapes

1. **Choisir un cas d'usage** adapté à votre domaine
2. **Cloner la structure** en adaptant à vos besoins
3. **Commencer simple** (quelques commands + 1 agent)
4. **Itérer progressivement** (ajouter skills, hooks, MCP)
5. **Tester en local** avec marketplace locale
6. **Partager avec équipe** via GitHub/Git marketplace

---

## 📚 Ressources

- **[Guide Plugins](./guide.md)** - Documentation complète
- **[Cheatsheet](./cheatsheet.md)** - Référence rapide

**Repos Exemples** :
- DevOps : https://github.com/exemple/devops-toolkit
- Data : https://github.com/exemple/data-platform
- Testing : https://github.com/exemple/testing-suite

---

**Version** : 1.0.0
**Dernière mise à jour** : 2025-11-06
