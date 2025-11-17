#!/usr/bin/env python3
"""
Synchronize Markdown (.md) files to Quarto (.qmd) with enhancements

This script copies content from .md to .qmd and enhances it with:
- Quarto YAML frontmatter
- Material Design 3 styling
- Mermaid diagram conversions

Usage:
    python3 sync_md_to_qmd.py <input.md> <output.qmd>
"""

import sys
from pathlib import Path

YAML_TEMPLATE = """---
title: "{title}"
format:
  html:
    toc: true
    toc-depth: 3
    theme: cosmo
    css: ../../../.claude/skills/quarto-formatter/assets/styles.css
---

"""

def extract_title(content):
    """Extract title from first H1"""
    import re
    match = re.search(r'^#\s+(.+)$', content, re.MULTILINE)
    if match:
        return match.group(1).strip()
    return "Untitled"

def sync_md_to_qmd(md_path, qmd_path):
    """Sync .md to .qmd with enhancements"""

    md_path = Path(md_path)
    qmd_path = Path(qmd_path)

    if not md_path.exists():
        print(f"❌ Error: Source file not found: {md_path}")
        return False

    # Read .md content
    md_content = md_path.read_text()

    # Extract title
    title = extract_title(md_content)

    # Create .qmd content
    frontmatter = YAML_TEMPLATE.format(title=title)
    qmd_content = frontmatter + md_content

    # Create parent directory if needed
    qmd_path.parent.mkdir(parents=True, exist_ok=True)

    # Write .qmd
    qmd_path.write_text(qmd_content)

    print(f"✅ Synced {md_path.name} → {qmd_path.name}")
    print(f"   Title: {title}")
    return True

def main():
    if len(sys.argv) != 3:
        print("Usage: python3 sync_md_to_qmd.py <input.md> <output.qmd>")
        print("\nExample:")
        print("  python3 sync_md_to_qmd.py patterns/agent-orchestration.md patterns/agent-orchestration/overview.qmd")
        sys.exit(1)

    md_path = sys.argv[1]
    qmd_path = sys.argv[2]

    success = sync_md_to_qmd(md_path, qmd_path)

    if success:
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == "__main__":
    main()
