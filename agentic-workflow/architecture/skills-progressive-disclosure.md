# Pattern: Skill Invocation Lifecycle & isMeta Messages

**Status**: ✅ VALIDATED - Architecture interne des Skills Claude Code
**Date**: 2025-01-17
**Sources**:
- [Claude Skills Deep Dive](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/) by Lee Hanchung (Technical Deep Dive)
- [Official Claude Code Skills Docs](https://docs.claude.com/en/docs/claude-code/skills)

---

## 📐 Vue d'Ensemble

Ce document détaille **comment les Skills fonctionnent en interne** dans Claude Code, depuis la découverte jusqu'à l'exécution. Comprendre ce mécanisme permet de créer des Skills optimaux et de debugger les problèmes d'invocation.

**Concept Clé** : Skills = Prompt-based Meta-Tool Architecture

```
╔═══════════════════════════════════════════════════════════╗
║         SKILL INVOCATION COMPLETE LIFECYCLE               ║
╚═══════════════════════════════════════════════════════════╝

PHASE 1: DISCOVERY (Startup)
    │
    ├─> Claude Code scans skill directories
    ├─> Loads SKILL.md files (frontmatter only)
    ├─> Builds skills list (name + description)
    └─> Filters by token budget (15,000 chars max)

PHASE 2: PRESENTATION (Every API Request)
    │
    ├─> Skill tool description generated dynamically
    ├─> <available_skills> section formatted
    ├─> Each skill: "name": description + when_to_use
    └─> Sent to Claude in tools array (NOT system prompt)

PHASE 3: SELECTION (Claude LLM Reasoning)
    │
    ├─> User prompt: "Extract text from report.pdf"
    ├─> Claude reads <available_skills>
    ├─> LLM reasoning: "PDF → pdf skill"
    ├─> Returns tool_use: {name: "Skill", input: {command: "pdf"}}
    └─> NO algorithmic matching, pure transformer decision

PHASE 4: EXECUTION (System Message Injection)
    │
    ├─> Validation: skill exists, not disabled
    ├─> Permission check: allow/deny/ask rules
    ├─> Load SKILL.md full content
    ├─> Generate 2 messages (metadata + prompt)
    ├─> Inject into conversation context
    ├─> Modify execution context (tools + model)
    └─> Continue conversation with enriched context

PHASE 5: TASK EXECUTION (Claude with Skill Context)
    │
    ├─> Claude receives skill prompt (isMeta: true)
    ├─> Follows skill instructions
    ├─> Uses pre-approved tools
    └─> Returns result to user
```

---

## Phase 1: Skill Discovery

### Scan Locations

Claude Code scans multiple locations in order:

```
PRIORITY 1: Project Skills (highest)
  .claude/skills/*/SKILL.md

PRIORITY 2: User Skills
  ~/.claude/skills/*/SKILL.md

PRIORITY 3: Plugin Skills
  Defined by installed plugins

PRIORITY 4: Built-in Skills
  Hardcoded in Claude Code
```

### Discovery Process

```typescript
// Pseudo-code du processus de découverte

async function getAllSkills() {
  // Load from all sources in parallel
  const [projectSkills, userSkills, pluginSkills, builtinSkills] =
    await Promise.all([
      loadSkills('.claude/skills/'),
      loadSkills('~/.claude/skills/'),
      loadPluginSkills(),
      getBuiltinSkills()
    ]);

  // Filter: Must have description OR when_to_use
  const validSkills = [...projectSkills, ...userSkills, ...pluginSkills, ...builtinSkills]
    .filter(skill =>
      skill.type === 'prompt' &&
      skill.isSkill === true &&
      !skill.disableModelInvocation &&
      (skill.description || skill.whenToUse)
    );

  return validSkills;
}

async function loadSkill(skillPath) {
  const content = readFile(`${skillPath}/SKILL.md`);
  const { frontmatter, markdown } = parseFrontmatter(content);

  return {
    type: 'prompt',
    name: frontmatter.name,
    description: frontmatter.description,
    whenToUse: frontmatter.when_to_use,  // ← Note: underscores!
    allowedTools: parseTools(frontmatter['allowed-tools']),
    model: frontmatter.model === 'inherit' ? undefined : frontmatter.model,
    isSkill: true,
    disableModelInvocation: frontmatter['disable-model-invocation'] || false,
    promptContent: markdown,
    baseDir: skillPath
  };
}
```

### Filtering Criteria

**Skill MUST have** :
- ✅ `type === 'prompt'` (not command)
- ✅ `isSkill === true` (marked as skill)
- ✅ `!disableModelInvocation` (auto-invocation enabled)
- ✅ `description` OR `when_to_use` present

**Example** :

```yaml
# ✅ VALID - Will be discovered
---
name: pdf-processor
description: Extract text from PDFs. Use for PDF processing.
---

# ✅ VALID - Has when_to_use
---
name: xlsx-processor
when_to_use: When user wants to analyze Excel files
---

# ❌ INVALID - No description or when_to_use
---
name: broken-skill
---

# ❌ INVALID - Disabled auto-invocation
---
name: manual-only-skill
description: Manual skill
disable-model-invocation: true
---
```

---

## Phase 2: Skill Presentation

### Tools Array Structure

Skills are presented to Claude via the **Skill tool** (capital S) in the tools array :

```json
{
  "model": "claude-sonnet-4-5",
  "system": "You are Claude Code...",
  "messages": [...],
  "tools": [
    {
      "name": "Skill",  // ← Meta-tool (capital S)
      "description": "Execute a skill within the main conversation\n\n<skills_instructions>\n...\n</skills_instructions>\n\n<available_skills>\n\"pdf\": Extract text from PDFs - Use for PDF processing\n\"xlsx\": Process Excel files - Use for spreadsheet work\n\"skill-creator\": Create new skills - When user wants to build custom skill\n</available_skills>",
      "input_schema": {
        "type": "object",
        "properties": {
          "command": {
            "type": "string",
            "description": "The skill name (no arguments)"
          }
        },
        "required": ["command"]
      }
    },
    {"name": "Read", "description": "..."},
    {"name": "Write", "description": "..."},
    {"name": "Bash", "description": "..."}
  ]
}
```

**Key Points** :
- ✅ Skills live in **tools array** (NOT system prompt)
- ✅ Skill tool aggregates ALL available skills
- ✅ Each skill formatted: `"name": description [+ when_to_use]`
- ✅ Token budget: 15,000 chars for `<available_skills>`

### Skill Formatting

```typescript
function formatSkill(skill) {
  // Combine description + when_to_use with hyphen separator
  let description = skill.whenToUse
    ? `${skill.description} - ${skill.whenToUse}`
    : skill.description;

  // Add source annotation
  const sourceLabel = `(${skill.source})`;  // e.g., "(plugin:pdf-tools)"

  return `"${skill.name}": ${description} ${sourceLabel}`;
}

// Example outputs:
// "pdf": Extract text from PDFs. Use for PDF processing. (user)
// "xlsx": Process Excel files - When user wants spreadsheet analysis (plugin:office-suite)
```

### Token Budget Management

```typescript
// Skill tool has 15,000 char budget for <available_skills>

function buildAvailableSkills(skills) {
  let totalChars = 0;
  const includedSkills = [];

  // Sort by priority (project > user > plugin > builtin)
  const sortedSkills = sortByPriority(skills);

  for (const skill of sortedSkills) {
    const formatted = formatSkill(skill);

    if (totalChars + formatted.length > 15000) {
      break;  // Budget exceeded, stop adding skills
    }

    includedSkills.push(formatted);
    totalChars += formatted.length;
  }

  return includedSkills.join('\n');
}
```

**Implication** : Skills with shorter descriptions have better chance of being included if budget is tight.

---

## Phase 3: Skill Selection (LLM Reasoning)

### No Algorithmic Routing

**CRITICAL** : Claude uses **pure LLM reasoning** to select skills. There is NO:
- ❌ Keyword matching
- ❌ Regex patterns
- ❌ Semantic embeddings
- ❌ Intent classification
- ❌ ML-based routing

### Claude's Decision Process

```
USER PROMPT: "Extract text from report.pdf"
                │
                ▼
CLAUDE RECEIVES:
  - System prompt: "You are Claude Code..."
  - Tools array: [Skill, Read, Write, Bash, ...]
  - User message: "Extract text from report.pdf"
                │
                ▼
CLAUDE READS SKILL TOOL DESCRIPTION:
  <available_skills>
  "pdf": Extract text from PDFs. Use for PDF processing. (user)
  "xlsx": Process Excel files. Use for spreadsheet work. (user)
  "skill-creator": Create new skills. When user wants custom skill. (builtin)
  </available_skills>
                │
                ▼
CLAUDE LLM REASONING (internal):
  "User wants to extract text from report.pdf"
  "This is a PDF file (extension .pdf)"
  "Looking at available skills..."
  "pdf skill description: 'Extract text from PDFs. Use for PDF processing.'"
  "This matches perfectly!"
  "Decision: Invoke Skill tool with command='pdf'"
                │
                ▼
CLAUDE RETURNS TOOL_USE:
  {
    "type": "tool_use",
    "id": "toolu_123abc",
    "name": "Skill",
    "input": {
      "command": "pdf"
    }
  }
```

### Writing Effective Descriptions

**Goal** : Make it easy for Claude's LLM to match user intent to skill.

```yaml
# ✅ EXCELLENT: Action verbs + file types + use cases
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.

# ✅ GOOD: Clear domain + specific use cases
description: Analyze sales data in Excel files and CRM exports. Use for sales reports, pipeline analysis, and revenue tracking.

# ⚠️ OK: Clear but less specific
description: Process Excel files and create charts. Use for spreadsheet work.

# ❌ BAD: Too vague, hard for LLM to match
description: Helps with data

# ❌ BAD: Generic, overlaps with other skills
description: For files

# ❌ BAD: Missing "when to use" guidance
description: PDF processor
```

**Best Practice** : Include file extensions, formats, and explicit use cases.

---

## Phase 4: Skill Execution (Message Injection)

### The Two-Message Pattern

When Claude invokes a skill, the system injects **2 separate user messages** :

```
TURN 1 (User → Claude):
  User: "Extract text from report.pdf"

TURN 2 (Claude → System):
  Claude: tool_use {name: "Skill", input: {command: "pdf"}}

TURN 3 (System → Claude): ← TWO MESSAGES INJECTED

  MESSAGE 1 (isMeta: false - VISIBLE to user):
  <command-message>The "pdf" skill is loading</command-message>
  <command-name>pdf</command-name>

  MESSAGE 2 (isMeta: true - HIDDEN from UI, SENT to API):
  You are a PDF processing specialist.

  Your task is to extract text from PDF documents using the pdftotext tool.

  ## Process
  1. Validate that the PDF file exists
  2. Run pdftotext command to extract text
  3. Read the output file
  4. Present the extracted text to the user

  ## Tools Available
  You have access to:
  - Bash(pdftotext:*) - For running pdftotext command
  - Read - For reading extracted text
  - Write - For saving results if needed

  ## Output Format
  Present the extracted text clearly formatted.

  Base directory: /Users/user/.claude/skills/pdf
  User arguments: report.pdf

  [... full skill prompt, 500-5000 words ...]

TURN 4 (Claude continues with enriched context):
  Claude: "I'll extract text from report.pdf. Let me process the file..."
  [Uses Bash tool with pre-approved permission]
```

### The isMeta Flag

**Purpose** : Control message visibility in UI while still sending to API.

```typescript
interface Message {
  role: "user" | "assistant";
  content: string | ToolUseBlock[];
  isMeta?: boolean;  // ← Controls UI visibility
  autocheckpoint?: boolean;
}

// isMeta: false (default) → Message VISIBLE in UI
// isMeta: true → Message HIDDEN from UI, SENT to API
```

### Why Two Messages?

**Problem** : Single message forces impossible choice :
- If `isMeta: false` → Full skill prompt clutters UI (5000 words!)
- If `isMeta: true` → No transparency about which skill activated

**Solution** : Two messages with different `isMeta` values :

| Aspect | Metadata Message (isMeta: false) | Skill Prompt Message (isMeta: true) |
|--------|----------------------------------|-------------------------------------|
| **Audience** | Human user | Claude (AI) |
| **Purpose** | Status/transparency | Instructions/guidance |
| **Length** | ~50-200 chars | ~500-5,000 words |
| **Format** | Structured XML | Natural language markdown |
| **Visibility** | Should be visible | Should be hidden |
| **Content** | "What is happening?" | "How to do it?" |
| **Processing** | Parsed for UI display | Sent directly to API |

### Message Generation

```typescript
// Pseudo-code de génération des messages

async function executeSkillTool(skillName, context) {
  // Load skill
  const skill = getSkill(skillName);
  const skillPrompt = await skill.getPromptForCommand("", context);

  // MESSAGE 1: Metadata (VISIBLE)
  const metadata = [
    `<command-message>The "${skill.userFacingName()}" skill is loading</command-message>`,
    `<command-name>${skill.userFacingName()}</command-name>`
  ].join('\n');

  // MESSAGE 2: Skill prompt (HIDDEN)
  // Prepend base directory path for {baseDir} variable
  const fullPrompt = `${skillPrompt}\n\nBase directory: ${skill.baseDir}`;

  // Create messages array
  const messages = [
    {
      role: "user",
      content: metadata,
      isMeta: false  // ← VISIBLE in UI
    },
    {
      role: "user",
      content: fullPrompt,
      isMeta: true  // ← HIDDEN from UI, SENT to API
    }
  ];

  // Add permissions message if needed
  if (skill.allowedTools.length > 0 || skill.model) {
    messages.push({
      role: "user",
      content: {
        type: "command_permissions",
        allowedTools: skill.allowedTools,
        model: skill.model
      },
      isMeta: true
    });
  }

  return {
    type: "result",
    data: {success: true, commandName: skillName},
    newMessages: messages,
    contextModifier: createContextModifier(skill)
  };
}
```

### Execution Context Modification

**Beyond message injection**, skills modify the execution context :

```typescript
function createContextModifier(skill) {
  return function contextModifier(context) {
    let modified = context;

    // 1. Pre-approve tools (no user prompt)
    if (skill.allowedTools.length > 0) {
      modified = {
        ...modified,
        async getAppState() {
          const state = await context.getAppState();
          return {
            ...state,
            toolPermissionContext: {
              ...state.toolPermissionContext,
              alwaysAllowRules: {
                ...state.toolPermissionContext.alwaysAllowRules,
                command: [
                  ...state.toolPermissionContext.alwaysAllowRules.command || [],
                  ...skill.allowedTools  // ← Pre-approve these tools
                ]
              }
            }
          };
        }
      };
    }

    // 2. Override model if specified
    if (skill.model) {
      modified = {
        ...modified,
        options: {
          ...modified.options,
          mainLoopModel: skill.model
        }
      };
    }

    return modified;
  };
}
```

**Result** :
- ✅ `allowed-tools` → Claude can use without user prompt
- ✅ `model` → Overrides session model (e.g., use haiku for speed)

---

## Phase 5: Task Execution

### Claude Receives Enriched Context

After skill invocation, Claude continues with:

1. **Conversation context** : All previous messages + skill prompt (isMeta: true)
2. **Execution context** : Modified tool permissions + model override
3. **User's original request** : Still in context

```
CLAUDE'S EFFECTIVE CONTEXT:

System Prompt:
  "You are Claude Code..."

Messages:
  1. User: "Extract text from report.pdf"
  2. Assistant: tool_use Skill(command="pdf")
  3. User: "<command-message>pdf loading</command-message>" (visible)
  4. User: [FULL PDF SKILL PROMPT] (hidden via isMeta: true) ← INJECTED
  5. User: {command_permissions: allowedTools: ["Bash(pdftotext:*)", "Read"]} (hidden)

Execution Context:
  - allowed-tools: ["Bash(pdftotext:*)", "Read"] pre-approved
  - model: inherit (using session model)

Claude now reasons with skill instructions and executes task.
```

### Execution Flow

```
CLAUDE (with PDF skill context):
  "I'll extract text from report.pdf using pdftotext."

  [Following skill instructions]
  1. ✅ Validate PDF exists (Read tool)
  2. ✅ Run pdftotext (Bash tool - pre-approved!)
  3. ✅ Read output file
  4. ✅ Present to user

RESULT:
  User sees extracted text, unaware of internal skill mechanics.
```

---

## 🎓 Key Learnings

### Skills Meta-Architecture

✅ **Skill tool (capital S)** = Meta-tool in tools array
✅ **skills (lowercase s)** = Individual skills (pdf, xlsx, etc.)
✅ **Selection** = LLM reasoning (no algorithmic matching)
✅ **Execution** = Prompt injection + context modification

### Two-Message Pattern

✅ **Message 1 (isMeta: false)** = User-facing transparency (~50-200 chars)
✅ **Message 2 (isMeta: true)** = Hidden instructions for Claude (~500-5000 words)
✅ **Why split?** = Transparency without information overload

### Progressive Disclosure

✅ **Level 1** : Frontmatter → Minimal for discovery (name + description)
✅ **Level 2** : SKILL.md → Full instructions if selected
✅ **Level 3** : Bundled resources → Loaded on-demand via {baseDir}

### Execution Context

✅ **allowed-tools** → Pre-approved, no user prompt
✅ **model** → Override session model (haiku/sonnet/opus)
✅ **Scoped to skill** → Returns to normal after execution

---

## 📚 Ressources

### Documentation Interne

- 📄 [Command/Agent/Skill Pattern](./command-agent-skill.md)
- 📄 [Orchestration Principles](../orchestration-principles.md)

### Documentation Externe

- 📄 [Claude Skills Deep Dive](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/) by Lee Hanchung (Technical)
- 📄 [Official Skills Docs](https://docs.claude.com/en/docs/claude-code/skills)
- 📄 [Anthropic Engineering Blog](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

---

**Comprendre cette architecture permet de créer des Skills optimaux et de debugger les problèmes d'invocation !**
