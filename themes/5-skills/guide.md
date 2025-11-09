# 💡 Skills Claude Code - Guide Complet

> **Maîtrisez les capacités spécialisées autonomes**

📄 **Docs officielles** : [Claude Code Skills](https://docs.claude.com/en/docs/claude-code/skills)

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

## 💪 Patterns Avancés

### Pattern 1 : Skill avec Dépendances

Documentez dépendances npm requises :

```markdown
# Image Processor

Process and analyze images.

## Dependencies
- sharp (npm install sharp)
- jimp (npm install jimp)

## Capabilities
- Resize images
- Convert formats
- Extract EXIF data
```

### Pattern 2 : Skills Chaînés

Skills peuvent s'invoquer entre eux :

```markdown
# Report Generator

Generate reports from data sources.

## Capabilities
- Read Excel (uses excel-handler skill)
- Extract PDF data (uses pdf-processor skill)
- Generate formatted report
```

---

## 🎓 Points Clés

### ✅ Concepts Essentiels

1. **Skill = Capacité Autonome**
   - Invoqué automatiquement par Claude
   - Pas besoin de `/command`

2. **Structure Simple**
   - Dossier avec SKILL.md
   - Documentation des capabilities

3. **Réutilisable**
   - Packagé dans plugins
   - Partageable avec équipe

### 🎯 Best Practices

**DO ✅** :
- Documenter capabilities clairement
- Lister dépendances npm
- Exemples d'utilisation
- Error handling documenté

**DON'T ❌** :
- Skills trop génériques
- Documentation vague
- Oublier dépendances
- Pas de tests

---

## 📚 Ressources

### 📄 Documentation Officielle
- 📄 [Claude Code Skills](https://docs.claude.com/en/docs/claude-code/skills)
- 📄 [Plugins](../6-plugins/guide.md) - Package skills

### 🔗 Guides Connexes
- 📖 [Commands](../2-commands/guide.md) - Commands vs Skills
- 📖 [MCP](../4-mcp/guide.md) - MCP vs Skills
- 📖 [Plugins](../6-plugins/guide.md) - Distribution skills

### 🧪 Exemples Communautaires
- 🔗 [PDF Skill Example](https://github.com/anthropics/claude-code-skills)
- 🔗 [Excel Handler](https://github.com/community/excel-skill)

---

**🎓 Prêt ?** → Passez aux [Exercices](./exercices/niveau-1.md) ! 🚀
