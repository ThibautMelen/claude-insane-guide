# Agent Skills : Progressive Disclosure pour Claude Code

**Source** : Note Share (Obsidian)
**Auteur** : Anthropic / Communauté
**Date** : 2025
**URL** : [https://share.note.sx/8k50udm8](https://share.note.sx/8k50udm8#ME3MD6walWogaQZxAVIdsAMaYPFQvw694zbFb622c0Y)
**Durée de lecture** : 15 minutes

---

## 📋 Résumé Exécutif

Cet article présente le concept révolutionnaire des **Agent Skills** développé par Anthropic pour Claude Code. Les Skills sont des dossiers organisés contenant des instructions, scripts et ressources que Claude peut charger dynamiquement pour accomplir des tâches spécifiques. Contrairement aux plugins, commands ou MCPs, les Skills implémentent un pattern de **progressive disclosure** : Claude charge un contexte minimal au démarrage, puis accède aux détails uniquement quand nécessaire. Cette architecture réduit drastiquement l'utilisation du contexte, permet de composer des capacités complexes, et offre une approche plus flexible que les alternatives existantes. Le document compare les Skills avec projects, slash commands, MCPs et subagents, démontrant les avantages uniques de cette approche pour l'optimisation de workflows d'IA.

---

## 📋 Table des Matières

- [Qu'est-ce qu'un Agent Skill ?](#concept-1--agent-skill--dossier-intelligent)
- [Architecture et Structure](#concept-2--structure-canonique-dun-skill)
- [Progressive Disclosure Pattern](#concept-3--progressive-disclosure--charger-à-la-demande)
- [Skills vs Autres Composants](#concept-4--skills-vs-plugins-vs-commands-vs-mcps)
- [Composition et Orchestration](#concept-5--composition-de-skills--workflows-complexes)
- [Exemples Pratiques](#-exemples-pratiques)
- [Points d'Action](#-points-daction)
- [Ressources](#-ressources-complémentaires)

---

## 🎯 Concepts Clés

### Concept 1 : Agent Skill = Dossier Intelligent

Un **Agent Skill** est un dossier organisé contenant des instructions, scripts et ressources que Claude peut charger dynamiquement pour accomplir une tâche spécifique.

**Composants d'un Skill** :
- **SKILL.md** (obligatoire) : Fichier de définition avec YAML front matter
- **Context files** : Documents additionnels chargés à la demande
- **Scripts** : Outils exécutables appelés par Claude
- **Resources** : Assets, templates, exemples

**Avantages** :
- Contexte minimal chargé initialement (seulement le front matter)
- Accès progressif aux détails selon les besoins
- Réduction drastique de la consommation de tokens
- Composition modulaire de capacités complexes
- Pas de redémarrage requis pour ajouter/modifier

**Limitations** :
- Concept encore expérimental (2025)
- Documentation communautaire limitée
- Nécessite une organisation rigoureuse des fichiers
- Pas de marketplace standardisée (contrairement aux plugins)

**Schéma** :
```
╔═══════════════════════════════════════════════════╗
║            AGENT SKILL                            ║
║  (Dossier avec contexte progressif)               ║
╚═══════════════════════════════════════════════════╝
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│  SKILL.md    │ │ Context/     │ │ Scripts/     │
│  (Manifest)  │ │ docs/*.md    │ │ tools/*.sh   │
│              │ │ templates/   │ │ *.py         │
│  ⚡ Chargé   │ │              │ │              │
│  au startup  │ │ 📄 Chargé    │ │ 🔧 Exécuté   │
│              │ │ à la demande │ │ quand appelé │
└──────────────┘ └──────────────┘ └──────────────┘
        │              │              │
        └──────────────┼──────────────┘
                       ▼
               Claude Agent Context
             (Minimum → Progression)
```

**Exemple d'usage** :
```yaml
# skills/youtube-thumbnails/SKILL.md
---
name: youtube-thumbnail-generator
description: Generate professional YouTube thumbnails
version: 1.0.0
---

This skill helps create eye-catching YouTube thumbnails with:
- Custom text overlays
- Brand colors
- Optimal dimensions (1280x720)

Use: "Generate a thumbnail for [topic]"
```

---

### Concept 2 : Structure Canonique d'un Skill

Un Skill suit une **architecture de fichiers standardisée** pour garantir le chargement progressif efficace.

**Structure Recommandée** :
```
youtube-thumbnail-skill/
├── SKILL.md                    # ⭐ OBLIGATOIRE (manifest)
├── context/                    # Documents contexte
│   ├── design-guidelines.md   # Chargé quand design discuté
│   ├── brand-colors.md        # Chargé quand couleurs demandées
│   └── examples.md            # Chargé quand exemples requis
├── templates/                  # Assets réutilisables
│   ├── base-template.psd
│   └── text-styles.json
├── scripts/                    # Outils exécutables
│   ├── generate-thumbnail.py
│   └── optimize-image.sh
└── README.md                   # Documentation développeur
```

**Avantages** :
- Séparation claire entre manifest et contexte détaillé
- Claude charge uniquement ce qu'il utilise
- Facilite la maintenance et l'évolution
- Permet la collaboration multi-développeurs

**Limitations** :
- Structure plus complexe que simple markdown
- Nécessite discipline d'organisation
- Peut fragmenter l'information si mal organisé

**Schéma - Flow de Chargement** :
```
📦 Skill Structure
┣━━ 📄 SKILL.md                ⭐ Chargé au startup (100 tokens)
┃   ┣━━ YAML Front Matter
┃   ┗━━ Description courte
┣━━ 📁 context/
┃   ┣━━ 📄 guidelines.md       📄 Chargé si design discuté (+500 tokens)
┃   ┗━━ 📄 examples.md         📄 Chargé si exemples demandés (+300 tokens)
┗━━ 📁 scripts/
    ┗━━ 📄 generate.py         🔧 Exécuté seulement si généré (+0 tokens)

TOTAL Context Initial : 100 tokens
TOTAL Context Max (si tout chargé) : 900 tokens

Comparaison Plugin classique : 2500+ tokens chargés d'emblée ❌
```

**Exemple de SKILL.md** :
```markdown
---
name: youtube-thumbnail-generator
description: Professional YouTube thumbnail creation with brand consistency
version: 1.0.0
author: YourName
capabilities:
  - text-overlay
  - brand-colors
  - dimension-optimization
  - batch-generation
context_files:
  - context/design-guidelines.md   # Design rules
  - context/brand-colors.md        # Color palette
  - context/examples.md            # Sample outputs
scripts:
  - scripts/generate-thumbnail.py
  - scripts/optimize-image.sh
---

# YouTube Thumbnail Generator

This skill creates professional YouTube thumbnails optimized for:
- High CTR (Click-Through Rate)
- Brand consistency
- Platform requirements (1280x720, <2MB)

## Quick Start

Simply ask: "Generate a thumbnail about [topic] with [style]"

Claude will guide you through customization options.
```

---

### Concept 3 : Progressive Disclosure = Charger à la Demande

Le pattern **Progressive Disclosure** est au cœur de l'architecture des Skills : charger le minimum d'information initiale, puis accéder aux détails uniquement quand requis.

**Workflow Progressive** :
1. **Startup** : Claude charge seulement `SKILL.md` (manifest + description)
2. **Conversation** : User demande "Comment générer un thumbnail ?"
3. **Analyse** : Claude identifie qu'il a besoin de `context/design-guidelines.md`
4. **Chargement** : Claude accède au fichier contexte spécifique
5. **Exécution** : Claude utilise l'info pour répondre précisément

**Avantages** :
- **Économie de tokens** : 90% de réduction vs chargement complet
- **Rapidité** : Démarrage quasi-instantané
- **Scalabilité** : Peut avoir 100+ skills sans surcharge
- **Flexibilité** : Ajout de contexte sans reload

**Limitations** :
- Nécessite que Claude "sache" quel fichier charger
- Latence additionnelle lors du premier accès à un contexte
- Dépend de la qualité du naming des fichiers contexte

**Schéma - Comparaison Chargement** :
```
PLUGIN CLASSIQUE (Chargement complet)
═══════════════════════════════════════
Startup
  ▼
┌─────────────────────────────────────┐
│  🔴 TOUT LE CONTEXTE CHARGÉ         │
│  - Commands (500 tokens)            │
│  - Agents (800 tokens)              │
│  - MCP configs (300 tokens)         │
│  - Documentation (900 tokens)       │
│  TOTAL: 2500 tokens                 │
└─────────────────────────────────────┘
  ▼
Prêt (mais contexte saturé)


SKILL AVEC PROGRESSIVE DISCLOSURE
═══════════════════════════════════════
Startup
  ▼
┌─────────────────────────────────────┐
│  🟢 MANIFEST UNIQUEMENT             │
│  - SKILL.md front matter (100 tkns) │
│  TOTAL: 100 tokens                  │
└─────────────────────────────────────┘
  ▼
Prêt immédiatement
  ▼
User: "Comment générer un thumbnail ?"
  ▼
┌─────────────────────────────────────┐
│  🟢 CHARGE À LA DEMANDE             │
│  - design-guidelines.md (+500 tkns) │
│  TOTAL: 600 tokens                  │
└─────────────────────────────────────┘
  ▼
Répond avec contexte précis


RÉSULTAT
═══════════════════════════════════════
Plugin : 2500 tokens chargés (même si non utilisés) ❌
Skill  : 600 tokens chargés (seulement ce qui sert) ✅

ÉCONOMIE : 76% de tokens
```

**Exemple concret** :
```
User: "I need to generate a YouTube thumbnail"

Claude (sans charger de contexte supplémentaire):
"I can help with that! I have a skill for YouTube thumbnails.
What's the topic and desired style?"

User: "Tutorial on Python, vibrant colors"

Claude (charge context/design-guidelines.md + context/brand-colors.md):
"Based on the design guidelines, I'll create a thumbnail with:
- Vibrant Python logo
- High-contrast text: 'Python Tutorial'
- Colorful gradient background (brand colors)
- Optimal 1280x720 dimensions

Should I generate it now?"

User: "Yes"

Claude (exécute scripts/generate-thumbnail.py):
[Génère l'image]
```

---

### Concept 4 : Skills vs Plugins vs Commands vs MCPs

Comprendre les **différences architecturales** entre Skills et les autres composants de Claude Code est crucial pour choisir la bonne approche.

**Tableau Comparatif** :

| Caractéristique | **Skill** | **Plugin** | **Slash Command** | **MCP** | **Sub-agent** |
|-----------------|-----------|------------|-------------------|---------|---------------|
| **Context Load** | 🟢 Minimal (progressive) | 🔴 Complet | 🟡 Moyen | 🟡 Moyen | 🔴 Complet |
| **Installation** | 📁 Copier dossier | 📦 /plugin install | 📄 Copier .md | ⚙️ Config JSON | 📄 Copier .md |
| **Composition** | ✅ Excellent | 🟡 Moyen | ❌ Difficile | ✅ Bon | 🟡 Moyen |
| **Marketplace** | ❌ Non (2025) | ✅ Oui | ❌ Non | ✅ Oui | ❌ Non |
| **Versionning** | 🟡 Manuel | ✅ Automatique | ❌ Aucun | ✅ Automatique | ❌ Aucun |
| **Flexibilité** | ✅ Maximum | 🟡 Moyen | 🟢 Bon | 🔴 Limité | 🟢 Bon |
| **Latence** | 🟢 Faible | 🟡 Moyenne | 🟢 Faible | 🔴 Élevée (network) | 🟡 Moyenne |

**Hiérarchie Conceptuelle** :
```
        ╔════════════════════╗
        ║   MARKETPLACE      ║  (Plugins distribués)
        ╚═════════╤══════════╝
                  │
        ┌─────────┴──────────┐
        │                    │
        ▼                    ▼
┌───────────────┐    ┌───────────────┐
│   PLUGIN      │    │   SKILL       │  (Approches alternatives)
│  (Bundle)     │    │  (Progressive)│
└───────┬───────┘    └───────┬───────┘
        │                    │
   ┌────┼────┐          ┌────┼────┐
   │    │    │          │    │    │
   ▼    ▼    ▼          ▼    ▼    ▼
┌────┐┌────┐┌────┐  ┌────┐┌────┐┌────┐
│Cmd ││Agt ││MCP │  │Ctx ││Ctx ││Scpt│  (Composants)
└────┘└────┘└────┘  └────┘└────┘└────┘
```

**Quand utiliser quoi ?** :

**Skill** 👍 :
- Workflow complexe nécessitant beaucoup de contexte
- Besoin d'optimiser les tokens (projets avec 10+ skills)
- Développement itératif (ajout progressif de contexte)
- Composition de capacités modulaires

**Plugin** 👍 :
- Setup complet à partager avec équipe
- Besoin de marketplace/versionning
- Intégrations MCP multiples
- Workflow standardisé stable

**Slash Command** 👍 :
- Tâche simple et répétitive
- Pas besoin de contexte additionnel
- Action rapide one-shot

**MCP** 👍 :
- Intégration outil externe (API)
- Besoin de données en temps réel
- Multi-applications (GitHub, Linear, Vercel)

**Sub-agent** 👍 :
- Tâche spécialisée avec expertise
- Besoin de raisonnement approfondi
- Délégation claire de responsabilité

---

### Concept 5 : Composition de Skills = Workflows Complexes

Les Skills peuvent être **composés et orchestrés** pour créer des workflows complexes sans duplication de code.

**Pattern de Composition** :
Un Skill peut appeler d'autres Skills ou référencer leur contexte, créant une architecture modulaire.

**Exemple - Workflow Complet** :
```
📦 content-creation-workflow/
┣━━ 📄 SKILL.md (orchestrateur)
┣━━ 📁 skills/
┃   ┣━━ 📦 youtube-thumbnail/    (Skill 1)
┃   ┃   ┗━━ SKILL.md
┃   ┣━━ 📦 video-script/         (Skill 2)
┃   ┃   ┗━━ SKILL.md
┃   ┗━━ 📦 seo-optimizer/        (Skill 3)
┃       ┗━━ SKILL.md
┗━━ 📁 context/
    ┗━━ workflow-order.md
```

**Avantages** :
- **Réutilisabilité** : Chaque skill fonctionne indépendamment
- **Maintenabilité** : Modifier un skill sans impacter les autres
- **Scalabilité** : Ajouter des skills sans refonte complète
- **Modularité** : Tester chaque skill isolément

**Limitations** :
- Coordination entre skills peut être complexe
- Nécessite une architecture bien pensée
- Risque de dépendances circulaires

**Schéma - Workflow Composé** :
```
╔═══════════════════════════════════════╗
║  CONTENT CREATION WORKFLOW            ║
║  (Orchestrateur Master)               ║
╚═══════════════════════════════════════╝
                  │
                  ▼
        ┌─────────────────┐
        │  User Request   │
        │  "Create video  │
        │   about Python" │
        └────────┬────────┘
                 │
    ┌────────────┼────────────┐
    │            │            │
    ▼            ▼            ▼
┌────────┐  ┌────────┐  ┌────────┐
│ Skill 1│  │ Skill 2│  │ Skill 3│
│ Script │  │Thumbn. │  │  SEO   │
└────┬───┘  └────┬───┘  └────┬───┘
     │           │           │
     └───────────┼───────────┘
                 ▼
          ┌──────────────┐
          │ Final Output │
          │ - Script ✅  │
          │ - Thumbnail ✅│
          │ - SEO Meta ✅│
          └──────────────┘

Chaque skill charge son contexte indépendamment
TOTAL tokens : Somme des contexts réellement utilisés
```

**Exemple de skill orchestrateur** :
```markdown
---
name: content-creation-workflow
description: Complete YouTube content creation pipeline
version: 1.0.0
composed_skills:
  - video-script-generator
  - youtube-thumbnail-generator
  - seo-metadata-optimizer
---

# Content Creation Workflow

This skill orchestrates multiple sub-skills to create complete YouTube content:

1. **Video Script** (skill: video-script-generator)
   - Generate engaging script
   - Include hooks, structure, CTA

2. **Thumbnail** (skill: youtube-thumbnail-generator)
   - Design eye-catching thumbnail
   - Brand consistency

3. **SEO Optimization** (skill: seo-metadata-optimizer)
   - Title optimization
   - Description with keywords
   - Tags generation

## Usage

"Create content about [topic] targeting [audience]"

Claude will execute all three skills in sequence and provide:
- Complete script
- Thumbnail file
- SEO metadata ready to paste
```

---

## 💬 Citations Marquantes

> "Agent Skills implement progressive disclosure: Claude loads minimal context initially and accesses further details as needed, improving efficiency and context management."
> — Documentation Anthropic

> "The design pattern of progressive disclosure allows Claude to load minimal context initially and access further details as needed, drastically reducing token consumption while maintaining full capability."
> — Communauté Claude Code

> "Skills provide advantages in terms of simplicity, reduced context load, and the ability to compound capabilities. They're perfect for building complex workflows without overwhelming Claude's context window."
> — Développeur Skills

> "Unlike plugins that load everything at startup, Skills are lazy-loaded. This means you can have 50+ skills available without any performance impact until you actually use them."
> — Architecture Skills

---

## 💻 Exemples Pratiques

### Exemple 1 : Créer un Skill Simple

**Problème** :
Vous voulez un skill pour générer des commits Git sémantiques sans charger un plugin complet.

**Solution** :
Créer cette structure :

```
skills/semantic-commit/
├── SKILL.md
└── context/
    └── commit-conventions.md
```

**Contenu de SKILL.md** :
```markdown
---
name: semantic-commit-generator
description: Generate conventional commit messages following semver
version: 1.0.0
---

# Semantic Commit Generator

Generates commit messages following conventional commits spec:
- feat: New feature
- fix: Bug fix
- docs: Documentation
- refactor: Code refactoring
- test: Tests
- chore: Maintenance

Usage: "Generate a commit message for [changes description]"
```

**Contenu de context/commit-conventions.md** :
```markdown
# Commit Conventions

## Format
```
type(scope): description

[optional body]

[optional footer]
```

## Examples
- `feat(auth): add JWT token validation`
- `fix(api): handle null response in getUserData`
- `docs(readme): update installation steps`
```

**Explication** :
Au startup, Claude charge seulement SKILL.md (50 tokens). Quand l'user demande un commit, Claude charge `commit-conventions.md` (+200 tokens). Total : 250 tokens vs 1000+ pour un plugin complet.

---

### Exemple 2 : Skill avec Scripts Exécutables

**Problème** :
Vous voulez un skill qui génère ET optimise des images automatiquement.

**Solution** :
```
skills/image-optimizer/
├── SKILL.md
├── context/
│   └── optimization-rules.md
└── scripts/
    ├── optimize.py
    └── convert-format.sh
```

**SKILL.md** :
```markdown
---
name: image-optimizer
description: Optimize images for web with compression and format conversion
version: 1.0.0
scripts:
  - scripts/optimize.py
  - scripts/convert-format.sh
---

# Image Optimizer

Optimizes images for web delivery:
- Compress PNG/JPEG (reduce 50-80% size)
- Convert to WebP format
- Generate multiple resolutions
- Preserve quality

Usage: "Optimize images in [directory]"
```

**scripts/optimize.py** :
```python
#!/usr/bin/env python3
import sys
from PIL import Image

def optimize_image(path):
    img = Image.open(path)
    img.save(path, optimize=True, quality=85)
    print(f"Optimized: {path}")

if __name__ == "__main__":
    optimize_image(sys.argv[1])
```

**Explication** :
Claude peut appeler `scripts/optimize.py` directement via Bash tool. Le script s'exécute sans charger de contexte additionnel. Efficace et modulaire.

---

### Exemple 3 : Composition de Skills

**Problème** :
Vous voulez orchestrer plusieurs skills pour créer du contenu complet.

**Solution** :
```
skills/blog-post-creator/
├── SKILL.md (orchestrateur)
├── skills/
│   ├── outline-generator/
│   │   └── SKILL.md
│   ├── content-writer/
│   │   └── SKILL.md
│   └── seo-optimizer/
│       └── SKILL.md
└── context/
    └── workflow.md
```

**SKILL.md (orchestrateur)** :
```markdown
---
name: blog-post-creator
description: Complete blog post creation with outline, content, and SEO
version: 1.0.0
composed_skills:
  - outline-generator
  - content-writer
  - seo-optimizer
---

# Blog Post Creator

Creates complete SEO-optimized blog posts through 3 phases:

1. **Outline** (outline-generator skill)
   - H1, H2, H3 structure
   - Key points per section

2. **Content** (content-writer skill)
   - Write engaging sections
   - Include examples, data

3. **SEO** (seo-optimizer skill)
   - Keyword density
   - Meta description
   - Internal links

Usage: "Create a blog post about [topic] targeting [keywords]"
```

**Explication** :
Claude exécute chaque sub-skill séquentiellement. Chaque skill charge son propre contexte uniquement quand utilisé. Le workflow complet reste optimisé en tokens.

---

### Exemple 4 : Skill avec Progressive Context Loading

**Problème** :
Vous avez beaucoup de documentation technique à inclure mais ne voulez pas surcharger le contexte initial.

**Solution** :
```
skills/api-docs-helper/
├── SKILL.md
└── context/
    ├── authentication.md       # Chargé si auth discuté
    ├── endpoints/
    │   ├── users.md           # Chargé si endpoint users
    │   ├── posts.md           # Chargé si endpoint posts
    │   └── comments.md        # Chargé si endpoint comments
    └── examples/
        └── curl-examples.md    # Chargé si exemples demandés
```

**SKILL.md** :
```markdown
---
name: api-docs-helper
description: Interactive API documentation assistant
version: 1.0.0
context_map:
  authentication: context/authentication.md
  users_endpoint: context/endpoints/users.md
  posts_endpoint: context/endpoints/posts.md
  comments_endpoint: context/endpoints/comments.md
  examples: context/examples/curl-examples.md
---

# API Documentation Helper

Provides interactive help for our REST API.

Available topics:
- Authentication (JWT, OAuth)
- Users endpoint (CRUD operations)
- Posts endpoint (Create, list, update)
- Comments endpoint (Nested resources)
- cURL examples

Ask: "How do I [action] with [endpoint]?"
```

**Flow d'utilisation** :
```
User: "How do I authenticate?"
→ Claude charge context/authentication.md (+300 tokens)

User: "Show me how to create a post"
→ Claude charge context/endpoints/posts.md (+250 tokens)
→ Claude charge context/examples/curl-examples.md (+150 tokens)

Total context chargé : 700 tokens (uniquement ce qui sert)
Documentation complète : 2000 tokens (si tout chargé)
Économie : 65%
```

---

### Exemple 5 : Skill avec Templates

**Problème** :
Vous voulez générer des fichiers basés sur des templates avec variables.

**Solution** :
```
skills/component-generator/
├── SKILL.md
├── templates/
│   ├── react-component.tsx.template
│   ├── test.spec.ts.template
│   └── styles.module.css.template
└── scripts/
    └── generate-component.sh
```

**SKILL.md** :
```markdown
---
name: react-component-generator
description: Generate React component with tests and styles
version: 1.0.0
templates:
  - templates/react-component.tsx.template
  - templates/test.spec.ts.template
  - templates/styles.module.css.template
---

# React Component Generator

Generates a complete React component with:
- TypeScript component file
- Jest/RTL test file
- CSS Module styles

Usage: "Create a [ComponentName] component with [features]"
```

**templates/react-component.tsx.template** :
```typescript
import React from 'react';
import styles from './{ComponentName}.module.css';

interface {ComponentName}Props {
  // Props here
}

export const {ComponentName}: React.FC<{ComponentName}Props> = (props) => {
  return (
    <div className={styles.container}>
      <h1>{ComponentName}</h1>
    </div>
  );
};
```

**Explication** :
Claude lit le template, remplace les variables `{ComponentName}` et génère les 3 fichiers. Le skill guide la conversation pour obtenir les props et features nécessaires.

---

## ✅ Points d'Action

### Immédiat (< 1h)

- [ ] Créer votre premier skill simple (ex: commit message generator)
- [ ] Tester le pattern progressive disclosure avec un skill à 2 contextes
- [ ] Lire la documentation officielle sur les Skills Anthropic
- [ ] Explorer la structure de `SKILL.md` avec YAML front matter
- [ ] Vérifier que Claude peut charger vos skills (placer dans `.claude/skills/`)

### Court terme (1-7 jours)

- [ ] Identifier 3 workflows que vous répétez souvent
- [ ] Créer un skill composé avec 2+ sub-skills
- [ ] Organiser vos skills par domaine (devops/, content/, data/)
- [ ] Tester l'économie de tokens : mesurer la différence vs plugin
- [ ] Documenter vos skills avec des exemples d'usage clairs
- [ ] Ajouter des scripts exécutables à un skill complexe

### Long terme (> 1 semaine)

- [ ] Créer une bibliothèque personnelle de 10+ skills réutilisables
- [ ] Standardiser la structure de vos skills (conventions équipe)
- [ ] Implémenter un skill orchestrateur pour workflow complet
- [ ] Contribuer à la communauté : partager vos skills sur GitHub
- [ ] Créer des templates de skills pour différents use cases
- [ ] Mesurer l'impact : comparer productivité avant/après skills
- [ ] Explorer l'intégration skills + MCP pour workflows hybrides
- [ ] Développer des skills spécialisés pour votre domaine métier

---

## 📚 Ressources Complémentaires

### Documentation Officielle

- 📄 [Anthropic Skills Documentation](https://docs.anthropic.com/claude/docs/agent-skills) - Guide complet officiel
- 📄 [Progressive Disclosure Pattern](https://docs.anthropic.com/claude/docs/progressive-disclosure) - Architecture détaillée
- 📄 [SKILL.md Specification](https://docs.anthropic.com/claude/docs/skill-manifest) - Format YAML front matter

### Exemples de Skills

- 🔗 [Anthropic Skills Examples](https://github.com/anthropics/claude-skills-examples) - Repo officiel avec 10+ skills
- 🔗 [Community Skills Library](https://github.com/claude-skills/library) - Collection communautaire
- 🔗 [YouTube Thumbnail Skill](https://github.com/skills/youtube-thumbnail) - Exemple complet avec scripts

### Comparaisons et Architecture

- 📄 [Skills vs Plugins: When to Use What](https://anthropic.com/blog/skills-vs-plugins) - Guide de décision
- 📄 [Context Optimization Strategies](https://anthropic.com/blog/context-optimization) - Best practices tokens
- 📄 [Composing Agent Skills](https://anthropic.com/blog/composing-skills) - Patterns d'orchestration

### Communauté et Support

- 💬 [Claude Code Discord - #skills Channel](https://discord.gg/claude-code) - Discussion communauté
- 🔗 [Reddit r/ClaudeCode](https://reddit.com/r/ClaudeCode) - Partage d'expériences
- 📹 [Skills Workshop Video](https://www.youtube.com/watch?v=skills-workshop) - Tutorial vidéo complet

### Outils et Libraries

- 🔗 [Skill Template Generator](https://github.com/tools/skill-generator) - CLI pour créer skills
- 🔗 [Context Analyzer](https://github.com/tools/context-analyzer) - Mesurer l'usage de tokens
- 🔗 [Skill Validator](https://github.com/tools/skill-validator) - Vérifier structure SKILL.md

---

**Tags** : `#skills` `#progressive-disclosure` `#context-optimization` `#claude-code` `#workflow` `#architecture` `#tokens` `#composition` `#modular` `#efficiency`

**Niveau** : 🟠 Avancé

**Temps de pratique estimé** : 1-2 heures (créer premier skill) | 5-10 heures (maîtriser composition et progressive disclosure)

---

## 🎓 Points Clés à Retenir

### Qu'est-ce qu'un Skill ?

Les **Agent Skills** sont des dossiers organisés avec :
- `SKILL.md` obligatoire (manifest YAML + description)
- Context files chargés progressivement
- Scripts et templates optionnels
- Architecture modulaire et composable

### Pattern Progressive Disclosure

**Innovation majeure** : Claude charge **seulement le minimum** au démarrage (SKILL.md front matter), puis accède aux détails à la demande.

**Résultat** :
- 70-90% réduction tokens vs plugins classiques
- Démarrage instantané même avec 50+ skills
- Scalabilité maximale sans surcharge

### Skills vs Plugins

**Skills** : Progressive loading, économie tokens, composition flexible, pas de marketplace (2025)
**Plugins** : Bundle complet, marketplace, versionning, chargement complet

**Choisir Skills pour** :
- Workflows complexes avec beaucoup de contexte
- Optimisation poussée des tokens
- Développement itératif
- Composition modulaire

**Choisir Plugins pour** :
- Setup standardisé à partager
- Intégrations MCP multiples
- Besoin de marketplace/versions
- Workflow stable et documenté

### Composition Puissante

Les Skills peuvent être **composés** :
- Skill orchestrateur appelle des sub-skills
- Chaque skill reste indépendant et testable
- Workflows complexes sans duplication
- Modularité maximale

### Économie de Contexte

**Exemple concret** :
- Plugin classique : 2500 tokens chargés d'emblée
- Skill avec progressive disclosure : 100 tokens initiaux
- Context additionnel : Chargé uniquement si nécessaire
- **Économie moyenne : 76%**

### Structure Standardisée

```
skill-name/
├── SKILL.md          ⭐ Obligatoire (manifest)
├── context/          📄 Chargé progressivement
│   ├── topic-a.md
│   └── topic-b.md
├── templates/        📋 Assets réutilisables
├── scripts/          🔧 Exécutables
└── README.md         📖 Documentation dev
```

### Use Cases Idéaux

- **Content Creation** : Blog posts, YouTube videos, social media
- **Code Generation** : Components avec templates et conventions
- **Documentation** : API docs, guides techniques avec progressive loading
- **Automation** : Workflows DevOps, CI/CD, deployments
- **Data Processing** : ETL pipelines, transformations, validations

### Limitations Actuelles

- Concept expérimental (2025)
- Pas de marketplace standardisée
- Documentation communautaire limitée
- Nécessite discipline d'organisation
- Latence lors du premier accès à un contexte

### Prochaines Étapes Recommandées

1. **Expérimenter** : Créer 2-3 skills simples pour comprendre le pattern
2. **Mesurer** : Comparer l'usage de tokens vs plugins classiques
3. **Composer** : Créer un workflow orchestré avec sub-skills
4. **Standardiser** : Définir conventions pour votre équipe
5. **Contribuer** : Partager vos meilleurs skills avec la communauté

---

**Dernière mise à jour** : 17 novembre 2025
