# Hook Automation - Lifecycle Pattern

**Niveau** : Production
**Prérequis** : Hooks, Orchestration Principles

---

## 📚 Vue d'Ensemble

Le **Hook Automation Pattern** permet d'automatiser le lifecycle de vos workflows sans intervention manuelle.

> **"Hooks = Automation. Si vous faites quelque chose manuellement 2+ fois, automatisez avec un hook."**

```
╔═══════════════════════════════════════════════════╗
║         HOOKS = LIFECYCLE AUTOMATION              ║
╚═══════════════════════════════════════════════════╝
                       ↓
        ┌──────────────┴──────────────┐
        │  Trigger automatically on:   │
        │  • Tool use (before/after)   │
        │  • Agent lifecycle           │
        │  • Session events            │
        │  • User prompts              │
        └──────────────────────────────┘
```

---

## 🎯 Hook Types & Use Cases

### 1. PreToolUse - Validation Gates

**Trigger** : BEFORE any tool is used
**Purpose** : Validate inputs, prevent destructive actions
**Use Cases** : Security checks, quality gates, approval workflows

```yaml
# .claude/hooks/pre-tool-use/quality-gate.md
---
description: Block deployment if test coverage <80%
trigger: before tool Bash(npm run deploy)
---

IF tool is Bash AND command contains "deploy":
  Check test coverage (read coverage/coverage-summary.json)

  IF coverage <80%:
    BLOCK deployment
    Report: "❌ Coverage too low: {coverage}% (require 80%+)"
  ELSE:
    ALLOW deployment
    Report: "✅ Coverage OK: {coverage}%"
```

**Real Example** : CI/CD Pipeline

```
┌────────────────────────────────────────────┐
│         CI/CD Pipeline                     │
│                                            │
│  Test Phase Complete                       │
│         ↓                                  │
│  ┌──────────────────────┐                 │
│  │ PreToolUse Hook:     │                 │
│  │ Quality-Gate         │                 │
│  │                      │                 │
│  │ Check coverage:      │                 │
│  │ - Unit: 87% ✅      │                 │
│  │ - Integration: 76%   │                 │
│  │ - Overall: 81% ✅   │                 │
│  └──────────────────────┘                 │
│         ↓                                  │
│  Coverage >80% → ALLOW Deploy             │
│         ↓                                  │
│  Deploy Phase Proceeds                     │
└────────────────────────────────────────────┘
```

---

### 2. PostToolUse - Audit & Logging

**Trigger** : AFTER tool is used successfully
**Purpose** : Audit actions, log metrics, trigger follow-ups
**Use Cases** : Security audit, cost tracking, compliance

```yaml
# .claude/hooks/post-tool-use/security-audit.md
---
description: Log all destructive operations for compliance
trigger: after tool Bash(rm), Bash(git push --force), etc.
---

IF tool is destructive (rm, force push, DROP TABLE, etc.):
  Log to audit trail:
  - Timestamp
  - Tool used
  - Arguments
  - User
  - Result

  IF operation is on production:
    Send alert to SOC team
    Require post-incident review
```

**Real Example** : Security Incident Response

```
┌────────────────────────────────────────────────┐
│      Security Incident Response                │
│                                                │
│  Containment Agent: Block malicious IP        │
│         ↓                                      │
│  Bash(iptables -A INPUT -s 192.0.2.1 -j DROP) │
│         ↓                                      │
│  ┌──────────────────────────────┐             │
│  │ PostToolUse Hook:            │             │
│  │ Security-Audit               │             │
│  │                              │             │
│  │ Log:                         │             │
│  │ - Time: 2025-01-15 14:32:15  │             │
│  │ - Tool: iptables             │             │
│  │ - IP blocked: 192.0.2.1      │             │
│  │ - Reason: Malware C2         │             │
│  │ - Approved by: SOC-Manager   │             │
│  └──────────────────────────────┘             │
│         ↓                                      │
│  Alert sent to SOC + Incident logged          │
└────────────────────────────────────────────────┘
```

---

### 3. SubagentStop - Result Aggregation

**Trigger** : AFTER agent completes
**Purpose** : Collect results, aggregate metrics, trigger next phase
**Use Cases** : Multi-agent coordination, batch processing

```yaml
# .claude/hooks/subagent-stop/aggregate-results.md
---
description: Aggregate results from all translation agents
trigger: after each translation agent completes
---

Store result in session context:
- Language: {language}
- Status: {success/failure}
- File path: {output_path}
- Word count: {word_count}
- Duration: {time_taken}

IF all agents completed:
  Aggregate metrics:
  - Total languages: 15
  - Successes: 14
  - Failures: 1 (zh-CN)
  - Total words translated: 45,230
  - Total time: 22 minutes
  - Cost: $12.50

  Report to COMMAND for final summary
```

**Real Example** : Global Localization

```
┌─────────────────────────────────────────────────┐
│       Global Localization Pipeline              │
│                                                 │
│  15 Translation Agents (parallel)               │
│         ↓         ↓         ↓                   │
│     Agent-ES  Agent-FR  Agent-DE  ...           │
│         ↓         ↓         ↓                   │
│  ┌───────────────────────────────────────────┐ │
│  │ SubagentStop Hook (after each agent):    │ │
│  │                                           │ │
│  │ Agent 1 (ES): ✅ Success                 │ │
│  │ Agent 2 (FR): ✅ Success                 │ │
│  │ Agent 3 (DE): ✅ Success                 │ │
│  │ ...                                       │ │
│  │ Agent 14 (JA): ✅ Success                │ │
│  │ Agent 15 (ZH): ❌ Failed (API timeout)   │ │
│  │                                           │ │
│  │ All 15 completed → Aggregate:            │ │
│  │ - Successes: 14/15 (93%)                 │ │
│  │ - Failures: 1 (zh-CN - retry needed)     │ │
│  │ - Total time: 22 min                     │ │
│  └───────────────────────────────────────────┘ │
│         ↓                                       │
│  Report to COMMAND: "14/15 languages done,     │
│  retry zh-CN with Context7 fallback"           │
└─────────────────────────────────────────────────┘
```

---

### 4. SessionStart - Initialization

**Trigger** : START of Claude Code session
**Purpose** : Initialize context, load config, setup environment
**Use Cases** : Project setup, environment validation

```yaml
# .claude/hooks/session-start/project-init.md
---
description: Initialize project context for RFP workflows
trigger: session start
---

Load project configuration:
- Read .claude/CLAUDE.md (Memory)
- Load company profile
- Load template library
- Verify MCP servers (Contracts-DB, ERP, etc.)

Validate environment:
- Check API keys exist (1Password)
- Verify database connections
- Load Translation-Memory skill
- Check disk space >10GB

Report initialization status:
✅ Memory loaded
✅ MCP servers connected (3/3)
✅ Skills loaded (2/2)
✅ Environment ready
```

---

### 5. UserPromptSubmit - Input Validation

**Trigger** : BEFORE user prompt is processed
**Purpose** : Validate user input, prevent malformed requests
**Use Cases** : Security filtering, input sanitization

```yaml
# .claude/hooks/user-prompt-submit/security-filter.md
---
description: Block potentially malicious prompts
trigger: before user prompt submitted
---

Scan prompt for:
- SQL injection attempts
- Command injection patterns
- Malicious file paths (../../etc/passwd)
- Dangerous commands (rm -rf /, DROP DATABASE)

IF malicious pattern detected:
  BLOCK prompt
  Alert user: "❌ Potentially unsafe command detected"
  Log attempt for security review

ELSE:
  ALLOW prompt to proceed
```

---

## 🏗️ Hook Coordination Patterns

### Pattern 1: Validation Chain (PreToolUse)

**Use Case** : Multi-step validation before critical action

```
┌────────────────────────────────────────┐
│         Deploy to Production           │
└────────────────────────────────────────┘
                  ↓
    ┌─────────────────────────┐
    │ PreToolUse Hook Chain:  │
    │                         │
    │ 1. Check tests pass     │
    │    → Coverage >80% ✅   │
    │         ↓               │
    │ 2. Check security scan  │
    │    → 0 critical vuln ✅ │
    │         ↓               │
    │ 3. Check human approval │
    │    → SOC approved ✅    │
    │         ↓               │
    │ All gates passed → ALLOW│
    └─────────────────────────┘
                  ↓
          Deploy proceeds
```

**Implementation**:

```yaml
# Hook 1: Test Coverage
---
trigger: before Bash(deploy)
---
Check coverage >80%
BLOCK if failed

# Hook 2: Security Scan
---
trigger: before Bash(deploy)
---
Check security scan (0 critical vulns)
BLOCK if failed

# Hook 3: Human Approval
---
trigger: before Bash(deploy)
---
Check approval in .claude/approvals/deploy-{date}.txt
BLOCK if not approved
```

---

### Pattern 2: Audit Trail (PostToolUse)

**Use Case** : Comprehensive logging for compliance

```
┌─────────────────────────────────────────┐
│      Destructive Operation              │
│  (delete user account)                  │
└─────────────────────────────────────────┘
                   ↓
     ┌─────────────────────────┐
     │ PostToolUse Hook:       │
     │                         │
     │ 1. Log to audit.json    │
     │    - Timestamp          │
     │    - Tool used          │
     │    - Arguments          │
     │    - User               │
     │    - Result             │
     │         ↓               │
     │ 2. Send to SIEM         │
     │    - Splunk event       │
     │         ↓               │
     │ 3. Notify compliance    │
     │    - Email SOC team     │
     └─────────────────────────┘
                   ↓
     Compliance trail complete
```

---

### Pattern 3: Progressive Aggregation (SubagentStop)

**Use Case** : Real-time progress tracking during batch processing

```
┌──────────────────────────────────────────┐
│     Batch Processing (200 locales)       │
│                                          │
│  Wave 1: Agents 1-20                     │
│         ↓                                │
│  ┌────────────────────────────┐         │
│  │ SubagentStop Hook:         │         │
│  │                            │         │
│  │ Agent 1 done → Progress: 1/200 (0.5%)│
│  │ Agent 2 done → Progress: 2/200 (1.0%)│
│  │ ...                        │         │
│  │ Agent 20 done → Progress: 20/200 (10%)│
│  └────────────────────────────┘         │
│         ↓                                │
│  Wave 2: Agents 21-40                    │
│         ↓                                │
│  ... Progress updates ...                │
│         ↓                                │
│  Wave 10: Agents 181-200                  │
│         ↓                                │
│  Agent 200 done → Progress: 200/200 (100%)│
│         ↓                                │
│  Final aggregation + report              │
└──────────────────────────────────────────┘
```

---

## 💡 Implementation Examples

### Example 1: Auto-Rollback Hook (CI/CD)

```yaml
# .claude/hooks/post-tool-use/auto-rollback.md
---
description: Automatically rollback deployment if health checks fail
trigger: after tool Bash(deploy-to-production.sh)
---

Wait 60 seconds for deployment to stabilize

Run health checks:
- API endpoint: https://api.example.com/health
- Response time <500ms
- Error rate <1%
- Memory usage <80%

IF any health check fails:
  Trigger rollback:
  - Run rollback-to-previous.sh
  - Restore previous version
  - Alert DevOps team

  Report:
  "❌ Deployment failed health checks. Auto-rollback complete.
  Previous version restored. Incident logged."

ELSE:
  Report:
  "✅ Deployment successful. All health checks passed."
```

**Flow**:
```
Deploy Agent → Bash(deploy.sh) → PostToolUse Hook
                                       ↓
                              Health checks (60s)
                                       ↓
                          ┌────────────┴────────────┐
                          │                         │
                    PASS ✅                    FAIL ❌
                          │                         │
                   Report success      Auto-rollback
                                      + Alert team
```

---

### Example 2: Cost Tracking Hook (Resource Monitoring)

```yaml
# .claude/hooks/post-tool-use/cost-tracker.md
---
description: Track API costs for budget monitoring
trigger: after any MCP tool use (Context7, Perplexity, etc.)
---

Extract cost from tool result:
- Tool: {tool_name}
- Tokens used: {tokens}
- Cost estimate: {cost}

Append to session cost tracker:
.claude/sessions/{session-id}/costs.json

Update running total:
- Total cost: ${total}
- Budget remaining: ${budget - total}

IF cost exceeds budget threshold (>$100):
  Alert user:
  "⚠️ Session cost: ${total} (Budget: $100)
  Consider using cheaper fallbacks or batching requests."

Report after session:
"Session cost summary:
- Context7: $45
- Perplexity: $12
- Firecrawl: $8
- Total: $65 (Budget: $100, Remaining: $35)"
```

---

### Example 3: P1 Incident Approval Hook (Security)

```yaml
# .claude/hooks/pre-tool-use/p1-approval.md
---
description: Require human approval for P1 incident responses
trigger: before destructive security actions
---

IF severity == "P1" AND action is destructive:
  Check for approval file:
  .claude/approvals/incident-{incident-id}-approval.txt

  IF approval file exists:
    Verify approver is SOC manager
    Verify timestamp <5 minutes old
    ALLOW action to proceed

  ELSE:
    BLOCK action
    Prompt user:
    "❌ P1 incident requires SOC manager approval.

    Create approval file:
    echo 'APPROVED by {soc-manager} at {timestamp}' > \
      .claude/approvals/incident-{id}-approval.txt

    Then retry command."

IF severity == "P2" or lower:
  ALLOW action (auto-remediation)
```

**Flow**:
```
┌──────────────────────────────────────────┐
│ Security Incident (P1)                   │
│ Containment action: Block malicious IPs │
└──────────────────────────────────────────┘
                  ↓
    ┌─────────────────────────┐
    │ PreToolUse Hook:        │
    │ P1-Approval             │
    │                         │
    │ Check approval file...  │
    │         ↓               │
    │   ┌─────┴─────┐        │
    │   │           │        │
    │ EXISTS    NOT EXISTS   │
    │   │           │        │
    │   ↓           ↓        │
    │ ALLOW       BLOCK      │
    │ Action      + Prompt   │
    │            "Get SOC    │
    │             approval"  │
    └─────────────────────────┘
```

---

## 🎯 Best Practices

### ✅ DO

**1. Use hooks for repetitive tasks**
```yaml
✅ Correct:
Hook: Quality-Gate (runs automatically before every deploy)

❌ Incorrect:
Manual check before each deploy (error-prone)
```

**2. Keep hooks focused**
```yaml
✅ Correct:
Hook: check-test-coverage.md (single responsibility)

❌ Incorrect:
Hook: check-everything.md (tests, security, docs, etc.)
```

**3. Chain hooks for complex workflows**
```yaml
✅ Correct:
PreToolUse:
  1. check-coverage.md
  2. check-security.md
  3. check-approval.md

❌ Incorrect:
One mega-hook with all validations (hard to maintain)
```

**4. Provide clear error messages**
```yaml
✅ Correct:
"❌ Coverage too low: 76% (require 80%+)
Run: npm run test:coverage
Then retry deploy."

❌ Incorrect:
"Coverage check failed."
```

---

### ❌ DON'T

**1. Don't use hooks for one-time tasks**
```yaml
❌ WRONG:
Hook for task that runs once per project

✅ CORRECT:
Use COMMAND or manual action
```

**2. Don't make hooks too complex**
```yaml
❌ WRONG:
Hook with 200 lines of logic

✅ CORRECT:
Hook calls specialized agent if logic >50 lines
```

**3. Don't forget to handle errors**
```yaml
❌ WRONG:
Hook assumes all checks pass

✅ CORRECT:
Hook handles failures gracefully (clear messages, fallbacks)
```

**4. Don't create hook conflicts**
```yaml
❌ WRONG:
Two PreToolUse hooks that BLOCK same tool

✅ CORRECT:
Combine into single hook or use conditions
```

---

## 📊 Hook Lifecycle

```
┌───────────────────────────────────────────────┐
│            HOOK LIFECYCLE                     │
└───────────────────────────────────────────────┘
                     ↓
         ┌───────────────────────┐
         │ 1. SessionStart       │
         │    Initialize         │
         └───────────────────────┘
                     ↓
         ┌───────────────────────┐
         │ 2. UserPromptSubmit   │
         │    Validate input     │
         └───────────────────────┘
                     ↓
         ┌───────────────────────┐
         │ 3. PreToolUse         │
         │    Validate before    │
         └───────────────────────┘
                     ↓
         ┌───────────────────────┐
         │ 4. Tool Executes      │
         │    (if allowed)       │
         └───────────────────────┘
                     ↓
         ┌───────────────────────┐
         │ 5. PostToolUse        │
         │    Audit after        │
         └───────────────────────┘
                     ↓
         ┌───────────────────────┐
         │ 6. SubagentStop       │
         │    Aggregate results  │
         └───────────────────────┘
                     ↓
         ┌───────────────────────┐
         │ 7. SessionEnd         │
         │    Cleanup            │
         └───────────────────────┘
```

---

## 🎓 Points Clés

✅ **Hooks = Automation** - Éliminent intervention manuelle
✅ **PreToolUse** = Validation gates (quality, security, approval)
✅ **PostToolUse** = Audit trail (logging, metrics, compliance)
✅ **SubagentStop** = Result aggregation (progress, final report)
✅ **SessionStart** = Initialization (config, environment)
✅ **Chain hooks** = Complex workflows (validation → audit → aggregation)
✅ **Clear errors** = User-friendly messages avec instructions

**Impact** : Automation complète = 0 erreur manuelle + compliance garantie ✨

---

## 📚 Ressources

### Documentation Interne
- 🎓 [Orchestration Principles](../orchestration-principles.md)
- 🔗 [Command Coordination](./command-coordination.md)
- 🔗 [Agent Orchestration](./agent-orchestration.md)
- 🚀 [Workflows](../4-workflows/README.md)

### Documentation Officielle
- 📄 [Hooks Guide](https://code.claude.com/docs/en/hooks-guide)
- 📄 [Lifecycle Events](https://code.claude.com/docs/en/hooks-guide#lifecycle-events)

### Workflows Utilisant Ce Pattern
- 🎯 [CI/CD Pipeline](../4-workflows/ci-cd-pipeline.md) - Quality gates + auto-rollback
- 🎯 [Security Incident Response](../4-workflows/security-incident-response.md) - P1 approval + audit
- 🎯 [Global Localization](../4-workflows/global-localization.md) - Progress aggregation

---

**Prochaines Étapes** :
1. Créer votre premier hook (PreToolUse quality gate)
2. Lire [Agent Orchestration](./agent-orchestration.md) pour optimiser execution
3. Combiner hooks dans workflows production
