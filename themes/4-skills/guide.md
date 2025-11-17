# 💡 Skills Claude Code - Guide Complet

> **Maîtrisez les capacités spécialisées autonomes**

📄 **Docs officielles** : [Claude Code Skills](https://code.claude.com/docs/skills)

---

## 📚 Théorie Fondamentale

### 🎯 Qu'est-ce qu'un Skill ?

Un **skill** est une **capacité spécialisée** que Claude peut invoquer **automatiquement** quand nécessaire.

```
╔══════════════════════════════════════════════════════════╗
║  SKILLS - CAPACITÉS AUTONOMES                           ║
╚══════════════════════════════════════════════════════════╝

Sans Skill                     Avec Skill
──────────                     ──────────

User: "Lis ce PDF"            User: "Lis ce PDF"
  │                              │
  ▼                              ▼
Claude: "Je ne peux pas"       Claude invoque Skill PDF
                                 │
                                 ▼
                               PDF lu et analysé ✅
```

### 🧩 Problème Résolu

**Avant Skills** :
- Claude limité aux outils built-in
- Pas d'extensions personnalisées
- Workflows manuels répétitifs

**Avec Skills** :
- Capacités étendues (PDF, Excel, API customs)
- Invocation automatique
- Réutilisabilité totale

---

## 🏗️ Architecture Skill

### 📂 Structure

```
.claude/skills/
└── pdf-processor/
    └── SKILL.md
```

### 📄 Format SKILL.md

```markdown
# PDF Processor Skill

Process and extract content from PDF files.

## Capabilities

- Read PDF files
- Extract text content
- Parse tables
- Extract images

## Usage

Automatically invoked when user mentions PDF files.

## Examples

Input: "Lis document.pdf"
Output: [PDF content extracted]
```

---

## 🏗️ Architecture Interne

### 🎯 Meta-Tool : Le Système de Gestion des Skills

**Principe fondamental** : Tous les skills sont gérés par UN SEUL tool appelé `Skill` (majuscule).

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

**Comment ça marche** :

1. **Le `Skill` tool** (capital S) apparaît dans le `tools` array aux côtés de Read, Write, Bash
2. **Sa description** contient la liste dynamique de TOUS les skills disponibles
3. **Claude choisit** le skill approprié via language understanding (pas d'algorithme de routing)
4. **Budget limité** : 15,000 caractères maximum pour la description du Skill tool

**Pourquoi c'est important** :
- ✅ **Centralisation** : Un seul point d'entrée pour gérer des dizaines de skills
- ✅ **Découverte dynamique** : Nouveaux skills détectés automatiquement
- ✅ **Isolation** : Chaque skill opère dans son propre contexte

> **Citation clé** :
> "The skill selection mechanism has no algorithmic routing or intent classification at the code level."
> — Han Lee

**Cas d'usage** :
- Gérer 10+ skills sans polluer le tools array
- Permettre à Claude de choisir le skill via compréhension naturelle du langage

---

### 📨 Message Injection : Communication Dual-Channel

**Problème** : Comment montrer à l'user qu'un skill se charge SANS polluer l'interface avec 5,000 mots d'instructions ?

**Solution** : Système à 2 messages avec flag `isMeta`

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

**Message 1** (isMeta: false) - **VISIBLE** dans l'UI :
```xml
<command-message>The "pdf" skill is loading</command-message>
<command-name>pdf</command-name>
```

**Message 2** (isMeta: true) - **HIDDEN** de l'UI, envoyé à l'API :
```markdown
You are a PDF processing specialist.

## Overview
Extract text, images, and metadata from PDF files...

## Instructions
1. Validate PDF exists
2. Run extraction script
3. Parse JSON output
4. Generate markdown

[... 4,500 more words of detailed instructions ...]
```

**Tableau comparatif** :

| Aspect | Message 1 (Metadata) | Message 2 (Prompt) |
|--------|---------------------|-------------------|
| **Audience** | Human user | Claude (AI) |
| **Longueur** | ~50-200 chars | ~500-5,000 words |
| **Format** | XML structuré | Markdown naturel |
| **Visibilité** | ✅ Visible UI | ❌ Hidden |
| **But** | Status indicator | Instructions complètes |

**Pourquoi 2 messages** :
- **Transparence** : User voit qu'un skill se charge
- **Clarté** : UI non polluée par détails techniques
- **Puissance** : Claude a accès aux instructions complètes

---

### 📊 Progressive Disclosure : 3 Niveaux d'Information

**Principe** : Révéler l'information progressivement pour optimiser l'utilisation du contexte.

```
        ╔═══════════════════════╗
        ║   FRONTMATTER YAML    ║  ◄─── Niveau 1
        ║   (Minimal metadata)  ║       Toujours visible
        ╚═══════════════════════╝       ~200 tokens
                  ▼
        ┌───────────────────────┐
        │   SKILL.md Content    │  ◄─── Niveau 2
        │   (Focused workflow)  │       Chargé si invoked
        └───────────────────────┘       ~2,000-6,000 tokens
                  ▼
        ┌───────────────────────┐
        │  Supporting Assets    │  ◄─── Niveau 3
        │  (On-demand loading)  │       Chargé si nécessaire
        └───────────────────────┘       Variable tokens
```

**Détails par niveau** :

**Niveau 1 : Frontmatter** (~200 tokens)
- Visible dans la description du Skill tool
- Champs : `name`, `description`, `allowed-tools`, `model`
- Permet à Claude de décider si ce skill correspond à l'intent

**Niveau 2 : SKILL.md Content** (~2,000-6,000 tokens)
- Chargé uniquement si le skill est invoqué
- Instructions détaillées du workflow
- Référence les assets externes avec `{baseDir}`

**Niveau 3 : Supporting Assets** (variable)
- Chargés à la demande via Read tool
- Fichiers dans `scripts/`, `references/`, `assets/`
- Ne consomment des tokens que si explicitement lus

> **Citation** :
> "The most important concept for building Skills is Progressive Disclosure — showing just enough information to help agents decide what to do next, then reveal more details as they need them."
> — Han Lee

**Avantages** :
- ✅ Évite la saturation du context window
- ✅ Skill descriptions légères (15,000 chars budget partagé)
- ✅ Instructions détaillées disponibles si besoin

**Exemple avec PDF skill** :
```
Niveau 1 → Description: "Extract text from PDF files"
Niveau 2 → SKILL.md: Workflow complet (validation, extraction, formatting)
Niveau 3 → scripts/extract_pdf.py: Script Python chargé si nécessaire
```

---

### ⚙️ Context Modification : Permissions Temporaires

**Principe** : Les skills modifient temporairement l'environnement d'exécution via `contextModifier`.

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

**Modifications possibles** :

**1. Pre-approve tools** :
```yaml
allowed-tools: "Bash(git:*), Read, Write"
```
→ Ces outils ne demandent plus confirmation pendant l'exécution du skill

**2. Override model** :
```yaml
model: haiku
```
→ Utilise Haiku au lieu de Sonnet pour rapidité/coût

**3. Adjust thinking tokens** :
```yaml
thinking-tokens: 10000
```
→ Augmente les tokens de raisonnement pour tâches complexes

> **Citation** :
> "Permissions are scoped to skill execution via execution context modification."
> — Han Lee

**Exemple concret avec PDF skill** :
```yaml
---
name: pdf
allowed-tools: Bash(python3:*), Read, Write
model: sonnet
---
```

**Flow** :
1. User demande : "Extrais texte de report.pdf"
2. Claude invoque skill PDF
3. **Context modifié** : `Bash(python3:*)`, `Read`, `Write` pre-approved
4. Claude exécute `python3 scripts/extract.py` SANS prompt user
5. Skill terminé → **Context restauré** → prochaine commande demandera confirmation

**Avantages** :
- ✅ **UX fluide** : Pas de prompts répétitifs pour chaque tool call
- ✅ **Sécurité** : Permissions limitées dans le temps et au scope du skill
- ✅ **Performance** : Override de modèle pour optimiser coût/vitesse

---

## 🎯 Cas d'Usage

### 🟢 Cas 1 : PDF Processor

**Objectif** : Permettre à Claude de lire des PDFs.

```markdown
# PDF Processor

Extract and analyze PDF content.

## Capabilities
- Read PDF files (.pdf)
- Extract text with formatting
- Parse tables to JSON
- Extract metadata

## Implementation
Uses pdf-parse npm package for processing.
```

### 🟡 Cas 2 : Excel Handler

**Objectif** : Traiter fichiers Excel.

```markdown
# Excel Handler

Process Excel spreadsheets.

## Capabilities
- Read .xlsx/.xls files
- Extract data to JSON
- Parse formulas
- Generate reports

## Usage
Invoke when user references Excel files.
```

### 🟠 Cas 3 : API Custom

**Objectif** : Intégrer API propriétaire.

```markdown
# Internal API Skill

Query company internal API.

## Capabilities
- Authenticate with API
- Query endpoints
- Parse responses
- Handle pagination

## Configuration
Requires API_KEY env variable.
```

---

## 🗂️ Organisation des Ressources

### 📁 Structure Complète d'un Skill

Un skill peut contenir 3 types de ressources organisées dans des dossiers spécifiques :

```
📦 my-skill/
┣━━ 📄 SKILL.md              ◄─── Prompt principal (obligatoire)
┣━━ 📁 scripts/              ◄─── Scripts exécutables
┃   ┣━━ 🐍 process.py
┃   ┗━━ 📜 validate.sh
┣━━ 📁 references/           ◄─── Documentation chargée dans contexte
┃   ┣━━ 📄 api-guide.md
┃   ┗━━ 📄 schema.json
┗━━ 📁 assets/               ◄─── Templates référencés par path
    ┣━━ 📝 template.html
    ┗━━ 🖼️ diagram.png
```

### 🎯 Distinction CRITIQUE : Chargement vs Référence

**La différence entre ces dossiers impacte directement votre budget tokens** :

| Dossier | Contenu | Chargé en Contexte ? | Usage Tokens | Cas d'usage |
|---------|---------|----------------------|--------------|-------------|
| **`scripts/`** | Python, Bash exécutables | ❌ Non | 0 | Automation, data processing |
| **`references/`** | Markdown, JSON, docs | ✅ Oui (via Read) | Élevé | Guides, schemas, checklists |
| **`assets/`** | Templates, images, binaires | ❌ Non | 0 | Templates à remplir, ressources statiques |

**Schéma de flux** :
```
User Request
     │
     ▼
SKILL.md (Instructions)
     │
     ├──────> scripts/ (Execute via Bash)
     │             │
     │             ▼
     │        ❌ Non chargé en contexte
     │        ✅ Exécuté, résultat retourné
     │
     ├──────> references/ (Load via Read)
     │             │
     │             ▼
     │        ✅ Chargé en contexte Claude
     │        📊 Consomme tokens
     │
     └──────> assets/ (Reference by path)
                   │
                   ▼
              ❌ Non chargé en contexte
              🔗 Path fourni à Claude
```

### 📚 Détails par Dossier

#### `scripts/` - Automation

**Usage** : Opérations déterministes qui nécessitent code exécutable

**Exemples** :
- `extract_pdf.py` : Parser PDF avec PyPDF2
- `validate_json.sh` : Valider schema JSON
- `api_call.py` : Requête API avec retry logic

**Dans SKILL.md** :
```markdown
## Instructions

1. Validate input file
2. Execute extraction script:
   ```bash
   python3 {baseDir}/scripts/extract_pdf.py {input_file}
   ```
3. Parse JSON output from script
```

**Avantages** :
- ✅ Logic complexe en Python/Bash (plus fiable que LLM pour opérations déterministes)
- ✅ Ne consomme PAS de tokens context
- ✅ Peut utiliser bibliothèques externes (PyPDF2, requests, etc.)

---

#### `references/` - Documentation

**Usage** : Contenu textuel que Claude doit lire et intégrer dans son raisonnement

**Exemples** :
- `api_reference.md` : Documentation API complète
- `schema.json` : Schema de validation
- `style_guide.md` : Guidelines de formatage
- `examples.md` : Exemples de code

**Dans SKILL.md** :
```markdown
## Instructions

1. Read API reference for detailed endpoints:
   ```
   Read {baseDir}/references/api_reference.md
   ```
2. Use schema to validate output:
   ```
   Read {baseDir}/references/schema.json
   ```
```

**⚠️ Attention** :
- ⚠️ **Consomme des tokens** : Un fichier de 10 KB = ~2,500 tokens
- ⚠️ Charger uniquement si nécessaire (progressive disclosure)
- ⚠️ Optimiser la taille des fichiers de référence

**Best practice** :
```markdown
✅ Bon : Read {baseDir}/references/api_endpoints.md si besoin de détails API
❌ Mauvais : Read tous les fichiers references/ systématiquement
```

---

#### `assets/` - Templates & Ressources Statiques

**Usage** : Fichiers manipulés par path, non lus dans le contexte

**Exemples** :
- `report_template.html` : Template HTML avec placeholders
- `logo.png` : Image à insérer dans rapport
- `config_boilerplate.json` : Config de base à dupliquer
- `diagram.svg` : Schéma architecture

**Dans SKILL.md** :
```markdown
## Instructions

1. Copy template to output directory:
   ```bash
   cp {baseDir}/assets/report_template.html ./output/report.html
   ```
2. Fill placeholders in template
3. Reference diagram in documentation:
   - Path: {baseDir}/assets/diagram.svg
```

**Cas d'usage typique** :
```markdown
User: "Génère un rapport HTML"

Claude:
1. Copie {baseDir}/assets/report_template.html
2. Remplace {{TITLE}} par le titre fourni
3. Remplace {{CONTENT}} par le contenu généré
4. Insère {baseDir}/assets/logo.png en header
5. Écrit le résultat final
```

**Avantages** :
- ✅ Ne consomme PAS de tokens
- ✅ Peut contenir binaires (images, fonts, PDFs)
- ✅ Templates réutilisables

---

### 🎓 Exemple Complet : Skill avec les 3 Dossiers

**Skill : API Documentation Generator**

```
api-doc-generator/
┣━━ SKILL.md
┣━━ scripts/
┃   ┗━━ fetch_endpoints.py      # Interroge API pour lister endpoints
┣━━ references/
┃   ┣━━ openapi_spec.json       # Spec OpenAPI pour validation
┃   ┗━━ doc_style_guide.md      # Guidelines documentation
┗━━ assets/
    ┣━━ api_doc_template.html   # Template HTML rapport
    ┗━━ company_logo.png         # Logo entreprise
```

**Flow d'exécution** :

1. **SKILL.md** : Instructions du workflow
2. **Exécute** `scripts/fetch_endpoints.py` → Récupère liste endpoints
3. **Lit** `references/openapi_spec.json` → Valide spec OpenAPI
4. **Lit** `references/doc_style_guide.md` → Applique style guidelines
5. **Copie** `assets/api_doc_template.html` → Base du rapport
6. **Référence** `assets/company_logo.png` → Insère logo dans HTML

**Tokens consommés** :
- SKILL.md : ~500 tokens
- `scripts/fetch_endpoints.py` : 0 tokens (exécuté, pas lu)
- `references/openapi_spec.json` : 1,200 tokens (lu via Read)
- `references/doc_style_guide.md` : 800 tokens (lu via Read)
- `assets/api_doc_template.html` : 0 tokens (copié par path)
- `assets/company_logo.png` : 0 tokens (image référencée)

**Total : ~2,500 tokens** au lieu de potentiellement 10,000+ si tout était dans SKILL.md

---

### 📖 Source Validation

Cette distinction est confirmée par les sources officielles Anthropic :

> "The references/ directory stores documentation that Claude reads into its context when referenced. The assets/ directory contains templates and binary files that Claude references by path but doesn't load into context."
> — Han Lee, Claude Agent Skills Deep Dive

> "Supporting scripts: templates, sample datasets, brand assets, or policy documents… templates & sample assets: PowerPoint templates, spreadsheets, legal boilerplate… referenced by Claude at runtime, but not injected in context."
> — Anthropic Engineering Blog

**Sources** :
- 📄 [Claude Skills Deep Dive](https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/)
- 📄 [Anthropic Engineering: Agent Skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills)

---

## 📋 Frontmatter Avancé & Variable {baseDir}

### 🎯 Tous les Champs Frontmatter

**Structure complète** :

```yaml
---
name: my-skill                    # ✅ REQUIS
description: Brief overview       # ✅ REQUIS
when_to_use: Specific use case    # ⚠️ UNDOCUMENTED (expérimental)
allowed-tools: Read, Write        # ⚙️ Optionnel
model: sonnet                     # ⚙️ Optionnel
license: MIT                      # ⚙️ Optionnel
version: 1.0.0                    # ⚙️ Optionnel
disable-model-invocation: false   # ⚙️ Optionnel
mode: false                       # ⚙️ Optionnel
---
```

### 📖 Détails des Champs

#### `when_to_use` ⚠️ (Undocumented)

**Status** : Présent dans le code mais NON documenté officiellement

**Fonction** : Appendé à la description pour guider Claude

**Exemple** :
```yaml
description: Extract text from PDF files
when_to_use: When user wants to process PDF documents
```

**Résultat dans Skill tool** :
```
"pdf": Extract text from PDF files - When user wants to process PDF documents
```

**⚠️ Recommandation** :
- Ne pas utiliser en production (non officiel)
- Inclure usage guidance directement dans `description`

---

#### `disable-model-invocation`

**Fonction** : Empêche Claude d'invoquer automatiquement le skill

**Usage** : Skills manuels nécessitant invocation explicite via `/skill-name`

**Exemple** :
```yaml
name: dangerous-operation
disable-model-invocation: true
```

→ User doit taper `/dangerous-operation` explicitement
→ Skill N'APPARAÎT PAS dans la liste des skills disponibles pour Claude

**Cas d'usage** :
- Operations destructives (delete, reset, deploy)
- Configurations système
- Workflows nécessitant confirmation explicite

---

#### `mode`

**Fonction** : Catégorise le skill comme "Mode Command"

**Effet** : Apparaît dans une section spéciale "Mode Commands" (en haut de la liste)

**Exemple** :
```yaml
name: debug-mode
mode: true
```

**Cas d'usage** :
- `debug-mode` : Contexte debugging persistant
- `expert-mode` : Niveau de détail avancé
- `review-mode` : Focus sur code review

---

### 🔗 Variable `{baseDir}` : Portabilité des Skills

**Problème** : Chemins absolus cassent la portabilité

```markdown
❌ Mauvais :
python /home/user/.claude/skills/pdf/scripts/extract.py

❌ Mauvais :
Read /Users/alice/project/.claude/skills/pdf/references/guide.md
```

**Solution** : Variable `{baseDir}` résolue automatiquement

```markdown
✅ Bon :
python {baseDir}/scripts/extract.py

✅ Bon :
Read {baseDir}/references/guide.md
```

**Résolution automatique** :
- User config : `~/.config/claude/skills/pdf/` → `{baseDir}` = `~/.config/claude/skills/pdf`
- Project config : `.claude/skills/pdf/` → `{baseDir}` = `.claude/skills/pdf`
- Plugin : `plugins/my-plugin/skills/pdf/` → `{baseDir}` = `plugins/my-plugin/skills/pdf`

**Avantages** :
- ✅ Skills portables entre projets
- ✅ Fonctionne sur tous les OS (Windows, macOS, Linux)
- ✅ Partageable dans plugins sans modification

**Exemple complet** :
```markdown
# SKILL.md

## Instructions

1. Read configuration:
   ```
   Read {baseDir}/references/config.md
   ```

2. Execute validation:
   ```bash
   python3 {baseDir}/scripts/validate.py --input "{USER_INPUT}"
   ```

3. Use template:
   ```bash
   cp {baseDir}/assets/template.json ./output.json
   ```
```

---

## 🔄 Cycle de Vie d'Exécution

### 📊 Les 5 Phases Complètes

Le cycle d'exécution d'un skill passe par **5 phases distinctes** :

```
╔═══════════════════════════════════════════════════════════╗
║                 SKILL EXECUTION LIFECYCLE                 ║
╚═══════════════════════════════════════════════════════════╝

PHASE 1: DISCOVERY & LOADING (Startup)
┌─────────────────────────────────────────────────────────┐
│  System scans:                                          │
│  • ~/.config/claude/skills/          (user global)     │
│  • .claude/skills/                   (project local)   │
│  • Plugin-provided skills            (extensions)      │
│  • Built-in skills                   (official)        │
│                                                         │
│  → Builds available skills list                        │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 2: USER REQUEST & SKILL SELECTION
┌─────────────────────────────────────────────────────────┐
│  1. User sends message: "Extract text from report.pdf" │
│  2. Claude receives Skill tool description              │
│  3. Claude reads <available_skills> list                │
│  4. Claude uses LLM reasoning to match intent           │
│  5. Decision: Invoke "pdf" skill                        │
│                                                         │
│  ⚡ No algorithmic routing - Pure LLM reasoning!        │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 3: SKILL TOOL EXECUTION (Validation & Loading)
┌─────────────────────────────────────────────────────────┐
│  Step 1: Validation                                     │
│    • Skill exists?                                      │
│    • Skill enabled?                                     │
│    • Type = "prompt"?                                   │
│                                                         │
│  Step 2: Permission Check                               │
│    • Check deny rules                                   │
│    • Check allow rules                                  │
│    • Prompt user if needed                              │
│                                                         │
│  Step 3: File Loading                                   │
│    • Load SKILL.md from disk                            │
│    • Parse frontmatter (allowed-tools, model, etc.)     │
│    • Prepare context modifications                      │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 4: API REQUEST (Message Injection)
┌─────────────────────────────────────────────────────────┐
│  Messages array sent to Anthropic API:                  │
│                                                         │
│  1. User message: "Extract text from report.pdf"       │
│  2. Assistant tool_use: Skill(command: "pdf")          │
│  3. User metadata (isMeta: false):                      │
│     "<command-message>pdf skill loading</command>"     │
│  4. User prompt (isMeta: true):                         │
│     "You are a PDF specialist... [full SKILL.md]"      │
│  5. Permission message:                                 │
│     { allowed-tools: [...], model: "sonnet" }          │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
PHASE 5: CLAUDE TOOL EXECUTION (Workflow Execution)
┌─────────────────────────────────────────────────────────┐
│  Claude executes with modified context:                 │
│                                                         │
│  ✅ Reads hidden prompt (SKILL.md instructions)         │
│  ✅ Uses pre-approved tools (no user prompt)            │
│  ✅ Follows skill workflow step-by-step                 │
│  ✅ Calls Bash, Read, Write as needed                   │
│  ✅ Returns final result to user                        │
│                                                         │
│  Context restored after skill completes                 │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
                    USER SEES RESULT
```

### 🔍 Détails des Phases Critiques

**Phase 2 : LLM Reasoning pour Sélection**

Aucun code de matching. Claude décide via :
```
User: "Extrais texte de report.pdf"

Claude raisonne :
- Task = extraction de texte
- File = PDF
- Scanning available_skills...
- "pdf": Extract text from PDF files ✅ MATCH
- Decision: Invoke Skill(command: "pdf")
```

**Phase 3 : Validation Errors**

5 error codes possibles :
1. Empty command
2. Unknown skill
3. Can't load skill file
4. Model invocation disabled
5. Not prompt-based skill

**Phase 4 : Message Injection Détaillée**

2 canaux séparés :
- **Canal visible** : User voit status indicator (~50 chars)
- **Canal hidden** : Claude reçoit instructions complètes (~5,000 words)

**Phase 5 : Context Temporaire**

Modifications actives :
- ✅ allowed-tools pre-approved
- ✅ model override appliqué
- ✅ thinking-tokens ajustés

Après skill :
- ❌ Context restauré à default
- ❌ Permissions révoquées

---

## 💪 Patterns Avancés avec Diagrammes

### Pattern 1 : Script Automation

**Principe** : Déléguer les opérations complexes à Python/Bash avec SKILL.md orchestrant l'exécution.

```
┌─────────────────────────────────────────────────────────┐
│                  SCRIPT AUTOMATION                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  User Request                                           │
│       │                                                 │
│       ▼                                                 │
│  SKILL.md (Orchestration)                               │
│       │                                                 │
│       ├──> Read input file                              │
│       │                                                 │
│       ├──> Execute Python script                        │
│       │    python {baseDir}/scripts/process.py          │
│       │         │                                       │
│       │         ▼                                       │
│       │    Heavy computation                            │
│       │    API calls                                    │
│       │    Data transformation                          │
│       │         │                                       │
│       │         ▼                                       │
│       │    Return JSON result                           │
│       │                                                 │
│       ├──> Parse script output                          │
│       │                                                 │
│       └──> Write formatted result                       │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Cas d'usage** :
- PDF extraction (PyPDF2)
- Image processing (Pillow, sharp)
- Data transformation (pandas)
- API interactions avec retry logic

**Exemple SKILL.md** :
```markdown
## Instructions

1. Validate input file exists
2. Execute: `python3 {baseDir}/scripts/extract.py {input_file}`
3. Parse JSON output: `{"pages": 10, "text": "..."}`
4. Format as markdown
```

---

### Pattern 2 : Read-Process-Write

**Principe** : Transformation simple sans script externe, Claude fait le processing.

```
┌─────────────────────────────────────────────────────────┐
│                READ-PROCESS-WRITE                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Read input                                             │
│       │                                                 │
│       ▼                                                 │
│  ┌───────────────────────┐                             │
│  │  Claude Processing    │                             │
│  │  • Transform headers  │                             │
│  │  • Fix formatting     │                             │
│  │  • Add TOC            │                             │
│  │  • Validate links     │                             │
│  └───────────────────────┘                             │
│       │                                                 │
│       ▼                                                 │
│  Write output                                           │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Cas d'usage** :
- Markdown formatting
- Code refactoring
- Documentation generation
- Configuration file transformation

**Exemple SKILL.md** :
```markdown
## Instructions

1. Read source file with Read tool
2. Transform content:
   - Convert headers to title case
   - Generate table of contents
   - Fix broken internal links
   - Add frontmatter if missing
3. Write to destination file
```

---

### Pattern 3 : Search-Analyze-Report

**Principe** : Grep patterns dans codebase, analyser findings, générer rapport structuré.

```
┌─────────────────────────────────────────────────────────┐
│              SEARCH-ANALYZE-REPORT                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Grep(pattern: "TODO|FIXME|XXX")                        │
│       │                                                 │
│       ▼                                                 │
│  Files matched: [src/app.js, utils/helper.ts, ...]     │
│       │                                                 │
│       ▼                                                 │
│  Read each file (context around match)                  │
│       │                                                 │
│       ▼                                                 │
│  ┌───────────────────────┐                             │
│  │   Analyze Findings    │                             │
│  │   • Categorize        │                             │
│  │   • Prioritize        │                             │
│  │   • Estimate effort   │                             │
│  └───────────────────────┘                             │
│       │                                                 │
│       ▼                                                 │
│  Generate markdown report:                              │
│  ## Critical Issues (FIXME)                             │
│  - [File:Line] Description                              │
│  ## Nice to Have (TODO)                                 │
│  - [File:Line] Description                              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Cas d'usage** :
- Code review automation
- Security audit (search vulnerabilities)
- Technical debt tracking
- Dependency analysis

**Exemple SKILL.md** :
```markdown
## Instructions

1. Search codebase:
   Grep(pattern: "TODO|FIXME", output_mode: "content")
2. For each match:
   - Read file for context
   - Analyze severity
   - Extract description
3. Generate report:
   - Group by priority
   - Include file paths and line numbers
   - Estimate effort for fixes
```

---

### Pattern 4 : Command Chain Execution

**Principe** : Séquence de commandes avec dépendances, reporting à chaque étape.

```
┌─────────────────────────────────────────────────────────┐
│             COMMAND CHAIN EXECUTION                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  Command 1: npm install                                 │
│       │                                                 │
│       ▼                                                 │
│  ✅ Success? ──────> Continue                           │
│  ❌ Failure? ──────> Report & stop                      │
│       │                                                 │
│       ▼                                                 │
│  Command 2: npm run lint                                │
│       │                                                 │
│       ▼                                                 │
│  ✅ Success? ──────> Continue                           │
│  ❌ Failure? ──────> Report & stop                      │
│       │                                                 │
│       ▼                                                 │
│  Command 3: npm test                                    │
│       │                                                 │
│       ▼                                                 │
│  ✅ Success? ──────> Continue                           │
│  ❌ Failure? ──────> Report & stop                      │
│       │                                                 │
│       ▼                                                 │
│  Final Report: All checks passed ✅                     │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Cas d'usage** :
- CI/CD workflows
- Pre-commit checks
- Deployment pipelines
- Multi-step validation

**Exemple SKILL.md** :
```markdown
## Instructions

1. Run tests: `npm test`
   - If fail: report errors and STOP
2. Run linter: `npm run lint`
   - If fail: report warnings and STOP
3. Build project: `npm run build`
   - If fail: report build errors and STOP
4. If all passed: report success summary
```

---

### 🚀 Patterns Avancés

#### Wizard-Style Workflows

**Principe** : Processus multi-étapes avec confirmation utilisateur entre chaque phase.

**Structure** :
```markdown
## Workflow

### Step 1: Initial Setup
1. Ask user for project type
2. Validate prerequisites
3. Create base configuration
**Wait for user confirmation before proceeding**

### Step 2: Configuration
1. Present configuration options
2. Ask user to choose settings
3. Generate config files
**Wait for user confirmation before proceeding**

### Step 3: Initialization
1. Run initialization scripts
2. Verify setup successful
3. Report completion
```

**Cas d'usage** :
- Project initialization wizards
- Configuration tools
- Setup assistants
- Migration tools

---

#### Template-Based Generation

**Principe** : Charger template depuis `assets/`, remplir placeholders, écrire résultat.

**Flow** :
```
Read {baseDir}/assets/template.html
    ▼
Remplacer {{TITLE}} → User-provided title
Remplacer {{CONTENT}} → Generated content
Remplacer {{DATE}} → Current date
    ▼
Write output file
```

**Cas d'usage** :
- Report generation
- Boilerplate code creation
- Documentation templates
- Email templates

---

#### Iterative Refinement

**Principe** : Analyses progressives avec profondeur croissante.

**Structure** :
```
Pass 1: Broad Scan
  → Identify high-level issues
  → Categorize findings

Pass 2: Deep Analysis
  → For each issue: read full context
  → Analyze root cause
  → Determine severity

Pass 3: Recommendations
  → Research best practices
  → Generate specific fixes
  → Estimate effort
```

**Cas d'usage** :
- Code optimization (structure → performance → security)
- Quality audits
- Comprehensive code reviews

---

#### Context Aggregation

**Principe** : Synthétiser informations de sources multiples.

**Flow** :
```
1. Read README.md (project overview)
2. Analyze package.json (dependencies)
3. Grep codebase (specific patterns)
4. Check git history (recent changes)
5. Synthesize into coherent summary
```

**Cas d'usage** :
- Project documentation
- Dependency analysis
- Impact assessments
- Onboarding documentation

---

## ⚖️ Tools vs Skills : Quand Utiliser Quoi ?

### 📊 Tableau Comparatif

| Aspect | Traditional Tools | Skills |
|--------|-------------------|--------|
| **Nature** | Code exécutable | Template de prompts |
| **Execution** | Synchrone, directe | Expansion de contexte |
| **Purpose** | Opération spécifique | Workflow guidé |
| **Return** | Résultat immédiat | Contexte modifié + résultats |
| **Messages** | 2 (tool_use + result) | 5-10+ (metadata + prompt + tools) |
| **Concurrency** | Safe | ❌ Not safe |
| **Token Overhead** | ~100 tokens | ~1,500-5,000 tokens |
| **Use Case** | Simple, direct tasks | Complex, multi-step workflows |

### 🎯 Quand Utiliser Skills ?

**✅ Utilisez Skills si** :
- Workflow complexe nécessitant jugement
- Besoin de guidelines contextuelles
- Instructions en langage naturel plus claires que code
- Task nécessitant adaptation dynamique
- Plusieurs outils à orchestrer

**Exemple** :
```
❌ Tool: extract_pdf(file_path) → Direct extraction
✅ Skill: PDF Processor → Validate → Extract → Format → Handle errors
```

### 🎯 Quand Utiliser Tools ?

**✅ Utilisez Tools si** :
- Opération simple et directe
- Logic déterministe (pas de jugement)
- Performance critique
- Besoin de concurrency
- Overhead tokens à minimiser

**Exemple** :
```
✅ Tool: Read(file_path) → Direct file read
❌ Skill: File Reader → Overhead inutile
```

---

## 🔒 Security Considerations

### ⚠️ Risques d'Injection Malveillante

**Problème** : Un skill malveillant peut injecter des instructions cachées.

**Vecteurs d'attaque** :
1. **Prompt injection** dans SKILL.md
2. **Malicious scripts** dans `scripts/`
3. **Compromised references** dans `references/`

**Mitigation** :

**1. Validation des Skills** :
```markdown
✅ Review SKILL.md avant installation
✅ Vérifier provenance (official, community, unknown)
✅ Scanner scripts/ avec antivirus
✅ Auditer allowed-tools (pas trop permissifs)
```

**2. Permissions Minimales** :
```yaml
# ❌ Trop permissif
allowed-tools: "Bash(*), Read, Write"

# ✅ Scoped
allowed-tools: "Bash(git:*), Read, Write"
```

**3. Disable-model-invocation** pour skills sensibles :
```yaml
name: deploy-production
disable-model-invocation: true  # ← Require explicit /deploy-production
```

**Ressources** :
- 📄 [Claude Skill Hijack Warning](https://securetrajectories.substack.com/p/claude-skill-hijack-invisible-sentence)

---

## ⚡ Performance & Optimization

### 🎯 Optimiser les Tokens

**1. Progressive Disclosure** :
```markdown
✅ Charger references/ uniquement si nécessaire
❌ Read all references/ upfront
```

**2. Skill Description Concise** :
```yaml
# ✅ Concise (19 words)
description: Extract text from PDF files and convert to markdown

# ❌ Verbose (42 words)
description: This skill provides comprehensive PDF processing capabilities including text extraction, image extraction, metadata parsing, table detection, and conversion to multiple output formats including markdown, JSON, and HTML
```

**Budget** : 15,000 caractères partagés entre TOUS les skills

**3. Limiter SKILL.md** :
```markdown
✅ Keep under 5,000 words (~800 lines)
✅ Link to references/ pour détails
❌ Embed tout dans SKILL.md
```

---

### 🚀 Optimiser la Vitesse

**1. Model Override pour Tâches Simples** :
```yaml
# Tâche simple → Use Haiku (3x faster, 10x cheaper)
name: markdown-formatter
model: haiku
```

**2. Pre-approve Tools** :
```yaml
# Évite prompts répétitifs
allowed-tools: "Bash(git:*), Read, Write"
```

**3. Scripts pour Logic Déterministe** :
```markdown
✅ Python script pour PDF parsing (reliable, fast)
❌ LLM pour PDF parsing (slow, unreliable)
```

---

### 💰 Optimiser les Coûts

**Coût par modèle (Input)** :
- Haiku : $0.25 / 1M tokens
- Sonnet : $3.00 / 1M tokens
- Opus : $15.00 / 1M tokens

**Stratégie** :
```yaml
# Simple formatting → Haiku
name: json-formatter
model: haiku

# Complex reasoning → Sonnet
name: code-reviewer
model: sonnet

# Critical analysis → Opus
name: security-audit
model: opus
```

**Économie** :
```
Skill avec 5,000 tokens context + Haiku
  → $0.00125 par invocation

Skill avec 5,000 tokens context + Sonnet
  → $0.015 par invocation (12x plus cher)
```

---

## 🎓 Points Clés

### ✅ Concepts Fondamentaux

**1. Skill = Template de Prompts, Pas Code**
- ❌ Les skills ne sont PAS du code exécutable
- ✅ Les skills sont des instructions en langage naturel
- ✅ Claude choisit via LLM reasoning (pas d'algorithme de routing)

**2. Meta-Tool Architecture**
- Un seul tool `Skill` (majuscule) gère tous les skills individuels
- Budget de 15,000 caractères pour descriptions
- Découverte dynamique à chaque startup

**3. Message Injection Dual-Channel**
- **Message 1** (isMeta: false) : Visible UI (~50 chars)
- **Message 2** (isMeta: true) : Hidden, full prompt (~5,000 words)
- Transparence pour user + instructions complètes pour Claude

**4. Progressive Disclosure (3 Niveaux)**
- Niveau 1 : Frontmatter (~200 tokens) → Toujours visible
- Niveau 2 : SKILL.md (~2,000-6,000 tokens) → Chargé si invoked
- Niveau 3 : Supporting assets (variable) → Chargé à la demande

**5. Context Modification Temporaire**
- Pre-approve tools via `allowed-tools`
- Override model (haiku/sonnet/opus)
- Permissions scoped à l'exécution du skill
- Context restauré après completion

---

### 🗂️ Organisation Ressources

**Distinction CRITIQUE (Impact tokens)** :

| Dossier | Chargé ? | Tokens | Usage |
|---------|----------|--------|-------|
| `scripts/` | ❌ Non | 0 | Exécution Python/Bash |
| `references/` | ✅ Oui (Read) | Élevé | Documentation lue |
| `assets/` | ❌ Non | 0 | Templates par path |

**Best Practice** :
```
✅ scripts/ pour logic déterministe
✅ references/ pour docs nécessaires
✅ assets/ pour templates/images
```

---

### 🔗 Variable {baseDir}

**TOUJOURS utiliser** `{baseDir}` pour portabilité :
```
✅ {baseDir}/scripts/extract.py
❌ /home/user/.claude/skills/pdf/scripts/extract.py
```

---

### 📋 Frontmatter Avancé

**Champs clés** :
- `name`, `description` : REQUIS
- `allowed-tools` : Pre-approve outils
- `model` : Override (haiku/sonnet/opus)
- `disable-model-invocation` : Manuel uniquement
- `mode` : Apparaît dans "Mode Commands"

---

### 🎯 Patterns Essentiels

**4 patterns principaux** :
1. **Script Automation** : SKILL.md orchestre scripts Python/Bash
2. **Read-Process-Write** : Transformation simple par Claude
3. **Search-Analyze-Report** : Grep → Analyze → Rapport structuré
4. **Command Chain** : Séquence avec dépendances

**Patterns avancés** : Wizard-Style, Template-Based, Iterative, Context Aggregation

---

### ⚖️ Tools vs Skills

**Utilisez Skills si** :
- ✅ Workflow complexe nécessitant jugement
- ✅ Instructions en langage naturel plus claires
- ✅ Plusieurs outils à orchestrer

**Utilisez Tools si** :
- ✅ Opération simple et directe
- ✅ Logic déterministe sans jugement
- ✅ Performance critique / concurrency needed

---

### 🔒 Security

**Validation obligatoire** :
- ✅ Review SKILL.md avant installation
- ✅ Vérifier provenance (official, community, unknown)
- ✅ Scanner `scripts/` avec antivirus
- ✅ Auditer `allowed-tools` (pas trop permissifs)

**Permissions minimales** :
```yaml
❌ Trop permissif: allowed-tools: "Bash(*)"
✅ Scoped: allowed-tools: "Bash(git:*)"
```

---

### ⚡ Performance & Optimisation

**Tokens** :
- ✅ Progressive disclosure (charger references/ si besoin)
- ✅ Description concise (<100 words)
- ✅ Limiter SKILL.md à 5,000 words

**Vitesse** :
- ✅ `model: haiku` pour tâches simples (3x faster)
- ✅ Pre-approve tools (évite prompts répétitifs)
- ✅ Scripts pour logic déterministe

**Coûts** :
- Haiku : $0.25/1M tokens (10x cheaper que Sonnet)
- Sonnet : $3.00/1M tokens (standard)
- Opus : $15.00/1M tokens (critical only)

---

### 🎯 Best Practices

**DO ✅** :
- Utiliser `{baseDir}` pour tous les paths
- Charger references/ uniquement si nécessaire
- Pre-approve tools avec scope minimal
- Override model selon complexité tâche
- Documenter capabilities clairement
- Exemples concrets dans SKILL.md

**DON'T ❌** :
- Chemins absolus hardcodés
- Permissions trop larges (`Bash(*)`)
- Tout embedder dans SKILL.md
- Skills trop génériques
- Ignorer security validation
- Oublier Progressive Disclosure

---

### 💡 Citations Clés

> "The skill selection mechanism has no algorithmic routing or intent classification at the code level."
> — Han Lee

> "Permissions are scoped to skill execution via execution context modification."
> — Han Lee

> "Progressive Disclosure — showing just enough information to help agents decide what to do next."
> — Han Lee

---

## 📚 Ressources

### 📄 Documentation Officielle
- 📄 **Claude Code Skills** : https://code.claude.com/docs/en/skills
- 📄 **Engineering Best Practices** : https://www.anthropic.com/engineering/claude-code-best-practices

### 📝 Articles & Deep Dives
- 📝 **Skills Deep Dive** : https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/
  - Architecture interne des Skills
  - Comparaison avec Prompts traditionnels
  - Quand utiliser Skills vs autres patterns
- 📝 **Skills Explained (Reddit)** : https://www.reddit.com/r/ClaudeAI/comments/1ow9cka/skills_explained_how_skills_compares_to_prompts/
  - Comparaison Skills vs Prompts
  - Cas d'usage communauté

### ⚠️ Sécurité & Limitations
- 🔒 **Claude Skill Hijack Warning** : https://securetrajectories.substack.com/p/claude-skill-hijack-invisible-sentence
  - Risques injection malveillante dans Skills
  - Best practices sécurité
  - Validation inputs utilisateur

### 🔗 Repositories Communauté
- 🔗 **Anthropic Official Skills** : https://github.com/anthropics/skills
  - Skills officielles maintenues par Anthropic
  - Templates et exemples production
- 🔗 **Awesome Claude Skills** : https://github.com/travisvn/awesome-claude-skills
  - Catalogue communautaire de Skills
  - PDF, Excel, Image processing, API integrations
  - Voting communautaire best skills

### 📚 Ressources Internes
- 📋 [Cheatsheet Skills](./cheatsheet.md) - Référence rapide
- 🎓 [Exercices Skills](../exercises/skills/) - Créer vos Skills
- 🔗 [Commands](../2-commands/guide.md) - Quand utiliser Commands vs Skills
- 🔗 [MCP](../7-mcp/guide.md) - MCP vs Skills (intégration externe)
- 🔗 [Plugins](../6-plugins/guide.md) - Packaging Skills dans plugins
- 🔗 [Agents](../5-agents/guide.md) - Skills utilisés par agents

---
