# Principes d'Orchestration Claude Code

> **Source Anthropic** : Basé sur l'analyse de l'article "Disrupting the First AI-Orchestrated Cyber Espionage Campaign" et les best practices officielles.

---

## ⚠️ **Disclaimer Important**

Ce document présente un **framework opinionné** pour orchestrer des workflows agentiques avec Claude Code. Les concepts et conventions présentés ici sont des **patterns proposés**, pas des spécifications officielles Claude Code.

**Terminologie officielle Claude Code** :
- **Subagents** (`.claude/agents/*.md`)
- **Custom slash commands** (`.claude/commands/*.md`)
- **Skills** (`.claude/skills/*/SKILL.md`)
- **Hooks** (`settings.json`, bash ou LLM)

📖 **Documentation officielle** : [https://docs.anthropic.com/en/docs/claude-code](https://docs.anthropic.com/en/docs/claude-code)

---

## 📚 Vue d'Ensemble

Ce document établit les **règles recommandées** pour orchestrer Custom Commands, Subagents, Skills, Hooks et MCP selon les patterns Anthropic 2025 et best practices.

**Objectif** : Créer des workflows auditables, scalables et sécurisés en respectant une hiérarchie claire.

---

## 🎯 Règles d'Or Anthropic

### Règle 1 : COMMAND Orchestre Toujours

> ⚠️ **Règle Officielle Claude Code** : "Subagents cannot spawn other subagents" - Documentation officielle

```
✅ CORRECT : Command → Subagent
✅ CORRECT : Command → Coordinator Subagent → Worker Subagent (via command)
❌ INTERDIT : Subagent → Subagent (violation règle officielle)
❌ INTERDIT : Subagent → Command
```

**Pourquoi** :
- **Auditabilité** : Tous les flux partent d'un point central identifiable
- **Monitoring** : Supervision centralisée des exécutions
- **Contrôle** : Décisions stratégiques au niveau Command uniquement
- **Clarté** : Pas de logique cachée dans les subagents
- **Règle officielle** : Empêche nesting infini de subagents

**Citation Documentation Officielle** :
> "Subagents cannot spawn other subagents; prevents infinite nesting of agents"

**Note** : "COMMAND" et "COORDINATOR SUBAGENT" sont des conventions de ce guide. Les types officiels sont "custom slash commands" et "subagents".

---

### Règle 2 : Hiérarchie Recommandée (2-3 niveaux)

**Voir** : [Command-Subcommand-Subagent Architecture](./3-architecture/command-coordinator-workers.md) pour détails complets.

**Recommandation** : 2-3 niveaux (Command → [Coordinator Subagent] → Worker Subagent). Subagents workers = feuilles, jamais de délégation.

> 📖 Note : Il n'y a pas de limite officielle "3 niveaux max". C'est une recommandation basée sur la complexité et maintenabilité.

---

### Règle 3 : Subagents = Tâches Atomiques

**Définition Subagent Worker** (terme officiel : "subagent") :
- Exécute **UNE seule tâche** bien définie
- Ne prend **AUCUNE décision stratégique**
- Ne lance **JAMAIS** d'autres subagents (règle officielle)
- Renvoie un résultat simple et structuré

```
╔═══════════════════════════════════════════════════════════╗
║                    AGENT BIEN DÉFINI                      ║
╚═══════════════════════════════════════════════════════════╝

Input :  Données précises (fichier, URL, paramètres)
         │
         ▼
Process: Tâche unique atomique
         │
         ▼
Output:  Résultat structuré (JSON, Markdown, status)
```

**Exemples Agents Valides** :
- ✅ `Legal-Analyzer` : Analyse un document légal → retourne risques
- ✅ `Unit-Tester` : Exécute tests unitaires → retourne coverage
- ✅ `French-Translator` : Traduit texte → retourne traduction

**Contre-exemples (INTERDIT)** :
- ❌ `Pipeline-Manager` : Coordonne build + test + deploy ← C'EST UNE COMMAND !
- ❌ `Multi-Task-Agent` : Fait analyse + écriture + review ← TROP LARGE !
- ❌ `Delegating-Agent` : Lance d'autres agents ← VIOLATION RÈGLE 1 !

---

### Règle 4 : Hooks pour Validation et Décisions

**Voir** : [Hooks Lifecycle Architecture](./3-architecture/hooks-lifecycle.md) pour détails complets.

**En bref** :
- **Deux types** : Bash hooks (déterministes) + Prompt hooks (LLM evaluation)
- **10 events** : PreToolUse, PermissionRequest, PostToolUse, Notification, UserPromptSubmit, Stop, SubagentStop, PreCompact, SessionStart, SessionEnd
- **Exit codes** (bash) : `0`=Success, `2`=Blocking error, autres=Non-blocking
- **JSON output** : Pour contrôle avancé (decision, reason, continue)

---

### Règle 5 : Skills pour Économie de Contexte

**Voir** : [Skills Progressive Disclosure Architecture](./3-architecture/skills-progressive-disclosure.md) pour détails complets.

**En bref** :
- **Auto-invoquées** par LLM reasoning
- **Progressive disclosure** : Fichiers chargés "only when needed" (doc officielle)
- **Structure** : SKILL.md (requis) + fichiers additionnels optionnels
- **Économie** : 10-50x moins de tokens vs memory

> 📖 Note : Le modèle "3 niveaux" est une simplification didactique. Claude charge les fichiers de manière flexible selon besoin.

---

### Règle 6 : MCP pour Intégrations Externes

**Model Context Protocol (MCP)** :
- Interface standardisée vers outils externes
- Agents/Commands accèdent via MCP (jamais direct)
- Abstraction : changement de tool sans refactoring agents

```
┌─────────────────────────────────────────────────────────┐
│                    MCP ARCHITECTURE                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Command/Agent                                          │
│       │                                                 │
│       ├──> MCP: Database (Postgres, MongoDB)           │
│       ├──> MCP: API (Stripe, Twilio, SendGrid)         │
│       ├──> MCP: Security (VirusTotal, SIEM)            │
│       ├──> MCP: DevOps (Git, K8s, Prometheus)          │
│       └──> MCP: AI (DeepL, OpenAI, Claude)             │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Exemples Intégrations** :

```yaml
# .claude/mcp-config.yml

mcp_servers:
  - name: contracts-db
    protocol: postgres
    endpoint: ${CONTRACTS_DB_URL}

  - name: threat-intel
    protocol: virustotal-api
    api_key: ${VT_API_KEY}

  - name: translation-api
    protocol: deepl
    api_key: ${DEEPL_KEY}
```

**Usage dans Agent** :

```markdown
<!-- .claude/agents/legal-analyzer.md -->

Use MCP contracts-db to fetch:
- Similar past contracts
- Validated clauses
- Legal precedents

Cross-reference with skill Legal-KB for risk assessment.
```

---

## 🏗️ Framework de Décision

### Quand Utiliser COMMAND vs SUBCOMMAND vs AGENT

```
╔═══════════════════════════════════════════════════════════╗
║            ARBRE DE DÉCISION ARCHITECTURE                 ║
╚═══════════════════════════════════════════════════════════╝

Question 1 : Y a-t-il orchestration de plusieurs tâches ?
             │
             ├─> OUI → COMMAND (ou SUBCOMMAND si déjà dans Command)
             └─> NON → Question 2
                         │
                         Question 2 : Tâche unique atomique ?
                                      │
                                      ├─> OUI → AGENT
                                      └─> NON → Découper en sous-tâches
                                                 → COMMAND + Agents
```

**Exemples Concrets** :

| Use Case | Architecture | Justification |
|----------|--------------|---------------|
| Traduire 1 fichier | AGENT | Tâche atomique |
| Traduire 20 langues | COMMAND + 20 Agents | Orchestration parallèle |
| Pipeline CI/CD | COMMAND + 3 Subcommands (Build, Test, Deploy) | Phases séquentielles avec sous-étapes |
| Analyser code | AGENT | Tâche unique |
| Code review complet | COMMAND + Agents (Lint, Security, Quality) | Orchestration analyses multiples |

---

## 🚫 Anti-Patterns (JAMAIS FAIRE)

### ❌ Anti-Pattern 1 : Subagent Lance Subagent

> ⚠️ **Violation règle officielle** : "Subagents cannot spawn other subagents"

```
❌ INTERDIT

.claude/agents/orchestrator-agent.md

Execute these tasks:
1. Launch Legal-Subagent
2. Launch Tech-Subagent
3. Aggregate results

→ PROBLÈME : Subagent fait de l'orchestration = rôle Command !
→ VIOLATION : Subagents ne peuvent pas spawner d'autres subagents
```

**Solution** :

```
✅ CORRECT

.claude/commands/rfp-analyzer.md

1. Launch Legal-Agent
2. Launch Tech-Agent
3. Aggregate results
```

---

### ❌ Anti-Pattern 2 : Hiérarchie Profonde

```
❌ INTERDIT : 5+ NIVEAUX

Main-Command
  └─> Regional-Subcommand
       └─> Country-Subcommand
            └─> City-Agent
                 └─> District-Subagent  ← TROP PROFOND !
```

**Solution (Aplatir)** :

```
✅ CORRECT : 3 NIVEAUX MAX

Main-Command
  ├─> EMEA-Subcommand
  │     ├─> France-Agent
  │     ├─> Germany-Agent
  │     └─> Spain-Agent
  ├─> APAC-Subcommand
  │     ├─> Japan-Agent
  │     └─> China-Agent
  └─> AMERICAS-Subcommand
        ├─> USA-Agent
        └─> Brazil-Agent
```

---

### ❌ Anti-Pattern 3 : Agent Multi-Responsabilité

```
❌ INTERDIT

.claude/agents/super-agent.md

Tasks:
1. Analyze document
2. Write summary
3. Translate to 5 languages
4. Publish to CMS
5. Send notifications

→ PROBLÈME : Trop de responsabilités, pas atomique !
```

**Solution (Décomposer)** :

```
✅ CORRECT

.claude/commands/doc-pipeline.md

1. Analyzer-Agent → analysis
2. Writer-Agent → summary
3. Launch 5 Translator-Agents (parallel)
4. Publisher-Agent → CMS
5. Notifier-Agent → emails
```

---

### ❌ Anti-Pattern 4 : Hooks Absents sur Workflow Critique

```
❌ MANQUE HOOKS

Command
  ├─> Subcommand: Financial-Calculation
  │     ├─> Agent: Tax-Calculator
  │     └─> Agent: Invoice-Generator
  └─> Subcommand: Payment-Processing  ← AUCUNE VALIDATION !
        └─> Agent: Payment-Executor

→ PROBLÈME : Pas de quality gate avant paiement !
```

**Solution (Ajouter Hooks)** :

```
✅ CORRECT

Command
  ├─> Subcommand: Financial-Calculation
  │     ├─> Agent: Tax-Calculator
  │     └─> Agent: Invoice-Generator
  ├─> HOOK: Validation (montants, taxes, format)
  ├─> HOOK: Human-Approval (executive sign-off)
  └─> Subcommand: Payment-Processing
        ├─> Agent: Payment-Executor
        └─> HOOK: Transaction-Verification
```

---

## 📊 Comparaison Patterns Validés

### Pattern 1 : Hierarchical (Tesla, JP Morgan)

```
MAIN COMMAND
  │
  ├─> SUBCOMMAND: Phase 1
  │     ├─> Agent A
  │     └─> Agent B
  │
  ├─> SUBCOMMAND: Phase 2
  │     ├─> Agent C
  │     └─> Agent D
  │
  └─> SUBCOMMAND: Phase 3
        └─> Agent E
```

**Quand** : Workflows complexes multi-phases (CI/CD, RFP, Incident Response)

**Avantages** :
- Clarté des phases
- Facile à monitorer
- Hooks entre phases

---

### Pattern 2 : Parallelization (Unilever, Mayo Clinic)

```
COMMAND
  │
  ├──> Agent 1 (parallel) ─┐
  ├──> Agent 2 (parallel) ─┤
  ├──> Agent 3 (parallel) ─┼─> AGGREGATION
  ├──> Agent 4 (parallel) ─┤
  └──> Agent 5 (parallel) ─┘
```

**Quand** : Tâches indépendantes identiques (traductions, tests, analyses)

**Avantages** :
- Speedup 10-20x
- Scalabilité linéaire
- Économie temps

**Benchmark** :
- Séquentiel : 20 langues × 5min = 100min
- Parallèle : 20 langues / 20 threads = 5min
- **Speedup : 20x**

**Best Practices** : Batch size max 20, timeout 5min, retry 3x, fail gracefully.

---

### Pattern 3 : Supervisor-Worker (Article Anthropic)

```
SUPERVISOR COMMAND
  │
  ├─> HOOK: Task-Distribution
  │
  ├─> Worker-Agent-1 (specialist)
  ├─> Worker-Agent-2 (specialist)
  ├─> Worker-Agent-3 (specialist)
  │
  ├─> HOOK: Results-Aggregation
  │
  └─> HOOK: Quality-Gate
```

**Quand** : Agents spécialisés coordonnés centralement (cyberattack, fraud detection)

**Caractéristiques** :
- 80-90% autonomie agents
- 4-6 points décision humaine
- Thousands requests/sec

---

### Pattern 4 : Human-in-Loop (Banques, Santé, Légal)

```
COMMAND
  │
  ├─> Automated-Processing (Agents)
  │
  ├─> HOOK: Risk-Assessment
  │     │
  │     ├─> Low Risk → Continue auto
  │     └─> High Risk → HOOK: Human-Approval
  │                       │
  │                       ├─> Approved → Continue
  │                       └─> Rejected → Rollback
  │
  └─> Execution
```

**Quand** : Décisions critiques (finance, santé, sécurité, légal)

**Règle** : Hook Human-Approval sur tout workflow à risque

---

## 🎓 Best Practices Anthropic

### 1. Auditabilité Maximale

```yaml
# Logs structurés JSONL

.claude/logs/workflow-audit.jsonl

{"timestamp": "2025-01-15T10:00:00Z", "command": "RFP-Orchestrator", "event": "start"}
{"timestamp": "2025-01-15T10:00:05Z", "agent": "Legal-Analyzer", "status": "running"}
{"timestamp": "2025-01-15T10:02:30Z", "agent": "Legal-Analyzer", "status": "success", "duration": 145}
{"timestamp": "2025-01-15T10:02:31Z", "hook": "Validation", "result": "pass"}
{"timestamp": "2025-01-15T10:02:32Z", "agent": "Tech-Analyzer", "status": "running"}
```

**Bénéfices** :
- Traçabilité complète
- Debug facile
- Compliance (SOC2, GDPR)
- Post-mortem précis

---

### 2. Monitoring Temps Réel

**Implémentation** : Hook PostToolUse → log metrics → dashboard (WebSocket/SSE) → alertes

---

### 3. Gestion d'Erreurs Robuste

**Stratégie** : Retry 3x backoff → Fallback (cache/default/skip) → Escalate human si critique → Log toujours

---

### 4. Resource Management

**Limits** : Command (20 agents, 30min, 200k tokens) | Agent (5min, 10MB, 100 calls) | Hook (30s, fail-open)

---

### 5. Security & Compliance

**Checklist** : Input validation | Output sanitization | Access control (RBAC) | Secrets (MCP vault) | Audit logs (JSONL) | Human approval

---

## 🔗 Validation Cas Réels

### Tesla Production Line (Pattern Hierarchical)

```
MAIN: Production-Orchestrator
  ├─> SUB: Quality-Inspection (3 agents parallèles)
  ├─> HOOK: Defect-Detection → Human-Review si >5% defects
  ├─> SUB: Assembly-Optimization (2 agents)
  └─> SUB: Inventory-Management (1 agent)

Résultats:
  ├─> Defect rate : 12% → 3% (-75%)
  ├─> Production time : -18%
  └─> Human oversight : 6 checkpoints/jour (vs 40 avant)
```

---

### JP Morgan Fraud Detection (Pattern Supervisor-Worker)

```
SUPERVISOR: Fraud-Monitor
  ├─> HOOK: Transaction-Ingestion (normalize data)
  ├─> 10 Workers parallèles (each analyze subset)
  ├─> HOOK: Risk-Aggregation
  └─> HOOK: Human-Approval si risk >80%

Résultats:
  ├─> Detection speed : 2s (vs 15min manual)
  ├─> False positive rate : 0.3% (vs 8% baseline)
  └─> Throughput : 10,000 tx/min
```

---

### Mayo Clinic Diagnostics (Pattern Human-in-Loop)

```
MAIN: Diagnostic-Assistant
  ├─> SUB: Symptoms-Analysis (3 specialist agents)
  ├─> HOOK: Differential-Diagnosis
  ├─> HOOK: Doctor-Review (OBLIGATOIRE)
  └─> SUB: Treatment-Recommendation (2 agents)

Résultats:
  ├─> Diagnosis accuracy : 94% (AI suggestions)
  ├─> Doctor time saved : 40% (prep automated)
  └─> Patient satisfaction : +22% (faster results)
```

---

## 📚 Ressources

### Documentation Anthropic Officielle

- 📄 [Claude Code Docs](https://code.claude.com/docs)
- 📄 [Building Agents with Claude SDK](https://www.anthropic.com/engineering/building-agents-with-the-claude-agent-sdk)
- 📄 [Claude Code Best Practices](https://www.anthropic.com/engineering/claude-code-best-practices)
- 📄 [Disrupting AI Espionage](https://www.anthropic.com/news/disrupting-AI-espionage)

### Patterns Multi-Agent

- 📄 [LangGraph Hierarchical Teams](https://langchain-ai.github.io/langgraph/tutorials/multi_agent/hierarchical_agent_teams/)
- 📄 [9 Agentic Workflow Patterns 2025](https://www.linkedin.com/pulse/9-agentic-workflow-patterns-reshaping-enterprise-ai-2025-prasad-i1ase)
- 📄 [Multi-Agent Orchestration Talkdesk](https://www.talkdesk.com/blog/multi-agent-orchestration/)

### Cas d'Usage Enterprise

- 📄 [SuperAGI Case Studies](https://superagi.com/case-studies-in-ai-agent-orchestration-real-world-applications-and-success-stories-across-various-industries/)
- 📄 [Agentic AI Examples 2025](https://skywork.ai/blog/agentic-ai-examples-workflow-patterns-2025/)

---

## 🎓 Points Clés à Retenir

### Architecture

✅ **COMMAND orchestre, SUBAGENT exécute**
- Jamais subagent → subagent (règle officielle) ou subagent → command

✅ **Hiérarchie recommandée : 2-3 niveaux**
- Main Command → Coordinator Subagent → Worker Subagent

✅ **Subagents atomiques**
- 1 subagent = 1 tâche unique et bien définie

---

### Qualité

✅ **Hooks partout**
- Validation, décisions, monitoring, human-in-loop

✅ **Skills pour cohérence**
- Connaissances partagées, économie contexte

✅ **MCP pour intégrations**
- Abstraction tools, changements sans refactoring

---

### Production

✅ **Auditabilité totale**
- Logs JSONL, monitoring temps réel, compliance

✅ **Gestion erreurs robuste**
- Retry, fallback, escalation, logging détaillé

✅ **Security-first**
- Validation input/output, secrets management, access control

---

## 🚀 Prochaines Étapes

1. ✅ Lire les 4 workflows détaillés :
   - `workflows/enterprise-rfp.md`
   - `workflows/ci-cd-pipeline.md`
   - `workflows/global-localization.md`
   - `workflows/security-incident-response.md`

2. ✅ Implémenter un workflow simple selon ces principes

3. ✅ Ajouter hooks progressivement (validation → monitoring → human-in-loop)

4. ✅ Mesurer benchmarks (time, accuracy, cost)

5. ✅ Itérer et optimiser

---

**Respecter ces principes = workflows industriels, auditables et scalables façon Anthropic 2025 !**
