# Patterns: Error Handling & Fallback Chains

**Status**: ✅ VALIDATED - Best practices from Claude Code orchestration + MCP ecosystem
**Date**: 2025-01-17
**Sources**:
- Claude Code official docs: hooks, error handling
- MCP Context7, Perplexity, Firecrawl fallback strategies
- Community patterns (Edmund Yong, Weston Hobson)

---

## 📐 Core Pattern: Graceful Degradation

```
PRIMARY SOURCE (MCP Context7)
    ↓
  [FAILS?] → FALLBACK 1 (Perplexity)
               ↓
          [FAILS?] → FALLBACK 2 (Firecrawl)
                        ↓
                   [FAILS?] → USER VALIDATION
                                  ↓
                              [BLOCK or WARN]
```

**Principes clés**:
- **Chaînes de secours**: Toujours avoir un plan B (et C)
- **Retry intelligent**: Au niveau COMMAND, pas agent
- **Transparence**: Informer l'utilisateur des fallbacks utilisés
- **Exit codes**: 0=succès, 1=warning, 2=échec bloquant

---

## 1️⃣ Fallback Chains Pattern

### Concept

Quand un service externe échoue (API limit, timeout, données manquantes), **basculer automatiquement vers une alternative** sans bloquer le workflow.

### Flow Complet

```
╔════════════════════════════════════════════╗
║     Fallback Chain avec Exit Codes         ║
╚════════════════════════════════════════════╝

📊 COMMAND démarre
    ↓
┌───────────────────────────────────────┐
│ PRIMARY: MCP Context7 (docs officielles)│
│ ✅ Fast, structured, comprehensive    │
└───────────────────────────────────────┘
    ↓
[Success?] ────YES───→ EXIT 0 ✅
    │
    NO (rate limit, offline)
    ↓
┌───────────────────────────────────────┐
│ FALLBACK 1: Perplexity AI Search     │
│ ⚡ Current web data, slower           │
└───────────────────────────────────────┘
    ↓
[Success?] ────YES───→ EXIT 1 ⚠️ (warn: fallback utilisé)
    │
    NO (API key missing, down)
    ↓
┌───────────────────────────────────────┐
│ FALLBACK 2: Firecrawl Scraping       │
│ 🐌 Slow but reliable                 │
└───────────────────────────────────────┘
    ↓
[Success?] ────YES───→ EXIT 1 ⚠️ (warn: fallback 2 utilisé)
    │
    NO (scraping failed)
    ↓
┌───────────────────────────────────────┐
│ USER VALIDATION: AskUserQuestion      │
│ ❓ "Provide manual URL or skip?"     │
└───────────────────────────────────────┘
    ↓
[User choice]
    ├─→ Provide URL → Retry Firecrawl → EXIT 1 ⚠️
    └─→ Skip → EXIT 2 ❌ (block, données manquantes)
```

### Exemple Concret: Documentation Fetcher

**Use case**: Générer des docs locales en récupérant les dernières infos API.

```yaml
# .claude/commands/fetch-docs.md
---
description: Fetch latest API docs using fallback chain
allowed-tools: Task, AskUserQuestion, mcp__context7__*, mcp__perplexity__*, mcp__firecrawl__*
argument-hint: <library-name>
---

You are a documentation fetcher with robust error handling.

## Workflow

1. **PARSE ARGUMENT**
   - Library name: e.g., "Next.js", "Supabase"
   - Validate non-empty

2. **PRIMARY SOURCE: Context7 MCP**
   ```
   TRY:
     - mcp__context7__resolve-library-id
     - mcp__context7__get-library-docs
   CATCH ApiError:
     - Log: "Context7 rate limit or offline"
     - → FALLBACK 1
   ```

3. **FALLBACK 1: Perplexity Search**
   ```
   TRY:
     - mcp__perplexity__search_web with query="latest {library} API docs"
   CATCH ApiError:
     - Log: "Perplexity API key missing or quota exceeded"
     - → FALLBACK 2
   ```

4. **FALLBACK 2: Firecrawl Scraping**
   ```
   TRY:
     - mcp__firecrawl__scrape official docs URL
   CATCH ScrapeError:
     - Log: "Firecrawl failed to scrape"
     - → USER VALIDATION
   ```

5. **USER VALIDATION**
   ```
   AskUserQuestion:
     - "Tous les services ont échoué. Veux-tu :"
       - "Fournir URL manuelle" → Retry Firecrawl
       - "Utiliser cache local (si dispo)" → Use stale data
       - "Annuler" → EXIT 2 (block)
   ```

6. **REPORT**
   - Success: "✅ Docs fetched from [source]"
   - Warning: "⚠️ Used fallback [X], verify accuracy"
   - Blocked: "❌ All sources failed, manual intervention needed"
```

### Exit Codes Convention

| Code | Signification | Action |
|------|--------------|--------|
| `0` | ✅ **Succès complet** | Workflow continue |
| `1` | ⚠️ **Warning** (fallback utilisé) | Workflow continue, mais review recommandée |
| `2` | ❌ **Échec bloquant** | Workflow arrêté, données critiques manquantes |

**Pourquoi important ?**
- Permet aux hooks de décider si continuer ou bloquer
- Facilite debugging (logs structurés)
- Standards Unix (0=success, >0=error)

---

## 2️⃣ Retry Logic Pattern

### Concept

**Retry au niveau COMMAND**, jamais au niveau agent individuel. Évite les boucles infinies et centralise la logique.

### Flow de Retry

```
╔════════════════════════════════════════════╗
║         Retry Logic (Command Level)        ║
╚════════════════════════════════════════════╝

COMMAND lance 10 agents parallèles
    ↓
┌────────────────────────────────┐
│ AGENTS exécutent               │
│ ✅✅✅❌❌✅✅❌✅✅              │
│ Success: 7/10 | Failed: 3/10   │
└────────────────────────────────┘
    ↓
COMMAND collecte résultats
    ↓
┌────────────────────────────────┐
│ Identifier échecs :            │
│ - Agent #4 (timeout)           │
│ - Agent #5 (API error)         │
│ - Agent #8 (data missing)      │
└────────────────────────────────┘
    ↓
RETRY LOGIC (1 seule fois)
    ↓
┌────────────────────────────────┐
│ Relancer 3 agents échoués      │
│ avec contexte amélioré         │
└────────────────────────────────┘
    ↓
    ├─→ 2/3 succès → REPORT ⚠️ (1 échec persistant)
    └─→ 0/3 succès → REPORT ❌ (échec critique)
```

### Exemple: Batch Locale Generator

```markdown
# .claude/commands/generate-locales.md

## Workflow

4. **LAUNCH AGENTS** (parallel)
   - Use Task tool for each locale
   - Max batch: 10 locales per wave
   - Collect results: `{ locale, status, error? }`

5. **RETRY FAILURES** (once)
   ```
   IF any agent failed:
     - Extract failed locales
     - RETRY with improved prompt:
       - "Previous attempt failed with: {error}"
       - "Try alternative approach: use fallback data source"
     - Launch retry agents (parallel)
     - Collect retry results
   ```

6. **AGGREGATE FINAL RESULTS**
   ```
   Success = original_success + retry_success
   Failed = retry_failed

   Report:
   - ✅ {success_count} locales generated
   - ⚠️ {retry_success_count} succeeded after retry
   - ❌ {failed_count} failed permanently:
       - {locale1}: {error}
       - {locale2}: {error}
   ```
```

### Règles de Retry

| ✅ DO | ❌ DON'T |
|------|----------|
| Retry au niveau COMMAND | Retry dans chaque agent (loop infini) |
| 1 seule retry (max 2 tentatives) | Retry indéfiniment |
| Améliorer contexte/prompt au retry | Retry avec même config |
| Logger raisons d'échec | Retry aveuglément |
| User validation si retry échoue | Continuer silencieusement |

---

## 3️⃣ User Validation Points

### Concept

Demander validation utilisateur **avant** de faire des actions irréversibles ou **après** échecs critiques.

### Flow avec Validation

```
╔════════════════════════════════════════════╗
║      User Validation Checkpoints           ║
╚════════════════════════════════════════════╝

COMMAND démarre
    ↓
┌────────────────────────────────┐
│ CHECKPOINT 1: Pre-flight       │
│ ❓ "Delete 50 files?"          │
└────────────────────────────────┘
    ↓
[User confirms?] ────NO───→ EXIT 0 (cancelled)
    │
   YES
    ↓
Exécution...
    ↓
[Error occurred?] ────NO───→ EXIT 0 ✅
    │
   YES (3 failures)
    ↓
┌────────────────────────────────┐
│ CHECKPOINT 2: Post-error       │
│ ❓ "3 failures. Continue?"     │
│   - Retry failed items         │
│   - Skip failures              │
│   - Abort all                  │
└────────────────────────────────┘
    ↓
[User choice]
    ├─→ Retry → Retry logic
    ├─→ Skip → Continue, EXIT 1 ⚠️
    └─→ Abort → Rollback, EXIT 2 ❌
```

### Exemple: Destructive Command

```yaml
# .claude/commands/cleanup-cache.md
---
description: Delete cache files with user confirmation
allowed-tools: Glob, Bash, AskUserQuestion
---

## Workflow

2. **SCAN CACHE FILES**
   - Use Glob to find *.cache, .temp/*, node_modules/.cache/*
   - Count files and total size

3. **USER VALIDATION CHECKPOINT**
   ```typescript
   AskUserQuestion({
     questions: [{
       question: `Found ${count} cache files (${size} MB). Delete?`,
       header: "Confirm",
       multiSelect: false,
       options: [
         {
           label: "Delete All",
           description: "Remove all cache files (cannot undo)"
         },
         {
           label: "Delete Old (>7 days)",
           description: "Keep recent cache, delete old"
         },
         {
           label: "Cancel",
           description: "Abort, no changes made"
         }
       ]
     }]
   })
   ```

4. **EXECUTE BASED ON CHOICE**
   - "Delete All" → rm -rf files → Report count
   - "Delete Old" → find + rm with -mtime +7
   - "Cancel" → EXIT 0 (no-op)

5. **POST-EXECUTION VALIDATION** (if partial failures)
   ```
   IF some files failed to delete (permissions):
     AskUserQuestion:
       "5 files couldn't be deleted (permissions). Sudo?"
         - "Yes" → sudo rm
         - "No" → Report failures, EXIT 1
   ```
```

### Quand Valider ?

| Situation | Validation Needed? | Exemple |
|-----------|-------------------|---------|
| **Destructive ops** | ✅ TOUJOURS | Delete, overwrite, drop DB |
| **Coûts élevés** | ✅ OUI | API calls >100, long processing |
| **Données sensibles** | ✅ OUI | Accès secrets, PII processing |
| **Échecs critiques** | ✅ OUI | Retry? Rollback? |
| **Read-only ops** | ❌ NON | Grep, Read, status checks |

---

## 4️⃣ Error Aggregation & Reporting

### Concept

Collecter **tous** les détails d'erreur pendant workflow et générer un rapport structuré en fin.

### Structure de Report

```
╔════════════════════════════════════════════╗
║         Error Report Template              ║
╚════════════════════════════════════════════╝

📊 WORKFLOW: {command-name}
📅 Started: {timestamp}
⏱️ Duration: {duration}

✅ SUCCESS: {count} / {total}
⚠️ WARNINGS: {count}
❌ FAILURES: {count}

───────────────────────────────────────────

🎯 SUCCESSFUL OPERATIONS:
  ✅ {item1}: {result}
  ✅ {item2}: {result}
  ...

───────────────────────────────────────────

⚠️ WARNINGS (review recommended):
  ⚠️ {item1}: Used fallback (Perplexity)
  ⚠️ {item2}: Partial data (95% complete)
  ...

───────────────────────────────────────────

❌ FAILURES (action required):
  ❌ {item1}:
     Error: API rate limit exceeded
     Source: mcp__context7__get-docs
     Attempted: 2 times (original + retry)
     Suggestion: Wait 1 hour or use manual URL

  ❌ {item2}:
     Error: Network timeout
     Source: mcp__firecrawl__scrape
     Attempted: 2 times
     Suggestion: Check internet connection
  ...

───────────────────────────────────────────

🔗 SOURCES USED:
  - Primary: Context7 MCP (70%)
  - Fallback 1: Perplexity (20%)
  - Fallback 2: Firecrawl (10%)

───────────────────────────────────────────

💡 NEXT STEPS:
  1. Review {warning_count} warnings for accuracy
  2. Manually fix {failure_count} failed items:
     - {item1}: Use `fetch-docs --url={url}`
     - {item2}: Check API key in ~/.config/claude-code/config.json
  3. Re-run command for failed items: `/{command} {failed_items}`
```

### Exemple: Implementation

```typescript
// Pseudo-code pour error aggregation dans command

interface Result {
  item: string;
  status: 'success' | 'warning' | 'failure';
  source?: string;
  error?: string;
  attempts?: number;
}

class ErrorAggregator {
  results: Result[] = [];
  startTime: Date;

  addSuccess(item: string, source: string) {
    this.results.push({ item, status: 'success', source });
  }

  addWarning(item: string, reason: string, source: string) {
    this.results.push({
      item,
      status: 'warning',
      error: reason,
      source
    });
  }

  addFailure(item: string, error: string, source: string, attempts: number) {
    this.results.push({
      item,
      status: 'failure',
      error,
      source,
      attempts
    });
  }

  generateReport(): string {
    const success = this.results.filter(r => r.status === 'success');
    const warnings = this.results.filter(r => r.status === 'warning');
    const failures = this.results.filter(r => r.status === 'failure');

    return `
📊 WORKFLOW SUMMARY
✅ Success: ${success.length}
⚠️ Warnings: ${warnings.length}
❌ Failures: ${failures.length}

${failures.length > 0 ? this.formatFailures(failures) : ''}
${warnings.length > 0 ? this.formatWarnings(warnings) : ''}

💡 NEXT STEPS: ${this.suggestNextSteps(failures, warnings)}
    `;
  }
}
```

---

## 5️⃣ Hooks pour Error Handling

### Concept

Utiliser **hooks** pour automatiser les réactions aux erreurs et implémenter des politiques globales.

### Hook: Post-Command Error Check

```yaml
# .claude/hooks/on-command-end.md
---
description: Validate command exit codes and enforce policies
event: CommandComplete
---

You are an error policy enforcer.

## Workflow

1. **CHECK EXIT CODE**
   - Read command exit code from context
   - Map to policy:
     - 0 → Continue
     - 1 → Log warning, continue
     - 2 → Block, require manual review

2. **EXIT CODE 2 POLICY** (blocking errors)
   ```
   IF exit_code === 2:
     - Log error to .claude/errors.log
     - Create .claude/failed-{command}.json with details
     - AskUserQuestion:
       "Command failed critically. Actions:"
         - "Review logs" → Show .claude/errors.log
         - "Retry" → Re-run command
         - "Skip" → Mark as known issue
   ```

3. **EXIT CODE 1 POLICY** (warnings)
   ```
   IF exit_code === 1:
     - Log warning to .claude/warnings.log
     - IF warning_count > 5:
       AskUserQuestion:
         "5+ warnings detected. Review?"
           - "Review now" → Show warnings
           - "Continue" → Proceed
   ```

4. **METRICS COLLECTION**
   - Append to .claude/metrics.json:
     ```json
     {
       "command": "generate-locales",
       "timestamp": "2025-01-17T10:30:00Z",
       "exit_code": 1,
       "duration_ms": 45000,
       "success_rate": 0.87,
       "fallback_used": "perplexity"
     }
     ```
```

### Hook: Pre-Command Validation

```yaml
# .claude/hooks/before-mcp-call.md
---
description: Validate MCP availability before expensive operations
event: BeforeMcpCall
---

## Workflow

1. **CHECK MCP HEALTH**
   - Ping MCP server: lightweight call
   - IF fails → Don't proceed with heavy operation

2. **FAILFAST PATTERN**
   ```
   TRY quick health check:
     mcp__context7__resolve-library-id("test")
   CATCH error:
     - Log: "Context7 MCP unavailable"
     - SKIP to fallback immediately (don't waste time)
     - Set context: primary_source = "fallback"
   ```

3. **RATE LIMIT CHECK**
   - Read .claude/rate-limits.json
   - IF near limit → Warn user, suggest wait
   ```
   IF api_calls_today > 900 (out of 1000):
     AskUserQuestion:
       "API near limit (900/1000). Continue?"
         - "Yes" → Proceed, risk rate limit
         - "Use cache" → Use stale data
         - "Wait" → Abort, schedule later
   ```
```

---

## 🎯 Best Practices

### ✅ DO

1. **Chaînes de fallback** pour toute API externe
2. **Retry une seule fois**, avec contexte amélioré
3. **Exit codes standardisés** (0/1/2)
4. **User validation** pour ops destructives
5. **Rapports détaillés** avec next steps actionnables
6. **Failfast** : Vérifier disponibilité avant opérations coûteuses
7. **Logging structuré** pour post-mortem

### ❌ DON'T

1. **Retry infini** (max 1 retry, puis user validation)
2. **Continuer silencieusement** après erreurs critiques
3. **Retry au niveau agent** (centraliser dans command)
4. **Ignorer exit codes** (bloquer si nécessaire)
5. **Rapports vagues** ("something failed" ❌ → détails précis ✅)
6. **Fallback sans log** (toujours tracer quelle source utilisée)

---

## 📋 Cheatsheet Rapide

```bash
# Pattern Fallback Chain
TRY primary_source
  → CATCH error → TRY fallback_1
    → CATCH error → TRY fallback_2
      → CATCH error → USER_VALIDATION

# Pattern Retry
LAUNCH agents → COLLECT results
  → IF failures: RETRY once with improved context
    → IF still failures: REPORT + USER_VALIDATION

# Exit Codes
0 = ✅ Success (continue)
1 = ⚠️ Warning (continue but review)
2 = ❌ Blocked (stop, manual intervention)

# User Validation Triggers
- Destructive ops (delete, overwrite)
- Costly ops (>100 API calls, >5 min)
- Critical failures (all fallbacks failed)
- Security ops (access secrets, PII)

# Error Report Structure
📊 Summary (counts)
✅ Successes
⚠️ Warnings
❌ Failures (with details, attempts, suggestions)
💡 Next steps (actionable)
```

---

## 🎓 Points Clés

1. **Graceful degradation** : Toujours avoir un plan B (fallback chains)
2. **Retry intelligent** : 1 seule fois, au niveau COMMAND, avec contexte amélioré
3. **Exit codes** : Standard Unix (0=ok, 1=warn, 2=error) pour hooks automatisés
4. **User validation** : Demander avant actions irréversibles, après échecs critiques
5. **Transparence** : Rapports détaillés avec sources utilisées, erreurs, suggestions
6. **Failfast** : Vérifier santé services avant opérations coûteuses
7. **Hooks automatisés** : Policies globales pour error handling

---

## 📚 Ressources

### Documentation Interne
- 📄 [Command/Agent/Skill Pattern](./command-agent-skill.md) - Architecture base
- 📄 [Parallel Execution](./parallel-execution.md) - Patterns concurrents
- 📄 [State Management](./state-management.md) - Gestion état & recovery
- 📄 [MCP Guide](../themes/7-mcp/guide.md) - Configuration MCP servers
- 📄 [Hooks Guide](../themes/3-hooks/guide.md) - Automation avec hooks
- 📄 [Interactive UI](../advanced/interactive-ui.md) - AskUserQuestion patterns

### Documentation Externe
- 📄 [Claude Code Hooks](https://code.claude.com/docs/hooks) - Events et automation
- 📄 [Context7 MCP](https://github.com/context7/mcp-server) - Docs fallback source
- 📄 [Perplexity AI](https://docs.perplexity.ai/) - Search API patterns

### Repos Communauté
- 🔗 [fix-grammar plugin](https://github.com/wshobson/commands) - Retry pattern example
- 🔗 [pr-review-toolkit](https://github.com/edmund-io/edmunds-claude-code) - Error aggregation
