# Best Practices : Cost Optimization

> **Objectif** : Réduire les coûts d'orchestration AI de 90%+ tout en maintenant qualité et performance.

## 📚 Vue d'Ensemble

**Problème Résolu** :
Les workflows d'orchestration AI peuvent rapidement devenir coûteux avec des millions de tokens consommés, des appels API redondants, et des processus inefficaces. Sans optimisation, un workflow peut coûter 10-100x plus cher que nécessaire.

**Impact Business** :
- **Réduction coûts** : 90-98% d'économies possibles
- **ROI amélioré** : Payback en jours au lieu de mois
- **Scalabilité** : Capacité à traiter 10-100x plus de workflows avec même budget
- **Compétitivité** : Marges préservées, pricing agressif possible

**Exemples Réels** :
- **RFP Workflow** : $25,500 → $750 (97% économie)
- **Localization** : $800/langue → $12/langue (98.5% économie)
- **CI/CD** : $5,000/release → $150/release (97% économie)

---

## 🎯 Stratégie 1 : Fallback Chains (Local → Cloud)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║              FALLBACK CHAIN STRATEGY                      ║
╚═══════════════════════════════════════════════════════════╝

TIER 1 : LOCAL (Free/Cheap)
         ├─> Cache local (.claude/cache/)
         ├─> Skills (knowledge base)
         └─> MCP: Local files, SQLite
         Cost: $0

TIER 2 : CONTEXT7 (Mid-tier)
         ├─> Library docs (up-to-date)
         └─> Code examples
         Cost: $0.001/query

TIER 3 : PERPLEXITY (Web search)
         ├─> Recent info (recency filter)
         └─> Specific queries
         Cost: $0.01/query

TIER 4 : FIRECRAWL (Heavy scraping)
         ├─> Deep web extraction
         └─> Complex sites
         Cost: $0.10/scrape

TIER 5 : CLAUDE API (Full generation)
         ├─> Complex reasoning
         └─> Last resort
         Cost: $3-15/request
```

### Implémentation YAML

```yaml
# .claude/agents/research-agent.md

---
name: research-agent
description: Researches technical information with cost-optimized fallback chain
---

## INPUT
- Query: {query}
- Max Cost: {max_cost_usd}

## COST-OPTIMIZED RESEARCH STRATEGY

### TIER 1: Local Search (FREE)

1. Check local cache:
   ```bash
   grep -r "{query}" .claude/cache/ --include="*.md"
   ```
   If found → Return cached result
   Cost: $0

2. Consult Skills:
   - SKILL: technical-kb
   - SKILL: documentation-library
   If sufficient → Return from skills
   Cost: $0

3. Query local MCP:
   - MCP: local-files
   - MCP: sqlite-db
   If data available → Return local data
   Cost: $0

### TIER 2: Context7 ($0.001/query)

If local search insufficient:

```yaml
MCP: context7
  - resolve-library-id: {query}
  - get-library-docs:
      library: {resolved_id}
      topic: {query}
      page: 1
```

Cost: $0.001
If found → Return Context7 docs

### TIER 3: Perplexity ($0.01/query)

If Context7 not sufficient:

```yaml
MCP: perplexity
  - search_web:
      query: {query}
      recency: week
```

Cost: $0.01
If found → Return Perplexity results

### TIER 4: Firecrawl ($0.10/scrape)

If Perplexity insufficient and URL known:

```yaml
MCP: firecrawl
  - scrape:
      url: {specific_url}
      formats: [markdown]
```

Cost: $0.10
If successful → Return scraped content

### TIER 5: Full Claude Generation ($3-15/request)

ONLY if all above fail:

Use full Claude reasoning with extended context.
Cost: $3-15

## OUTPUT

Return:
- Result: {data}
- Cost Tier Used: {tier}
- Actual Cost: ${cost}
- Savings vs Tier 5: {percentage}%

## BUDGET TRACKING

Log to .claude/logs/cost-tracking.jsonl:
```json
{
  "timestamp": "2025-01-15T10:00:00Z",
  "agent": "research-agent",
  "query": "{query}",
  "tier_used": 2,
  "cost_usd": 0.001,
  "savings_vs_tier5": 99.97
}
```
```

### Benchmarks Réels

**Exemple : 100 recherches techniques**

| Tier | Requêtes | Coût/req | Total | % du total |
|------|----------|----------|-------|------------|
| Tier 1 (Local) | 40 | $0 | $0 | 40% |
| Tier 2 (Context7) | 30 | $0.001 | $0.03 | 30% |
| Tier 3 (Perplexity) | 20 | $0.01 | $0.20 | 20% |
| Tier 4 (Firecrawl) | 8 | $0.10 | $0.80 | 8% |
| Tier 5 (Claude) | 2 | $5 | $10.00 | 2% |
| **Total** | **100** | | **$11.03** | **100%** |

**Comparaison sans fallback (100% Tier 5)** :
- Coût : 100 × $5 = $500
- **Économie : 97.8%** ($488.97 saved)

---

## 💡 Stratégie 2 : Skill Reuse (Translation Memory)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║           TRANSLATION MEMORY PATTERN                      ║
╚═══════════════════════════════════════════════════════════╝

WITHOUT MEMORY:
  Translate "Dashboard" → API call → $0.001
  Translate "Dashboard" (again) → API call → $0.001
  Translate "Dashboard" (3rd time) → API call → $0.001
  Cost: $0.003 for 3 identical translations

WITH MEMORY (SKILL):
  Translate "Dashboard" → API call → $0.001 → Store in skill
  Translate "Dashboard" (again) → Read skill → $0
  Translate "Dashboard" (3rd time) → Read skill → $0
  Cost: $0.001 (67% savings on 3 translations)

SCALING (1000 translations, 30% duplicates):
  WITHOUT: 1000 × $0.001 = $1.00
  WITH: 700 × $0.001 + 300 × $0 = $0.70
  Savings: 30%

REAL PROJECT (10,000 strings, 50% duplicates):
  WITHOUT: 10,000 × $0.001 = $10.00
  WITH: 5,000 × $0.001 + 5,000 × $0 = $5.00
  Savings: 50%
```

### Implémentation

```markdown
# .claude/skills/translation-memory.md

---
name: translation-memory
description: Validated translations to avoid re-translating identical strings
---

## FRENCH → ENGLISH

### UI Terms
| Source (FR) | Target (EN) | Context | Validated |
|-------------|-------------|---------|-----------|
| Tableau de bord | Dashboard | UI | 2025-01-15 |
| Paramètres | Settings | UI | 2025-01-15 |
| Déconnexion | Sign Out | UI | 2025-01-15 |
| Utilisateur | User | General | 2025-01-15 |
| Mot de passe | Password | Auth | 2025-01-15 |

### Business Terms
| Source (FR) | Target (EN) | Context | Validated |
|-------------|-------------|---------|-----------|
| Contrat | Contract | Legal | 2025-01-15 |
| Facture | Invoice | Finance | 2025-01-15 |
| Devis | Quote | Sales | 2025-01-15 |

### Technical Terms
| Source (FR) | Target (EN) | Context | Validated |
|-------------|-------------|---------|-----------|
| Base de données | Database | Tech | 2025-01-15 |
| Serveur | Server | Tech | 2025-01-15 |
| API | API | Tech | 2025-01-15 |

## USAGE IN AGENTS

```yaml
# .claude/agents/french-translator.md

Before translating:
1. Check SKILL: translation-memory for exact match
2. If found → Use validated translation (FREE)
3. If not found → Translate via API ($) → Add to skill

This creates a growing dictionary that reduces costs over time.
```

## STATISTICS

```
Project Start (Day 1):
  - Memory: 0 entries
  - Hit rate: 0%
  - Cost per string: $0.001

Week 1:
  - Memory: 500 entries
  - Hit rate: 20%
  - Cost per string: $0.0008 (20% savings)

Month 1:
  - Memory: 2,000 entries
  - Hit rate: 40%
  - Cost per string: $0.0006 (40% savings)

Month 3:
  - Memory: 5,000 entries
  - Hit rate: 60%
  - Cost per string: $0.0004 (60% savings)

Year 1:
  - Memory: 10,000 entries
  - Hit rate: 80%
  - Cost per string: $0.0002 (80% savings)
```
```

### Benchmarks Localization Workflow

**Global Localization (20 langues, 5,000 strings)**

Sans Translation Memory :
- Coût : 20 langues × 5,000 strings × $0.001 = $100
- Temps : 20 langues × 5min = 100min

Avec Translation Memory (50% hit rate) :
- Coût : 20 langues × 2,500 strings × $0.001 = $50
- Temps : 20 langues × 3min = 60min (faster lookups)
- **Économie : 50%** ($50 saved)

Projet mature (80% hit rate) :
- Coût : 20 langues × 1,000 strings × $0.001 = $20
- **Économie : 80%** ($80 saved vs baseline)

---

## ⚡ Stratégie 3 : Batch Efficiency

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║              BATCH PROCESSING OPTIMIZATION                ║
╚═══════════════════════════════════════════════════════════╝

INEFFICIENT (1 call per item):
  Item 1 → API Call → $0.01
  Item 2 → API Call → $0.01
  Item 3 → API Call → $0.01
  ...
  Item 100 → API Call → $0.01
  Total: 100 calls × $0.01 = $1.00

EFFICIENT (Batch of 10):
  Batch [Items 1-10] → API Call → $0.05
  Batch [Items 11-20] → API Call → $0.05
  ...
  Batch [Items 91-100] → API Call → $0.05
  Total: 10 calls × $0.05 = $0.50
  Savings: 50%

OPTIMAL BATCH SIZE:
  ├─> Too small (batch=1) : High overhead, many API calls
  ├─> Too large (batch=1000) : Timeout risk, retry cost
  └─> Optimal (batch=10-20) : Balance between efficiency and reliability
```

### Calcul Optimal Batch Size

```
┌─────────────────────────────────────────────────────────┐
│           BATCH SIZE DECISION FRAMEWORK                 │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  SMALL ITEMS (< 100 tokens each):                      │
│    └─> Batch size: 20-50                               │
│        (Examples: translations, classifications)       │
│                                                         │
│  MEDIUM ITEMS (100-500 tokens):                        │
│    └─> Batch size: 10-20                               │
│        (Examples: summaries, extractions)              │
│                                                         │
│  LARGE ITEMS (500-2000 tokens):                        │
│    └─> Batch size: 5-10                                │
│        (Examples: document analysis, code review)      │
│                                                         │
│  VERY LARGE ITEMS (>2000 tokens):                      │
│    └─> Batch size: 1-3                                 │
│        (Examples: full document generation)            │
│                                                         │
│  FORMULA:                                              │
│    optimal_batch_size = min(                           │
│      max_context_window / avg_item_tokens,             │
│      20  // max recommended for reliability            │
│    )                                                   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Implémentation

```yaml
# .claude/hooks/parallel-execution.yml

name: parallel-execution
description: Batch process items with optimal sizing
type: execution

workflow:
  - name: calculate-batch-size
    logic: |
      avg_item_tokens = estimate_tokens(items[0])
      max_context = 200000  # Claude 3.5 Sonnet

      if avg_item_tokens < 100:
        batch_size = min(50, len(items))
      elif avg_item_tokens < 500:
        batch_size = min(20, len(items))
      elif avg_item_tokens < 2000:
        batch_size = min(10, len(items))
      else:
        batch_size = min(3, len(items))

      num_batches = ceil(len(items) / batch_size)

  - name: process-batches
    parallel: true
    batches: |
      for i in range(0, len(items), batch_size):
        batch = items[i:i+batch_size]
        launch_agent(batch_processor, batch)

  - name: aggregate-results
    logic: |
      results = collect_all_batch_results()
      return merge(results)

## EXAMPLE: Translation of 1000 strings

Without batching:
  - API calls: 1000
  - Cost: 1000 × $0.001 = $1.00
  - Time: 1000 × 0.5s = 500s (sequential)

With batching (batch_size=20):
  - API calls: 50
  - Cost: 50 × $0.01 = $0.50 (50% savings)
  - Time: 50 × 2s = 100s (parallel) = 5x faster
```

### Benchmarks

**Traduction 1,000 strings (avg 50 tokens/string)**

| Batch Size | API Calls | Coût | Temps | Savings |
|------------|-----------|------|-------|---------|
| 1 (no batch) | 1000 | $1.00 | 500s | 0% |
| 5 | 200 | $0.60 | 120s | 40% |
| 10 | 100 | $0.50 | 80s | 50% |
| 20 ✅ | 50 | $0.45 | 60s | 55% |
| 50 | 20 | $0.40 | 50s | 60% (mais timeout risk) |

**Optimal : batch_size = 20** (best balance cost/reliability)

---

## 🔍 Stratégie 4 : Token Optimization

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║              TOKEN REDUCTION TECHNIQUES                   ║
╚═══════════════════════════════════════════════════════════╝

VERBOSE PROMPT (Bad):
  "Please analyze this document and provide a comprehensive
   summary of all the key points, making sure to include any
   important details that might be relevant to the reader,
   and organize the information in a clear and logical way."

  Tokens: ~50
  Cost: $0.0005 (input)

CONCISE PROMPT (Good):
  "Summarize key points, prioritize relevance."

  Tokens: ~8
  Cost: $0.00008 (input)
  Savings: 84%

SCHEMA-BASED OUTPUT (Best):
  Output format: JSON schema
  ```json
  {
    "summary": "string (max 200 chars)",
    "key_points": ["string"],
    "priority": "high|medium|low"
  }
  ```

  Prevents verbose responses, saves output tokens.
```

### Techniques Concrètes

#### 1. Prompt Compression

```markdown
❌ VERBOSE (300 tokens)

You are a legal analyst specializing in contract review. Your task
is to carefully analyze the provided legal document and identify
any potential risks, liabilities, or clauses that might be
problematic for our organization. Please pay special attention to
payment terms, liability limitations, termination conditions, and
intellectual property rights. Provide a detailed report with your
findings, organized by category, and include recommendations for
how we should address each identified issue.

✅ CONCISE (80 tokens)

Legal analyst. Analyze contract for risks:
- Payment terms
- Liability limits
- Termination conditions
- IP rights

Output: JSON schema (category, risk_level, recommendation)
```

**Savings : 73% tokens** (220 tokens saved)

#### 2. Schema-Constrained Output

```yaml
# .claude/agents/legal-analyzer.md

## OUTPUT SCHEMA (STRICT)

```json
{
  "risk_score": "number (0-10)",
  "risks": [
    {
      "category": "payment|liability|termination|ip",
      "severity": "critical|high|medium|low",
      "description": "string (max 100 chars)",
      "recommendation": "string (max 150 chars)"
    }
  ],
  "overall_recommendation": "proceed|negotiate|decline"
}
```

DO NOT include explanations, preambles, or verbose descriptions.
ONLY output valid JSON matching this schema.
```

**Impact** :
- Sans schema : 500-1000 tokens output (verbose explanations)
- Avec schema : 100-200 tokens output (structured data only)
- **Savings : 60-80% output tokens**

#### 3. Reference Instead of Repeat

```markdown
❌ BAD (Répétition dans chaque agent)

# Agent 1 prompt
Company background: We are Acme Corp, founded in 2010, specializing
in SaaS solutions for enterprise clients. Our products include...
(500 tokens)

# Agent 2 prompt
Company background: We are Acme Corp, founded in 2010, specializing
in SaaS solutions for enterprise clients. Our products include...
(500 tokens)

Total: 1000 tokens

✅ GOOD (Skill référencé)

# .claude/skills/company-background.md
(500 tokens, stored once)

# Agent 1 prompt
Consult SKILL: company-background
(10 tokens)

# Agent 2 prompt
Consult SKILL: company-background
(10 tokens)

Total: 520 tokens (48% savings)
```

### Benchmarks Token Optimization

**Workflow RFP (3 agents)**

Sans optimization :
- Prompt moyen : 800 tokens/agent
- Output moyen : 1,000 tokens/agent
- Total : 3 × (800 + 1000) = 5,400 tokens
- Coût : 5,400 × $0.001 = $5.40

Avec optimization :
- Prompt compressed : 200 tokens/agent (skills reference)
- Output schema : 300 tokens/agent (JSON strict)
- Total : 3 × (200 + 300) = 1,500 tokens
- Coût : 1,500 × $0.001 = $1.50
- **Économie : 72%** ($3.90 saved)

Sur 100 RFPs :
- Sans : $540
- Avec : $150
- **Savings : $390 (72%)**

---

## 📊 Stratégie 5 : Budget Monitoring (PostToolUse Hooks)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║           REAL-TIME BUDGET MONITORING                     ║
╚═══════════════════════════════════════════════════════════╝

WORKFLOW START:
  Budget: $10.00
  Spent: $0.00
  Remaining: $10.00

Agent 1 completes:
  HOOK: PostToolUse
    └─> Log cost: $2.50
    └─> Update remaining: $7.50
    └─> Check threshold: OK (75% remaining)

Agent 2 completes:
  HOOK: PostToolUse
    └─> Log cost: $3.00
    └─> Update remaining: $4.50
    └─> Check threshold: OK (45% remaining)

Agent 3 completes:
  HOOK: PostToolUse
    └─> Log cost: $4.00
    └─> Update remaining: $0.50
    └─> Check threshold: ⚠️ WARNING (5% remaining)
    └─> Alert: "Budget 95% consumed"

Agent 4 would cost $2.00:
  HOOK: PreExecution
    └─> Estimate: $2.00
    └─> Remaining: $0.50
    └─> Decision: ❌ BLOCK (insufficient budget)
    └─> Escalate to human for budget increase
```

### Implémentation

```yaml
# .claude/hooks/budget-monitor.yml

name: budget-monitor
description: Tracks costs and enforces budget limits
type: monitoring
trigger: PostToolUse (after every agent/MCP call)

config:
  budget_total: 10.00  # USD
  currency: USD
  thresholds:
    warning: 0.75  # 75% consumed
    critical: 0.90  # 90% consumed
    block: 0.95  # 95% consumed

tracking:
  - name: log-cost
    file: .claude/logs/budget-tracking.jsonl
    format: |
      {
        "timestamp": "{iso_timestamp}",
        "workflow_id": "{workflow_id}",
        "agent": "{agent_name}",
        "tool": "{tool_name}",
        "tokens_input": {input_tokens},
        "tokens_output": {output_tokens},
        "cost_usd": {cost},
        "cumulative_cost": {cumulative},
        "budget_remaining": {remaining},
        "percent_consumed": {percent}
      }

  - name: check-thresholds
    logic: |
      percent_consumed = cumulative_cost / budget_total

      if percent_consumed >= 0.95:
        action: BLOCK_NEXT_EXECUTION
        alert: CRITICAL
        notify: ["team-lead@company.com", "finance@company.com"]

      elif percent_consumed >= 0.90:
        action: WARN
        alert: CRITICAL
        notify: ["team-lead@company.com"]

      elif percent_consumed >= 0.75:
        action: WARN
        alert: WARNING
        log: "Budget 75% consumed"

alerts:
  warning:
    slack: "#ai-ops"
    message: "⚠️ Workflow {workflow_id} consumed {percent}% budget"

  critical:
    slack: "#ai-ops"
    pagerduty: true
    message: "🚨 Workflow {workflow_id} exceeded {percent}% budget - BLOCKED"

exit_codes:
  under_budget: 0  # Continue
  at_threshold: 1  # Warn but continue
  over_budget: 2  # Block execution
```

### Dashboard Temps Réel

```
┌─────────────────────────────────────────────────────────┐
│              BUDGET MONITORING DASHBOARD                │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Workflow: RFP-Orchestrator-ACME-2025                  │
│  Budget: $10.00 | Spent: $7.80 | Remaining: $2.20      │
│                                                         │
│  Progress: ████████████████░░░░ 78%                    │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │ COST BREAKDOWN BY AGENT                         │   │
│  ├─────────────────────────────────────────────────┤   │
│  │ Legal-Analyzer      : $2.50 (32%)               │   │
│  │ Tech-Analyzer       : $3.00 (38%)               │   │
│  │ Finance-Analyzer    : $2.30 (30%)               │   │
│  │ ─────────────────────────────                   │   │
│  │ Total               : $7.80 (78%)               │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │ COST BREAKDOWN BY TYPE                          │   │
│  ├─────────────────────────────────────────────────┤   │
│  │ Claude API          : $6.50 (83%)               │   │
│  │ MCP (Contracts DB)  : $0.80 (10%)               │   │
│  │ MCP (ERP)           : $0.50 (7%)                │   │
│  │ ─────────────────────────────                   │   │
│  │ Total               : $7.80 (100%)              │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
│  Next Agents (Estimated):                              │
│    ├─> Content-Writer     : ~$1.50 (would reach 93%)  │
│    ├─> Pricing-Calculator : ~$0.80 (would reach 101%) │
│    └─> ⚠️ WARNING: Budget will exceed at Pricing step  │
│                                                         │
│  Actions:                                              │
│    [ Request Budget Increase ]                         │
│    [ Optimize Next Agents ]                            │
│    [ Abort Workflow ]                                  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Benchmarks Budget Monitoring

**Scénario : Workflow sans monitoring**
- Budget initial : Non défini
- Dépenses finales : $45.00 (surprise !)
- Problème : Détecté après exécution
- Impact : Budget mensuel dépassé

**Scénario : Workflow avec monitoring**
- Budget initial : $10.00
- Alerte à 75% : $7.50 (action préventive)
- Blocage à 95% : $9.50 (évite dépassement)
- Dépenses finales : $9.50
- **Économie : Protection budget** (pas de surprise)

---

## 💰 Stratégie 6 : ROI-Based Decision Making

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║              ROI DECISION FRAMEWORK                       ║
╚═══════════════════════════════════════════════════════════╝

QUESTION : Investir dans workflow AI ?

CALCUL :
  Implementation Cost (one-time) : $50,000
  Operating Cost (per workflow) : $750

  Manual Cost (per workflow) : $25,500
  Manual Time (per workflow) : 2-4 weeks

  Savings per workflow : $24,750
  Time saved per workflow : 336 hours

  Break-even : 2 workflows ($50,000 / $24,750)

  Annual volume : 50 workflows
  Annual savings : $1,237,500
  Annual time saved : 16,800 hours

  ROI : 2,375% (first year)
  Payback period : 6 days

DECISION : ✅ INVEST (ROI exceptionnel)
```

### Framework de Décision

```
┌─────────────────────────────────────────────────────────┐
│           ROI DECISION MATRIX                           │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  HIGH VOLUME + HIGH COST = TOP PRIORITY                │
│  │                                                      │
│  ├─> RFP Response (50/year, $25k each)                 │
│  │   ROI: 2,375% → INVEST IMMEDIATELY                  │
│  │                                                      │
│  ├─> Localization (100/year, $800 each)                │
│  │   ROI: 1,200% → HIGH PRIORITY                       │
│  │                                                      │
│  └─> CI/CD (500/year, $5k each)                        │
│      ROI: 900% → HIGH PRIORITY                         │
│                                                         │
│  HIGH VOLUME + LOW COST = GOOD CANDIDATE               │
│  │                                                      │
│  ├─> Email Classification (10k/month, $2 each)         │
│  │   ROI: 500% → MEDIUM PRIORITY                       │
│  │                                                      │
│  └─> Support Ticket Routing (5k/month, $3 each)        │
│      ROI: 400% → MEDIUM PRIORITY                       │
│                                                         │
│  LOW VOLUME + HIGH COST = EVALUATE CASE-BY-CASE        │
│  │                                                      │
│  ├─> M&A Due Diligence (2/year, $100k each)            │
│  │   ROI: 150% → CONSIDER (strategic value)            │
│  │                                                      │
│  └─> Executive Briefings (10/year, $10k each)          │
│      ROI: 80% → LOW PRIORITY                           │
│                                                         │
│  LOW VOLUME + LOW COST = SKIP                          │
│  │                                                      │
│  └─> Annual Report (1/year, $5k)                       │
│      ROI: 20% → NOT WORTH AUTOMATING                   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Calcul ROI Template

```yaml
# .claude/tools/roi-calculator.yml

## INPUT
- Workflow Name: {name}
- Annual Volume: {volume}
- Manual Cost per Instance: ${manual_cost}
- Manual Time per Instance: {manual_hours}h
- Automated Cost per Instance: ${auto_cost}
- Implementation Cost (one-time): ${impl_cost}

## CALCULATION

Savings per instance:
  ${manual_cost} - ${auto_cost} = ${savings}

Annual savings:
  {volume} × ${savings} = ${annual_savings}

Annual time saved:
  {volume} × {manual_hours}h = {time_saved}h

Break-even volume:
  ${impl_cost} / ${savings} = {breakeven_volume} workflows

Payback period:
  {breakeven_volume} / ({volume} / 365 days) = {payback_days} days

First year ROI:
  (${annual_savings} - ${impl_cost}) / ${impl_cost} × 100%

## DECISION

If ROI > 500%:
  Priority: TOP (invest immediately)

If ROI 200-500%:
  Priority: HIGH (strong candidate)

If ROI 100-200%:
  Priority: MEDIUM (evaluate strategic value)

If ROI 50-100%:
  Priority: LOW (consider if strategic importance)

If ROI < 50%:
  Priority: SKIP (not worth automating)

## EXAMPLE OUTPUT

```markdown
# ROI Analysis: RFP Response Automation

## Metrics
- Annual Volume: 50 RFPs
- Manual Cost: $25,500/RFP
- Automated Cost: $750/RFP
- Implementation: $50,000

## Savings
- Per RFP: $24,750
- Annual: $1,237,500
- Time: 16,800 hours/year

## ROI
- Break-even: 2 RFPs
- Payback: 6 days
- First Year ROI: 2,375%

## Recommendation
✅ TOP PRIORITY - Invest immediately
```
```

---

## 📈 Stratégie 7 : Continuous Optimization Loop

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║          CONTINUOUS IMPROVEMENT CYCLE                     ║
╚═══════════════════════════════════════════════════════════╝

MONTH 1 (Baseline):
  └─> Run workflows, collect metrics
      ├─> Average cost: $10/workflow
      ├─> Average time: 60min
      └─> Success rate: 90%

MONTH 2 (Analyze):
  └─> Identify optimization opportunities
      ├─> 40% of costs in redundant API calls
      ├─> 30% of time in sequential processes
      └─> 10% failures due to timeouts

MONTH 3 (Optimize):
  └─> Implement improvements
      ├─> Add caching (reduce API calls 40%)
      ├─> Parallelize tasks (reduce time 30%)
      └─> Add retries (reduce failures 50%)

MONTH 4 (Measure):
  └─> New metrics
      ├─> Average cost: $6/workflow (40% ↓)
      ├─> Average time: 42min (30% ↓)
      └─> Success rate: 95% (5% ↑)

MONTH 5 (Iterate):
  └─> Find new optimization opportunities
      ├─> Add fallback chains
      ├─> Optimize prompts
      └─> Increase batch sizes

→ REPEAT CYCLE QUARTERLY
```

### Implémentation Dashboard

```
┌─────────────────────────────────────────────────────────┐
│          OPTIMIZATION TRACKING DASHBOARD                │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  📊 QUARTERLY PERFORMANCE                               │
│                                                         │
│  Q1 2025 (Baseline):                                   │
│    Avg Cost: $10.00/workflow                           │
│    Avg Time: 60min                                     │
│    Success Rate: 90%                                   │
│    Volume: 50 workflows                                │
│    Total Spent: $500                                   │
│                                                         │
│  Q2 2025 (+Caching, +Parallel):                        │
│    Avg Cost: $6.00/workflow (-40%) ✅                  │
│    Avg Time: 42min (-30%) ✅                           │
│    Success Rate: 95% (+5%) ✅                          │
│    Volume: 75 workflows (+50%)                         │
│    Total Spent: $450 (-10% despite +50% volume)        │
│                                                         │
│  Q3 2025 (+Fallback, +Batching):                       │
│    Avg Cost: $3.50/workflow (-65%) ✅                  │
│    Avg Time: 35min (-42%) ✅                           │
│    Success Rate: 97% (+2%) ✅                          │
│    Volume: 100 workflows (+33%)                        │
│    Total Spent: $350 (-22% despite +33% volume)        │
│                                                         │
│  Q4 2025 (+Skills, +Schema):                           │
│    Avg Cost: $2.00/workflow (-80%) ✅                  │
│    Avg Time: 30min (-50%) ✅                           │
│    Success Rate: 98% (+1%) ✅                          │
│    Volume: 120 workflows (+20%)                        │
│    Total Spent: $240 (-31% despite +20% volume)        │
│                                                         │
│  🎯 YEAR-OVER-YEAR                                      │
│    Cost Reduction: 80%                                 │
│    Time Reduction: 50%                                 │
│    Volume Increase: 140%                               │
│    Total Savings: $760 (despite 2.4x volume)           │
│                                                         │
│  🔧 NEXT OPTIMIZATIONS (Q1 2026)                        │
│    [ ] Implement prompt compression                    │
│    [ ] Add more skills (reduce context)                │
│    [ ] Optimize MCP usage (reduce queries)             │
│    [ ] Target: $1.50/workflow                          │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## ✅ DO / ❌ DON'T

### ✅ DO

```
✅ Implement fallback chains
   Local → Context7 → Perplexity → Firecrawl → Claude
   (Start cheap, escalate only if needed)

✅ Build translation memory skills
   Reuse validated translations, avoid re-translating

✅ Batch process when possible
   10-20 items per API call (optimal balance)

✅ Use schema-constrained outputs
   Prevent verbose responses, save tokens

✅ Monitor budget in real-time
   PostToolUse hooks to track costs

✅ Calculate ROI before implementing
   Invest only in high-ROI workflows (>200%)

✅ Optimize continuously
   Review metrics quarterly, iterate improvements
```

### ❌ DON'T

```
❌ Always use most expensive tier
   Don't default to Claude API when cache/skill available

❌ Process items one-by-one
   Avoid 1000 API calls when 50 batches would work

❌ Duplicate context across agents
   Don't repeat company background in every prompt

❌ Allow unconstrained outputs
   Verbose responses waste tokens ($)

❌ Run workflows without budget limits
   Costs can spiral out of control

❌ Automate low-ROI workflows
   ROI <50% = not worth the effort

❌ Set and forget
   Workflows degrade over time without optimization
```

---

## 🎓 Points Clés

### Architecture de Coûts

✅ **Fallback chains** : 97.8% savings (local → cloud)
✅ **Skill reuse** : 30-80% savings (translation memory)
✅ **Batch processing** : 50-60% savings (optimal sizing)
✅ **Token optimization** : 72% savings (concise prompts + schema)

### Monitoring

✅ **Real-time tracking** : PostToolUse hooks for budget monitoring
✅ **Threshold alerts** : 75% warning, 95% block
✅ **Cost dashboards** : Visibility into spending patterns

### ROI

✅ **Top priority** : ROI >500% (RFP, Localization, CI/CD)
✅ **High priority** : ROI 200-500% (Email classification)
✅ **Skip** : ROI <50% (low volume + low cost)

### Continuous Improvement

✅ **Quarterly review** : Analyze metrics, identify optimizations
✅ **Iterative gains** : 10-20% improvement per quarter
✅ **Compound effect** : 80% cost reduction over 1 year

---

## 📚 Ressources

### Documentation Interne

- 📄 [Orchestration Principles](../orchestration-principles.md)
- 📄 [Enterprise RFP Workflow](../4-workflows/enterprise-rfp.md)
- 📄 [Global Localization Workflow](../4-workflows/global-localization.md)
- 📄 [CI/CD Pipeline Workflow](../4-workflows/ci-cd-pipeline.md)

### Patterns Connexes

- 📄 [Performance Optimization](./performance.md)
- 📄 [Error Resilience](./error-resilience.md)
- 📄 [Team Collaboration](./team-collaboration.md)

---

**Suivez ces stratégies pour réduire vos coûts d'orchestration AI de 90%+ tout en maintenant qualité et performance !**
