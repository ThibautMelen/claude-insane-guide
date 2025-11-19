# 📋 Workflow Structure - Quick Reference

> **Guide rapide** : Templates essentiels pour structurer vos workflows Claude Code.
> Pour guide détaillé → [STRUCTURE-TEMPLATE.md](./STRUCTURE-TEMPLATE.md)

---

## ⚡ CRITICAL: Philosophy Dan

```
1. Start with /command (the primitive)
2. Test & Validate
3. Compose to Skill IF repeat + auto-invoke needed
4. NEVER skip steps 1-2
```

📚 **[Core 4 & Fundamentals](../themes/8-advanced/core-4-fundamentals.md)**

---

## 📦 1. Component Inventory (Copy/Paste)

```markdown
### 📦 Component Inventory

#### ⚡ Slash Commands
| Command | File | Purpose | Trigger |
|---------|------|---------|---------|
| `/example` | `.claude/commands/example.md` | Description | 👤 Manual |

**Total**: X

#### 🤖 Skills
| Skill | File | Purpose | Type |
|-------|------|---------|------|
| `@example` | `.claude/skills/example/SKILL.md` | Description | 📚 Knowledge / 🏗️ Composition |

**Total**: X

#### 🧑‍💼 Sub-Agents
| Agent | Invoked By | Purpose | Parallel |
|-------|-----------|---------|----------|
| `@agent` | `/command` | Description | ✅ YES |

**Total**: X

#### 🔌 MCP Servers
| MCP | Purpose | Tools | Service |
|-----|---------|-------|---------|
| `mcp-name` | Description | `tool1`, `tool2` | API name |

**Total**: X

#### 🎣 Hooks (Optional)
| Hook | Event | Purpose |
|------|-------|---------|
| `hook-name` | `before-commit` | Description |

**Total**: X

#### 🧠 Memory
| Type | File | Scope |
|------|------|-------|
| User | `~/.claude/CLAUDE.md` | Global |
| Project | `.claude/CLAUDE.md` | Project |
```

---

## 🏗️ 2. Component Roles (Template)

```markdown
### 🏗️ Component Roles

#### Main Orchestrator: `/command-name`
**Role**: Orchestrate entire workflow
**Why**: 👤 Manual trigger, ⚡ Primitive, 🏗️ Orchestration

#### Skills: `@skill-name`
**Role**: Knowledge base + Composition
**Why**: 🤖 Auto-invoked, 📈 Progressive disclosure

#### Sub-Agents: `@agent-name`
**Role**: Parallel execution
**Why**: ⚡ Parallelizable, 🔒 Isolated context

#### MCP: `mcp-name`
**Role**: External data
**Why**: 🔌 Live data, API/DB access

#### Hooks: `hook-name` (Optional)
**Role**: Auto-validation
**Why**: 🎣 Event-driven, deterministic
```

---

## 📊 3. Architecture Diagram (Mermaid)

```markdown
### 📊 Architecture Diagram

\`\`\`mermaid
graph TB
    subgraph "WORKFLOW NAME"
        CMD[/command-name<br/>Orchestrator]

        CMD -->|orchestrates| LOGIC[Workflow Logic]

        LOGIC -->|reads| SK[🤖 Skill<br/>Knowledge Base]
        LOGIC -->|launches| SA[🧑‍💼 Sub-Agents<br/>Parallel]
        LOGIC -->|queries| MCP[🔌 MCP Server<br/>External Data]

        SA -->|reads from| SK
        SA -->|queries| MCP
    end

    style CMD fill:#c8e6c9,stroke:#2e7d32,stroke-width:3px
    style SK fill:#fff9c4,stroke:#f57f17,stroke-width:2px
    style SA fill:#bbdefb,stroke:#1565c0,stroke-width:2px
    style MCP fill:#e1bee7,stroke:#6a1b9a,stroke-width:2px
\`\`\`
```

---

## 🔄 4. Workflow Flow (Sequence)

```markdown
### 🔄 Workflow Flow

\`\`\`mermaid
sequenceDiagram
    participant U as User
    participant C as /command
    participant SK as Skill
    participant A as Sub-Agent
    participant M as MCP

    U->>C: /command arg1 arg2
    C->>C: 1. Validate args
    C->>SK: 2. Load knowledge
    SK-->>C: Knowledge loaded

    par Parallel Execution
        C->>A: Launch agent-1
        C->>A: Launch agent-2
    end

    A->>M: Query external data
    M-->>A: Data returned
    A-->>C: Results

    C->>C: 3. Aggregate results
    C->>U: Report success
\`\`\`
```

---

## 💻 5. Implementation Quick Template

### Command File

```markdown
---
description: Brief command description
allowed-tools: Read, Write, Task, Bash
argument-hint: <required-arg> [optional]
---

You are the workflow coordinator...

## Workflow

1. PARSE ARGUMENTS
   - Validate required args
   - Parse optional flags

2. STRATEGY DECISION
   - Single item → Process directly
   - Multiple items → Launch parallel agents

3. LAUNCH AGENTS (if parallel)
   - Task tool with subagent_type
   - Pass minimal context

4. AGGREGATE & REPORT
   - Collect results
   - Count success/failures
   - Report to user
```

### Agent File

```markdown
---
name: agent-name
description: Brief agent description
color: blue|green|yellow|red
model: haiku|sonnet|opus
---

You are [Agent Role]...

## Instructions

1. Load knowledge from @skill-name
2. Process single task
3. Query MCP if needed
4. Return structured result

## Output Format

\`\`\`
✓ Task completed (Xs)
- Result: X
\`\`\`
```

### Skill File

```markdown
---
name: skill-name
description: What skill does + when to use (specific!)
allowed-tools: Read, Write, Bash
model: haiku
---

You provide [domain knowledge]...

## Knowledge Base

- Structure templates in references/
- Validation rules in references/
- Examples in assets/

## Composition

This skill can:
- Use /command-name
- Use mcp-server-name
- Launch @agent-name
```

---

## 🎯 6. Usage Example

```markdown
### 🎯 Usage

\`\`\`bash
# Single item
/command arg1

# Multiple items
/command arg1 arg2 arg3

# With flags
/command arg1 --flag=value
\`\`\`

**Expected Output**:
\`\`\`
✅ Processed 3 items
- Success: 2
- Failed: 1 (error details)
\`\`\`
```

---

## 📚 7. References

```markdown
### 📚 References

**Related Docs**:
- [Core 4 & Fundamentals](../themes/8-advanced/core-4-fundamentals.md)
- [Decision Trees](../themes/8-advanced/decision-trees.md)
- [Pattern Guide](./patterns/command-agent-skill.md)

**Related Workflows**:
- Link to similar workflows
```

---

## ✅ Checklist

Avant de publier votre workflow, vérifier :

- [ ] ✅ Component Inventory complet (tous les components listés)
- [ ] ✅ Component Roles expliqués (pourquoi chaque feature)
- [ ] ✅ Architecture Diagram (Mermaid visual)
- [ ] ✅ Workflow Flow (sequence diagram)
- [ ] ✅ Implementation (code templates fournis)
- [ ] ✅ Usage Examples (au moins 2 exemples)
- [ ] ✅ References (liens vers docs/workflows)
- [ ] ✅ Follows Dan's philosophy (Command → Test → Compose)

---

## 📖 Next Steps

**Need detailed guide?** → [STRUCTURE-TEMPLATE.md](./STRUCTURE-TEMPLATE.md) (full version)

**Real example?** → [patterns/command-agent-skill.md](./patterns/command-agent-skill.md)

**Understand philosophy?** → [Core 4 & Fundamentals](../themes/8-advanced/core-4-fundamentals.md)
