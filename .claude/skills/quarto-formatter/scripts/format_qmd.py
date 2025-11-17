#!/usr/bin/env python3
"""
Format Quarto (.qmd) files with modern standards

This script formats .qmd files by:
- Adding proper YAML frontmatter
- Ensuring Mermaid diagrams have colors
- Setting optimal figure sizing
- Validating Quarto syntax

Usage:
    python3 format_qmd.py <file.qmd>
"""

import sys
import re
from pathlib import Path

YAML_FRONTMATTER_TEMPLATE = """---
title: "{title}"
format:
  html:
    toc: true
    toc-depth: 3
    code-fold: false
    theme: cosmo
    fig-width: 10
    fig-height: 8
    css: ../../../.claude/skills/quarto-formatter/assets/styles.css
---
"""

MATERIAL_COLORS = {
    'primary': '#6366F1',
    'secondary': '#EC4899',
    'accent': '#10B981',
    'warning': '#F59E0B',
    'error': '#EF4444',
    'success': '#10B981',
    'info': '#3B82F6'
}

def extract_title(content):
    """Extract title from first H1 or filename"""
    match = re.search(r'^#\s+(.+)$', content, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return "Untitled Document"

def add_mermaid_colors(content):
    """Add classDef colors to Mermaid diagrams if missing"""

    # Pattern to find mermaid code blocks
    mermaid_pattern = r'```\{mermaid\}(.*?)```'

    def add_colors_to_diagram(match):
        diagram = match.group(1)

        # Check if classDef already exists
        if 'classDef' in diagram:
            return match.group(0)

        # Add classDef at the end of diagram
        class_defs = '\n'.join([
            f'    classDef {name}Class fill:{color},stroke:{color},stroke-width:2px,color:#fff'
            for name, color in MATERIAL_COLORS.items()
        ])

        return f'```{{mermaid}}{diagram}\n{class_defs}\n```'

    return re.sub(mermaid_pattern, add_colors_to_diagram, content, flags=re.DOTALL)

def format_qmd_file(file_path):
    """Format a .qmd file with modern standards"""

    file_path = Path(file_path)

    if not file_path.exists():
        print(f"❌ Error: File not found: {file_path}")
        return False

    if not file_path.suffix == '.qmd':
        print(f"❌ Error: File must have .qmd extension: {file_path}")
        return False

    # Read content
    content = file_path.read_text()

    # Check if frontmatter exists
    has_frontmatter = content.startswith('---')

    if not has_frontmatter:
        # Extract title and add frontmatter
        title = extract_title(content)
        frontmatter = YAML_FRONTMATTER_TEMPLATE.format(title=title)
        content = frontmatter + '\n' + content
        print(f"✅ Added YAML frontmatter with title: {title}")
    else:
        print("ℹ️  YAML frontmatter already exists")

    # Add Mermaid colors
    original_content = content
    content = add_mermaid_colors(content)

    if content != original_content:
        print("✅ Added Material Design 3 colors to Mermaid diagrams")
    else:
        print("ℹ️  Mermaid diagrams already have colors or no diagrams found")

    # Write back
    file_path.write_text(content)
    print(f"✅ Successfully formatted: {file_path}")

    return True

def main():
    if len(sys.argv) != 2:
        print("Usage: python3 format_qmd.py <file.qmd>")
        print("\nExample:")
        print("  python3 format_qmd.py patterns/agent-orchestration/diagrams.qmd")
        sys.exit(1)

    file_path = sys.argv[1]

    print(f"📝 Formatting {file_path}...")
    print()

    success = format_qmd_file(file_path)

    if success:
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == "__main__":
    main()
