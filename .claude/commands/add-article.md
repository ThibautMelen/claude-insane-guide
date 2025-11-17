---
name: add-article
description: Analyse un article web et crée une fiche complète dans ressources/articles/. Usage - /add-article <article-url>
---

Tu es un expert en analyse de contenu technique sur Claude Code, l'IA et le développement.

## CONTEXTE

Ce projet est un guide d'apprentissage francophone sur Claude Code. Toutes les fiches article doivent respecter les guidelines du fichier `.claude/CLAUDE.md`.

## ARGUMENTS

**URL Article (REQUIS)** : L'URL complète de l'article à analyser
- Formats acceptés : articles de blog, documentation, tutoriels, posts Medium, dev.to, etc.
- L'article doit être accessible publiquement
- Exemples :
  - `https://medium.com/@author/article-title`
  - `https://dev.to/author/article-slug`
  - `https://blog.company.com/article-path`
  - Documentation officielle, guides techniques, etc.

## WORKFLOW DÉTAILLÉ

### 1. Récupération du Contenu avec Supadata

Utilise le MCP tool `mcp__supadata-ai-mcp__supadata_scrape` avec:
- URL de l'article fournie
- `lang`: `fr` (priorité au français, sinon `en`)
- `noLinks`: `false` pour conserver les liens du contenu

Si l'article contient beaucoup de contenu, le scraping retournera le markdown complet.

### 1.5. Vérification des Doublons

**AVANT** d'analyser le contenu, vérifier si l'article n'existe pas déjà :

1. **Extraire le domaine et le chemin** de l'URL fournie
2. **Chercher dans ressources/articles/** avec Grep :
   ```bash
   grep -l "URL.*domain\.com.*article-path" ressources/articles/*.md
   ```
3. **Si un fichier est trouvé** :
   - Afficher : `⚠️ Cette ressource existe déjà : {filename}`
   - Utiliser AskUserQuestion pour demander :
     ```markdown
     Question: "Cet article existe déjà dans ressources/articles/{filename}. Que voulez-vous faire ?"
     Options:
     1. "Écraser l'existant" - Continuer et remplacer le fichier
     2. "Créer avec nouveau nom" - Ajouter suffixe (ex: -v2)
     3. "Annuler" - Arrêter la commande
     ```
4. **Si aucun doublon** : Continuer normalement

### 2. Extraction des Métadonnées

À partir de la réponse de Supadata, extraire:
- Titre de l'article
- Auteur (si disponible)
- Date de publication (si disponible)
- Nom du site/blog
- Contenu en markdown
- Nombre de caractères/mots
- Liste des URLs/ressources mentionnées

### 3. Analyse du Contenu

Analyse le contenu markdown pour extraire:

**a) Concepts Clés**
- Identifier 3-5 concepts principaux
- Pour chaque concept:
  - Définition claire
  - Avantages/Limitations
  - Cas d'usage concrets
  - **OBLIGATOIRE**: Créer un schéma ASCII illustratif

**b) Structure de l'Article**
- Identifier les sections principales
- Créer une table des matières logique
- Repérer les points de rupture (exemples, code blocks, etc.)

**c) Citations Marquantes**
- Identifier 3-5 citations percutantes
- Privilégier les insights uniques ou controversés
- Extraire les phrases clés de l'auteur

**d) Points d'Action**
- Classifier en 3 niveaux:
  - ✅ Immédiat (< 1h)
  - 🔄 Court terme (1 jour - 1 semaine)
  - 💪 Long terme (> 1 semaine)

**e) Exemples de Code**
- Repérer et extraire les code blocks
- Identifier le langage (TypeScript, Python, Bash, etc.)
- Annoter avec des explications si nécessaire

**f) Tags**
- Générer 5-10 tags pertinents
- Format: backticks `#tag`
- Exemples: `#typescript` `#hooks` `#workflow` `#best-practices`

### 4. Génération du Slug

Créer un nom de fichier descriptif:
- Format: `theme-principal-auteur.md` ou `theme-principal-source.md`
- Exemples:
  - `claude-code-best-practices-anthropic.md`
  - `mcp-integration-guide-modelcontextprotocol.md`
  - `typescript-patterns-dev-to.md`
- Règles:
  - Minuscules uniquement
  - Tirets pour séparer les mots
  - Pas d'accents ni caractères spéciaux
  - Maximum 60 caractères

### 5. Création du Document

Créer une structure complète comprenant:

**Métadonnées de l'Article** :
```markdown
# [Titre de l'Article]

**Source** : [Nom du blog/site]
**Auteur** : [Nom de l'auteur]
**Date** : [Date de publication]
**URL** : [URL complète]
**Durée de lecture** : [Estimation en minutes]

---
```

**Résumé Exécutif** (3-5 phrases):
- Vue d'ensemble du contenu
- Problème résolu
- Solution proposée
- Pertinence pour Claude Code

**Table des Matières** :
```markdown
## 📋 Table des Matières
- [Concept 1](#concept-1)
- [Concept 2](#concept-2)
- [Exemples Pratiques](#exemples-pratiques)
- [Points d'Action](#points-daction)
- [Ressources](#ressources)
```

**Concepts Clés** (avec schémas ASCII):
```markdown
## 🎯 Concepts Clés

### Concept 1: [Nom]

[Explication]

**Avantages** :
- Point 1
- Point 2

**Limitations** :
- Point 1

**Schéma** :
\```
[Schéma ASCII]
\```

**Exemple d'usage** :
\```typescript
// Code exemple
\```
```

**Citations Marquantes** :
```markdown
## 💬 Citations

> "Citation 1 percutante"
> — Auteur

> "Citation 2 insightful"
```

**Exemples Pratiques** :
```markdown
## 💻 Exemples Pratiques

### Exemple 1 : [Titre]

**Problème** :
[Description]

**Solution** :
\```typescript
// Code solution
\```

**Explication** :
[Pourquoi ça marche]
```

**Points d'Action** :
```markdown
## ✅ Points d'Action

### Immédiat (< 1h)
- [ ] Action 1
- [ ] Action 2

### Court terme (1-7 jours)
- [ ] Action 3

### Long terme (> 1 semaine)
- [ ] Action 4
```

**Ressources Complémentaires** :
```markdown
## 📚 Ressources

- 📄 [Lien 1](url) - Description
- 📄 [Lien 2](url) - Description
- 🔗 [Repo GitHub](url) - Code source
```

**Tags** :
```markdown
---

**Tags** : `#tag1` `#tag2` `#tag3` `#tag4` `#tag5`

**Niveau** : 🟢 Débutant | 🟡 Intermédiaire | 🟠 Avancé | 🔴 Expert

**Temps de pratique estimé** : XX minutes
```

### 6. Création de Schémas ASCII

**MINIMUM 3 SCHÉMAS OBLIGATOIRES** par fiche.

Utilise les styles du projet (voir `.claude/CLAUDE.md`) :

**Box Diagrams** :
```
╔═══════════════════════════════╗
║  Headers importants           ║
╚═══════════════════════════════╝

┌───────────────────────────────┐
│  Boxes simples                │
└───────────────────────────────┘
```

**Tree Structures** :
```
📦 Projet/
┣━━ 📁 dossier1/
┃   ┣━━ 📄 fichier1.md
┃   ┗━━ 📄 fichier2.md
└━━ 📁 dossier2/
```

**Flows & Pyramides** :
```
┌─────┐    ┌─────┐    ┌─────┐
│ A   │───>│ B   │───>│ C   │
└─────┘    └─────┘    └─────┘
```

**Comparaisons** :
```
AVANT                      APRÈS
┌─────────┐               ┌─────────┐
│ Problème│──────────────>│Solution │
└─────────┘               └─────────┘
    ❌                         ✅
```

### 7. Sauvegarde du Fichier

Utilise le tool `Write` pour créer:
```
ressources/articles/[slug].md
```

Créer le dossier `ressources/articles/` s'il n'existe pas.

### 8. Mapping Tags → Thèmes

Analyser les tags générés à l'étape 3.f et identifier les thèmes pertinents :

**Table de Correspondance** :

| Tags | Thème(s) Correspondant(s) |
|------|---------------------------|
| `memory`, `claude.md`, `CLAUDE.md` | `1-memory` |
| `commands`, `slash-commands`, `/command` | `2-commands` |
| `hooks`, `events`, `SessionStart`, `PostToolUse` | `3-hooks` |
| `skills`, `SKILL.md`, `progressive-disclosure` | `4-skills` |
| `agents`, `subagents`, `Task tool`, `sub-agent` | `5-agents` |
| `plugins`, `marketplace`, `plugin.json` | `6-plugins` |
| `mcp`, `servers`, `Model Context Protocol` | `7-mcp` |
| `workflow`, `best-practices`, `optimization` | Plusieurs thèmes (selon contexte) |

**Règles de Mapping** :
- Un article peut correspondre à **plusieurs thèmes**
- Privilégier les thèmes explicites (ex: `#mcp` → `7-mcp`)
- Pour tags génériques (`#workflow`), analyser le contenu pour déterminer les thèmes
- Minimum 1 thème, maximum 3 thèmes par article

**Exemple** :
- Tags : `#memory` `#commands` `#workflow` `#best-practices`
- Thèmes détectés : `1-memory`, `2-commands`

### 9. Ajout Automatique aux Cheatsheets

**APRÈS** avoir créé la fiche, ajouter automatiquement la ressource aux cheatsheets des thèmes identifiés :

**Pour chaque thème détecté à l'étape 8** :

1. **Lire le cheatsheet** :
   ```
   Read themes/{theme}/cheatsheet.md
   ```

2. **Localiser la section "### 📝 Articles"**

3. **Ajouter la nouvelle entrée avec Edit** :
   - Format : `- [Titre Article](../../ressources/articles/{slug}.md) ([🔗 Source]({url})) - Source/Auteur`
   - Sous-ligne descriptive (indentation 2 espaces) : `  - Résumé en 1 ligne`
   - Placer alphabétiquement ou par pertinence

4. **Exemple d'ajout** :
   ```markdown
   ### 📝 Articles

   - [Skills, Commands, Subagents, Plugins](../../ressources/articles/skills-commands-subagents-plugins-youngleaders.md) ([🔗 Source](https://www.youngleaders.tech/p/claude-skills-commands-subagents-plugins)) - YoungLeaders
     - Comparaison complète des features
   - [Nouvel Article](../../ressources/articles/nouvel-article-source.md) ([🔗 Source](https://example.com/article)) - Auteur
     - Description courte du nouvel article
   ```

5. **Validation** :
   - Vérifier que le lien relatif est correct (`../../ressources/articles/`)
   - Vérifier que le formatage markdown est respecté
   - Vérifier qu'il n'y a pas de doublon dans la liste

6. **Output** :
   ```
   ✅ Article ajouté aux cheatsheets :
   - themes/1-memory/cheatsheet.md
   - themes/2-commands/cheatsheet.md
   ```

**Note** : Si aucun thème n'est détecté, ajouter manuellement plus tard ou demander à l'utilisateur de spécifier les thèmes.

## GUIDELINES OBLIGATOIRES

### Ton & Style
- 🇫🇷 Français clair et accessible
- 🗣️ Ton amical et pédagogue
- 💡 Expliquer le "pourquoi" derrière les concepts
- 📊 Exemples concrets et visuels
- 🎓 Progressif : du simple au complexe

### Structure
- ✅ Respecter l'ordre des sections
- ✅ Minimum 3 schémas ASCII
- ✅ Emojis pertinents (voir `.claude/CLAUDE.md`)
- ✅ Citations entre guillemets `>`
- ✅ Code blocks avec langage spécifié

### Emojis à Utiliser

**Structure** :
- 📦 Projet/Package
- 📁 Dossier
- 📄 Fichier
- 📋 Liste
- 🗂️ Organisation

**Acteurs** :
- 👤 User
- 🏢 Enterprise
- 🤖 AI/Claude

**Technique** :
- ⚡ Quick/Rapide
- 🔧 Config/Outils
- 🔌 Plugins
- 🧠 Memory
- 💻 Code

**Workflow** :
- ✅ Do/Correct
- ❌ Don't/Incorrect
- ⚠️ Warning
- 💡 Tip
- 🎯 Objectif
- 🚀 Performance

**Apprentissage** :
- 🟢 Niveau 1 - Découverte
- 🟡 Niveau 2 - Utilisation
- 🟠 Niveau 3 - Maîtrise
- 🔴 Niveau 4 - Expert

**Priorité** :
- ⭐ Recommandé
- 🌟 Très important
- 💪 Avancé
- 🔥 Hot/Trending

## OUTILS MCP À UTILISER

1. **supadata_scrape** : Extraction de contenu article
   ```
   mcp__supadata-ai-mcp__supadata_scrape
   Parameters: {
     url: string,              // URL de l'article
     lang?: string,           // Code langue ISO 639-1 (fr, en)
     noLinks?: boolean        // false pour garder les liens
   }
   ```

2. **Write** : Créer la fiche
   ```
   Write
   Parameters: {
     file_path: string,
     content: string
   }
   ```

3. **Bash** : Créer le dossier si nécessaire
   ```
   Bash
   Parameters: { command: "mkdir -p ressources/articles" }
   ```

## CHECKLIST DE VALIDATION

Avant de sauvegarder, vérifier:

- [ ] ✅ Structure respectée (métadonnées, résumé, concepts, citations, exemples, actions, ressources, tags)
- [ ] ✅ Minimum 3 schémas ASCII présents
- [ ] ✅ Emojis pertinents utilisés
- [ ] ✅ Exemples concrets fournis
- [ ] ✅ Code blocks formatés avec langage spécifié
- [ ] ✅ Citations entre guillemets
- [ ] ✅ Tags générés (5-10)
- [ ] ✅ Slug approprié et unique
- [ ] ✅ Résumé exécutif clair (3-5 phrases)
- [ ] ✅ Points d'action classifiés (Immédiat/Court/Long terme)
- [ ] ✅ Ressources avec liens cliquables
- [ ] ✅ Niveau de difficulté indiqué
- [ ] ✅ Temps de pratique estimé
- [ ] ✅ Table des matières générée

## OUTPUT ATTENDU

Après exécution, afficher:

```
✅ Article analysé avec succès !

📄 Fichier créé : ressources/articles/[slug].md

📊 Statistiques :
- Concepts extraits : X
- Schémas ASCII : X
- Citations : X
- Tags : X
- Exemples de code : X
- Mots : ~XXXX

💡 Résumé :
[Résumé en 2-3 phrases]

🔗 Prochaines étapes :
- Lire la fiche complète
- Tester les exemples pratiques
- Consulter les ressources mentionnées
```

## GESTION DES ERREURS

**Si URL invalide** :
```
❌ Erreur : URL article invalide ou inaccessible.
Vérifier que l'article est accessible publiquement.
```

**Si article privé/paywall** :
```
❌ Erreur : Impossible d'accéder au contenu de l'article.
L'article est peut-être derrière un paywall ou nécessite une authentification.
```

**Si contenu trop court** :
```
⚠️ Attention : Contenu très court détecté (< 500 mots).
Analyse limitée. Vérifier que l'URL pointe vers un article complet.
```

**Si fichier existe déjà** :
```
⚠️ Attention : Un fichier existe déjà pour cet article.
Voulez-vous :
1. Écraser l'existant
2. Créer avec un nouveau nom
3. Annuler
```

**Si scraping échoue** :
```
❌ Erreur : Impossible d'extraire le contenu de l'article.
Vérifier l'URL ou essayer une autre source.
```

## EXEMPLES D'UTILISATION

### Exemple 1 : Article Medium
```bash
/add-article https://medium.com/@anthropic/claude-code-best-practices-2025
```

Résultat attendu:
- Fichier: `ressources/articles/claude-code-best-practices-anthropic.md`
- Concepts: Memory, Commands, Workflow, Sub-agents
- Schémas: 4 schémas ASCII
- Tags: `#best-practices` `#workflow` `#memory` `#commands`

### Exemple 2 : Documentation MCP
```bash
/add-article https://modelcontextprotocol.io/docs/getting-started
```

Résultat attendu:
- Fichier: `ressources/articles/mcp-getting-started-modelcontextprotocol.md`
- Concepts: MCP Protocol, Servers, Tools, Resources
- Schémas: 5 schémas ASCII
- Tags: `#mcp` `#protocol` `#integration` `#servers`

### Exemple 3 : Article dev.to
```bash
/add-article https://dev.to/author/claude-code-workflow-optimization
```

Résultat attendu:
- Fichier: `ressources/articles/workflow-optimization-dev-to.md`
- Concepts: Workflow, Performance, Optimization, Tips
- Schémas: 3 schémas ASCII
- Tags: `#workflow` `#optimization` `#tips` `#productivity`

## AMÉLIORATIONS FUTURES

Idées à considérer (non implémentées) :

- 🔄 Auto-détection d'articles similaires pour cross-references
- 📊 Génération automatique de quiz/exercices
- 🎨 Suggestion de thèmes/catégories
- 🔗 Intégration avec système de tags global
- 📈 Tracking des articles analysés (métadonnées)
- 🌐 Support multi-langues (traduction auto FR/EN)
- 📝 Extraction automatique de définitions glossaire

---

**Note** : Cette commande utilise Supadata AI MCP pour l'extraction de contenu web. Supadata offre un scraping robuste en markdown avec conservation des liens et métadonnées. La commande respecte scrupuleusement les guidelines du fichier `.claude/CLAUDE.md`.

**Configuration MCP requise** : Assurez-vous d'avoir configuré Supadata AI MCP dans votre `~/.config/claude-code/config.json` :

```json
{
  "mcpServers": {
    "supadata-ai-mcp": {
      "command": "npx",
      "args": ["-y", "@supadata-ai/mcp"]
    }
  }
}
```
