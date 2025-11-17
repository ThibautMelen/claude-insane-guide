---
name: quarto-formatter
description: This skill should be used when working with Quarto (.qmd) files for documentation. It provides tools for formatting .qmd files with modern visual standards, converting ASCII diagrams to Mermaid, applying Material Design 3 styling, and synchronizing Markdown (.md) files to Quarto (.qmd) format with enhanced visualizations.
---

# Quarto Formatter

## Overview

This skill enables creation and formatting of beautiful, modern Quarto documentation with advanced visual diagrams, Material Design 3 styling, and automated synchronization between Markdown and Quarto formats.

## Quick Start

When working with Quarto documentation:
1. **Format .qmd files**: Apply modern standards with `scripts/format_qmd.py`
2. **Convert diagrams**: Transform ASCII art → Mermaid with `scripts/ascii_to_mermaid.py`
3. **Sync .md → .qmd**: Keep files synchronized with `scripts/sync_md_to_qmd.py`
4. **Apply styling**: Use `assets/template.qmd` and `assets/styles.css` for consistent design

## Format Quarto Files

To format a .qmd file with modern standards:

```bash
python3 .claude/skills/quarto-formatter/scripts/format_qmd.py <file.qmd>
```

**What it does:**
- Adds proper YAML frontmatter with theme configuration
- Ensures proper Mermaid diagram syntax with colors
- Applies fig-width and fig-height for optimal rendering
- Validates Quarto syntax

**Example usage:**
```bash
# Format a single file
python3 .claude/skills/quarto-formatter/scripts/format_qmd.py patterns/agent-orchestration/diagrams.qmd

# Format all .qmd files in a directory
find workflow-pattern-orchestration -name "*.qmd" -exec python3 .claude/skills/quarto-formatter/scripts/format_qmd.py {} \;
```

## Convert ASCII to Mermaid

To convert ASCII diagrams to Mermaid visual diagrams:

```bash
python3 .claude/skills/quarto-formatter/scripts/ascii_to_mermaid.py <file.qmd>
```

**What it does:**
- Detects ASCII diagrams in code blocks
- Converts to appropriate Mermaid diagram type (flowchart, sequence, state, etc.)
- Adds Material Design 3 colors with classDef
- Preserves existing Mermaid diagrams

**Supported conversions:**
- Box diagrams → Mermaid flowcharts
- Tree structures → Mermaid graphs
- Flow arrows → Mermaid sequences
- State diagrams → Mermaid state diagrams

## Synchronize .md to .qmd

To sync a Markdown file to enhanced Quarto format:

```bash
python3 .claude/skills/quarto-formatter/scripts/sync_md_to_qmd.py <file.md> <output.qmd>
```

**What it does:**
- Copies content from .md to .qmd
- Enhances with Mermaid diagrams
- Adds Quarto-specific YAML frontmatter
- Applies Material Design 3 styling
- Maintains bidirectional sync (if .md changes, .qmd updates)

**Example:**
```bash
# Sync a single file
python3 .claude/skills/quarto-formatter/scripts/sync_md_to_qmd.py patterns/agent-orchestration.md patterns/agent-orchestration/overview.qmd

# Batch sync all .md files
find patterns -name "*.md" -exec python3 .claude/skills/quarto-formatter/scripts/sync_md_to_qmd.py {} {}.qmd \;
```

## Visual Standards

### Material Design 3 Color Palette

Use colors from `references/material-colors.md`:
- Primary: #6366F1 (Indigo)
- Secondary: #EC4899 (Pink)
- Accent: #10B981 (Green)
- Warning: #F59E0B (Amber)
- Error: #EF4444 (Red)

### Mermaid Diagram Types

Prefer these 10+ diagram types (see `references/mermaid-syntax.md`):
1. **flowchart** - Decision trees, workflows
2. **sequence** - Interactions, API calls
3. **state** - State machines, lifecycles
4. **gantt** - Timelines, project planning
5. **pie** - Percentages, distributions
6. **class** - Architecture, UML
7. **journey** - User flows
8. **gitGraph** - Git workflows
9. **quadrant** - Priority matrices
10. **er** - Entity relationships
11. **mindmap** - Concept maps
12. **timeline** - Historical data
13. **sankey** - Flow diagrams

### Template Usage

Start with `assets/template.qmd` for new files:
- Pre-configured YAML frontmatter
- Material Design 3 CSS imports
- Responsive diagram sizing
- Light/dark mode support

## Resources

This skill includes example resource directories that demonstrate how to organize different types of bundled resources:

### scripts/
Executable code (Python/Bash/etc.) that can be run directly to perform specific operations.

**Examples from other skills:**
- PDF skill: `fill_fillable_fields.py`, `extract_form_field_info.py` - utilities for PDF manipulation
- DOCX skill: `document.py`, `utilities.py` - Python modules for document processing

**Appropriate for:** Python scripts, shell scripts, or any executable code that performs automation, data processing, or specific operations.

**Note:** Scripts may be executed without loading into context, but can still be read by Claude for patching or environment adjustments.

### references/
Documentation and reference material intended to be loaded into context to inform Claude's process and thinking.

**Examples from other skills:**
- Product management: `communication.md`, `context_building.md` - detailed workflow guides
- BigQuery: API reference documentation and query examples
- Finance: Schema documentation, company policies

**Appropriate for:** In-depth documentation, API references, database schemas, comprehensive guides, or any detailed information that Claude should reference while working.

### assets/
Files not intended to be loaded into context, but rather used within the output Claude produces.

**Examples from other skills:**
- Brand styling: PowerPoint template files (.pptx), logo files
- Frontend builder: HTML/React boilerplate project directories
- Typography: Font files (.ttf, .woff2)

**Appropriate for:** Templates, boilerplate code, document templates, images, icons, fonts, or any files meant to be copied or used in the final output.

---

**Any unneeded directories can be deleted.** Not every skill requires all three types of resources.
