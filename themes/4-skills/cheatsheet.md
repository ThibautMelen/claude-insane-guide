# 💡 Skills - Cheatsheet

> **Référence rapide Skills Claude Code**

## ⚡ Quick Start

**Location** : `.claude/skills/skill-name/SKILL.md`

**Création minimale** :
```bash
mkdir -p .claude/skills/pdf-processor
touch .claude/skills/pdf-processor/SKILL.md
```

**Template minimal** :
````markdown
---
name: PDF Processor
description: Extract text from PDFs. Use when user mentions PDF files.
---

# PDF Processing

Use pdfplumber:
```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
````

---

## 📋 Frontmatter YAML - Référence Complète

```yaml
---
# REQUIS
name: My Skill                           # 64 chars max
description: Brief overview...           # 1024 chars max, third person

# OPTIONNELS
allowed-tools: "Bash(git:*), Read, Write"  # Pre-approve tools
model: haiku                             # haiku/sonnet/opus
disable-model-invocation: false          # true = manual only
mode: false                              # true = mode command
---
```

### Champs Détaillés

| Champ | Type | Requis | Description |
|-------|------|--------|-------------|
| `name` | String | ✅ | Nom humain (max 64 chars) |
| `description` | String | ✅ | What + When to use (max 1024 chars, **third person**) |
| `allowed-tools` | String | ❌ | Pre-approve outils (format: `"Tool1, Tool2(pattern:*)"`) |
| `model` | String | ❌ | Override modèle (`haiku`/`sonnet`/`opus`) |
| `disable-model-invocation` | Boolean | ❌ | `true` = invocation manuelle uniquement (`/skill-name`) |
| `mode` | Boolean | ❌ | `true` = catégorise comme "Mode Command" |

### Exemples allowed-tools

```yaml
# Git operations uniquement
allowed-tools: "Bash(git:*)"

# Lecture + écriture fichiers
allowed-tools: "Read, Write"

# Python scripts + fichiers
allowed-tools: "Bash(python3:*), Read, Write"

# Multiple tools
allowed-tools: "Bash(git:*), Bash(npm:*), Read, Write, Grep"

# ❌ Éviter : trop permissif
allowed-tools: "Bash(*)"
```

---

## 📝 Description Efficace

### Formula Gagnante

```
[WHAT IT DOES] + [WHEN TO USE] + [KEY TERMS]
```

### Template

```markdown
[Action] when user [trigger]. Use when [context/keywords].
```

### ✅ Exemples Bons

```yaml
# PDF Processing
description: Extract text and tables from PDFs, fill forms. Use when user
  mentions PDF files, forms, or document extraction.

# Git Commit
description: Generate descriptive commit messages by analyzing git diffs.
  Use when user asks for help writing commits or reviewing staged changes.

# Excel Analysis
description: Analyze Excel spreadsheets, create pivot tables, generate charts.
  Use when analyzing Excel, spreadsheets, tabular data, or .xlsx files.

# Code Review
description: Review code for bugs, readability, conventions. Use when user
  asks to review code, check PR, or analyze code quality.
```

### ❌ Exemples Mauvais

```yaml
# Trop vague
description: Helps with documents

# First person (incorrect)
description: I can help you process PDF files

# Second person (incorrect)
description: You can use this to process PDFs

# Pas de "when to use"
description: Extract text from PDF files
```

---

## 🏗️ Structure Fichiers

### Organisation Recommandée

```
.claude/skills/my-skill/
├── SKILL.md              # Entry point (obligatoire)
├── scripts/              # Exécutables (0 tokens)
│   ├── process.py
│   └── validate.sh
├── references/           # Docs lues (coûte tokens)
│   ├── api-guide.md
│   └── schema.json
└── assets/               # Templates (0 tokens)
    ├── template.html
    └── config.json
```

### Impact Tokens

| Dossier | Chargé ? | Tokens | Quand utiliser |
|---------|----------|--------|----------------|
| `scripts/` | ❌ Non | 0 | Code exécutable déterministe |
| `references/` | ✅ Oui | Élevé | Docs que Claude doit lire |
| `assets/` | ❌ Non | 0 | Templates/fichiers manipulés par path |

### Variable {baseDir}

**Toujours utiliser** pour portabilité :

```markdown
✅ python {baseDir}/scripts/extract.py
❌ python /Users/me/.claude/skills/pdf/scripts/extract.py
```

---

## 📚 Patterns Communs

### Pattern 1 : Script Automation

````markdown
## Instructions

1. Validate input
2. Execute: `python {baseDir}/scripts/process.py {input}`
3. Parse JSON output
4. Format result
````

### Pattern 2 : Read-Process-Write

````markdown
## Instructions

1. Read source with Read tool
2. Transform: [specific transformations]
3. Write to destination
````

### Pattern 3 : Workflow avec Checklist

````markdown
## Process

Copy and check off:
```
Progress:
- [ ] Step 1: Analyze
- [ ] Step 2: Process
- [ ] Step 3: Validate
```

**Step 1: Analyze**
[Instructions détaillées]
````

### Pattern 4 : Feedback Loop

````markdown
## Process

1. Execute action
2. **Validate**: `python {baseDir}/scripts/validate.py`
3. If fails:
   - Review errors
   - Fix issues
   - Run validation again
4. **Only proceed when validation passes**
````

### Pattern 5 : Progressive Disclosure

````markdown
# Main Topic

## Quick start
[Basic usage]

## Advanced
- **Feature A**: See [FEATURE_A.md](FEATURE_A.md)
- **Feature B**: See [FEATURE_B.md](FEATURE_B.md)
````

---

## 🎯 Degrees of Freedom

### High Freedom (Guidelines)

```markdown
## Code review

1. Analyze structure
2. Check for bugs
3. Suggest improvements
4. Verify conventions
```

**Quand** : Multiple approaches valides, decisions dépendent du contexte

### Medium Freedom (Template + Params)

````markdown
## Generate report

Use and customize:
```python
def generate_report(data, format="markdown", charts=True):
    # Process data
    # Generate output
```
````

**Quand** : Pattern préféré existe, variation acceptable

### Low Freedom (Exact Script)

````markdown
## Database migration

Run exactly:
```bash
python scripts/migrate.py --verify --backup
```

Do not modify flags.
````

**Quand** : Opération fragile, séquence spécifique requise

---

## 🆚 Decision Tree : Skill vs Command

```
                 Besoin d'auto-invocation ?
                        │
            ┌───────────┴───────────┐
          OUI                      NON
            │                        │
         SKILL                   COMMAND
            │
    Workflow complexe ?
            │
    ┌───────┴───────┐
  OUI              NON
    │                │
Use SKILL.md      Start with
+ references      COMMAND first
                  (convert later)
```

**Use SKILL si** :
- ✅ Auto-invocation souhaitée
- ✅ Workflow multi-steps
- ✅ Context répétitif
- ✅ Composition tools/MCP

**Use COMMAND si** :
- ✅ Invocation manuelle explicite
- ✅ One-shot task
- ✅ Phase de test/prototyping
- ✅ Contrôle utilisateur requis

---

## 📊 Quick Reference Tables

### Model Override

| Model | Speed | Cost | Usage |
|-------|-------|------|-------|
| `haiku` | 🚀 3x faster | 💰 10x cheaper | Tâches simples, scripts |
| `sonnet` | ⚡ Standard | 💰 Standard | Reasoning normal |
| `opus` | 🐌 Plus lent | 💰 60x Haiku | Analyse critique |

### Limites Importantes

| Limite | Valeur | Raison |
|--------|--------|--------|
| SKILL.md body | 500 lignes | Performance optimale |
| Description | 1024 chars | Budget metadata |
| Name | 64 chars | Display constraints |
| Profondeur refs | 1 niveau | Éviter partial reads |

---

## ✅ Checklist Création Skill

### Avant de commencer
- [ ] Identifié pattern répétitif
- [ ] Testé workflow sans skill d'abord
- [ ] Noté contexte fourni répétitivement

### Structure
- [ ] `name` clair et descriptif
- [ ] `description` avec "what" + "when" + key terms
- [ ] `description` en third person
- [ ] `allowed-tools` scope minimal
- [ ] `model` approprié si besoin
- [ ] `{baseDir}` pour tous paths

### Contenu
- [ ] SKILL.md < 500 lignes
- [ ] Instructions concises (Claude est smart)
- [ ] Exemples concrets (pas abstraits)
- [ ] Terminologie consistente
- [ ] Pas d'info time-sensitive
- [ ] Forward slashes dans paths

### Organisation
- [ ] Scripts dans `scripts/` (0 tokens)
- [ ] Docs dans `references/` (si nécessaire)
- [ ] Templates dans `assets/` (0 tokens)
- [ ] Références 1 niveau deep max
- [ ] Table of contents si ref > 100 lignes

### Testing
- [ ] 3+ évaluations créées
- [ ] Testé avec Haiku/Sonnet/Opus
- [ ] Testé scénarios réels (pas juste tests)
- [ ] Itéré avec Claude A/Claude B

---

## 🚀 Exemples Prêts à l'Emploi

### Exemple 1 : Git Commit Helper

````markdown
---
name: Git Commit Helper
description: Generate conventional commit messages by analyzing git diffs. Use when user asks to commit changes or write commit messages.
allowed-tools: "Bash(git:*), Read"
model: haiku
---

# Git Commit Helper

## Process

1. Run `git diff --staged`
2. Analyze changes
3. Generate commit message:
   - Format: `type(scope): description`
   - Types: feat, fix, docs, refactor, test, chore
   - Body: explain WHY, not what
4. Show to user for approval

## Examples

**feat(auth)**: implement JWT authentication
Add login endpoint with token validation

**fix(api)**: handle null response in getUserData
Add error handling for missing user data
````

### Exemple 2 : PDF Processor

````markdown
---
name: PDF Processor
description: Extract text and tables from PDFs, fill forms. Use when user mentions PDF files or document extraction.
allowed-tools: "Bash(python3:*), Read, Write"
---

# PDF Processing

## Text extraction

```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    for page in pdf.pages:
        text = page.extract_text()
```

## Advanced

- **Form filling**: See [FORMS.md](FORMS.md)
- **Table extraction**: See [TABLES.md](TABLES.md)
````

### Exemple 3 : Code Review

````markdown
---
name: Code Review
description: Review code for bugs, readability, conventions. Use when user asks to review code, check PR, or analyze quality.
model: sonnet
---

# Code Review Process

1. Read code with Read tool
2. Check:
   - Structure and organization
   - Potential bugs/edge cases
   - Readability improvements
   - Project conventions
3. Generate report:
   - Issues found (with severity)
   - Suggested improvements
   - Positive aspects
````

---

## 🎓 Best Practices

### DO ✅

- **Concise** : Claude est smart, n'expliquez que l'essentiel
- **Third person** dans description
- **{baseDir}** pour tous paths
- **Specific** : "what" + "when" + key terms
- **Test** avec Haiku/Sonnet/Opus
- **Evaluate** avant doc extensive
- **Iterate** avec Claude A/Claude B

### DON'T ❌

- **❌ First/second person** dans description
- **❌ Windows paths** (`\` au lieu de `/`)
- **❌ Trop d'options** sans guidance
- **❌ Info time-sensitive** (dates absolues)
- **❌ Terminologie inconsistente**
- **❌ Assuming tools installed**
- **❌ Permissions larges** (`Bash(*)`)
- **❌ Nested refs** (> 1 niveau)

---

## 📚 Ressources

### 📄 Documentation
- [Skills Docs](https://code.claude.com/docs/skills)
- [Best Practices](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/best-practices)
- [Skills Overview](https://docs.anthropic.com/en/docs/agents-and-tools/agent-skills/overview)

### 📖 Guide Complet
- [Guide Skills](./guide.md) - Documentation complète avec workflows, patterns, evaluation

### 🎥 Vidéos
- [Skills vs MCP vs Subagents](../../ressources/videos/skills-vs-mcp-vs-subagents.md) - Solo Swift Crafter | 🟢 Débutant
- [The Core 4](../../ressources/videos/skills-vs-slash-commands-vs-subagents-vs-mcp-dan.md) - Dan | 🟠 Avancé
- [800h Claude Code](../../ressources/videos/800h-claude-code-edmund-yong.md) - Edmund Yong | 🔴 Expert

### 🔗 Repos
- [Anthropic Official Skills](https://github.com/anthropics/skills)
- [Awesome Claude Skills](https://github.com/travisvn/awesome-claude-skills) ⭐ 2.1K
- [Claude Code Superpowers](https://github.com/obra/superpowers) ⭐ 7K

---

**💡 Quick Tip**: Start simple. Test without skill first. Create minimal SKILL.md. Iterate based on real usage.
