# Claude Agent Skills: A First Principles Deep Dive

**Source** : Lee Han Chung's Blog
**Auteur** : Han Lee
**Date** : 26 octobre 2025
**URL** : https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/
**Durée de lecture** : 41 minutes (~7,455 mots)

---

## 🎯 Résumé Exécutif

Cet article analyse en profondeur l'architecture des **Skills** de Claude Code. Contrairement aux approches traditionnelles (function calling, code exécutable), les Skills fonctionnent par **expansion de prompts** et **modification temporaire du contexte**. Han Lee dévoile les mécanismes internes : injection de messages, progressive disclosure, permission scoping, et cycle d'exécution complet. Un guide technique essentiel pour comprendre comment Claude prend ses décisions et exécute des workflows complexes via des templates d'instructions.

**Pertinence Claude Code** : Comprendre l'architecture interne des Skills permet de créer des workflows plus efficaces, d'optimiser les permissions, et de structurer ses prompts pour maximiser les capacités de Claude.

---

## 📋 Table des Matières

- [Concepts Clés](#-concepts-clés)
  - [1. Architecture Meta-Tool](#1-architecture-meta-tool)
  - [2. Prompt-Based System](#2-prompt-based-system)
  - [3. Message Injection (isMeta Flag)](#3-message-injection-ismeta-flag)
  - [4. Progressive Disclosure](#4-progressive-disclosure)
  - [5. Context Modification](#5-context-modification)
- [Structure d'un Skill (SKILL.md)](#-structure-dun-skill-skillmd)
- [Organisation des Ressources](#-organisation-des-ressources)
- [Cycle de Vie d'Exécution](#-cycle-de-vie-dexécution)
- [Patterns Communs](#-patterns-communs)
- [Citations Marquantes](#-citations-marquantes)
- [Exemples Pratiques](#-exemples-pratiques)
- [Points d'Action](#-points-daction)
- [Ressources](#-ressources)

---

## 🎯 Concepts Clés

### 1. Architecture Meta-Tool

Les Skills fonctionnent via un **meta-tool** unique appelé `Skill` (majuscule).

**Principe** :
- Le tool `Skill` apparaît dans le tools array de Claude (avec `Read`, `Write`, `Bash`)
- Gère la découverte et l'invocation de TOUS les skills individuels
- Utilise la génération dynamique de prompts pour présenter les skills disponibles

**Schéma** :
```
╔═══════════════════════════════════════════════════════════╗
║            SKILL TOOL (Meta-Tool Architecture)            ║
╚═══════════════════════════════════════════════════════════╝
                             │
                             ▼
      ┌──────────────────────────────────────────┐
      │   Claude's Tools Array                   │
      ├──────────────────────────────────────────┤
      │  • Read                                  │
      │  • Write                                 │
      │  • Bash                                  │
      │  • Skill ◄─────── Meta-Tool manages ─────┐
      └──────────────────────────────────────────┘│
                                                  │
      ┌───────────────────────────────────────────┘
      │
      ▼
┌─────────────────────────────────────────────────────┐
│  Individual Skills (lowercase s)                    │
├─────────────────────────────────────────────────────┤
│  • pdf                                              │
│  • markdown-creator                                 │
│  • code-reviewer                                    │
│  • debug-mode                                       │
│  • [your-custom-skill]                              │
└─────────────────────────────────────────────────────┘
```

**Avantages** :
- Centralisation : un seul point d'entrée pour tous les skills
- Découverte dynamique : nouveaux skills détectés automatiquement
- Isolation : chaque skill opère dans son propre contexte

**Limitations** :
- Budget de tokens limité (15,000 caractères pour la description du Skill tool)
- Nécessite une description concise pour chaque skill

**Cas d'usage** :
- Gérer des dizaines de skills sans polluer le tools array
- Permettre à Claude de choisir le skill approprié via language understanding

---

### 2. Prompt-Based System

Les Skills ne sont **pas du code exécutable**, mais des **templates de prompts**.

**Principe** :
- Un skill = un fichier `SKILL.md` contenant des instructions détaillées
- Claude lit ces instructions et les exécute via son raisonnement naturel
- Aucun algorithme de routing au niveau code

**Citation clé** :
> "The skill selection mechanism has no algorithmic routing or intent classification at the code level."
> — Han Lee

**Schéma comparatif** :
```
TRADITIONAL TOOLS                    SKILLS (Prompt-Based)
┌─────────────────┐                 ┌─────────────────────┐
│  Function Call  │                 │   SKILL.md Prompt   │
│  (Code Logic)   │                 │   (Instructions)    │
└────────┬────────┘                 └──────────┬──────────┘
         │                                     │
         ▼                                     ▼
┌─────────────────┐                 ┌─────────────────────┐
│  Synchronous    │                 │  Claude Reasoning   │
│  Execution      │                 │  + Tool Calls       │
└────────┬────────┘                 └──────────┬──────────┘
         │                                     │
         ▼                                     ▼
┌─────────────────┐                 ┌─────────────────────┐
│  Return Value   │                 │  Context Modified   │
│  (Data)         │                 │  + Workflow Result  │
└─────────────────┘                 └─────────────────────┘
        ❌                                    ✅
   Direct, rigid                     Flexible, adaptable
```

**Avantages** :
- Flexibilité : instructions en langage naturel
- Évolutivité : Claude s'améliore, les skills deviennent plus puissants
- Transparence : prompts lisibles par les humains

**Limitations** :
- Dépendance à la qualité du LLM
- Nécessite des prompts bien structurés pour éviter les dérives

**Cas d'usage** :
- Workflows complexes nécessitant jugement humain
- Tâches où le contexte change (debugging, refactoring)

---

### 3. Message Injection (isMeta Flag)

Les Skills utilisent un système d'injection de messages à **deux canaux**.

**Principe** :
- **Message 1** (`isMeta: false`) : Visible dans l'interface utilisateur
- **Message 2** (`isMeta: true`) : Invisible, mais envoyé à l'API pour raisonnement

**Schéma** :
```
╔═══════════════════════════════════════════════════════════╗
║            MESSAGE INJECTION ARCHITECTURE                 ║
╚═══════════════════════════════════════════════════════════╝

USER INTERFACE (Visible)              CLAUDE API (Hidden)
┌───────────────────────┐             ┌─────────────────────┐
│                       │             │                     │
│  Message 1            │             │  Message 1          │
│  isMeta: false        │             │  (Status indicator) │
│                       │             │                     │
│  ✅ Visible to user   │             │  Message 2          │
│                       │             │  isMeta: true       │
│  <command-message>    │             │                     │
│  "pdf skill loading"  │             │  ✅ Full prompt     │
│  </command-message>   │             │  (500-5000 words)   │
│                       │             │                     │
└───────────────────────┘             └─────────────────────┘
         │                                      │
         │                                      │
         ▼                                      ▼
   User sees status               Claude reasons with instructions
```

**Exemple concret** :

**Message 1 (Visible)** :
```xml
<command-message>The "pdf" skill is loading</command-message>
<command-name>pdf</command-name>
```

**Message 2 (Hidden)** :
```
You are an expert in PDF processing.

## Overview
Extract text, images, and metadata from PDF files...

## Instructions
1. Use the Read tool to access the PDF
2. Parse content using Python scripts in scripts/
3. Generate structured output in markdown
4. Handle errors gracefully

[... 4,500 more words of detailed instructions ...]
```

**Avantages** :
- Transparence : user voit qu'un skill se charge
- Clarté : interface non polluée par les détails techniques
- Puissance : Claude a accès aux instructions complètes

**Cas d'usage** :
- Tous les skills utilisent ce mécanisme par défaut

---

### 4. Progressive Disclosure

Architecture à **trois niveaux** d'information pour optimiser l'utilisation du contexte.

**Principe** :
1. **Frontmatter (YAML)** : Métadonnées minimales (name, description, allowed-tools)
2. **SKILL.md** : Instructions complètes mais focalisées (500-5,000 mots)
3. **Supporting assets** : Chargés à la demande (scripts, references, assets)

**Schéma pyramide** :
```
        ╔═══════════════════════╗
        ║   FRONTMATTER YAML    ║  ◄─── Niveau 1
        ║   (Minimal metadata)  ║       Toujours visible
        ╚═══════════════════════╝
                  ▼
        ┌───────────────────────┐
        │   SKILL.md Content    │  ◄─── Niveau 2
        │   (Focused workflow)  │       Chargé si invoked
        └───────────────────────┘
                  ▼
        ┌───────────────────────┐
        │  Supporting Assets    │  ◄─── Niveau 3
        │  (On-demand loading)  │       Chargé si nécessaire
        └───────────────────────┘

Budget tokens :
Niveau 1 : ~200 tokens (description)
Niveau 2 : ~2,000-6,000 tokens (prompt complet)
Niveau 3 : Variable (fichiers de référence)
```

**Avantages** :
- Évite la surcharge du contexte
- Skill descriptions légères dans le tool description
- Instructions détaillées chargées uniquement si besoin

**Limitations** :
- Nécessite une structuration rigoureuse
- Fichiers de référence doivent être optimisés

**Cas d'usage** :
- Skills avec beaucoup de documentation (ex: API references)
- Workflows nécessitant des templates complexes

---

### 5. Context Modification

Les Skills modifient temporairement l'environnement d'exécution via `contextModifier`.

**Principe** :
- **Pre-approve tools** : outils spécifiés dans `allowed-tools` ne demandent plus confirmation
- **Override model** : forcer un modèle spécifique (ex: Haiku pour tâches simples)
- **Scope permissions** : permissions limitées à la durée du skill

**Schéma** :
```
╔═══════════════════════════════════════════════════════════╗
║              CONTEXT MODIFICATION LIFECYCLE               ║
╚═══════════════════════════════════════════════════════════╝

BEFORE SKILL INVOCATION
┌─────────────────────────────────────────────────────────┐
│  Default Context                                        │
│  • User must approve each tool call                     │
│  • Model: sonnet-3.5 (default)                          │
│  • No special permissions                               │
└─────────────────────────────────────────────────────────┘
                          │
                          │ Skill invoked
                          ▼
┌─────────────────────────────────────────────────────────┐
│  Modified Context (Scoped to Skill)                     │
│  ✅ allowed-tools: Bash(git:*), Read, Write             │
│  ✅ model: haiku (faster for simple tasks)              │
│  ✅ thinking-tokens: 10000 (complex reasoning)          │
│  ⏰ Duration: Only during skill execution               │
└─────────────────────────────────────────────────────────┘
                          │
                          │ Skill completes
                          ▼
┌─────────────────────────────────────────────────────────┐
│  Context Restored                                       │
│  • Back to default permissions                          │
│  • User approval required again                         │
│  • Original model restored                              │
└─────────────────────────────────────────────────────────┘
```

**Citation** :
> "Permissions are scoped to skill execution via execution context modification."
> — Han Lee

**Avantages** :
- UX fluide : pas de prompts répétitifs pour chaque tool call
- Sécurité : permissions limitées dans le temps
- Performance : override de modèle pour optimiser coût/vitesse

**Limitations** :
- Nécessite une liste `allowed-tools` précise
- Permissions trop larges = risques de sécurité

**Cas d'usage** :
- Skills utilisant intensivement `Bash(git:*)` (ex: commit workflow)
- Skills nécessitant haiku pour rapidité (ex: formatage markdown)

---

## 📄 Structure d'un Skill (SKILL.md)

Chaque skill = 1 fichier markdown avec **2 composants** :

### 1. Frontmatter YAML (Configuration)

```yaml
---
name: pdf
description: Extract text and images from PDF files and convert to markdown
allowed-tools: Read, Write, Bash(python3:*)
model: sonnet
license: MIT
disable-model-invocation: false
mode: false
---
```

**Champs clés** :
- `name` : Identifiant unique du skill
- `description` : Signal principal pour Claude (keep it action-oriented)
- `allowed-tools` : Tools pré-approuvés (comma-separated)
- `model` : Override du modèle (sonnet, haiku, opus)
- `disable-model-invocation` : Si true, nécessite invocation manuelle
- `mode` : Si true, apparaît dans "Mode Commands"

### 2. Markdown Content (Instructions)

Structure recommandée :

```markdown
# Purpose
[1-2 sentences explaining what this skill does]

## Overview
[Brief summary of the workflow]

## Prerequisites
- Tool X must be available
- User must provide Y input

## Instructions

### Step 1: [Action]
[Detailed instructions]

### Step 2: [Action]
[Detailed instructions]

## Output Format
[Specify expected output structure]

## Error Handling
- If X fails, do Y
- If Z is missing, prompt user

## Examples

### Example 1: [Scenario]
\```bash
command here
\```

## Resources
- [Link to doc](url)
```

**Best Practices** :
- Limiter à 5,000 mots (~800 lignes)
- Langage impératif ("Analyze code for…")
- Référencer external files plutôt qu'embed tout
- Focus sur le workflow core

---

## 🗂️ Organisation des Ressources

Structure standard d'un skill avec ressources :

```
📦 my-skill/
┣━━ 📄 SKILL.md              ◄─── Prompt principal (obligatoire)
┣━━ 📁 scripts/              ◄─── Scripts Python/Bash exécutables
┃   ┣━━ 🐍 process.py
┃   ┗━━ 📜 validate.sh
┣━━ 📁 references/           ◄─── Documentation chargée dans contexte
┃   ┣━━ 📄 api-reference.md
┃   ┗━━ 📄 schema.json
┗━━ 📁 assets/               ◄─── Templates référencés par path
    ┣━━ 📝 template.txt
    ┗━━ 🖼️ diagram.png
```

**Rôles des dossiers** :

| Dossier | Usage | Chargé en Contexte ? |
|---------|-------|----------------------|
| `scripts/` | Opérations déterministes, automation | ❌ Non (exécuté via Bash) |
| `references/` | Documentation, schemas JSON | ✅ Oui (Read tool) |
| `assets/` | Templates, binaires | ❌ Non (référencé par path) |

**Schéma de flux** :
```
User Request
     │
     ▼
SKILL.md (Instructions)
     │
     ├──────> scripts/ (Execute automation)
     │             │
     │             ▼
     │        Process data, API calls
     │
     ├──────> references/ (Load docs)
     │             │
     │             ▼
     │        Context enrichment
     │
     └──────> assets/ (Reference templates)
                   │
                   ▼
              Fill templates with data
```

---

## 🔄 Cycle de Vie d'Exécution

Le cycle complet d'exécution d'un skill en **5 phases** :

```
╔═══════════════════════════════════════════════════════════╗
║                 SKILL EXECUTION LIFECYCLE                 ║
╚═══════════════════════════════════════════════════════════╝

PHASE 1: DISCOVERY & LOADING
┌─────────────────────────────────────────────────────────┐
│  System scans:                                          │
│  • ~/.config/claude/skills/          (user)            │
│  • .claude/skills/                   (project)         │
│  • Plugin-provided skills                              │
│  • Built-in skills                                     │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 2: USER REQUEST & SKILL SELECTION
┌─────────────────────────────────────────────────────────┐
│  1. User sends message                                  │
│  2. Claude receives Skill tool description              │
│  3. Claude uses language understanding to match intent  │
│  4. Decision happens in LLM reasoning (no code routing) │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 3: SKILL TOOL EXECUTION
┌─────────────────────────────────────────────────────────┐
│  1. Validation: skill exists and enabled                │
│  2. Permission check: allow/deny rules or user prompt   │
│  3. File loading: load SKILL.md + context mods          │
│  4. Message injection: prepare metadata + prompt        │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 4: API REQUEST
┌─────────────────────────────────────────────────────────┐
│  Message array sent:                                    │
│  • Original user message                                │
│  • Assistant tool use (Skill invocation)                │
│  • Metadata message (visible, isMeta: false)            │
│  • Skill prompt message (hidden, isMeta: true)          │
│  • Permission message (allowed-tools list)              │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 5: CLAUDE TOOL EXECUTION
┌─────────────────────────────────────────────────────────┐
│  Claude executes workflow:                              │
│  • Reads skill instructions from hidden message         │
│  • Uses pre-approved tools (Bash, Read, Write, etc.)    │
│  • No additional user prompts for allowed tools         │
│  • Returns results                                      │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
                    USER SEES RESULT
```

**Points clés** :
- **Phase 2** : Aucun algorithme de routing côté code
- **Phase 3** : Permissions validées avant exécution
- **Phase 4** : Message caché contient le prompt complet
- **Phase 5** : Claude travaille avec contexte modifié

---

## 🎨 Patterns Communs

### Pattern 1: Script Automation

**Principe** : Déléguer les opérations complexes à Python/Bash, avec SKILL.md dirigeant l'exécution.

**Structure** :
```
skill/
├── SKILL.md
└── scripts/
    └── process_data.py
```

**SKILL.md snippet** :
```markdown
## Instructions

1. Read input file with Read tool
2. Execute `python3 {baseDir}/scripts/process_data.py <input>`
3. Parse script output
4. Write results to output file
```

**Cas d'usage** :
- PDF extraction
- Image processing
- Data transformation

---

### Pattern 2: Read-Process-Write

**Principe** : Transformation simple sans script externe.

**Flow** :
```
Read input
    ▼
Process (Claude reasoning)
    ▼
Write output
```

**Exemple** :
```markdown
1. Read source file
2. Transform content:
   - Convert headers to title case
   - Add table of contents
   - Fix broken links
3. Write to destination
```

**Cas d'usage** :
- Markdown formatting
- Code refactoring
- Documentation generation

---

### Pattern 3: Search-Analyze-Report

**Principe** : Grep patterns, analyser findings, générer rapport structuré.

**Flow** :
```
Grep for patterns
    ▼
Read matching files
    ▼
Analyze findings
    ▼
Generate structured report
```

**Exemple** :
```markdown
1. Search codebase: `Grep(pattern: "TODO|FIXME")`
2. Read each matching file
3. Categorize by priority:
   - Critical (FIXME)
   - Nice to have (TODO)
4. Generate markdown report with file paths
```

**Cas d'usage** :
- Code review
- Security audit
- Technical debt tracking

---

### Pattern 4: Command Chain Execution

**Principe** : Séquence de commandes avec dépendances, reporting à chaque étape.

**Flow** :
```
Command 1 ──> Check result ──> Command 2 ──> Check result ──> Command 3
```

**Exemple** :
```markdown
1. Run tests: `npm test`
2. If pass: build: `npm run build`
3. If build success: deploy: `npm run deploy`
4. Report results at each step
```

**Cas d'usage** :
- CI/CD workflows
- Deployment pipelines
- Multi-step validation

---

### Patterns Avancés

**Wizard-Style Workflows** :
- Processus multi-étapes avec confirmation utilisateur entre phases
- Exemple : Configuration initiale d'un projet

**Template-Based Generation** :
- Remplir templates avec données générées ou user-provided
- Exemple : Création de boilerplate code

**Iterative Refinement** :
- Analyses progressives avec profondeur croissante
- Exemple : Code optimization (pass 1: structure, pass 2: performance, pass 3: security)

**Context Aggregation** :
- Synthétiser informations de sources multiples
- Exemple : Documentation generation from multiple repos

---

## 💬 Citations Marquantes

> "The skill selection mechanism has no algorithmic routing or intent classification at the code level."
> — Han Lee

*Claude choisit les skills via language understanding pur, pas d'algorithme de matching.*

---

> "Permissions are scoped to skill execution via execution context modification."
> — Han Lee

*Les permissions sont temporaires, limitées à la durée du skill, puis restaurées.*

---

> "Skills function as specialized prompt templates that inject domain-specific instructions into conversation context."
> — Han Lee

*Un skill = un prompt spécialisé, pas du code exécutable.*

---

> "The Skill tool description is limited to 15,000 characters, forcing concise skill descriptions."
> — Han Lee

*Budget limité pour éviter la saturation du contexte window.*

---

> "Unlike ChatGPT's system prompt-embedded tools, Claude's skill architecture offers temporary, scoped behavior modifications."
> — Han Lee

*Approche unique vs autres LLMs : modifications temporaires, pas de résidus.*

---

## 💻 Exemples Pratiques

### Exemple 1 : Skill PDF Simple

**Problème** :
Extraire texte d'un PDF et convertir en markdown.

**Solution** :

**Frontmatter** :
```yaml
---
name: pdf
description: Extract text from PDF and convert to markdown
allowed-tools: Bash(python3:*), Read, Write
model: sonnet
---
```

**Instructions** :
```markdown
# PDF Extraction Skill

## Instructions

1. Validate input file exists with Read tool
2. Execute extraction script:
   \```bash
   python3 {baseDir}/scripts/extract_pdf.py {input_pdf}
   \```
3. Parse JSON output from script
4. Convert to markdown format
5. Write to `{input_name}.md`

## Error Handling
- If PDF is encrypted, prompt user for password
- If extraction fails, return error message with details
```

**Script** (`scripts/extract_pdf.py`) :
```python
import sys
import PyPDF2
import json

def extract_text(pdf_path):
    with open(pdf_path, 'rb') as f:
        reader = PyPDF2.PdfReader(f)
        text = ""
        for page in reader.pages:
            text += page.extract_text()
    return {"text": text, "pages": len(reader.pages)}

if __name__ == "__main__":
    result = extract_text(sys.argv[1])
    print(json.dumps(result))
```

**Explication** :
- SKILL.md guide Claude pour exécuter le script
- Script Python handle la logique déterministe (PDF parsing)
- Claude transforme le JSON output en markdown

---

### Exemple 2 : Skill Mode Debug

**Problème** :
Établir un contexte de debugging persistant avec outils pré-approuvés.

**Solution** :

**Frontmatter** :
```yaml
---
name: debug-mode
description: Enter debug mode with enhanced logging and debugging tools
allowed-tools: Bash(*, Read, Write, Grep
model: sonnet
mode: true
---
```

**Instructions** :
```markdown
# Debug Mode

You are now in debug mode. Follow these guidelines:

## Behavior Modifications
- Always show verbose output
- Log all intermediate steps
- Use detailed error messages
- Ask clarifying questions before proceeding

## Available Tools
- Read: Inspect file contents
- Grep: Search for error patterns
- Bash: Run diagnostic commands
- Write: Create debug logs

## Workflow
1. Understand the problem thoroughly
2. Inspect relevant files
3. Search for related errors
4. Test hypotheses incrementally
5. Document findings in debug.md

## Output Format
Always structure responses as:
- **Hypothesis**: What I think is wrong
- **Evidence**: Files/logs inspected
- **Test**: Command to validate hypothesis
- **Result**: Outcome and next steps
```

**Explication** :
- `mode: true` place ce skill dans "Mode Commands"
- Modifie le comportement de Claude pour toute la session
- Pre-approve tous les outils de diagnostic

---

### Exemple 3 : Skill Template-Based (Commit Message)

**Problème** :
Générer des commit messages conventionnels basés sur git diff.

**Solution** :

**Frontmatter** :
```yaml
---
name: commit-message
description: Generate conventional commit message from git diff
allowed-tools: Bash(git:*), Read
model: haiku
---
```

**Instructions** :
```markdown
# Commit Message Generator

## Instructions

1. Run `git diff --staged` to get changes
2. Analyze changes:
   - Identify primary change type (feat/fix/docs/refactor/test/chore)
   - Determine scope (component/file affected)
   - Extract key changes
3. Generate commit message following Conventional Commits:
   \```
   <type>(<scope>): <description>

   <optional body>

   <optional footer>
   \```

## Examples

**Feat** :
\```
feat(auth): add JWT token validation

Implement middleware to validate JWT tokens on protected routes.
Handles token expiration and invalid signatures.
\```

**Fix** :
\```
fix(api): handle null response in getUserData

Add null check before accessing response.data to prevent crashes.
\```

## Output
Present generated message and ask for confirmation before committing.
```

**Explication** :
- Utilise haiku (faster, cheaper pour tâche simple)
- Pre-approve `Bash(git:*)` pour éviter prompts répétitifs
- Template structure guide la génération

---

## ✅ Points d'Action

### Immédiat (< 1h)

- [ ] Lire la structure d'un skill existant (ex: `~/.config/claude/skills/markdown-creator/SKILL.md`)
- [ ] Identifier les `allowed-tools` utilisés dans vos skills favoris
- [ ] Tester la commande `/skill pdf` pour voir le message injection en action
- [ ] Comparer un skill "mode" vs skill "normal" dans votre setup

### Court terme (1-7 jours)

- [ ] Créer un skill simple Pattern 2 (Read-Process-Write) pour une tâche récurrente
- [ ] Ajouter un script Python dans `scripts/` pour automatiser une opération complexe
- [ ] Expérimenter avec `model: haiku` sur un skill simple pour comparer vitesse/coût
- [ ] Documenter un workflow multi-étapes avec Pattern 4 (Command Chain)
- [ ] Tester progressive disclosure : créer `references/` avec docs volumineuses

### Long terme (> 1 semaine)

- [ ] Architecturer un skill avancé avec les 3 dossiers (scripts, references, assets)
- [ ] Créer un "mode" personnalisé pour votre workflow principal
- [ ] Optimiser vos skills existants : réduire descriptions, scopper permissions
- [ ] Contribuer un skill à un repo communautaire (ex: Awesome Sub-Agents)
- [ ] Mesurer l'impact des `contextModifier` sur la performance de vos workflows

---

## 📚 Ressources

### Documentation Officielle
- 📄 [Claude Code Skills Documentation](https://code.claude.com/docs/skills) - Guide officiel
- 📄 [Anthropic API Reference](https://docs.anthropic.com/en/api) - API details
- 📄 [Skill Creation Guide](https://code.claude.com/docs/skills/creating-skills) - Tutorial

### Repos Communauté
- 🔗 [Awesome Claude Code Sub-Agents](https://github.com/VoltAgent/awesome-claude-code-subagents) - Collection de skills
- 🔗 [Han Lee's GitHub](https://github.com/leehanchung) - Auteur de l'article
- 🔗 [Claude Code Examples](https://github.com/anthropics/claude-code-examples) - Examples officiels

### Articles Connexes
- 📄 [Skills vs Commands vs Agents](../../themes/4-skills/guide.md) - Comparaison
- 📄 [Memory Best Practices](../../themes/1-memory/guide.md) - Optimiser contexte
- 📄 [Hook System](../../themes/3-hooks/guide.md) - Intégrer skills avec hooks

---

**Tags** : `#skills` `#architecture` `#prompt-engineering` `#meta-tool` `#context-modification` `#message-injection` `#progressive-disclosure` `#workflow` `#best-practices` `#advanced`

**Niveau** : 🔴 Expert

**Temps de pratique estimé** : 4-6 heures (lecture + expérimentation)
