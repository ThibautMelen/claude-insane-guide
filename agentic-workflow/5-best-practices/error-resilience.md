# Best Practices : Error Resilience

> **Objectif** : Construire des workflows production-ready capables de gérer erreurs, failures et conditions exceptionnelles avec graceful degradation.

## 📚 Vue d'Ensemble

**Problème Résolu** :
Les workflows AI sont sujets aux failures : API timeouts, rate limits, données invalides, ressources indisponibles. Sans resilience, un seul échec peut faire échouer tout le workflow.

**Impact Business** :
- **Reliability** : 90% → 98% success rate
- **MTTR** : 45min → 5min (auto-recovery)
- **Uptime** : 99.5% → 99.9% (graceful degradation)
- **User Trust** : Système prévisible et fiable

**Exemples Réels** :
- **CI/CD** : Auto-rollback si deploy fails (99.9% uptime)
- **RFP** : Partial success si 1/3 analyzers fails (degraded but usable)
- **Security** : Escalate to human if AI confidence <80%

---

## 🎯 Stratégie 1 : Fallback Chains (Try → Retry → Fallback → Report)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║              4-TIER FALLBACK STRATEGY                     ║
╚═══════════════════════════════════════════════════════════╝

TIER 1 : TRY (Primary execution)
         └─> Execute agent/task with optimal configuration

         ┌─> SUCCESS → Return result
         └─> FAILURE → Go to TIER 2

TIER 2 : RETRY (Automatic retry with backoff)
         └─> Retry with exponential backoff (1s, 2s, 4s)

         ┌─> SUCCESS → Return result
         └─> FAILURE (after 3 retries) → Go to TIER 3

TIER 3 : FALLBACK (Alternative approach)
         └─> Try alternative method/resource

         Examples:
         ├─> Use cached result (if <1h old)
         ├─> Use simpler model (Claude Haiku vs Sonnet)
         ├─> Use alternative MCP (backup API)
         └─> Use default/placeholder value

         ┌─> SUCCESS → Return degraded result + warning
         └─> FAILURE → Go to TIER 4

TIER 4 : REPORT (Escalate to human)
         └─> Log detailed error
         └─> Alert on-call engineer
         └─> Return error state (graceful degradation)
```

### Implémentation

```yaml
# .claude/agents/resilient-agent.md

---
name: resilient-agent
description: Agent with full fallback chain resilience
---

## INPUT
- Task: {task_description}
- Data: {input_data}
- Criticality: critical|high|medium|low

## EXECUTION STRATEGY

### TIER 1: PRIMARY EXECUTION

```python
try:
    result = execute_primary_task(task, data)
    log_success("Primary execution succeeded")
    return result

except Exception as e:
    log_error(f"Primary execution failed: {e}")
    # Fall through to TIER 2
```

### TIER 2: RETRY WITH BACKOFF

```python
max_retries = 3
backoff_delays = [1, 2, 4]  # seconds

for attempt in range(1, max_retries + 1):
    try:
        delay = backoff_delays[attempt - 1]
        sleep(delay)

        result = execute_primary_task(task, data)
        log_success(f"Retry {attempt} succeeded")
        return result

    except Exception as e:
        log_error(f"Retry {attempt} failed: {e}")

        if attempt == max_retries:
            # All retries exhausted → go to TIER 3
            log_warning("All retries exhausted, trying fallback")
            break
```

### TIER 3: FALLBACK STRATEGIES

```python
# Strategy 1: Use cached result (if available and recent)
cached = get_cached_result(task)
if cached and cached.age < 3600:  # <1 hour old
    log_warning("Using cached result (fallback)")
    return {
        "result": cached.data,
        "status": "degraded",
        "source": "cache",
        "warning": "Using cached data from {cached.timestamp}"
    }

# Strategy 2: Use simpler/cheaper model
if model == "claude-sonnet":
    try:
        result = execute_task_with_model(task, data, "claude-haiku")
        log_warning("Primary model failed, used Haiku (fallback)")
        return {
            "result": result,
            "status": "degraded",
            "source": "haiku",
            "warning": "Lower quality model used"
        }
    except Exception as e:
        log_error(f"Fallback model also failed: {e}")

# Strategy 3: Use alternative MCP/API
if primary_mcp == "firecrawl":
    try:
        result = execute_with_mcp(task, data, "supadata")
        log_warning("Primary MCP failed, used alternative (fallback)")
        return {
            "result": result,
            "status": "degraded",
            "source": "alternative_mcp"
        }
    except Exception as e:
        log_error(f"Alternative MCP also failed: {e}")

# Strategy 4: Use default/placeholder
if criticality in ["medium", "low"]:
    log_warning("Using default value (fallback)")
    return {
        "result": get_default_value(task),
        "status": "degraded",
        "source": "default",
        "warning": "Could not compute, using default"
    }

# No fallback worked → go to TIER 4
```

### TIER 4: ESCALATE TO HUMAN

```python
# Log comprehensive error report
error_report = {
    "timestamp": now(),
    "agent": "resilient-agent",
    "task": task,
    "input": data,
    "error": str(e),
    "stack_trace": traceback.format_exc(),
    "attempts": {
        "primary": "failed",
        "retries": f"{max_retries} failed",
        "fallbacks": ["cache: unavailable", "haiku: failed", "mcp: failed"]
    },
    "criticality": criticality
}

log_error(error_report)

# Alert based on criticality
if criticality == "critical":
    pagerduty_alert(error_report)
    slack_alert("#incidents", error_report)
    email_alert("on-call@company.com", error_report)

elif criticality == "high":
    slack_alert("#errors", error_report)
    email_alert("team-lead@company.com", error_report)

else:  # medium, low
    slack_alert("#warnings", error_report)

# Return error state (graceful degradation)
return {
    "result": None,
    "status": "failed",
    "error": "All fallback strategies exhausted",
    "report_id": error_report.id,
    "next_steps": "Human intervention required"
}
```

## OUTPUT SCHEMA

```json
{
  "result": "{data|null}",
  "status": "success|degraded|failed",
  "source": "primary|retry|cache|haiku|alternative|default",
  "tier_used": 1|2|3|4,
  "warning": "{message}",
  "error": "{message}",
  "execution_time_ms": {duration}
}
```
```

### Benchmarks Fallback Chains

**Scenario : 100 agent executions**

Sans fallback (fail fast) :
- Success : 85 (85%)
- Failures : 15 (15%)
- MTTR : 45min (manual intervention)
- Downtime : 15 × 45min = 675min

Avec fallback (Tier 1-4) :
- Tier 1 success : 85 (85%)
- Tier 2 success : 10 (10%, retries worked)
- Tier 3 success : 3 (3%, fallback worked)
- Tier 4 escalation : 2 (2%, human needed)
- **Total success : 98%** (vs 85%)
- MTTR : 5min (auto-recovery)
- Downtime : 2 × 5min = 10min
- **Downtime reduction : 98.5%** (675min → 10min)

---

## 🔄 Stratégie 2 : Retry Logic (Once Per Failure)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║          EXPONENTIAL BACKOFF RETRY STRATEGY               ║
╚═══════════════════════════════════════════════════════════╝

RETRY DECISION MATRIX:

┌────────────────┬─────────────────┬────────────────────┐
│ Error Type     │ Retry?          │ Backoff            │
├────────────────┼─────────────────┼────────────────────┤
│ Rate Limit     │ YES (3x)        │ 1s, 2s, 4s         │
│ Timeout        │ YES (3x)        │ 2s, 4s, 8s         │
│ Network Error  │ YES (3x)        │ 1s, 2s, 4s         │
│ 500 Server Err │ YES (2x)        │ 2s, 4s             │
│ 503 Unavail    │ YES (2x)        │ 5s, 10s            │
│ 400 Bad Req    │ NO              │ -                  │
│ 401 Unauth     │ NO              │ -                  │
│ 403 Forbidden  │ NO              │ -                  │
│ 404 Not Found  │ NO              │ -                  │
└────────────────┴─────────────────┴────────────────────┘

WHY EXPONENTIAL BACKOFF:
  ├─> Avoid overwhelming failing service
  ├─> Allow time for transient issues to resolve
  ├─> Reduce thundering herd problem
  └─> Increase success probability over time

RETRY BUDGET:
  ├─> Max retries per agent: 3
  ├─> Max total retries per workflow: 20
  ├─> If budget exhausted → escalate to human
```

### Implémentation

```python
# .claude/hooks/retry-handler.py

import time
import random
from enum import Enum

class ErrorType(Enum):
    RATE_LIMIT = "rate_limit"
    TIMEOUT = "timeout"
    NETWORK = "network"
    SERVER_5XX = "server_5xx"
    CLIENT_4XX = "client_4xx"
    UNKNOWN = "unknown"

class RetryConfig:
    """Configuration for retry behavior per error type."""

    RETRY_POLICIES = {
        ErrorType.RATE_LIMIT: {
            "max_retries": 3,
            "base_delay": 1.0,
            "max_delay": 60.0,
            "exponential_base": 2,
            "jitter": True
        },
        ErrorType.TIMEOUT: {
            "max_retries": 3,
            "base_delay": 2.0,
            "max_delay": 30.0,
            "exponential_base": 2,
            "jitter": True
        },
        ErrorType.NETWORK: {
            "max_retries": 3,
            "base_delay": 1.0,
            "max_delay": 16.0,
            "exponential_base": 2,
            "jitter": True
        },
        ErrorType.SERVER_5XX: {
            "max_retries": 2,
            "base_delay": 2.0,
            "max_delay": 16.0,
            "exponential_base": 2,
            "jitter": False
        },
        ErrorType.CLIENT_4XX: {
            "max_retries": 0,  # Don't retry client errors
            "base_delay": 0,
            "max_delay": 0,
            "exponential_base": 1,
            "jitter": False
        },
        ErrorType.UNKNOWN: {
            "max_retries": 1,
            "base_delay": 1.0,
            "max_delay": 4.0,
            "exponential_base": 2,
            "jitter": True
        }
    }

def classify_error(exception):
    """Classify exception into ErrorType."""

    error_msg = str(exception).lower()

    if "rate limit" in error_msg or "429" in error_msg:
        return ErrorType.RATE_LIMIT

    if "timeout" in error_msg or "timed out" in error_msg:
        return ErrorType.TIMEOUT

    if "network" in error_msg or "connection" in error_msg:
        return ErrorType.NETWORK

    if any(code in error_msg for code in ["500", "502", "503", "504"]):
        return ErrorType.SERVER_5XX

    if any(code in error_msg for code in ["400", "401", "403", "404"]):
        return ErrorType.CLIENT_4XX

    return ErrorType.UNKNOWN

def calculate_backoff(attempt, config):
    """Calculate backoff delay with exponential growth and jitter."""

    base_delay = config["base_delay"]
    exponential_base = config["exponential_base"]
    max_delay = config["max_delay"]
    jitter = config["jitter"]

    # Exponential backoff: base_delay * (exponential_base ^ attempt)
    delay = base_delay * (exponential_base ** attempt)

    # Cap at max_delay
    delay = min(delay, max_delay)

    # Add jitter (random 0-25% variation)
    if jitter:
        jitter_amount = delay * 0.25 * random.random()
        delay += jitter_amount

    return delay

def retry_with_backoff(func, *args, **kwargs):
    """
    Execute function with retry logic and exponential backoff.

    Returns:
        (success: bool, result: any, attempts: int, error: Exception|None)
    """

    attempt = 0
    last_exception = None

    while True:
        try:
            result = func(*args, **kwargs)
            return (True, result, attempt + 1, None)

        except Exception as e:
            last_exception = e
            error_type = classify_error(e)
            policy = RetryConfig.RETRY_POLICIES[error_type]

            attempt += 1

            # Check if should retry
            if attempt > policy["max_retries"]:
                # Max retries exhausted
                log_error(f"Max retries ({policy['max_retries']}) exhausted for {error_type}")
                return (False, None, attempt, last_exception)

            # Calculate backoff delay
            delay = calculate_backoff(attempt - 1, policy)

            log_warning(
                f"Attempt {attempt} failed with {error_type}, "
                f"retrying in {delay:.2f}s..."
            )

            # Wait before retry
            time.sleep(delay)

# USAGE EXAMPLE

def call_api_with_retry():
    """Call external API with automatic retry logic."""

    def api_call():
        # This may raise rate limit, timeout, etc.
        return external_api.query(data)

    success, result, attempts, error = retry_with_backoff(api_call)

    if success:
        log_success(f"API call succeeded after {attempts} attempt(s)")
        return result
    else:
        log_error(f"API call failed after {attempts} attempts: {error}")
        # Fall through to fallback strategy
        return None
```

### Benchmarks Retry Logic

**Scenario : 100 API calls with 15% transient error rate**

Sans retry :
- Success : 85 (85%)
- Failures : 15 (15%, could have succeeded with retry)

Avec retry (max 3) :
- Attempt 1 success : 85 (85%)
- Retry 1 success : 10 (67% of 15 failures)
- Retry 2 success : 3 (60% of remaining 5 failures)
- Retry 3 success : 1 (50% of remaining 2 failures)
- Permanent failures : 1 (1%)
- **Total success : 99%** (vs 85%)
- **Improvement : +14% success rate**

---

## 🎯 Stratégie 3 : Graceful Degradation (Partial Success)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║          GRACEFUL DEGRADATION PATTERNS                    ║
╚═══════════════════════════════════════════════════════════╝

PATTERN 1 : PARTIAL RESULTS
  ├─> Goal: Translate 20 languages
  ├─> Success: 18 languages
  ├─> Failure: 2 languages (timeout)
  └─> Decision: Return 18 translations + warning about 2 failures
      (90% complete is better than 0% complete)

PATTERN 2 : REDUCED QUALITY
  ├─> Goal: High-quality analysis with Claude Sonnet
  ├─> Failure: Rate limit exceeded
  └─> Decision: Use Claude Haiku (faster, cheaper, slightly lower quality)
      (Degraded quality is better than no result)

PATTERN 3 : CACHED DATA
  ├─> Goal: Real-time stock price
  ├─> Failure: API unavailable
  └─> Decision: Return cached price (5min old) + warning
      (Slightly stale data is better than no data)

PATTERN 4 : DEFAULT VALUES
  ├─> Goal: User preference from DB
  ├─> Failure: DB connection timeout
  └─> Decision: Return default preference + warning
      (Default is better than blocking user)

DECISION FRAMEWORK:
  Criticality = HIGH → No degradation, fail workflow
  Criticality = MEDIUM → Partial success allowed
  Criticality = LOW → Aggressive degradation OK
```

### Implémentation

```yaml
# .claude/commands/rfp-orchestrator-resilient.md

---
name: rfp-orchestrator-resilient
description: RFP orchestrator with graceful degradation
---

## PHASE 1: ANALYSIS (3 agents parallel)

Launch agents:
- Legal-Analyzer
- Tech-Analyzer
- Finance-Analyzer

## DEGRADATION STRATEGY

If ALL 3 fail:
  ├─> Criticality: HIGH (cannot proceed)
  └─> Action: ABORT workflow, escalate to human

If 2/3 succeed:
  ├─> Criticality: MEDIUM (degraded but usable)
  └─> Action: CONTINUE with warning
      Example: "Tech analysis unavailable, using historical data"

If 1/3 succeeds:
  ├─> Criticality: HIGH (insufficient data)
  └─> Action: ABORT workflow, escalate to human

## IMPLEMENTATION

```python
# Launch all 3 agents
results = launch_parallel([
    Legal-Analyzer,
    Tech-Analyzer,
    Finance-Analyzer
])

# Count successes
successes = [r for r in results if r.status == "success"]
failures = [r for r in results if r.status != "success"]

success_count = len(successes)

# Graceful degradation logic
if success_count == 3:
    # Perfect case
    log_success("All analyses complete")
    proceed_to_next_phase(results)

elif success_count == 2:
    # Partial success - DEGRADED MODE
    log_warning(f"Only {success_count}/3 analyses succeeded: {failures}")

    # Determine which failed
    failed_agents = [f.agent for f in failures]

    # Apply fallbacks
    fallback_results = []
    for agent in failed_agents:
        if agent == "Legal-Analyzer":
            # Use cached legal analysis from similar RFP
            cached = get_cached_legal_analysis(client, rfp_type)
            if cached and cached.age < 30days:
                fallback_results.append({
                    "agent": "Legal-Analyzer",
                    "result": cached.data,
                    "status": "degraded",
                    "source": "cache",
                    "warning": "Using cached legal analysis"
                })

        elif agent == "Tech-Analyzer":
            # Use simplified tech analysis
            simplified = run_simplified_tech_analysis(rfp)
            fallback_results.append({
                "agent": "Tech-Analyzer",
                "result": simplified,
                "status": "degraded",
                "source": "simplified",
                "warning": "Using simplified technical analysis"
            })

    # Merge successful + fallback results
    all_results = successes + fallback_results

    # Continue with warning
    log_warning(f"Proceeding in DEGRADED MODE with {len(all_results)}/3 analyses")
    proceed_to_next_phase(all_results, mode="degraded")

elif success_count == 1:
    # Too few successes - ABORT
    log_error(f"Only {success_count}/3 analyses succeeded, insufficient data")
    abort_workflow(reason="Insufficient analysis data")
    escalate_to_human(failures)

else:  # success_count == 0
    # Total failure - ABORT
    log_error("All analyses failed")
    abort_workflow(reason="Complete analysis failure")
    escalate_to_human(failures)
```

## OUTPUT

Final report includes degradation status:

```json
{
  "status": "success|degraded|failed",
  "completion": "100%|67%|33%|0%",
  "analyses": {
    "legal": {
      "status": "success|degraded|failed",
      "source": "primary|cache|simplified",
      "warning": "{message}"
    },
    "technical": { ... },
    "financial": { ... }
  },
  "warnings": [
    "Technical analysis used simplified model (degraded quality)",
    "Legal analysis used cached data (30 days old)"
  ],
  "recommendation": "Proceed with caution due to degraded analysis"
}
```
```

### Benchmarks Graceful Degradation

**Scenario : RFP workflow with 15% agent failure rate**

Sans graceful degradation (all-or-nothing) :
- Workflows with 0 failures : 85% × 85% × 85% = 61%
- **Success rate : 61%**
- Failed workflows : 39% (total loss)

Avec graceful degradation (2/3 acceptable) :
- 3/3 success : 61% (perfect)
- 2/3 success : 32% (degraded but usable)
- 1/3 success : 6% (abort)
- 0/3 success : 1% (abort)
- **Success rate : 93%** (61% perfect + 32% degraded)
- **Improvement : +32% success rate**

---

## 📊 Stratégie 4 : Error Aggregation (Batch Processing)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║         BATCH ERROR AGGREGATION STRATEGY                  ║
╚═══════════════════════════════════════════════════════════╝

WITHOUT AGGREGATION (fail fast):
  Batch [Items 1-20]
    ├─> Item 5 fails
    └─> ABORT entire batch (lose 19 successful items)

WITH AGGREGATION (collect all errors):
  Batch [Items 1-20]
    ├─> Item 5 fails → Log error, continue
    ├─> Item 12 fails → Log error, continue
    └─> Complete batch:
        ├─> Successes: 18 (90%)
        ├─> Failures: 2 (10%)
        └─> Return partial results + error report

BENEFITS:
  ✅ Maximize successful items
  ✅ Complete error visibility (all failures reported)
  ✅ Batch-level retry (only retry failed items)
  ✅ Better debugging (see all failure patterns)
```

### Implémentation

```python
# .claude/hooks/batch-processor-resilient.py

def process_batch_with_error_aggregation(items, processor_func):
    """
    Process batch of items, collecting all errors instead of failing fast.

    Args:
        items: List of items to process
        processor_func: Function to process each item

    Returns:
        {
            "successes": [...],
            "failures": [...],
            "success_rate": 0.9,
            "error_summary": {...}
        }
    """

    successes = []
    failures = []
    error_counts = {}

    for i, item in enumerate(items):
        try:
            result = processor_func(item)
            successes.append({
                "item_id": i,
                "item": item,
                "result": result
            })

        except Exception as e:
            error_type = classify_error(e)

            failures.append({
                "item_id": i,
                "item": item,
                "error": str(e),
                "error_type": error_type,
                "stack_trace": traceback.format_exc()
            })

            # Aggregate error counts
            error_counts[error_type] = error_counts.get(error_type, 0) + 1

            log_error(f"Item {i} failed: {e}")

    # Calculate metrics
    total_items = len(items)
    success_count = len(successes)
    failure_count = len(failures)
    success_rate = success_count / total_items if total_items > 0 else 0

    # Generate error summary
    error_summary = {
        "total_errors": failure_count,
        "error_types": error_counts,
        "most_common_error": max(error_counts, key=error_counts.get) if error_counts else None,
        "failure_rate": failure_count / total_items if total_items > 0 else 0
    }

    log_info(
        f"Batch complete: {success_count}/{total_items} succeeded "
        f"({success_rate:.1%}), {failure_count} failed"
    )

    return {
        "successes": successes,
        "failures": failures,
        "success_rate": success_rate,
        "error_summary": error_summary
    }

# USAGE EXAMPLE

items = [item1, item2, item3, ..., item100]

result = process_batch_with_error_aggregation(items, translate_item)

# Decision based on success rate
if result["success_rate"] >= 0.9:
    # 90%+ success → acceptable
    log_success(f"Batch {result['success_rate']:.1%} successful")

    # Retry only failed items (if any)
    if result["failures"]:
        failed_items = [f["item"] for f in result["failures"]]
        retry_result = process_batch_with_error_aggregation(failed_items, translate_item)

        # Merge results
        all_successes = result["successes"] + retry_result["successes"]
        final_success_rate = len(all_successes) / len(items)
        log_success(f"After retry: {final_success_rate:.1%} success")

elif result["success_rate"] >= 0.5:
    # 50-90% success → degraded but usable
    log_warning(
        f"Batch {result['success_rate']:.1%} successful (degraded), "
        f"most common error: {result['error_summary']['most_common_error']}"
    )

    # Return partial results with warning
    return {
        "status": "degraded",
        "results": result["successes"],
        "warning": f"{len(result['failures'])} items failed"
    }

else:
    # <50% success → abort
    log_error(f"Batch only {result['success_rate']:.1%} successful, aborting")
    escalate_to_human(result["error_summary"])
```

### Benchmarks Error Aggregation

**Scenario : Batch translation 100 items, 10% failure rate**

Sans aggregation (fail fast) :
- First failure at item 10
- Successes : 9 (9%)
- Lost : 91 items (not processed)
- Retries : Full batch (100 items)
- Total items processed : 200 (waste)

Avec aggregation (collect all errors) :
- Complete batch despite errors
- Successes : 90 (90%)
- Failures : 10 (10%)
- Retry : Only 10 failed items
- After retry : 95 successes (95%)
- Total items processed : 110
- **Efficiency : 82% better** (110 vs 200 items)

---

## 🔧 Stratégie 5 : Auto-Rollback (CI/CD PostToolUse Hook)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║          AUTO-ROLLBACK DECISION TREE                      ║
╚═══════════════════════════════════════════════════════════╝

DEPLOYMENT STAGES:
  ├─> Staging Deploy
  │   └─> Health Check
  │       ├─> Healthy → Continue
  │       └─> Unhealthy → ROLLBACK (Tier 1)
  │
  ├─> Canary Deploy (5% traffic)
  │   └─> Monitor 5min
  │       ├─> Error rate <1% → Continue
  │       └─> Error rate >1% → ROLLBACK (Tier 2)
  │
  └─> Production Deploy (100% traffic)
      └─> Monitor 10min
          ├─> All healthy → SUCCESS
          └─> Any degradation → ROLLBACK (Tier 3)

ROLLBACK TRIGGERS:
  ├─> Health check fails (HTTP 500, pod crash)
  ├─> Error rate spike (>1% baseline)
  ├─> Latency spike (p95 >500ms)
  ├─> Critical alert (PagerDuty)
  └─> Manual trigger (human decision)

ROLLBACK SPEED:
  ├─> Kubernetes: <2min (rollout undo)
  ├─> Traffic switch: <30s (DNS/load balancer)
  └─> Database: <5min (restore snapshot)
```

### Implémentation

```yaml
# .claude/hooks/auto-rollback.yml

name: auto-rollback
description: Automatic rollback on deployment failure
type: recovery
trigger: PostToolUse (after deploy agent completes)

config:
  health_check_timeout: 300s  # 5min
  error_rate_threshold: 0.01  # 1%
  latency_p95_threshold: 500ms
  min_sample_size: 100  # Min requests before judging

workflow:
  - name: wait-for-stabilization
    duration: 60s  # Wait 1min for deployment to stabilize

  - name: collect-metrics
    duration: 300s  # Monitor for 5min
    mcp: prometheus
    queries:
      - name: error_rate
        query: |
          rate(http_requests_total{status=~"5.."}[5m])
          / rate(http_requests_total[5m])

      - name: latency_p95
        query: |
          histogram_quantile(0.95,
            rate(http_request_duration_seconds_bucket[5m]))

      - name: request_count
        query: |
          sum(rate(http_requests_total[5m])) * 300

  - name: check-health
    conditions:
      - name: sufficient-traffic
        check: request_count >= min_sample_size
        action_if_false: WARN (not enough traffic to judge)

      - name: error-rate-ok
        check: error_rate < error_rate_threshold
        action_if_false: ROLLBACK

      - name: latency-ok
        check: latency_p95 < latency_p95_threshold
        action_if_false: ROLLBACK

      - name: pods-healthy
        mcp: kubernetes
        check: all pods Running and Ready
        action_if_false: ROLLBACK

  - name: rollback-if-needed
    trigger: any condition failed
    steps:
      - name: kubernetes-rollback
        mcp: kubernetes
        command: |
          kubectl rollout undo deployment/{name} -n production
          kubectl rollout status deployment/{name} -n production --timeout=120s

      - name: verify-rollback
        wait: 60s
        checks:
          - pods_healthy: true
          - error_rate: <0.005  # Should be back to baseline
          - latency_p95: <200ms  # Should be back to baseline

      - name: notify-team
        slack: "#incidents"
        pagerduty: true
        message: |
          🚨 AUTO-ROLLBACK EXECUTED

          Deployment: {deployment_name}
          Reason: {failure_reason}
          Metrics:
            - Error rate: {error_rate}% (threshold: {threshold}%)
            - Latency p95: {latency}ms (threshold: {threshold}ms)

          Rollback status: {rollback_status}
          Previous version restored: {previous_version}

          Action required: Investigate deployment failure

      - name: create-incident
        tool: jira
        action: create_issue
        fields:
          type: Incident
          priority: High
          summary: "Auto-rollback: {deployment_name}"
          description: |
            Deployment automatically rolled back due to health check failure.

            See Slack #incidents for details.

exit_codes:
  healthy: 0  # Deployment healthy, no rollback
  rolled_back: 1  # Rollback executed successfully
  rollback_failed: 2  # Rollback attempted but failed (critical!)
```

### Benchmarks Auto-Rollback

**Scenario : 100 deployments, 5% would cause production issues**

Sans auto-rollback (manual detection) :
- Issues detected : 5 (5%)
- Detection time : 15-30min (human monitoring)
- Rollback time : 15-30min (manual process)
- Total MTTR : 30-60min
- Downtime : 5 × 45min = 225min
- Customer impact : HIGH (extended outages)

Avec auto-rollback (automated) :
- Issues detected : 5 (5%, same)
- Detection time : <5min (automated health checks)
- Rollback time : 2min (automated kubectl undo)
- Total MTTR : 5min
- Downtime : 5 × 5min = 25min
- Customer impact : LOW (brief canary issues only)
- **MTTR improvement : 9x faster** (45min → 5min)
- **Downtime reduction : 89%** (225min → 25min)

---

## 🎯 Stratégie 6 : P1 Approval Pattern (Security Incidents)

### Principe

```
╔═══════════════════════════════════════════════════════════╗
║         HUMAN-IN-LOOP FOR CRITICAL DECISIONS              ║
╚═══════════════════════════════════════════════════════════╝

SEVERITY CLASSIFICATION:
  P1 (Critical) : Data breach, production down, security incident
  P2 (High)     : Feature broken, performance degraded
  P3 (Medium)   : Minor bug, cosmetic issue
  P4 (Low)      : Enhancement, documentation

DECISION MATRIX:
  ┌─────────┬──────────────────────┬────────────────────┐
  │ Severity│ Auto-Execute?        │ Human Approval?    │
  ├─────────┼──────────────────────┼────────────────────┤
  │ P1      │ ❌ NO                │ ✅ REQUIRED        │
  │ P2      │ ⚠️ WITH CONFIRMATION │ ✅ RECOMMENDED     │
  │ P3      │ ✅ YES               │ ❌ NOT NEEDED      │
  │ P4      │ ✅ YES               │ ❌ NOT NEEDED      │
  └─────────┴──────────────────────┴────────────────────┘

P1 APPROVAL WORKFLOW:
  1. AI detects incident (severity = P1)
  2. AI prepares response plan
  3. STOP and request human approval
  4. Human reviews plan (approve/reject/modify)
  5. AI executes approved plan
  6. Human monitors execution
```

### Implémentation

```yaml
# .claude/workflows/security-incident-response.md (excerpt)

---
name: security-incident-response
description: Handles security incidents with human approval for P1
---

## PHASE 1: DETECTION & ANALYSIS

AGENT: Threat-Detector
  ├─> Monitors logs, alerts, anomalies
  └─> Classifies severity (P1/P2/P3/P4)

## PHASE 2: RESPONSE PLANNING

AGENT: Response-Planner
  ├─> Analyzes incident
  ├─> Generates response plan:
      ├─> Containment steps (block IPs, disable accounts)
      ├─> Investigation steps (collect logs, analyze traffic)
      ├─> Remediation steps (patch vulnerability, rotate keys)
      └─> Communication plan (notify stakeholders)

## PHASE 3: DECISION GATE

HOOK: Human-Approval (if severity = P1)

```python
if incident.severity == "P1":
    # CRITICAL INCIDENT - HUMAN APPROVAL REQUIRED

    # Prepare approval request
    approval_request = {
        "incident_id": incident.id,
        "severity": "P1 (CRITICAL)",
        "type": incident.type,
        "detected_at": incident.timestamp,
        "impact": incident.impact_assessment,
        "affected_systems": incident.affected_systems,
        "proposed_plan": response_plan,
        "estimated_downtime": "15-30 minutes",
        "risk_if_delayed": "Data breach exposure continues"
    }

    # Send to on-call security team
    pagerduty.create_incident(
        title=f"P1 Security Incident: {incident.type}",
        urgency="high",
        body=approval_request
    )

    slack.send_message(
        channel="#security-incidents",
        message=format_approval_request(approval_request),
        buttons=["Approve", "Reject", "Modify"]
    )

    email.send(
        to="security-oncall@company.com",
        subject=f"🚨 P1 Approval Required: {incident.type}",
        body=approval_request
    )

    # WAIT for human decision (timeout: 10min)
    decision = wait_for_approval(timeout=600)

    if decision == "APPROVED":
        log_audit("P1 plan approved by {approver}")
        # Proceed to execution
        execute_response_plan(response_plan)

    elif decision == "MODIFIED":
        log_audit("P1 plan modified by {approver}")
        modified_plan = get_modified_plan()
        # Execute modified plan
        execute_response_plan(modified_plan)

    elif decision == "REJECTED":
        log_audit("P1 plan rejected by {approver}, reason: {reason}")
        # Escalate to higher authority
        escalate_to_ciso(incident, response_plan, rejection_reason)

    else:  # TIMEOUT
        # No decision within 10min
        log_critical("P1 approval timeout, escalating to CISO")
        pagerduty.escalate(incident_id)
        # Default to safest action: containment only
        execute_containment_only(response_plan.containment_steps)

elif incident.severity == "P2":
    # HIGH SEVERITY - CONFIRMATION RECOMMENDED
    slack.send_message(
        channel="#security-incidents",
        message=f"P2 incident detected, auto-executing in 60s unless stopped",
        buttons=["Stop", "Proceed Now"]
    )

    # Wait 60s for human to stop if needed
    decision = wait_for_confirmation(timeout=60)

    if decision == "STOP":
        wait_for_human_plan()
    else:
        execute_response_plan(response_plan)

else:  # P3, P4
    # LOW/MEDIUM SEVERITY - AUTO-EXECUTE
    log_info(f"{incident.severity} incident, auto-executing response")
    execute_response_plan(response_plan)
```

## AUDIT TRAIL

All P1 decisions logged to immutable audit log:

```json
{
  "timestamp": "2025-01-15T10:00:00Z",
  "incident_id": "INC-2025-001",
  "severity": "P1",
  "type": "SQL Injection Attempt",
  "proposed_plan": {...},
  "approver": "security-oncall@company.com",
  "decision": "APPROVED",
  "decision_time": "2025-01-15T10:03:45Z",
  "execution_started": "2025-01-15T10:03:50Z",
  "execution_completed": "2025-01-15T10:18:30Z",
  "outcome": "Incident contained, no data breach"
}
```
```

### Benchmarks Human-in-Loop

**Scenario : 100 security incidents**

| Severity | Count | Auto-Execute | Human Approval | Avg Decision Time |
|----------|-------|--------------|----------------|-------------------|
| P1 | 5 | ❌ NO | ✅ YES | 3-5 min |
| P2 | 20 | ⚠️ WITH CONFIRM | ✅ RECOMMENDED | 1 min (or timeout) |
| P3 | 50 | ✅ YES | ❌ NO | 0 min (instant) |
| P4 | 25 | ✅ YES | ❌ NO | 0 min (instant) |

**Time to Resolution** :
- P1 avec human-in-loop : 3-5min (decision) + 10min (execution) = 15min
- P1 sans human (hypothetical) : 0min (decision) + 10min (execution) = 10min
- **Trade-off : +5min for safety** (but prevents catastrophic errors)

**Error Prevention** :
- P1 false positives without human : 20% (AI over-reacts)
- P1 false positives with human : 2% (human filters)
- **Improvement : 90% reduction in false alarms**

---

## ✅ DO / ❌ DON'T

### ✅ DO

```
✅ Implement 4-tier fallback chains
   Try → Retry → Fallback → Report

✅ Use exponential backoff for retries
   1s, 2s, 4s delays (prevent overwhelming)

✅ Enable graceful degradation
   90% complete > 0% complete

✅ Aggregate errors in batch processing
   Collect all failures, retry only failed items

✅ Auto-rollback on deployment failures
   <5min MTTR vs 45min manual

✅ Require human approval for P1 incidents
   Safety > Speed for critical decisions

✅ Log comprehensive error context
   Stack traces, inputs, retry attempts
```

### ❌ DON'T

```
❌ Fail fast without retries
   Transient errors (rate limits) often succeed on retry

❌ Retry indefinitely
   Max 3 retries (then escalate)

❌ Abort workflow on single agent failure
   Graceful degradation allows partial success

❌ Process batch sequentially with fail-fast
   Lose all progress on first failure

❌ Deploy to production without health checks
   Silent failures cause extended outages

❌ Auto-execute P1 actions without human
   Catastrophic error risk too high

❌ Suppress error details
   Debugging impossible without context
```

---

## 🎓 Points Clés

### Fallback Strategies

✅ **4-tier fallback** : Try → Retry → Fallback → Report
✅ **Exponential backoff** : 1s, 2s, 4s, 8s (prevent thundering herd)
✅ **Retry budget** : Max 3 retries/agent, 20 total/workflow

### Graceful Degradation

✅ **Partial success** : 2/3 agents OK = proceed with warning
✅ **Reduced quality** : Haiku fallback if Sonnet fails
✅ **Cached data** : Stale data > no data (if <1h old)

### Error Handling

✅ **Error aggregation** : Collect all failures in batch
✅ **Batch-level retry** : Retry only failed items (not entire batch)
✅ **Comprehensive logging** : Stack traces, inputs, context

### Auto-Recovery

✅ **Auto-rollback** : <5min MTTR (vs 45min manual)
✅ **Health checks** : Error rate <1%, p95 latency <500ms
✅ **Canary deploys** : Detect issues before full rollout

### Human-in-Loop

✅ **P1 approval** : Critical decisions require human sign-off
✅ **Timeout handling** : Default to safest action if no response
✅ **Audit trail** : Immutable logs for compliance

---

## 📚 Ressources

### Documentation Interne

- 📄 [Orchestration Principles](../orchestration-principles.md)
- 📄 [Enterprise RFP Workflow](../4-workflows/enterprise-rfp.md)
- 📄 [CI/CD Pipeline Workflow](../4-workflows/ci-cd-pipeline.md)
- 📄 [Security Incident Response Workflow](../4-workflows/security-incident-response.md)

### Patterns Connexes

- 📄 [Cost Optimization](./cost-optimization.md)
- 📄 [Performance Optimization](./performance.md)
- 📄 [Team Collaboration](./team-collaboration.md)

---

**Suivez ces stratégies pour construire des workflows resilients avec 98%+ success rate !**

---

## Error Handling Patterns (Merged from patterns/)

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
- 📄 [Command-Agent-Skill Pattern](../3-architecture/command-coordinator-workers.md) - Architecture base
- 📄 [Parallel Execution](../2-patterns/3-parallelization.md) - Patterns concurrents
- 📄 [State Management](../3-architecture/state-management.md) - Gestion état & recovery
- 📄 [MCP Guide](../../themes/5-mcp/guide.md) - Configuration MCP servers
- 📄 [Hooks Guide](../../themes/3-hooks/guide.md) - Automation avec hooks
- 📄 [Interactive UI](../3-architecture/interactive-ui.md) - AskUserQuestion patterns

### Documentation Externe
- 📄 [Claude Code Hooks](https://code.claude.com/docs/hooks) - Events et automation
- 📄 [Context7 MCP](https://github.com/context7/mcp-server) - Docs fallback source
- 📄 [Perplexity AI](https://docs.perplexity.ai/) - Search API patterns

### Repos Communauté
- 🔗 [fix-grammar plugin](https://github.com/wshobson/commands) - Retry pattern example
- 🔗 [pr-review-toolkit](https://github.com/edmund-io/edmunds-claude-code) - Error aggregation
