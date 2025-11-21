# 💡 Skills Claude Code - Guide Complet

> **Capacités spécialisées invoquées automatiquement par Claude**

📄 **Docs officielles** : [Claude Code Skills](https://code.claude.com/docs/skills) | [Best Practices](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/best-practices)

---

## ⚡ L'Essentiel

```
╔══════════════════════════════════════════════════════════╗
║  Skills = Templates de Prompts Auto-Invoqués            ║
╚══════════════════════════════════════════════════════════╝

User: "Lis ce PDF"              User: "Commit mes changes"
  │                                │
  ▼                                ▼
Claude charge Skill PDF          Claude charge Skill Git
  │                                │
  ▼                                ▼
Instructions chargées ✅         Workflow conventionnel ✅
```

**Skill vs Command** :
- 🤖 **Model-invoked** : Claude décide automatiquement quand utiliser (vs Commands = manuel)
- 📈 **Progressive** : Charge metadata → SKILL.md → references (selon besoin)
- 🎯 **Specialized** : Une tâche spécifique bien définie

**Structure minimale** :
```
.claude/skills/pdf-processor/
└── SKILL.md
```

**Format SKILL.md** :
````markdown
---
name: PDF Processor
description: Extract text from PDFs. Use when user mentions PDF files or asks to read/analyze PDFs.
---

# PDF Processing

Use pdfplumber for text extraction:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
````

**🔗 Voir aussi** :
- [Cheatsheet](./cheatsheet.md) - Référence rapide
- [Commands](../2-commands/guide.md) - Quand utiliser Commands vs Skills

---

## 🎯 Core Principles

### 1. Concise is Key

**Le contexte est une ressource partagée**. Chaque token dans votre skill partage le contexte avec :
- System prompt
- Historique conversation
- Autres skills
- Votre requête actuelle

**Règle d'or** : Supposez que Claude est intelligent. N'ajoutez que ce qu'il ne sait pas déjà.

**✅ Bon exemple** (~50 tokens) :
````markdown
## Extract PDF text

Use pdfplumber:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
````

**❌ Mauvais exemple** (~150 tokens) :
```markdown
## Extract PDF text

PDF (Portable Document Format) files are a common file format that contains
text, images, and other content. To extract text from a PDF, you'll need to
use a library. There are many libraries available for PDF processing, but we
recommend pdfplumber because it's easy to use and handles most cases well.
First, install it with pip, then...
```

Claude sait ce qu'est un PDF et comment fonctionnent les bibliothèques.

### 2. Degrees of Freedom

Adaptez le niveau de prescription à la fragilité de la tâche.

**High freedom** (instructions texte) :
```markdown
## Code review process

1. Analyze code structure and organization
2. Check for potential bugs or edge cases
3. Suggest improvements for readability
4. Verify project conventions
```

**Medium freedom** (pseudocode/scripts avec paramètres) :
````markdown
## Generate report

Use this template and customize:
```python
def generate_report(data, format="markdown", include_charts=True):
    # Process data
    # Generate output in specified format
```
````

**Low freedom** (scripts spécifiques, séquence exacte) :
````markdown
## Database migration

Run exactly this script:
```bash
python scripts/migrate.py --verify --backup
```

Do not modify or add flags.
````

**Analogie** :
- **Pont étroit avec falaises** → Low freedom (migrations DB)
- **Champ ouvert sans danger** → High freedom (code review)

### 3. Test with All Models

Les skills fonctionnent différemment selon le modèle :
- **Haiku** : Rapide, économique → Besoin de plus de guidance
- **Sonnet** : Équilibré → Instructions claires et efficaces
- **Opus** : Puissant → Évitez sur-expliquer

Testez avec tous les modèles que vous comptez utiliser.

---

## 📋 Skill Structure

### Frontmatter YAML

```yaml
---
name: My Skill                         # REQUIS (64 chars max)
description: Brief overview...         # REQUIS (1024 chars max)
allowed-tools: "Bash(git:*), Read"    # Optionnel
model: haiku                           # Optionnel (haiku/sonnet/opus)
---
```

**Champs clés** :
- `name` : Nom humain du skill
- `description` : **CE QUI EST LE PLUS IMPORTANT** - active le skill
- `allowed-tools` : Pre-approve outils (évite prompts répétitifs)
- `model` : Override modèle selon complexité

### Description Efficace

**Format requis** : Third person

**✅ Bon** :
```yaml
description: Extract text and tables from PDFs. Use when user mentions PDFs,
  forms, or document extraction.
```

**❌ Éviter** :
```yaml
description: I can help you process PDF files
description: You can use this to process PDF files
description: Helps with documents  # Trop vague
```

**Structure recommandée** :
```
[WHAT IT DOES] + [WHEN TO USE] + [KEY TERMS]
```

**Exemples** :

```yaml
# PDF Processing
description: Extract text and tables from PDFs, fill forms. Use when working
  with PDF files or when user mentions PDFs, forms, document extraction.

# Git Commit Helper
description: Generate descriptive commit messages by analyzing git diffs. Use
  when user asks for help writing commit messages or reviewing staged changes.

# Excel Analysis
description: Analyze Excel spreadsheets, create pivot tables, generate charts.
  Use when analyzing Excel files, spreadsheets, tabular data, or .xlsx files.
```

### Progressive Disclosure

**Principe** : SKILL.md = overview qui pointe vers détails selon besoin

```
SKILL.md (overview, loaded when triggered)
    ↓ References au besoin
FORMS.md, REFERENCE.md, EXAMPLES.md (loaded as needed)
```

**Pattern 1 : High-level guide avec références** :

````markdown
# PDF Processing

## Quick start
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```

## Advanced features
- **Form filling**: See [FORMS.md](FORMS.md)
- **API reference**: See [REFERENCE.md](REFERENCE.md)
- **Examples**: See [EXAMPLES.md](EXAMPLES.md)
````

**Pattern 2 : Domain-specific organization** :

```
bigquery-skill/
├── SKILL.md (overview)
└── reference/
    ├── finance.md (revenue metrics)
    ├── sales.md (pipeline data)
    └── product.md (usage analytics)
```

````markdown
# BigQuery Analysis

## Datasets
- **Finance**: Revenue, ARR → [reference/finance.md](reference/finance.md)
- **Sales**: Pipeline, accounts → [reference/sales.md](reference/sales.md)
- **Product**: Usage, features → [reference/product.md](reference/product.md)

## Quick search
```bash
grep -i "revenue" reference/finance.md
```
````

**Pattern 3 : Conditional details** :

```markdown
# DOCX Processing

## Creating documents
Use docx-js. See [DOCX-JS.md](DOCX-JS.md).

## Editing documents
For simple edits, modify XML directly.

**For tracked changes**: See [REDLINING.md](REDLINING.md)
**For OOXML details**: See [OOXML.md](OOXML.md)
```

**⚠️ Limites** :
- **Max 500 lignes** pour SKILL.md (performance optimale)
- **1 niveau de profondeur** pour les références (pas de nested refs)
- **Table of contents** pour fichiers > 100 lignes

### Structure Complète

```
📦 my-skill/
┣━━ 📄 SKILL.md              # Entry point (obligatoire)
┣━━ 📁 scripts/              # Exécutables (0 tokens)
┃   ┣━━ process.py
┃   ┗━━ validate.sh
┣━━ 📁 references/           # Docs lues (coûte tokens)
┃   ┣━━ api-guide.md
┃   ┗━━ schema.json
┗━━ 📁 assets/               # Templates (0 tokens)
    ┣━━ template.html
    ┗━━ diagram.png
```

**Impact tokens** :

| Dossier | Chargé ? | Tokens | Usage |
|---------|----------|--------|-------|
| `scripts/` | ❌ Non | 0 | Exécuté via Bash |
| `references/` | ✅ Oui | Élevé | Lu via Read |
| `assets/` | ❌ Non | 0 | Référencé par path |

**Variable {baseDir}** : Toujours utiliser pour portabilité

```markdown
✅ Bon : python {baseDir}/scripts/extract.py
❌ Mauvais : python /home/user/.claude/skills/pdf/scripts/extract.py
```

---

## 🔄 Workflows & Feedback Loops

### Workflows avec Checklists

Pour tâches complexes, fournissez une checklist que Claude copie et coche.

**Exemple 1 : Research synthesis** (sans code) :

````markdown
## Research synthesis workflow

Copy this checklist and track progress:
```
Research Progress:
- [ ] Step 1: Read all source documents
- [ ] Step 2: Identify key themes
- [ ] Step 3: Cross-reference claims
- [ ] Step 4: Create structured summary
- [ ] Step 5: Verify citations
```

**Step 1: Read all source documents**
Review each document in `sources/`. Note main arguments.

**Step 2: Identify key themes**
Look for patterns. What themes appear repeatedly?

**Step 3: Cross-reference claims**
For each major claim, verify source. Note which source supports it.

**Step 4: Create structured summary**
Organize by theme:
- Main claim
- Supporting evidence
- Conflicting viewpoints

**Step 5: Verify citations**
Check every claim references correct source. If incomplete, return to Step 3.
````

**Exemple 2 : PDF form filling** (avec code) :

````markdown
## PDF form filling workflow

Copy and check off:
```
Task Progress:
- [ ] Step 1: Analyze form (run analyze_form.py)
- [ ] Step 2: Create mapping (edit fields.json)
- [ ] Step 3: Validate mapping (run validate_fields.py)
- [ ] Step 4: Fill form (run fill_form.py)
- [ ] Step 5: Verify output (run verify_output.py)
```

**Step 1: Analyze form**
`python scripts/analyze_form.py input.pdf`
Extracts fields → saves to `fields.json`

**Step 2: Create mapping**
Edit `fields.json` to add values for each field.

**Step 3: Validate mapping**
`python scripts/validate_fields.py fields.json`
Fix validation errors before continuing.

**Step 4: Fill form**
`python scripts/fill_form.py input.pdf fields.json output.pdf`

**Step 5: Verify output**
`python scripts/verify_output.py output.pdf`
If fails, return to Step 2.
````

### Feedback Loops

**Pattern commun** : Run validator → fix errors → repeat

**Exemple 1 : Style guide compliance** (sans code) :

```markdown
## Content review process

1. Draft content following STYLE_GUIDE.md
2. Review checklist:
   - Check terminology consistency
   - Verify examples follow format
   - Confirm all sections present
3. If issues found:
   - Note each issue with section reference
   - Revise content
   - Review checklist again
4. Only proceed when all requirements met
5. Finalize and save
```

**Exemple 2 : Document editing** (avec code) :

```markdown
## Document editing process

1. Make edits to `word/document.xml`
2. **Validate immediately**: `python scripts/validate.py unpacked_dir/`
3. If validation fails:
   - Review error message
   - Fix issues in XML
   - Run validation again
4. **Only proceed when validation passes**
5. Rebuild: `python scripts/pack.py unpacked_dir/ output.docx`
6. Test output
```

---

## 📝 Common Patterns

### Template Pattern

**Pour strict requirements** :

````markdown
## Report structure

ALWAYS use this exact template:
```markdown
# [Analysis Title]

## Executive summary
[One-paragraph overview]

## Key findings
- Finding 1 with data
- Finding 2 with data

## Recommendations
1. Specific action
2. Specific action
```
````

**Pour flexible guidance** :

````markdown
## Report structure

Default format (adapt as needed):
```markdown
# [Analysis Title]

## Executive summary
[Overview]

## Key findings
[Adapt based on discovery]

## Recommendations
[Tailor to context]
```

Adjust sections for specific analysis type.
````

### Examples Pattern

Fournissez des paires input/output :

````markdown
## Commit message format

**Example 1:**
Input: Added user authentication with JWT tokens
Output:
```
feat(auth): implement JWT-based authentication

Add login endpoint and token validation middleware
```

**Example 2:**
Input: Fixed bug where dates displayed incorrectly
Output:
```
fix(reports): correct date formatting

Use UTC timestamps consistently across report generation
```

Follow: type(scope): brief, then detailed explanation.
````

### Conditional Workflow Pattern

Guidez Claude à travers les décisions :

```markdown
## Document modification workflow

1. Determine modification type:
   - **Creating new?** → Follow "Creation workflow"
   - **Editing existing?** → Follow "Editing workflow"

2. Creation workflow:
   - Use docx-js library
   - Build from scratch
   - Export to .docx

3. Editing workflow:
   - Unpack existing document
   - Modify XML directly
   - Validate after each change
   - Repack when complete
```

---

## 🧪 Evaluation & Iteration

### Build Evaluations First

**AVANT d'écrire documentation extensive**, créez des évaluations.

**Processus evaluation-driven** :

1. **Identify gaps** : Lancez Claude sans skill. Documentez les échecs
2. **Create evaluations** : 3 scénarios testant ces gaps
3. **Establish baseline** : Mesurez performance sans skill
4. **Write minimal instructions** : Juste assez pour passer les evals
5. **Iterate** : Exécutez evals, comparez baseline, raffinez

**Structure evaluation** :

```json
{
  "skills": ["pdf-processing"],
  "query": "Extract text from document.pdf and save to output.txt",
  "files": ["test-files/document.pdf"],
  "expected_behavior": [
    "Successfully reads PDF using appropriate library",
    "Extracts text from all pages",
    "Saves to output.txt in readable format"
  ]
}
```

### Develop Skills Iteratively with Claude

**Pattern le plus efficace** : Utilisez Claude pour créer des skills pour Claude.

**Claude A** = expert qui aide à créer le skill
**Claude B** = agent qui utilise le skill

**Creating new skill** :

1. **Complete task without skill** : Travaillez avec Claude A. Notez le contexte fourni répétitivement
2. **Identify reusable pattern** : Quel contexte serait utile pour tâches similaires ?
3. **Ask Claude A to create skill** : "Create a Skill capturing this pattern"
4. **Review for conciseness** : "Remove explanation about win rate - Claude knows that"
5. **Improve info architecture** : "Organize so table schema is in separate file"
6. **Test on similar tasks** : Utilisez avec Claude B (fresh instance)
7. **Iterate based on observation** : Si Claude B struggle, retournez à Claude A

**Iterating existing skills** :

1. **Use Skill in real workflows** : Donnez vraies tâches à Claude B
2. **Observe Claude B's behavior** : Notez où il struggle/succède
3. **Return to Claude A for improvements** : Partagez SKILL.md actuel + observations
4. **Review suggestions** : Claude A suggère réorganisation/clarification
5. **Apply and test changes** : Testez avec Claude B
6. **Repeat** : Cycle observe-refine-test continu

**Pourquoi ça marche** : Claude A comprend besoins agents, vous apportez expertise domaine, Claude B révèle gaps par usage réel.

---

## ⚠️ Anti-Patterns

### ❌ Windows-style paths

Always use forward slashes:
- ✓ `scripts/helper.py`
- ✗ `scripts\helper.py`

### ❌ Too many options

Don't present multiple approaches unless necessary:

```markdown
✗ Bad: "You can use pypdf, or pdfplumber, or PyMuPDF..."

✓ Good: "Use pdfplumber for text extraction:
[code]
For scanned PDFs requiring OCR, use pdf2image with pytesseract."
```

### ❌ Time-sensitive information

```markdown
✗ Bad: "If before August 2025, use old API"

✓ Good:
## Current method
Use v2 API: `api.example.com/v2/messages`

## Old patterns
<details>
<summary>Legacy v1 API (deprecated 2025-08)</summary>
...
</details>
```

### ❌ Inconsistent terminology

Choose one term and stick:
- Always "API endpoint" (not mix "URL", "route", "path")
- Always "field" (not mix "box", "element", "control")

### ❌ Assuming tools installed

```markdown
✗ Bad: "Use the pdf library"

✓ Good: "Install: `pip install pypdf`
Then:
[code]"
```

---

## ✅ Checklist for Effective Skills

Avant de partager un skill :

### Core Quality
- [ ] Description spécifique avec key terms
- [ ] Description inclut "what" ET "when to use"
- [ ] SKILL.md body < 500 lignes
- [ ] Détails additionnels dans fichiers séparés
- [ ] Pas d'info time-sensitive (ou section "old patterns")
- [ ] Terminologie consistente
- [ ] Exemples concrets (pas abstraits)
- [ ] Références 1 niveau deep max
- [ ] Progressive disclosure appropriée
- [ ] Workflows avec steps clairs

### Code & Scripts
- [ ] Scripts résolvent problèmes (ne punt pas à Claude)
- [ ] Error handling explicite et utile
- [ ] Pas de "magic constants" (valeurs justifiées)
- [ ] Packages requis listés et vérifiés disponibles
- [ ] Scripts documentés clairement
- [ ] Pas de paths Windows (forward slashes)
- [ ] Validation steps pour opérations critiques
- [ ] Feedback loops pour tâches quality-critical

### Testing
- [ ] Au moins 3 évaluations créées
- [ ] Testé avec Haiku, Sonnet, Opus
- [ ] Testé avec scénarios réels
- [ ] Feedback équipe incorporé (si applicable)

---

## 🎓 Points Clés

### Principes Core

**Concise** : Context window = ressource partagée. N'ajoutez que ce que Claude ne sait pas.
**Degrees of freedom** : High (guidelines) → Medium (pseudocode) → Low (exact scripts)
**Test all models** : Haiku/Sonnet/Opus ont besoins différents

### Structure

**Frontmatter** : name + description (most important) + allowed-tools + model
**Description** : Third person, "what" + "when to use" + key terms
**Progressive disclosure** : SKILL.md overview → References loaded as needed
**Max 500 lignes** SKILL.md, 1 niveau profondeur refs

### Workflows

**Checklists** : Pour tâches complexes multi-steps
**Feedback loops** : Validate → fix → repeat pattern
**Templates** : Strict ou flexible selon besoin
**Examples** : Input/output pairs
**Conditional** : Guider décisions

### Evaluation

**Build evals first** : Avant doc extensive
**Iterate with Claude** : Claude A (expert) + Claude B (utilisateur)
**Test real scenarios** : Pas seulement test cases

### Anti-Patterns

- ❌ Windows paths
- ❌ Trop d'options
- ❌ Info time-sensitive
- ❌ Terminologie inconsistente
- ❌ Assuming tools installed

---

## 📚 Ressources

### 📄 Documentation Officielle
- 📄 [Skills Docs](https://code.claude.com/docs/skills) - Guide officiel
- 📄 [Best Practices](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/best-practices) - Guide complet authoring
- 📄 [Skills Overview](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/overview) - Concepts fondamentaux

### 📝 Articles Deep Dives
- 📝 [Skills Deep Dive - Architecture](../../ressources/articles/skills-deep-dive-architecture-lee.md) ([🔗 Source](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)) - Han Lee
  - Architecture interne : meta-tool, message injection, context modification
- 📝 [Agent Skills Progressive Disclosure](../../ressources/articles/agent-skills-progressive-disclosure-anthropic.md) ([🔗 Source](https://share.note.sx/8k50udm8)) - Kenny Liao (Anthropic)
  - Design patterns officiels pour skills
- 📝 [Skills vs Commands vs Subagents](../../ressources/articles/skills-commands-subagents-plugins-youngleaders.md) ([🔗 Source](https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins)) - YoungLeaders
  - Quand utiliser chaque feature

### 🎥 Vidéos Essentielles
- 🎥 [Skills vs MCP vs Subagents](../../ressources/videos/skills-vs-mcp-vs-subagents.md) ([🔗 YouTube](https://youtu.be/ZroGqu7GyXM)) - Solo Swift Crafter | 🟢 Débutant
- 🎥 [The Core 4](../../ressources/videos/skills-vs-slash-commands-vs-subagents-vs-mcp-dan.md) ([🔗 YouTube](https://youtu.be/kFpLzCVLA20)) - Dan | 🟠 Avancé
  - Skills, Commands, MCP, Subagents : quand utiliser quoi
- 🎥 [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) ([🔗 YouTube](https://www.youtube.com/watch?v=Ffh9OeJ7yxw)) - Edmund Yong | 🔴 Expert

### 🔗 Repositories Communauté
- 🔗 [Anthropic Official Skills](https://github.com/anthropics/skills) - Skills officielles
- 🔗 [Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills) ⭐ 2.1K - Collection communautaire
- 🔗 [Claude Code Superpowers](https://github.com/obra/superpowers) ⭐ 7K - Core skills library

---

**💡 Remember**: Skills = templates de prompts, pas code. Concis > verbeux. Test > assume. Iterate > perfect dès le début.
