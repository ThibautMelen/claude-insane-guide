# 🏢 Patterns Enterprise : Governance & Team Coordination

> **Durée estimée** : 120 minutes
> **Niveau** : 🔴 Expert
> **Prérequis** : Maîtrise Memory, Hooks, Plugins

## 📚 Introduction

Les patterns enterprise permettent de **standardiser Claude Code à l'échelle d'une organisation** : équipes multiples, projets partagés, governance centralisée.

**Cas d'usage** :
- 🏢 **Entreprises** avec >10 développeurs utilisant Claude Code
- 👥 **Teams distribuées** nécessitant conventions partagées
- 🔒 **Compliance** : Politiques de sécurité, audits, RGPD
- 📋 **Standardisation** : Shared plugins, MCP servers, workflows

---

## 📐 Core Pattern: Hierarchical Governance

```
╔════════════════════════════════════════════╗
║      Enterprise Memory Hierarchy           ║
╚════════════════════════════════════════════╝

🏢 ENTERPRISE Workspace
   (Admins control)
       ↓
   ┌───────────────────────────────────┐
   │ - Security policies               │
   │ - Approved MCP servers            │
   │ - Shared plugins                  │
   │ - Company conventions             │
   └───────────────────────────────────┘
       ↓ (inherited by all users)
       ↓
👤 USER Memory
   (~/.claude/CLAUDE.md)
       ↓
   ┌───────────────────────────────────┐
   │ - Personal preferences            │
   │ - Can EXTEND enterprise           │
   │ - Cannot OVERRIDE policies        │
   └───────────────────────────────────┘
       ↓
       ↓
📦 PROJECT Memory
   (.claude/CLAUDE.md)
       ↓
   ┌───────────────────────────────────┐
   │ - Project-specific config         │
   │ - Can OVERRIDE user (if allowed)  │
   │ - Must COMPLY with enterprise     │
   └───────────────────────────────────┘
```

**Principes clés** :
- **Top-down policies** : Enterprise impose règles globales
- **Selective override** : User/Project peuvent étendre (pas overrider policies)
- **Audit trail** : Hooks tracent toute action pour compliance
- **Centralized distribution** : Plugins/MCP via workspace, pas install individuel

---

## 1️⃣ Enterprise Workspace Setup

### Concept

Créer un **workspace centralisé** (dossier partagé) contenant configs, plugins, policies pour toute l'organisation.

### Structure Workspace

```
📦 ~/enterprise-claude/ (shared network drive ou git repo)
┣━━ 📄 CLAUDE.md (enterprise memory)
┣━━ 📁 .claude/
┃   ┣━━ 📁 plugins/ (shared plugins)
┃   ┃   ┣━━ 📦 code-review-policy/
┃   ┃   ┃   ┣━━ 📄 plugin.json
┃   ┃   ┃   ┗━━ 📄 README.md
┃   ┃   ┣━━ 📦 security-scanner/
┃   ┃   ┗━━ 📦 compliance-checker/
┃   ┣━━ 📁 hooks/ (global hooks)
┃   ┃   ┣━━ 📄 before-commit.md (audit trail)
┃   ┃   ┣━━ 📄 after-mcp-call.md (log API usage)
┃   ┃   ┗━━ 📄 subagent-stop.md (validate outputs)
┃   ┣━━ 📁 skills/ (shared knowledge)
┃   ┃   ┣━━ 📄 security-best-practices.md
┃   ┃   ┣━━ 📄 gdpr-compliance.md
┃   ┃   ┗━━ 📄 tech-stack-standards.md
┃   ┗━━ 📄 config.json (MCP servers)
┗━━ 📁 audit-logs/ (compliance)
    ┗━━ 📄 2025-01-17.log
```

### Exemple: Enterprise CLAUDE.md

```markdown
# Enterprise Claude Code Standards - Acme Corp

**Version**: 2.0
**Last Updated**: 2025-01-17
**Maintainer**: DevOps Team (devops@acme.com)

---

## 🔒 Security Policies (CANNOT BE OVERRIDDEN)

### Secrets Management
- ❌ **NEVER** commit secrets to git
- ✅ **ALWAYS** use 1Password CLI or AWS Secrets Manager
- 🔒 **MANDATORY** hook: `before-commit` scans for secrets

### Code Review
- ✅ **MANDATORY** : All code changes reviewed by Claude plugin `@code-review-policy`
- 📋 **MINIMUM** : 2 approvals (1 human + 1 AI) before merge
- 🔍 **AUTOMATED** : Security scan via `@security-scanner` plugin

### Data Privacy (GDPR Compliance)
- 🛡️ **PII Detection** : Hook `before-mcp-call` blocks PII in API requests
- 📊 **Audit Logs** : All MCP calls logged to `~/enterprise-claude/audit-logs/`
- 🔐 **Data Retention** : Logs kept 90 days, then auto-deleted

---

## 🧰 Approved MCP Servers (WHITELIST)

**Only these MCP servers allowed in production**:

```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@context7/mcp-server"],
      "env": {"API_KEY": "from-1password"}
    },
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "@mendable/firecrawl-mcp"],
      "env": {"API_KEY": "from-aws-secrets"}
    }
  }
}
```

**❌ Blocked MCP servers** (security audit failed):
- `mcp__unapproved__*` → Auto-blocked by hook

---

## 📋 Code Conventions (RECOMMENDED, can be overridden in projects)

### Commit Messages
```
<type>(<scope>): <description>

Types: feat|fix|docs|refactor|test|chore
Scope: component name
Co-Authored-By: Claude <noreply@anthropic.com>
```

### Code Style
- **Language**: TypeScript (strict mode)
- **Indentation**: 2 spaces (default, projects can override)
- **Line length**: 100 chars
- **Testing**: 80% coverage minimum

---

## 🔌 Shared Plugins (AUTO-INSTALLED)

**All users get these plugins automatically**:

1. **@code-review-policy** : Enforce code review standards
2. **@security-scanner** : Scan for vulnerabilities (OWASP Top 10)
3. **@compliance-checker** : GDPR, SOC2 compliance validation

**Installation**: Symlinked from `~/enterprise-claude/.claude/plugins/` to user `~/.claude/plugins/`

---

## 📚 Shared Skills (READ-ONLY)

**Knowledge base available to all projects**:

- 📄 `@security-best-practices` : OWASP, secure coding
- 📄 `@gdpr-compliance` : Data privacy, PII handling
- 📄 `@tech-stack-standards` : Approved libraries, versions

**Usage**: Import in project commands via `@skill-name`

---

## 🎯 Governance Hooks (ENFORCED)

### before-commit
- Scan for secrets (API keys, passwords)
- Validate commit message format
- Block if security scan fails

### after-mcp-call
- Log all API requests to audit trail
- Block PII in requests
- Track API usage per user/project

### subagent-stop
- Validate agent outputs against policies
- Reject outputs containing secrets or PII
```

---

## 2️⃣ Team Memory Hierarchy

### Concept

Organiser **Memory** sur 3 niveaux avec **permissions** : Enterprise (admins) > User (individual) > Project (team).

### Permission Matrix

| Level | Who Controls | Can Override | Use Case |
|-------|-------------|--------------|----------|
| **Enterprise** | Admins (DevOps, Security) | - | Policies, security, compliance |
| **User** | Individual developer | Enterprise ❌, Project ✅ | Personal preferences |
| **Project** | Project lead | User ✅, Enterprise ❌ | Project-specific config |

### Flow de Résolution

```
╔════════════════════════════════════════════╗
║      Memory Resolution with Permissions    ║
╚════════════════════════════════════════════╝

Claude démarre
    ↓
┌────────────────────────────────┐
│ 1. Load ENTERPRISE Memory      │
│    Mark sections as:           │
│    - POLICY (cannot override)  │
│    - RECOMMENDED (can override)│
└────────────────────────────────┘
    ↓
┌────────────────────────────────┐
│ 2. Load USER Memory            │
│    - Can extend RECOMMENDED    │
│    - CANNOT override POLICY    │
└────────────────────────────────┘
    ↓
[User tries to override POLICY?] ────YES───→ ❌ BLOCKED by hook
    │                                        Log violation to audit
    NO
    ↓
┌────────────────────────────────┐
│ 3. Load PROJECT Memory         │
│    - Can override USER         │
│    - CANNOT override ENTERPRISE│
│      POLICY                    │
└────────────────────────────────┘
    ↓
Final config (policies enforced)
```

### Exemple: Policy Enforcement Hook

```yaml
# ~/enterprise-claude/.claude/hooks/memory-loaded.md
---
description: Enforce enterprise policies, block overrides
event: MemoryLoaded
---

You are a policy enforcement agent.

## Workflow

1. **READ LOADED MEMORY**
   - Enterprise policies (marked with 🔒)
   - User overrides attempt
   - Project overrides attempt

2. **VALIDATE AGAINST POLICIES**
   ```
   FOR EACH policy in enterprise_policies:
     IF user_memory OR project_memory overrides policy:
       - Log violation to audit trail
       - Block override
       - Show warning to user:
         "⚠️ Enterprise policy cannot be overridden: {policy_name}"
   ```

3. **AUDIT LOG**
   ```
   Write to ~/enterprise-claude/audit-logs/2025-01-17.log:
   {
     "timestamp": "2025-01-17T10:30:00Z",
     "user": "john.doe",
     "project": "/home/john/project-x",
     "violation": "Attempted to override secret scanning policy",
     "blocked": true
   }
   ```

4. **ALLOW RECOMMENDED OVERRIDES**
   ```
   IF override is for RECOMMENDED setting (not POLICY):
     - Allow override
     - Log to info (not violation)
   ```
```

---

## 3️⃣ Governance & Compliance Hooks

### Concept

Utiliser **hooks** pour **automatiser compliance** : audit trail, PII detection, secret scanning, approvals.

### Hook Architecture

```
╔════════════════════════════════════════════╗
║      Governance Hooks Ecosystem            ║
╚════════════════════════════════════════════╝

┌──────────────────────────────────────┐
│ before-commit Hook                   │
│ - Scan for secrets (regex patterns)  │
│ - Validate commit message format     │
│ - Run security scanner plugin        │
│ - Block if fails                     │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ before-mcp-call Hook                 │
│ - Check MCP server in whitelist     │
│ - Detect PII in request payload      │
│ - Log API call to audit trail        │
│ - Block if PII detected              │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ after-mcp-call Hook                  │
│ - Log response (if not sensitive)    │
│ - Track API usage per user           │
│ - Alert if quota exceeded            │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ subagent-stop Hook                   │
│ - Validate agent output vs policies  │
│ - Redact PII from output             │
│ - Log agent actions                  │
└──────────────────────────────────────┘
    ↓
┌──────────────────────────────────────┐
│ command-complete Hook                │
│ - Generate compliance report         │
│ - Archive logs                       │
│ - Notify admins if violations        │
└──────────────────────────────────────┘
```

### Exemple: Secret Scanning Hook

```yaml
# ~/enterprise-claude/.claude/hooks/before-commit.md
---
description: Scan commits for secrets before allowing commit
event: BeforeCommit
---

You are a secret scanning agent (Acme Corp compliance).

## Workflow

1. **GET STAGED FILES**
   - Run: `git diff --cached --name-only`
   - Read content: `git diff --cached`

2. **SCAN FOR SECRET PATTERNS**
   ```javascript
   const SECRET_PATTERNS = [
     /API[_-]?KEY\s*=\s*['"]?([A-Za-z0-9]{32,})['"]?/gi,
     /SECRET[_-]?KEY\s*=\s*['"]?([A-Za-z0-9]{32,})['"]?/gi,
     /PASSWORD\s*=\s*['"]?([A-Za-z0-9]{8,})['"]?/gi,
     /AWS[_-]?SECRET[_-]?ACCESS[_-]?KEY\s*=\s*['"]?([A-Za-z0-9/+=]{40})['"]?/gi,
     /PRIVATE[_-]?KEY\s*=\s*['"]?(-----BEGIN[^-]+-----[\s\S]+-----END[^-]+-----)['"]?/gi
   ];

   for (const pattern of SECRET_PATTERNS) {
     const match = stagedContent.match(pattern);
     if (match) {
       return {
         blocked: true,
         reason: `Detected secret: ${pattern.source}`,
         file: matchedFile,
         line: matchedLine
       };
     }
   }
   ```

3. **IF SECRET FOUND**
   ```
   ❌ BLOCK COMMIT

   Error:
   ──────────────────────────────────────────
   🔒 SECRET DETECTED (Acme Corp Policy)
   ──────────────────────────────────────────
   File: .env
   Line: 12
   Pattern: API_KEY = "sk_live_abc123..."

   ⚠️ Secrets MUST NOT be committed to git.

   Solutions:
   1. Use 1Password CLI: op://vault/item/field
   2. Use AWS Secrets Manager
   3. Add to .gitignore if config file

   Docs: https://acme.com/security/secrets
   ```

4. **AUDIT LOG**
   ```
   Write to ~/enterprise-claude/audit-logs/secrets.log:
   {
     "timestamp": "2025-01-17T10:30:00Z",
     "user": "john.doe",
     "project": "/home/john/project-x",
     "violation": "Attempted to commit secret in .env",
     "pattern": "API_KEY",
     "blocked": true,
     "file": ".env",
     "line": 12
   }
   ```

5. **ALLOW IF CLEAN**
   ```
   ✅ No secrets detected. Proceed with commit.
   ```
```

### Exemple: PII Detection Hook

```yaml
# ~/enterprise-claude/.claude/hooks/before-mcp-call.md
---
description: Detect PII in MCP requests (GDPR compliance)
event: BeforeMcpCall
---

You are a PII detection agent (GDPR compliance).

## Workflow

1. **READ MCP REQUEST**
   - Tool: mcp__*__*
   - Payload: request body

2. **SCAN FOR PII PATTERNS**
   ```javascript
   const PII_PATTERNS = {
     email: /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/g,
     phone: /\b(\+?\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}\b/g,
     ssn: /\b\d{3}-\d{2}-\d{4}\b/g, // US Social Security Number
     creditCard: /\b\d{4}[\s-]?\d{4}[\s-]?\d{4}[\s-]?\d{4}\b/g,
     ipAddress: /\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b/g
   };

   for (const [type, pattern] of Object.entries(PII_PATTERNS)) {
     const match = requestPayload.match(pattern);
     if (match) {
       return {
         blocked: true,
         pii_type: type,
         matched: match[0]
       };
     }
   }
   ```

3. **IF PII DETECTED**
   ```
   ❌ BLOCK MCP CALL

   Error:
   ──────────────────────────────────────────
   🛡️ PII DETECTED (GDPR Compliance)
   ──────────────────────────────────────────
   Type: Email address
   Value: john.doe@acme.com
   Tool: mcp__perplexity__search

   ⚠️ PII must NOT be sent to external APIs.

   Solutions:
   1. Anonymize data before API call
   2. Use internal MCP server (no external calls)
   3. Get user consent (AskUserQuestion)

   Docs: https://acme.com/compliance/gdpr
   ```

4. **AUDIT LOG**
   ```
   {
     "timestamp": "2025-01-17T10:30:00Z",
     "user": "john.doe",
     "pii_type": "email",
     "mcp_server": "perplexity",
     "blocked": true
   }
   ```
```

---

## 4️⃣ Plugin Distribution Strategy

### Concept

Distribuer **plugins enterprise** à tous les utilisateurs via **symlinks** ou **git repo**, évitant install manuel.

### Distribution Methods

```
╔════════════════════════════════════════════╗
║      Plugin Distribution Strategies        ║
╚════════════════════════════════════════════╝

Method 1: SYMLINKS (Network Drive)
──────────────────────────────────────────
~/enterprise-claude/.claude/plugins/
    ↓ symlink
~/.claude/plugins/ (user's local)

Pros: Auto-updates, centralized
Cons: Requires network access

Method 2: GIT REPO (Distributed)
──────────────────────────────────────────
git clone https://github.com/acme/claude-plugins
cd ~/.claude/plugins
git pull origin main (daily)

Pros: Offline-friendly, versioned
Cons: Manual pull required

Method 3: NPM PACKAGE (Automated)
──────────────────────────────────────────
npm install -g @acme/claude-plugins
Plugins auto-installed to ~/.claude/plugins/

Pros: Fully automated, version control
Cons: Requires npm infra
```

### Exemple: Symlink Setup Script

```bash
#!/bin/bash
# setup-enterprise-claude.sh

ENTERPRISE_DIR="~/enterprise-claude"
USER_CLAUDE_DIR="~/.claude"

echo "🏢 Setting up Acme Corp Claude Code environment..."

# 1. Create symlinks for plugins
echo "📦 Symlinking enterprise plugins..."
ln -sf "$ENTERPRISE_DIR/.claude/plugins/code-review-policy" "$USER_CLAUDE_DIR/plugins/"
ln -sf "$ENTERPRISE_DIR/.claude/plugins/security-scanner" "$USER_CLAUDE_DIR/plugins/"
ln -sf "$ENTERPRISE_DIR/.claude/plugins/compliance-checker" "$USER_CLAUDE_DIR/plugins/"

# 2. Import enterprise memory
echo "🧠 Importing enterprise memory..."
cat >> "$USER_CLAUDE_DIR/CLAUDE.md" <<EOF

## Enterprise Standards (Acme Corp)
<!-- import: $ENTERPRISE_DIR/CLAUDE.md -->
EOF

# 3. Setup hooks
echo "🔗 Installing governance hooks..."
ln -sf "$ENTERPRISE_DIR/.claude/hooks/before-commit.md" "$USER_CLAUDE_DIR/hooks/"
ln -sf "$ENTERPRISE_DIR/.claude/hooks/before-mcp-call.md" "$USER_CLAUDE_DIR/hooks/"

# 4. Configure MCP servers
echo "🔌 Configuring approved MCP servers..."
cp "$ENTERPRISE_DIR/.claude/config.json" "$USER_CLAUDE_DIR/config.json"

echo "✅ Enterprise Claude Code setup complete!"
echo "📄 Review: cat ~/.claude/CLAUDE.md"
```

### Auto-Update Strategy

```yaml
# ~/enterprise-claude/.claude/hooks/daily-update.md (cron job)
---
description: Auto-update enterprise configs daily
event: ScheduledDaily
---

## Workflow

1. **PULL LATEST CONFIGS**
   ```bash
   cd ~/enterprise-claude
   git pull origin main
   ```

2. **NOTIFY USERS OF CHANGES**
   ```
   IF git diff shows changes in:
     - CLAUDE.md → Notify: "Enterprise policies updated"
     - plugins/ → Notify: "New plugin available: {plugin_name}"
     - hooks/ → Notify: "Governance hooks updated, restart Claude"
   ```

3. **LOG UPDATE**
   ```
   {
     "timestamp": "2025-01-17T09:00:00Z",
     "updated_files": ["CLAUDE.md", "plugins/security-scanner"],
     "user_notified": true
   }
   ```
```

---

## 5️⃣ Shared Conventions Across Teams

### Concept

Standardiser **workflows, commands, skills** pour cohérence entre équipes et projets.

### Convention Areas

```
╔════════════════════════════════════════════╗
║      Shared Conventions Ecosystem          ║
╚════════════════════════════════════════════╝

┌────────────────────────────────┐
│ COMMANDS (Workflows)           │
│ - /code-review (standard flow) │
│ - /deploy (with approvals)     │
│ - /onboard-dev (new hire)      │
└────────────────────────────────┘
    ↓
┌────────────────────────────────┐
│ SKILLS (Knowledge)             │
│ - @security-best-practices     │
│ - @tech-stack-standards        │
│ - @gdpr-compliance             │
└────────────────────────────────┘
    ↓
┌────────────────────────────────┐
│ PLUGINS (Automation)           │
│ - @code-review-policy          │
│ - @security-scanner            │
│ - @compliance-checker          │
└────────────────────────────────┘
    ↓
┌────────────────────────────────┐
│ MCP SERVERS (Data)             │
│ - context7 (approved docs)     │
│ - firecrawl (web scraping)     │
│ - NO unapproved servers        │
└────────────────────────────────┘
```

### Exemple: Shared Command - Code Review

```yaml
# ~/enterprise-claude/.claude/commands/code-review.md
---
description: Standard code review workflow (Acme Corp)
allowed-tools: Read, Grep, Task, AskUserQuestion, Bash
---

You are a code review coordinator (Acme Corp standards).

## Workflow

1. **PRE-REVIEW VALIDATION**
   - Check: All tests pass (`npm test`)
   - Check: No secrets in diff (`@security-scanner` plugin)
   - Check: Commit message format (conventional commits)
   - BLOCK if validation fails

2. **AUTOMATED REVIEW** (@code-review-policy plugin)
   - Security: OWASP Top 10 violations
   - Code quality: Complexity, duplication
   - Style: Acme Corp conventions (2 spaces, 100 chars)
   - Testing: Coverage >80%

3. **HUMAN REVIEW REQUEST**
   ```
   AskUserQuestion:
     "Automated review complete. Request human reviewer?"
       - "Yes" → Create PR, assign reviewer
       - "Fix issues first" → Show report, block PR
   ```

4. **APPROVAL LOGIC**
   ```
   Required approvals: 2
     - 1 AI (automated review passed) ✅
     - 1 Human (senior dev) ⏳

   IF both approved:
     - Allow merge
   ELSE:
     - Block merge, show issues
   ```

5. **AUDIT LOG**
   ```
   Log to ~/enterprise-claude/audit-logs/code-reviews.log:
   {
     "pr_id": 123,
     "author": "john.doe",
     "automated_review": "passed",
     "human_reviewer": "jane.smith",
     "approved": true,
     "timestamp": "2025-01-17T10:30:00Z"
   }
   ```
```

### Shared Skill: Tech Stack Standards

```markdown
# ~/enterprise-claude/.claude/skills/tech-stack-standards.md

## Acme Corp Tech Stack (2025)

### Frontend
- **Framework**: React 18+ (functional components only)
- **State**: Zustand (not Redux, unless large app)
- **Styling**: Tailwind CSS 3+
- **Testing**: Vitest + React Testing Library

### Backend
- **Runtime**: Node.js 20 LTS
- **Framework**: Express.js or Fastify
- **Database**: PostgreSQL 15+ (primary), Redis (cache)
- **ORM**: Prisma (preferred) or Drizzle

### DevOps
- **CI/CD**: GitHub Actions
- **Hosting**: AWS (approved regions: us-east-1, eu-west-1)
- **Monitoring**: Datadog
- **Secrets**: 1Password CLI or AWS Secrets Manager

### Deprecated (DO NOT USE)
- ❌ React class components
- ❌ Redux (use Zustand)
- ❌ Heroku (migrated to AWS)
- ❌ MongoDB (use PostgreSQL + JSONB)

**When in doubt**: Ask in #tech-architecture Slack channel.
```

---

## 6️⃣ Security & Access Control

### Concept

Implémenter **access control** : qui peut faire quoi, audit trail pour toute action sensible.

### RBAC Model (Role-Based Access Control)

```
╔════════════════════════════════════════════╗
║      RBAC for Claude Code                  ║
╚════════════════════════════════════════════╝

┌────────────────────────────────┐
│ ADMIN (DevOps, Security)       │
│ - Edit enterprise CLAUDE.md    │
│ - Deploy plugins globally      │
│ - Review audit logs            │
│ - Override any policy          │
└────────────────────────────────┘
    ↓ manages
┌────────────────────────────────┐
│ SENIOR DEV (Team Lead)         │
│ - Edit project CLAUDE.md       │
│ - Approve code reviews         │
│ - Deploy to staging            │
│ - Cannot override enterprise   │
└────────────────────────────────┘
    ↓ manages
┌────────────────────────────────┐
│ JUNIOR DEV (Developer)         │
│ - Edit own code                │
│ - Submit PRs (auto-reviewed)   │
│ - Cannot deploy                │
│ - Cannot access prod secrets   │
└────────────────────────────────┘
```

### Exemple: Access Control Hook

```yaml
# ~/enterprise-claude/.claude/hooks/before-command.md
---
description: Check user permissions before running sensitive commands
event: BeforeCommand
---

You are an access control agent.

## Workflow

1. **IDENTIFY USER ROLE**
   ```bash
   # Read from enterprise config
   USER_ROLE=$(grep "^$(whoami):" ~/enterprise-claude/roles.txt | cut -d: -f2)

   # roles.txt format:
   # john.doe:junior
   # jane.smith:senior
   # admin:admin
   ```

2. **CHECK COMMAND PERMISSIONS**
   ```javascript
   const COMMAND_PERMISSIONS = {
     '/deploy': ['admin', 'senior'],
     '/access-secrets': ['admin'],
     '/edit-enterprise-memory': ['admin'],
     '/code-review': ['admin', 'senior', 'junior'],
     '/generate-locales': ['admin', 'senior', 'junior']
   };

   const command = context.command; // e.g., "/deploy"
   const userRole = context.userRole; // e.g., "junior"

   const allowedRoles = COMMAND_PERMISSIONS[command];

   if (!allowedRoles.includes(userRole)) {
     return {
       blocked: true,
       reason: `User role '${userRole}' not allowed for command '${command}'. Required: ${allowedRoles.join(', ')}`
     };
   }
   ```

3. **IF BLOCKED**
   ```
   ❌ ACCESS DENIED

   Error:
   ──────────────────────────────────────────
   🔒 Insufficient Permissions (Acme Corp)
   ──────────────────────────────────────────
   Command: /deploy
   Your role: Junior Developer
   Required roles: Admin, Senior Developer

   ⚠️ Contact your team lead for deployment.

   Docs: https://acme.com/access-control
   ```

4. **AUDIT LOG**
   ```
   {
     "timestamp": "2025-01-17T10:30:00Z",
     "user": "john.doe",
     "role": "junior",
     "command": "/deploy",
     "blocked": true,
     "reason": "Insufficient permissions"
   }
   ```

5. **ALLOW IF PERMITTED**
   ```
   ✅ Access granted. Proceeding with command.
   ```
```

---

## 🎯 Best Practices

### ✅ DO

1. **Centralize governance** : Enterprise workspace > User > Project
2. **Audit everything** : Logs pour compliance (GDPR, SOC2)
3. **Whitelist MCPs** : Approuver seulement serveurs sécurisés
4. **Automate distribution** : Symlinks ou git pour plugins
5. **Enforce policies** : Hooks bloquent overrides non autorisés
6. **RBAC** : Permissions claires par rôle
7. **Shared conventions** : Commands, skills, plugins standardisés

### ❌ DON'T

1. **Laisser overrider policies** (sécurité compromise)
2. **Secrets dans Memory** (use env vars)
3. **Manual plugin installs** (use centralized distribution)
4. **Skip audit logs** (compliance violation)
5. **Unapproved MCP servers** (security risk)
6. **Ad-hoc conventions** (standardize)

---

## 📋 Cheatsheet Rapide

```bash
# Enterprise Hierarchy
Enterprise CLAUDE.md (policies) → CANNOT override
    ↓
User CLAUDE.md (preferences) → CAN extend
    ↓
Project CLAUDE.md (config) → CAN override user (not enterprise)

# Plugin Distribution
Method 1: Symlinks (network drive)
  ln -sf ~/enterprise/.claude/plugins/* ~/.claude/plugins/

Method 2: Git repo (versioned)
  git clone https://github.com/acme/claude-plugins ~/.claude/plugins

# Governance Hooks
before-commit → Scan secrets
before-mcp-call → Detect PII, check whitelist
subagent-stop → Validate outputs
command-complete → Audit log

# RBAC Roles
Admin → Full access, edit enterprise
Senior → Project config, code review, deploy staging
Junior → Code only, no deploy

# Audit Trail
~/enterprise-claude/audit-logs/
  - secrets.log (secret scanning violations)
  - pii.log (PII detection blocks)
  - access.log (permission denials)
  - code-reviews.log (review approvals)
```

---

## 🎓 Points Clés

1. **Enterprise Memory** : Policies centralisées, non overridables
2. **Hooks pour governance** : Secret scan, PII detection, access control
3. **Plugin distribution** : Symlinks ou git, auto-updates
4. **Audit trail** : Logs pour compliance (GDPR, SOC2)
5. **RBAC** : Admin > Senior > Junior (permissions strictes)
6. **Shared conventions** : Commands, skills, MCP whitelists standardisés
7. **Security first** : Secrets jamais committés, PII jamais en API externe

---

## 📚 Ressources

### Documentation Interne
- 📄 [Memory Guide](../1-memory/guide.md) - Hierarchy & imports
- 📄 [Hooks Guide](../3-hooks/guide.md) - Governance automation
- 📄 [Plugins Guide](../7-plugins/guide.md) - Distribution strategies
- 📄 [State Management](../patterns/state-management.md) - Cross-team coordination
- 📄 [Error Handling](../patterns/error-handling.md) - Audit & compliance

### Documentation Externe
- 📄 [Claude Code Enterprise](https://code.claude.com/docs/enterprise) - Official enterprise features
- 📄 [GDPR Compliance](https://gdpr.eu/) - Data privacy regulations
- 📄 [OWASP Top 10](https://owasp.org/www-project-top-ten/) - Security best practices

### Repos Communauté
- 🔗 [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Enterprise patterns
- 🔗 [Awesome Sub-Agents](https://github.com/VoltAgent/awesome-claude-code-subagents) - Shared workflows
- 🔗 [Security Plugins](https://github.com/search?q=claude-code+security) - Community security tools
