# Principes d'Orchestration Claude Code

> **Source Anthropic** : Basé sur l'analyse de l'article "Disrupting the First AI-Orchestrated Cyber Espionage Campaign" et les best practices officielles.

## 📚 Vue d'Ensemble

Ce document établit les **règles fondamentales** pour orchestrer Commands, Subcommands, Agents, Skills, Hooks et MCP selon les standards Anthropic 2025.

**Objectif** : Créer des workflows auditables, scalables et sécurisés en respectant une hiérarchie stricte.

---

## 🎯 Règles d'Or Anthropic

### Règle 1 : COMMAND Orchestre Toujours

```
✅ CORRECT : Command → Agent
✅ CORRECT : Command → Subcommand → Agent
❌ INTERDIT : Agent → Agent
❌ INTERDIT : Agent → Command
❌ INTERDIT : Agent → Subagent
```

**Pourquoi** :
- **Auditabilité** : Tous les flux partent d'un point central identifiable
- **Monitoring** : Supervision centralisée des exécutions
- **Contrôle** : Décisions stratégiques au niveau Command uniquement
- **Clarté** : Pas de logique cachée dans les agents

**Citation Anthropic** :
> "Subagents cannot spawn other subagents; prevents infinite nesting of agents"

---

### Règle 2 : Hiérarchie Plate (Flat Hierarchy)

```
╔═══════════════════════════════════════════════════════════╗
║               HIÉRARCHIE ANTHROPIC VALIDE                 ║
╚═══════════════════════════════════════════════════════════╝

NIVEAU 1 : MAIN COMMAND (Orchestrateur principal)
             │
             ├──> NIVEAU 2 : SUBCOMMAND 1
             │              ├──> AGENT A
             │              ├──> AGENT B
             │              └──> AGENT C
             │
             ├──> NIVEAU 2 : SUBCOMMAND 2
             │              ├──> AGENT D
             │              └──> AGENT E
             │
             └──> NIVEAU 2 : SUBCOMMAND 3
                            ├──> AGENT F
                            └──> AGENT G
```

**Structure maximale recommandée** :
```
LEVEL 1: Main Command
  └─> LEVEL 2: Subcommand
       └─> LEVEL 3: Agent (feuille, pas de délégation)
```

**Anti-pattern (JAMAIS FAIRE)** :
```
❌ PROFONDEUR EXCESSIVE

Command
 └─> Subcommand
      └─> Agent
           └─> Subagent  ← INTERDIT !
                └─> Sub-subagent  ← INTERDIT !
```

---

### Règle 3 : Agents = Tâches Atomiques

**Définition Agent** :
- Exécute **UNE seule tâche** bien définie
- Ne prend **AUCUNE décision stratégique**
- Ne lance **JAMAIS** d'autres agents ou commands
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

**Types de Hooks** :

```
┌─────────────────────────────────────────────────────────┐
│                   HOOKS ANTHROPIC                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  🔍 VALIDATION HOOKS                                    │
│     ├─> Quality-Gate (coverage, bugs, perf)            │
│     ├─> Format-Checker (schema, structure)             │
│     └─> Completeness-Check (tous champs requis)        │
│                                                         │
│  🎯 DECISION HOOKS                                      │
│     ├─> Severity-Decision (P1/P2/P3 routing)           │
│     ├─> Approval-Gate (human-in-loop)                  │
│     └─> Branching-Logic (A/B path selection)           │
│                                                         │
│  📊 MONITORING HOOKS                                    │
│     ├─> Logging (audit trail)                          │
│     ├─> Metrics (timing, success rate)                 │
│     └─> Alert-Ingestion (normalize events)             │
│                                                         │
│  🔧 EXECUTION HOOKS                                     │
│     ├─> PreProcess (data preparation)                  │
│     ├─> PostProcess (cleanup, aggregation)             │
│     └─> Parallel-Execution (launch batch)              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Placement Stratégique** :

```
Command
  ├─> HOOK: PreProcess
  ├─> Subcommand 1
  │     ├─> Agent A
  │     └─> Agent B
  ├─> HOOK: Validation (vérifie outputs A+B)
  ├─> Subcommand 2
  │     └─> Agent C
  ├─> HOOK: Quality-Gate (décision go/no-go)
  └─> HOOK: PostProcess (rapport final)
```

**Codes de Retour Hooks** :
- `0` : OK, continue
- `1` : Warning, continue avec log
- `2` : Block, arrête le workflow

---

### Règle 5 : Skills pour Économie de Contexte

**Définition Skill** :
- Base de connaissances partagée entre agents
- Évite la duplication de context
- Maintient la cohérence (brand voice, guidelines)

```
╔═══════════════════════════════════════════════════════════╗
║              SKILLS : SHARED KNOWLEDGE                    ║
╚═══════════════════════════════════════════════════════════╝

.claude/skills/
├── translation-memory.md      ← Glossaires, termes validés
├── corporate-voice.md         ← Ton, style, guidelines
├── threat-intelligence.md     ← IOCs, CVEs, TTPs
└── coding-standards.md        ← Best practices tech

Command/Agent accède aux skills → économie contexte
```

**Pattern d'Usage** :

```
Agent Legal-Analyzer
  │
  ├─> SKILL: Legal-KB (jurisprudence, clauses)
  ├─> SKILL: Corporate-Voice (formulations validées)
  │
  └─> Analyse document + applique connaissances → Output
```

**Bénéfices** :
- ✅ 10-50x moins de tokens (pas de répétition contexte)
- ✅ Cohérence garantie entre agents
- ✅ Mise à jour centralisée (1 skill → tous agents)

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

### ❌ Anti-Pattern 1 : Agent Lance Agent

```
❌ INTERDIT

.claude/agents/orchestrator-agent.md

Execute these tasks:
1. Launch Legal-Agent
2. Launch Tech-Agent
3. Aggregate results

→ PROBLÈME : Agent fait de l'orchestration = rôle Command !
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

```
┌─────────────────────────────────────────────────────────┐
│              DASHBOARD MONITORING                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  📊 Workflow: RFP-Orchestrator                          │
│                                                         │
│  Progress: ████████████░░░░░░░░░░ 60%                  │
│                                                         │
│  ✅ Analysis Phase    : Completed (2m 30s)              │
│  🔄 Writing Phase     : In Progress (3/5 agents done)   │
│  ⏳ Review Phase      : Pending                         │
│                                                         │
│  Agents:                                                │
│    ✅ Legal-Analyzer   : Success (145s)                 │
│    ✅ Tech-Analyzer    : Success (98s)                  │
│    ✅ Finance-Analyzer : Success (110s)                 │
│    🔄 Content-Writer   : Running (45s elapsed)          │
│    ⏳ Pricing-Calc     : Queued                         │
│                                                         │
│  Hooks:                                                 │
│    ✅ Validation       : Pass (0 errors)                │
│    ⏳ Format           : Pending                        │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Implémentation** :
- Hook PostToolUse pour chaque agent → log metrics
- Dashboard temps réel (WebSocket, Server-Sent Events)
- Alertes si timeout ou errors

---

### 3. Gestion d'Erreurs Robuste

```
┌─────────────────────────────────────────────────────────┐
│            ERROR HANDLING STRATEGY                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Agent Error                                            │
│    │                                                    │
│    ├─> Retry (max 3x) avec exponential backoff         │
│    │     │                                              │
│    │     ├─> Success → Continue                        │
│    │     └─> Fail → Fallback Strategy                  │
│    │                  │                                 │
│    │                  ├─> Use Cached Result            │
│    │                  ├─> Use Default Value            │
│    │                  ├─> Skip (if non-critical)       │
│    │                  └─> Escalate to Human            │
│    │                                                    │
│    └─> Log Error + Context (stack, input, config)      │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Code Example** :

```yaml
# .claude/agents/api-caller.md

Error Handling:
1. Retry 3x with backoff (1s, 2s, 4s)
2. If fail → fallback to cached data (if <1h old)
3. If no cache → return default empty result
4. Log error to .claude/logs/errors.jsonl
5. If critical → trigger HOOK: Human-Escalation
```

---

### 4. Resource Management

```
╔═══════════════════════════════════════════════════════════╗
║           RESOURCE LIMITS ANTHROPIC                       ║
╚═══════════════════════════════════════════════════════════╝

COMMAND Level:
  ├─> Max Parallel Agents: 20 (évite saturation API)
  ├─> Max Total Duration: 30min (timeout global)
  ├─> Max Context Tokens: 200k (Claude 3.5 Sonnet limit)
  └─> Max Retries: 3 per agent

AGENT Level:
  ├─> Max Duration: 5min (timeout individuel)
  ├─> Max Output Size: 10MB
  └─> Max API Calls: 100 (évite boucles infinies)

HOOK Level:
  ├─> Max Duration: 30s (validation rapide)
  └─> Timeout → Auto-Approve (fail-open strategy)
```

---

### 5. Security & Compliance

```
┌─────────────────────────────────────────────────────────┐
│              SECURITY CHECKLIST                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ✅ Input Validation                                    │
│     └─> Hook: Schema-Validation (reject malformed)     │
│                                                         │
│  ✅ Output Sanitization                                 │
│     └─> Hook: Format-Checker (strip PII if needed)     │
│                                                         │
│  ✅ Access Control                                      │
│     └─> MCP: Role-Based Access (agents can't sudo)     │
│                                                         │
│  ✅ Secrets Management                                  │
│     └─> MCP: 1Password/Vault (jamais hardcodé)         │
│                                                         │
│  ✅ Audit Trail                                         │
│     └─> Logs JSONL immutables (append-only)            │
│                                                         │
│  ✅ Human Approval                                      │
│     └─> Hook: Sign-Off sur actions critiques           │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

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

✅ **COMMAND orchestre, AGENT exécute**
- Jamais agent → agent ou agent → command

✅ **Hiérarchie plate (3 niveaux max)**
- Main Command → Subcommand → Agent

✅ **Agents atomiques**
- 1 agent = 1 tâche unique et bien définie

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
