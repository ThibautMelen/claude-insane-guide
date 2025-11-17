# Patterns: Command/Agent/Skill Architecture

**Status**: ✅ VALIDATED - Best practices from Claude Code + LLM orchestration research + Hooks automation
**Date**: 2025-01-12
**Sources**:
- Claude Code official docs: hooks, sub-agents, Agent SDK migration
- Perplexity AI orchestration patterns (2025)
- fix-grammar plugin analysis
- pr-review-toolkit, feature-dev patterns

---

## 📐 Core Pattern: Hierarchical Orchestration

```
COMMAND (Coordinator)
    ↓
  Validates + Decides Strategy
    ↓
  Launches AGENTS (parallel)
    ↓
  AGENTS read SKILL (knowledge)
    ↓
  AGENTS execute (MCPs, tools)
    ↓
  COMMAND aggregates + reports
```

**Key Principles**:
- **Separation of concerns**: COMMAND orchestrates, AGENT executes
- **Concurrent pattern**: Parallel agents for independent tasks
- **Shared knowledge**: SKILL provides common instructions
- **Transparent reporting**: Track sources, errors, timing

---

## 1️⃣ COMMAND Pattern

### Structure

```markdown
---
description: Brief description of what this command does
allowed-tools: Read, Edit, Write, Task, AskUserQuestion
argument-hint: <required-arg> [optional-arg]
---

Instructions for the command coordinator...
```

### Frontmatter (YAML)

| Field | Purpose | Example |
|-------|---------|---------|
| `description` | Short command summary | "Fix grammar in files" |
| `allowed-tools` | Tools command can use | `Read, Edit, Task` |
| `argument-hint` | Argument syntax help | `<file-path> [more...]` |

### Workflow Steps

**Standard pattern observed in Claude Code**:

```
1. PARSE ARGUMENTS
   ├─ Validate required args
   ├─ Parse optional flags
   └─ Error if missing/invalid

2. VALIDATE INPUTS
   ├─ Check file/path existence
   ├─ Validate permissions
   └─ Ask user via AskUserQuestion if needed

3. DECIDE STRATEGY
   ├─ Single item → Process directly
   ├─ Multiple items → Parallel agents
   └─ Batch size optimization (10-20 max)

4. LAUNCH AGENTS
   ├─ Use Task tool with subagent_type
   ├─ Pass minimal context to each agent
   ├─ Launch in parallel (single message, multiple Task calls)
   └─ Wait for completion

5. AGGREGATE RESULTS
   ├─ Collect agent outputs
   ├─ Count success/failures
   └─ Retry failures once if applicable

6. REPORT
   ├─ Show summary statistics
   ├─ List errors/warnings
   └─ Provide actionable next steps
```

### Example: fix-grammar Command

```markdown
---
description: Fix grammar and spelling errors in one or multiple files while preserving formatting
allowed-tools: Read, Edit, Write, Task
argument-hint: <file-path> [additional-files...]
---

You are a grammar correction coordinator. Fix grammar and spelling errors in files while preserving formatting and meaning.

## Workflow

1. **PARSE FILES**: Process file arguments
   - Split arguments into individual file paths
   - **CRITICAL**: At least one file path must be provided
   - **STOP** if no files specified – ask user for file paths

2. **DETERMINE STRATEGY**: Choose processing approach
   - **Single file**: Process directly with grammar corrections
   - **Multiple files**: Launch parallel `@fix-grammar` agents

3. **SINGLE FILE MODE**: Direct processing
   - `Read` the file completely
   - Apply grammar and spelling corrections
   - `Edit` or `Write` to update file

4. **MULTIPLE FILES MODE**: Parallel agent processing
   - **USE TASK TOOL**: Launch `@fix-grammar` agent for each file
   - **PARALLEL EXECUTION**: Process all files simultaneously
   - **AGENT PROMPT**: Only provide the file path to each agent
   - **WAIT**: For all agents to complete before reporting

5. **REPORT RESULTS**: Confirm completion
   - Show files processed
```

### Our Command Structure

```markdown
---
description: Generate technical locale documentation files using MCP-powered data sources
allowed-tools: Read, Write, Glob, Task, AskUserQuestion, Bash
argument-hint: <locale-codes> [--data=<path>]
---

You are the locale generation coordinator...

## Workflow

1. **PARSE ARGUMENTS**
   - Locale codes: single, multiple, pattern (ar-*), all
   - Optional --data flag for local data source

2. **DATA SOURCE HANDLING**
   - If no --data → Ask via AskUserQuestion
   - If path provided → Validate + Parse + Aggregate
   - Report coverage and conflicts

3. **STRATEGY DECISION**
   - Single locale → Launch 1 agent
   - 2-19 locales → Launch all parallel
   - 20+ locales → Batch (10-20 per batch)

4. **LAUNCH AGENTS**
   - Task tool with subagent_type="locale-technical-generator"
   - Pass: locale_code + aggregated_data
   - Parallel execution per batch

5. **AGGREGATE RESULTS**
   - Collect reports from agents
   - Count success/failures
   - Retry failures once

6. **REPORT**
   - Summary: X/Y locales generated
   - Time: parsing + generation
   - Sources breakdown
   - MCP usage statistics
```

---

## 2️⃣ AGENT Pattern

### Structure

```markdown
---
name: agent-name
description: Brief description of what this agent does
color: blue|green|yellow|red
model: haiku|sonnet|opus
---

You are [Agent Role]. Your task is to...

## Instructions

[Focused, step-by-step instructions]

## Output Format

[Structured output template]

## Rules

- [Constraint 1]
- [Constraint 2]
```

### Frontmatter (YAML)

| Field | Purpose | Values |
|-------|---------|--------|
| `name` | Agent identifier | `fix-grammar`, `locale-technical-generator` |
| `description` | Short agent summary | "Fix grammar in a single file" |
| `color` | Visual indicator | `blue`, `green`, `yellow`, `red` |
| `model` | AI model to use | `haiku` (fast/cheap), `sonnet` (balanced), `opus` (powerful) |

### Model Selection Guidelines

**haiku** (recommended for):
- Simple transformations
- Structured data processing
- Following explicit instructions
- Cost optimization (174 locales × haiku = cheaper)

**sonnet** (use when):
- Complex reasoning needed
- Ambiguity resolution
- Quality critical
- Few iterations (< 10 agents)

**opus** (rarely):
- Extremely complex tasks
- Highest quality required
- Single agent execution

### Agent Responsibilities

**DO**:
- ✅ Focus on single task
- ✅ Read SKILL docs for shared knowledge
- ✅ Use MCPs as instructed
- ✅ Validate output before returning
- ✅ Provide structured report

**DON'T**:
- ❌ Try to coordinate other agents
- ❌ Make strategic decisions (COMMAND's job)
- ❌ Duplicate SKILL instructions (reference them)
- ❌ Output verbose explanations (minimal reporting)

### Example: fix-grammar Agent

```markdown
---
name: fix-grammar
description: Use this agent to fix grammar and spelling errors in a single file while preserving formatting
color: blue
model: haiku
---

You are DevProfCorrectorGPT, a professional text corrector. Fix grammar and spelling errors in the specified file while preserving all formatting and meaning.

## File Processing

- Read the target file completely
- Apply grammar and spelling corrections only
- Preserve all formatting, tags, and technical terms
- Do not translate or change word order

## Correction Rules

- Fix only spelling and grammar errors
- Keep the same language used in each sentence
- Preserve all document structure and formatting

## File Update

- Use Edit or Write to update the file with corrections
- Overwrite original file with corrected version

## Output Format

```
✓ Fixed grammar in [filename]
- [number] corrections made
```

## Execution Rules

- Only process the single file provided
- Make minimal changes - corrections only
- Never add explanations or commentary to file content
```

### Our Agent Structure

```markdown
---
name: locale-technical-generator
description: Generate technical locale documentation using MCP-powered data sources for a single locale
color: green
model: haiku
---

You are a technical locale documentation generator. Generate a complete locale file for the specified locale code using the provided data sources and MCP queries.

## Input

- `locale_code`: Target locale (e.g., "ja-JP")
- `aggregated_data`: Pre-parsed local data (optional)

## Workflow

1. **LOAD SKILL**
   - Read @locale-technical-knowledge/skeleton.md for structure
   - Read @locale-technical-knowledge/sources.yaml for field mappings

2. **GENERATE SECTIONS (1-9)**
   For each field in each section:

   a) Check aggregated_data[field]
      → Found & non-empty? USE

   b) Check if derivable (sources.yaml)
      → is_rtl from script_code
      → cluster from locale_code

   c) Query MCP per sources.yaml
      → Context7 for ISO standards
      → Perplexity for current stats
      → Firecrawl for official sources

   d) Fallback if MCP fails
      → Perplexity fail → Try Firecrawl
      → Firecrawl fail → BLOCK (report error to COMMAND)

   e) Track source used
      → local_data | derived | context7 | perplexity | firecrawl

3. **VALIDATE**
   - Read @locale-technical-knowledge/validation-rules.md
   - Check structure (9 sections present)
   - Check semantic (ISO codes valid)
   - Check completeness (no placeholders)

4. **OUTPUT**
   - Write FINAL/locale-technical/{locale_code}.md
   - Use skeleton structure
   - Format per examples

## Output Format

```
✓ {locale_code} generated ({time}s)

Sources breakdown:
- Local data    : X fields
- Derived       : X fields
- Context7      : X fields
- Perplexity    : X fields
- Firecrawl     : X fields

⚠ Warnings:
- [warning 1 if any]
```

## Rules

- Focus on single locale only
- Follow sources.yaml priority strictly
- BLOCK if critical data missing (don't guess)
- Track sources transparently
- Minimal output (structured report only)
```

---

## 3️⃣ SKILL Pattern

### Structure

**Our extension pattern** (not built-in Claude Code, but logical):

```
.claude/skills/{skill-name}/
├── skeleton.md           # Template structure
├── sources.yaml          # Configuration (field → source mapping)
├── best-practices.md     # Usage guide
├── validation-rules.md   # Quality checks
└── examples/             # Reference examples
    ├── example-1.md
    └── example-2.md
```

### Purpose

SKILL provides **shared knowledge** that multiple agents can reference:
- Structure templates (skeleton)
- Configuration (sources mapping)
- Best practices (usage patterns)
- Validation rules (quality checks)

### Equivalent in Claude Code Ecosystem

While not explicitly named "skills", the concept exists:
- **pr-review-toolkit**: 6 agents share scoring rules, confidence thresholds
- **feature-dev**: 7-phase workflow with shared understanding between agents
- **code-review**: Agents share CLAUDE.md conventions for validation

### Our SKILL: locale-technical-knowledge

#### skeleton.md

Defines 9-section structure with field names and descriptions:

```markdown
# Technical Locale Documentation Structure

## Section 1: Core Identity

**Fields**:
- `locale_code` (string, format: xx-XX)
- `language` (string, full name)
- `language_native` (string, native script)
- `country` (string, full name)
- `script_code` (string, ISO 15924)
- `is_rtl` (boolean)
- `primary_keyboard` (string)

**Purpose**: Fundamental locale identification and classification.

[... continues for all 9 sections ...]
```

#### sources.yaml

Maps each field to data source priority and query details:

```yaml
section_1_core_identity:
  locale_code:
    priority: [local_data, derived]
    description: "Locale code in BCP-47 format"

  language:
    priority: [local_data, context7, perplexity]
    fallback:
      context7:
        library: "/unicode/cldr"
        query: "language name for {{locale_code}}"
      perplexity:
        query: "official language name for {{locale_code}}"

  script_code:
    priority: [local_data, context7]
    fallback:
      context7:
        library: "/iso/iso-15924"
        query: "script code for {{language}}"

  is_rtl:
    priority: [local_data, derived]
    derive_from: script_code
    logic: "script_code in ['Arab', 'Hebr'] → true, else false"

  primary_keyboard:
    priority: [local_data, perplexity]
    fallback:
      perplexity:
        query: "standard keyboard layout {{country}} {{language}} 2025"
        recency: "month"
      firecrawl:
        url: "https://en.wikipedia.org/wiki/Keyboard_layout"
        extract: "table for {{country}}"

section_2_formatting_numbers:
  decimal_separator:
    priority: [local_data, context7]
    fallback:
      context7:
        library: "/unicode/cldr"
        topic: "number formatting {{locale_code}}"

  thousands_separator:
    priority: [local_data, context7]
    fallback:
      context7:
        library: "/unicode/cldr"
        topic: "number formatting {{locale_code}}"

  special_cases:
    priority: [perplexity]
    fallback:
      perplexity:
        query: "Does {{currency_code}} use decimal places? Special formatting rules {{country}}"

[... continues for all sections/fields ...]
```

#### best-practices.md

Guides users on preparing local data sources:

```markdown
# Local Data Source Best Practices

## Folder Structure Options

### Option A: Locale-centric (Simple)
One file per locale, all fields in single file.

### Option B: Section-centric (Organized)
One file per section, all locales in single file.

### Option C: Hybrid (Flexible)
Combination of both patterns.

## Priority Rules

When same field in multiple files:
1. Locale-specific > Section-specific > Generic
2. JSON > YAML > CSV > MD (within same level)

## Minimal Bootstrap

10-15 essential fields to bootstrap 174 locales:
- locale_code, language, country, script_code
- decimal_separator, thousands_separator
- date_pattern, time_pattern
- timezone, currency

MCPs will fill the rest (hybrid approach).

[... examples and detailed guidance ...]
```

#### validation-rules.md

Defines quality checks agents must perform:

```markdown
# Validation Rules

## Level 1: Structure
- 9 sections present
- YAML frontmatter valid
- Markdown syntax correct
- No empty sections

## Level 2: Semantic
- `locale_code` format: xx-XX
- ISO codes valid (639-1, 3166-1, 15924, 4217)
- Dates parseable
- Regex patterns compile

## Level 3: Cross-reference
- `script_code` matches `is_rtl`
- `timezone` matches `country`
- `currency` matches `country`
- Examples match declared patterns

## Level 4: Completeness
- No `{{placeholders}}` remaining
- All critical fields filled
- Examples provided
- Edge cases documented

[... detailed rules and regex patterns ...]
```

---

## 🔄 Orchestration Patterns

### Concurrent Pattern (Our Primary)

**Use case**: Multiple independent locales

```
COMMAND launches agents:
├─ AGENT 1 (ja-JP) ─── ⏱️ 35s ──→ ✓
├─ AGENT 2 (en-US) ─── ⏱️ 28s ──→ ✓
├─ AGENT 3 (fr-FR) ─── ⏱️ 31s ──→ ✓
└─ AGENT N (ar-SA) ─── ⏱️ 42s ──→ ✓

Total time: max(35s, 28s, 31s, 42s) = 42s
vs Sequential: 35s + 28s + 31s + 42s = 136s

Speedup: 3.2x for 4 agents
```

**Implementation**:
```markdown
## MULTIPLE LOCALES MODE

Launch all agents in parallel using Task tool:

For each locale_code in locale_list:
  Task(
    subagent_type="locale-technical-generator",
    prompt="Generate {locale_code} using aggregated data",
    description="{locale_code} generation"
  )

Wait for all agents to complete.
Aggregate results.
```

### Batch Pattern (Large Scale)

**Use case**: 174 locales (avoid overwhelming)

```
COMMAND launches batches:

Batch 1 (20 agents) ─── ⏱️ 60s ──→ ✓
Batch 2 (20 agents) ─── ⏱️ 58s ──→ ✓
Batch 3 (20 agents) ─── ⏱️ 62s ──→ ✓
...
Batch 9 (14 agents) ─── ⏱️ 45s ──→ ✓

Total time: 9 batches × ~60s = 9-10 min
```

**Batch size optimization**:
- Too small (5): Many batches, overhead
- Too large (50): Risk timeouts, poor error isolation
- Optimal (10-20): Balance speed + reliability

### Hand-off Pattern (Optional Enhancement)

**Use case**: Quality validation

```
COMMAND
  ↓
AGENT (generation)
  ↓
VALIDATOR AGENT (quality check)
  ↓
  ├─ Pass → Done
  └─ Fail → Report to COMMAND → Retry
```

Could implement later if quality issues detected.

---

## ⚠️ Error Handling Patterns

### COMMAND Level (Fail Fast)

```
1. Validate arguments
   ├─ Missing required → Error + exit
   ├─ Invalid format → Ask user via dialogue
   └─ Valid → Continue

2. Validate data source (if provided)
   ├─ Path not found → Ask for correction
   ├─ Parse error → Report + ask skip or fix
   ├─ Security issue → Block + error
   └─ Valid → Continue

3. Launch agents
   ├─ Agent returns error → Collect for retry
   ├─ Agent timeout → Mark as failed
   └─ Agent success → Collect result

4. Retry failures (once)
   ├─ Success on retry → Mark success
   └─ Fail again → Report error + continue

5. Report
   ├─ Show success/fail counts
   ├─ List errors with details
   └─ Suggest fixes if possible
```

### AGENT Level (Fallback Chain)

```
For each field:

1. Try local_data
   └─ Found → Use

2. Try derivation
   └─ Derivable → Calculate

3. Try MCP Query (sources.yaml)
   ├─ Context7 fail → Try next
   ├─ Perplexity fail → Try Firecrawl
   └─ Firecrawl fail → Report to COMMAND

4. If all fail
   └─ BLOCK generation
   └─ Report: "Cannot fetch {field} for {locale}"
```

**Exit codes** (inspired by hooks pattern):
- `0`: Success, continue
- `1`: Warning (stderr), continue
- `2`: Error, block execution

---

## 📊 Reporting Pattern

### AGENT Report (Minimal)

```
✓ ja-JP generated (35s)

Sources breakdown:
- Local data    : 15 fields (25%)
- Derived       : 8 fields (13%)
- Context7      : 12 fields (20%)
- Perplexity    : 5 fields (8%)
- Firecrawl     : 3 fields (5%)

⚠ Warnings:
- internet_penetration: Perplexity query slow (8s)
```

### COMMAND Report (Comprehensive)

```
✅ Generation complete: 10 locales

Performance:
- Data parsing   : 12s
- Total time     : 3m 45s
- Avg per locale : 22.5s

Results:
- Success        : 8 locales
- Failed         : 2 locales (ar-SA, hi-IN)
- Retry needed   : 0

MCP Usage:
- Context7       : 5 queries (cached after 1st)
- Perplexity     : 35 queries
- Firecrawl      : 8 queries (fallback)

Data Sources:
- Local data     : 120 fields (40%)
- Derived        : 64 fields (21%)
- MCPs           : 116 fields (39%)

Errors:
1. ar-SA: Perplexity timeout for "internet_penetration"
2. hi-IN: Firecrawl blocked for "keyboard_layout"

Next steps:
- Review failed locales
- Retry with /generate-locale-technical ar-SA,hi-IN
- Or provide local data for missing fields
```

---

## 🎯 Key Learnings from Research

### From Claude Code Examples

1. **Frontmatter is declarative**: Metadata only, no logic
2. **Body is imperative**: Step-by-step instructions
3. **Task tool for parallelism**: Not manual orchestration
4. **Minimal agent output**: Structured reports, no verbose explanations
5. **Separation of concerns**: COMMAND coordinates, AGENT executes

### From LLM Orchestration Research (2025)

1. **Hierarchical architecture** suits enterprise workflows (our case)
2. **Concurrent pattern** for independent tasks (our locales)
3. **Specialization** reduces complexity per component
4. **Observability** via transparent reporting (source tracking)
5. **Human oversight** via dialogue for critical decisions

### From Sequential Thinking Analysis

1. **SKILL pattern** extends Claude Code logically (shared knowledge)
2. **Model choice** impacts cost significantly (haiku recommended)
3. **Error handling** at two levels (coordinator + executor)
4. **Folder-based data** requires aggregation phase (COMMAND responsibility)
5. **Priority rules** must be explicit (sources.yaml declarative)

### From Hooks Guide (2025)

1. **Deterministic automation**: Hooks run automatically, not LLM-suggested
2. **Event-driven architecture**: PreToolUse (can block), PostToolUse (validation)
3. **Exit codes matter**: 0=success, 1=warning, 2=block execution
4. **JSON input via stdin**: All hook scripts receive tool data as JSON
5. **Security implications**: Hooks execute with current credentials
6. **Performance impact**: Add ~1-2s per file (acceptable for batch operations)
7. **Scoped matchers**: Target specific tools (Write|Edit) for precision

---

## 🪝 Hooks Pattern (NEW)

### Hook Lifecycle Events

```
┌──────────────────────────────────────────────┐
│  USER PROMPT                                 │
└────────┬─────────────────────────────────────┘
         │
         ▼
    UserPromptSubmit Hook (optional)
         │
         ▼
┌────────────────────────────────────────────┐
│  CLAUDE REASONING                           │
└────────┬───────────────────────────────────┘
         │
         ▼
    PreToolUse Hook ← Can BLOCK execution
         │
         ▼
┌────────────────────────────────────────────┐
│  TOOL EXECUTION (Write, Edit, Bash, etc.)  │
└────────┬───────────────────────────────────┘
         │
         ▼
    PostToolUse Hook ← Validation/formatting
         │
         ▼
┌────────────────────────────────────────────┐
│  CLAUDE CONTINUES                           │
└────────┬───────────────────────────────────┘
         │
         ▼
    Stop Hook ← After Claude completes
```

### Hook Configuration Pattern

**Location**: `.claude/settings.json` (project) or `~/.claude/settings.json` (user)

**Structure**:
```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolName|ToolName2",
        "hooks": [
          {
            "type": "command",
            "command": "shell command that receives JSON via stdin"
          }
        ]
      }
    ]
  }
}
```

### Hook Best Practices

**From Perplexity research 2025**:

1. **Use jq for JSON parsing**: Robust, handles edge cases
   ```bash
   jq -r '.tool_input.file_path'
   ```

2. **Smart dispatching**: Single entry point, route to specific handlers
   ```bash
   # Bad: Multiple hooks for same event
   # Good: One hook, internal routing
   python3 .claude/hooks/dispatcher.py
   ```

3. **Parallel validation**: Run independent checks concurrently
   ```bash
   validate_yaml.py & validate_structure.py & wait
   ```

4. **Graceful fallbacks**: Non-critical hooks shouldn't block
   ```bash
   python3 optional_check.py || true  # Exit 0 even if fails
   ```

5. **Performance monitoring**: Log execution time
   ```bash
   start=$(date +%s)
   # ... validation logic ...
   echo "Hook took $(($(date +%s) - start))s" >> ~/.claude/hook-perf.log
   ```

### Our Hooks Strategy

**For locale generation**: 3 optional hooks

#### 1. Validation Hook (PostToolUse on Write/Edit)

**Purpose**: Ensure generated locale files are valid

**File**: `.claude/hooks/validate_locale.py`

```python
#!/usr/bin/env python3
"""
Validate locale markdown files after Write/Edit operations.
Exit codes: 0=success, 1=warning (continue), 2=error (block)
"""
import json
import sys
import re
from pathlib import Path

def validate_locale(file_path: str) -> int:
    """Validate locale file structure and content."""
    if not file_path.endswith('.md') or 'locale-technical' not in file_path:
        return 0  # Not a locale file, skip

    content = Path(file_path).read_text()
    errors = []
    warnings = []

    # Check 1: YAML frontmatter present
    if not re.match(r'^---\n', content):
        errors.append("Missing YAML frontmatter")

    # Check 2: 9 sections present
    sections = [
        "# Section 1: Core Identity",
        "# Section 2: Formatting Rules - Numbers",
        "# Section 3: Formatting Rules - Dates & Times",
        "# Section 4: Geographic & Regulatory Context",
        "# Section 5: Language Classification",
        "# Section 6: Content Organization",
        "# Section 7: Technical Specifications",
        "# Section 8: Digital Standards",
        "# Section 9: Validation & AI Guidelines"
    ]

    for section in sections:
        if section not in content:
            errors.append(f"Missing section: {section}")

    # Check 3: ISO code format in locale_code
    locale_match = re.search(r'locale_code:\s*"?([a-z]{2}-[A-Z]{2})"?', content)
    if not locale_match:
        warnings.append("Could not find locale_code in correct format (xx-XX)")

    # Check 4: No placeholder templates remaining
    if '{{' in content or '}}' in content:
        warnings.append("Placeholder templates ({{ }}) found - may need completion")

    # Report results
    if errors:
        print(f"❌ Validation FAILED for {file_path}:", file=sys.stderr)
        for error in errors:
            print(f"  - {error}", file=sys.stderr)
        return 2  # Block execution

    if warnings:
        print(f"⚠️  Warnings for {file_path}:", file=sys.stderr)
        for warning in warnings:
            print(f"  - {warning}", file=sys.stderr)
        return 1  # Continue with warning

    print(f"✅ Validation passed: {file_path}")
    return 0

# Main execution
if __name__ == "__main__":
    try:
        # Read JSON from stdin (provided by Claude Code)
        input_data = json.load(sys.stdin)
        file_path = input_data.get('tool_input', {}).get('file_path', '')

        if not file_path:
            sys.exit(0)  # No file path, skip

        exit_code = validate_locale(file_path)
        sys.exit(exit_code)

    except Exception as e:
        print(f"Hook error: {e}", file=sys.stderr)
        sys.exit(1)  # Non-blocking error
```

**Configuration**:
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "python3 .claude/hooks/validate_locale.py"
          }
        ]
      }
    ]
  }
}
```

#### 2. Formatting Hook (PostToolUse on Write)

**Purpose**: Auto-fix markdown formatting issues

**File**: `.claude/hooks/format_locale.py`

```python
#!/usr/bin/env python3
"""
Format locale markdown files after Write operations.
Fixes: missing language tags, excessive blank lines, inconsistent spacing.
"""
import json
import sys
import re
from pathlib import Path

def format_markdown(content: str) -> str:
    """Format markdown with language detection for code fences."""

    # Fix unlabeled code fences (add 'yaml' for frontmatter, 'bash' for commands)
    def add_lang_to_fence(match):
        indent, info, body, closing = match.groups()
        if not info.strip():
            # Detect language from content
            if re.match(r'^---\n', body):
                lang = 'yaml'
            elif re.search(r'\$|#!/bin/', body):
                lang = 'bash'
            else:
                lang = 'text'
            return f"{indent}```{lang}\n{body}{closing}\n"
        return match.group(0)

    fence_pattern = r'(?ms)^([ \t]{0,3})```([^\n]*)\n(.*?)(\n\1```) *$'
    content = re.sub(fence_pattern, add_lang_to_fence, content)

    # Fix excessive blank lines (max 2 consecutive)
    content = re.sub(r'\n{3,}', '\n\n', content)

    # Ensure file ends with single newline
    return content.rstrip() + '\n'

# Main execution
if __name__ == "__main__":
    try:
        input_data = json.load(sys.stdin)
        file_path = input_data.get('tool_input', {}).get('file_path', '')

        if not file_path or not file_path.endswith('.md'):
            sys.exit(0)

        path = Path(file_path)
        if path.exists():
            original = path.read_text()
            formatted = format_markdown(original)

            if formatted != original:
                path.write_text(formatted)
                print(f"✓ Formatted markdown: {file_path}")

        sys.exit(0)

    except Exception as e:
        print(f"Formatting error: {e}", file=sys.stderr)
        sys.exit(0)  # Non-blocking
```

#### 3. Logging Hook (PreToolUse on all MCP tools)

**Purpose**: Track MCP usage and generation stats

**File**: `.claude/hooks/log_mcp_usage.sh`

```bash
#!/bin/bash
# Log MCP queries for cost tracking and observability

LOG_FILE=~/.claude/logs/mcp-usage.jsonl

# Create log directory if needed
mkdir -p "$(dirname "$LOG_FILE")"

# Extract tool name and timestamp
TOOL_NAME=$(echo "$1" | jq -r '.tool_name // "unknown"')
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Log entry
echo "{\"timestamp\":\"$TIMESTAMP\",\"tool\":\"$TOOL_NAME\",\"session\":\"$CLAUDE_SESSION_ID\"}" >> "$LOG_FILE"

# Exit 0 (always allow execution)
exit 0
```

### When to Use Hooks

**✅ Use hooks when:**
- Validation logic is deterministic (no LLM judgment needed)
- Action must happen every time (not LLM-suggested)
- Performance cost is acceptable (~1-2s per hook)
- Logic can be coded (bash, Python, etc.)

**❌ Don't use hooks when:**
- Logic requires LLM reasoning
- Execution is conditional on context
- Hook would significantly slow workflow
- Better handled by agent instructions

---

## 🔧 Agent SDK Pattern (NEW)

### Declarative vs Programmatic Approaches

```
┌─────────────────────────────────────────────────────┐
│  DECLARATIVE (Markdown Files)                       │
│  ✅ Start here for our project                      │
├─────────────────────────────────────────────────────┤
│  .claude/commands/generate-locale-technical.md      │
│  .claude/agents/locale-technical-generator.md       │
│  .claude/skills/locale-technical-knowledge/         │
│                                                      │
│  Pros:                                              │
│  ✅ Work locally, test via CLI                      │
│  ✅ Rapid iteration (edit markdown, run)            │
│  ✅ No build step, no dependencies                  │
│  ✅ Git versioning simple                           │
│                                                      │
│  Cons:                                              │
│  ❌ Limited programmatic control                    │
│  ❌ Harder to unit test                             │
└─────────────────────────────────────────────────────┘
                        │
                        ▼ Migrate when needed
┌─────────────────────────────────────────────────────┐
│  PROGRAMMATIC (Agent SDK)                           │
│  ⚠️  Use only if CI/CD or programmatic control needed │
├─────────────────────────────────────────────────────┤
│  TypeScript: @anthropic-ai/claude-agent-sdk         │
│  Python: claude-agent-sdk                           │
│                                                      │
│  Pros:                                              │
│  ✅ Full programmatic control                       │
│  ✅ CI/CD integration                               │
│  ✅ Unit testable                                   │
│  ✅ Custom error handling                           │
│                                                      │
│  Cons:                                              │
│  ❌ Requires TypeScript/Python setup                │
│  ❌ More complex (build, dependencies)              │
│  ❌ Can't test via CLI directly                     │
└─────────────────────────────────────────────────────┘
```

### Declarative Pattern (Current Recommendation)

**Command file**: `.claude/commands/generate-locale-technical.md`

```markdown
---
description: Generate technical locale documentation using MCP-powered data sources
allowed-tools: Read, Write, Glob, Task, AskUserQuestion, Bash
argument-hint: <locale-codes> [--data=<path>]
---

You are the locale generation coordinator...

## Workflow

1. **PARSE ARGUMENTS**
   - Locale codes: single, multiple, pattern (ar-*), all
   - Optional --data flag

2. **LAUNCH AGENTS** (parallel)
   - Task tool with subagent_type="locale-technical-generator"
   - Pass locale_code + data to each agent

3. **REPORT**
   - Summary: X/Y locales generated
   - Sources breakdown
```

**Agent file**: `.claude/agents/locale-technical-generator.md`

```markdown
---
name: locale-technical-generator
description: Generate technical locale documentation for a single locale
color: green
model: haiku
tools: Read, Write, Bash
---

You are a technical locale generator...

## Workflow

1. **LOAD SKILL**
   - Read @locale-technical-knowledge/skeleton.md
   - Read @locale-technical-knowledge/sources.yaml

2. **GENERATE SECTIONS (1-9)**
   [Per section logic...]

3. **OUTPUT**
   - Write FINAL/locale-technical/{locale_code}.md
```

### Programmatic Pattern (Future/Optional)

**TypeScript Example**:

```typescript
// generate-locales.ts
import { query, tool } from '@anthropic-ai/claude-agent-sdk';

interface LocaleGenerationResult {
  locale: string;
  status: 'success' | 'failed';
  sources: Record<string, number>;
}

async function generateLocale(
  localeCode: string,
  localData?: Record<string, any>
): Promise<LocaleGenerationResult> {
  const result = await query({
    prompt: `Generate technical locale file for ${localeCode}`,
    options: {
      model: 'claude-sonnet-4-5',
      systemPrompt: {
        type: 'preset',
        preset: 'claude_code'
      },
      // Load project settings (commands, agents)
      settingSources: ['project'],
      tools: ['Read', 'Write', 'Bash']
    }
  });

  // Parse result and extract metadata
  return {
    locale: localeCode,
    status: result.success ? 'success' : 'failed',
    sources: extractSourcesFromOutput(result.output)
  };
}

async function generateAllLocales(locales: string[]): Promise<void> {
  // Parallel generation with concurrency limit
  const results = await Promise.all(
    locales.map(locale => generateLocale(locale))
  );

  // Aggregate and report
  const successful = results.filter(r => r.status === 'success');
  console.log(`✅ Generated ${successful.length}/${locales.length} locales`);

  // Detailed reporting
  results.forEach(r => {
    console.log(`${r.locale}: ${r.status}`);
    console.log(`  Sources: ${JSON.stringify(r.sources)}`);
  });
}

// Usage
generateAllLocales(['ja-JP', 'en-US', 'fr-FR']);
```

**Python Example**:

```python
# generate_locales.py
from claude_agent_sdk import query, ClaudeAgentOptions
from typing import Dict, List
import asyncio

async def generate_locale(
    locale_code: str,
    local_data: Dict[str, any] = None
) -> Dict[str, any]:
    """Generate a single locale file."""

    result = await query(
        prompt=f"Generate technical locale file for {locale_code}",
        options=ClaudeAgentOptions(
            model="claude-sonnet-4-5",
            system_prompt={"type": "preset", "preset": "claude_code"},
            setting_sources=["project"],  # Load .claude/ files
            tools=["Read", "Write", "Bash"]
        )
    )

    return {
        "locale": locale_code,
        "status": "success" if result.success else "failed",
        "sources": extract_sources(result.output)
    }

async def generate_all_locales(locales: List[str]):
    """Generate all locales in parallel batches."""

    # Batch processing (20 at a time)
    batch_size = 20
    for i in range(0, len(locales), batch_size):
        batch = locales[i:i+batch_size]
        results = await asyncio.gather(*[
            generate_locale(locale) for locale in batch
        ])

        # Report batch results
        successful = [r for r in results if r["status"] == "success"]
        print(f"Batch {i//batch_size + 1}: {len(successful)}/{len(batch)} success")

# Usage
asyncio.run(generate_all_locales(['ja-JP', 'en-US', 'fr-FR']))
```

### Custom Tools with Agent SDK

**Example: Custom MCP query tool**

```typescript
import { tool } from '@anthropic-ai/claude-agent-sdk';

@tool({
  name: 'query_context7',
  description: 'Query Context7 MCP for ISO standards'
})
async function queryContext7(params: {
  library: string;
  query: string;
}): Promise<string> {
  // Custom logic to query Context7
  const response = await fetch('context7-api-endpoint', {
    method: 'POST',
    body: JSON.stringify({
      library: params.library,
      query: params.query
    })
  });

  return await response.text();
}

// Use in query
const result = await query({
  prompt: "Get ISO 639-1 language codes",
  options: {
    customTools: [queryContext7]
  }
});
```

### Migration Decision Tree

```
Do you need programmatic control?
├─ NO → Stay with declarative (markdown files)
│   ✅ Fastest to implement
│   ✅ Easiest to maintain
│   ✅ Sufficient for 95% of use cases
│
└─ YES → Consider migration to Agent SDK
    ├─ Need CI/CD integration? → SDK
    ├─ Need unit testing? → SDK
    ├─ Need custom error handling? → SDK
    ├─ Need programmatic retries? → SDK
    └─ Just want automation? → Stay declarative + use hooks
```

### Hybrid Approach (Best of Both Worlds)

```typescript
// wrapper.ts - SDK wrapper around markdown-based agents
import { query } from '@anthropic-ai/claude-agent-sdk';

/**
 * Wrapper that uses markdown-based agents via SDK
 * Best approach for CI/CD while keeping markdown configs
 */
async function generateLocalesViaCLI(locales: string[]) {
  // Use SDK to invoke CLI command
  const result = await query({
    prompt: `/generate-locale-technical ${locales.join(',')}`,
    options: {
      settingSources: ['project'], // Load .claude/ markdown files
      model: 'claude-sonnet-4-5'
    }
  });

  return result;
}

// Keep markdown files for manual CLI usage
// Use this wrapper for CI/CD, programmatic testing, etc.
```

### Key Differences: Declarative vs SDK

| Aspect | Declarative (Markdown) | Programmatic (SDK) |
|--------|------------------------|-------------------|
| **Setup** | None (just markdown) | npm/pip install |
| **Testing** | Manual via CLI | Unit tests |
| **Iteration** | Edit file → run CLI | Edit code → build → run |
| **Version control** | Simple (markdown) | Complex (code + deps) |
| **Error handling** | Agent logic | Custom try/catch |
| **CI/CD** | Via CLI calls | Native integration |
| **Best for** | Development, iteration | Production, automation |

**Our decision**: Start declarative, migrate to SDK only if specific needs arise (CI/CD, programmatic control).

---

## 📋 Implementation Checklist

### SKILL Files (Foundation)

- [ ] `skeleton.md` - 9-section structure with field definitions
- [ ] `sources.yaml` - Field → MCP mapping with priorities
- [ ] `best-practices.md` - Data source preparation guide
- [ ] `validation-rules.md` - Quality check rules
- [ ] `examples/` - Reference examples (ja-JP, en-US, ar-SA)

### AGENT File (Worker)

- [ ] Frontmatter: name, description, color, model
- [ ] Workflow: Load SKILL → Generate sections → Validate → Output
- [ ] MCP integration: Context7, Perplexity, Firecrawl
- [ ] Error handling: Fallback chain → Block if fail
- [ ] Reporting: Structured output with source tracking

### COMMAND File (Coordinator)

- [ ] Frontmatter: description, allowed-tools, argument-hint
- [ ] Parse arguments: locale codes + --data flag
- [ ] Data source handling: Validate → Parse → Aggregate
- [ ] Strategy decision: Single vs parallel vs batch
- [ ] Launch agents: Task tool with parallel execution
- [ ] Aggregate results: Success/fail counts + retry logic
- [ ] Report: Comprehensive summary with MCP stats

### Testing Plan

- [ ] Test SKILL docs: Verify skeleton + sources.yaml complete
- [ ] Test AGENT: Single locale (ja-JP) without local data
- [ ] Test AGENT: Single locale (en-US) with partial local data
- [ ] Test AGENT: RTL locale (ar-SA) to verify derivation
- [ ] Test COMMAND: 3 locales parallel
- [ ] Test COMMAND: 10 locales batch
- [ ] Test Error handling: Missing data, MCP failures
- [ ] Test Reporting: Verify source tracking accurate

---

## 🚀 Next Steps

1. **Create SKILL files** (`.claude/skills/locale-technical-knowledge/`)
2. **Create AGENT file** (`.claude/agents/locale-technical-generator.md`)
3. **Create COMMAND file** (`.claude/commands/generate-locale-technical.md`)
4. **Test POC** (3 locales: ja-JP, en-US, ar-SA)
5. **Generate all** (174 locales in batches)

---

**Architecture validated** ✅
**Patterns documented** ✅
**Ready for implementation** ✅
