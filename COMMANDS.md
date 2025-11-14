# 🛠️ Commandes Personnalisées du Projet

Liste complète des slash commands disponibles dans ce projet.

---

## 📚 Ressources - Analyse de Contenu

### `/add-video <youtube-url>`

Analyse une vidéo YouTube et crée une fiche complète dans `ressources/videos/`.

**Usage** :
```bash
/add-video https://www.youtube.com/watch?v=xxxxx
```

**Fonctionnalités** :
- ✅ Extraction automatique de la transcription (Supadata AI MCP)
- ✅ Analyse des concepts clés
- ✅ Génération de 3+ schémas ASCII
- ✅ Extraction des timecodes importants
- ✅ Citations marquantes
- ✅ Points d'action classifiés (Immédiat/Court/Long terme)
- ✅ Tags automatiques

**Résultat** :
```
ressources/videos/theme-auteur.md
```

**Plateformes supportées** :
- YouTube
- TikTok
- Instagram
- Twitter

---

### `/add-article <article-url>` 🆕

Analyse un article web et crée une fiche complète dans `ressources/articles/`.

**Usage** :
```bash
/add-article https://blog.company.com/article-path
```

**Fonctionnalités** :
- ✅ Scraping de contenu en markdown (Supadata AI MCP)
- ✅ Analyse des concepts clés
- ✅ Génération de 3+ schémas ASCII
- ✅ Extraction des exemples de code
- ✅ Citations et insights
- ✅ Points d'action classifiés
- ✅ Table des matières automatique
- ✅ Tags automatiques

**Résultat** :
```
ressources/articles/theme-source.md
```

**Sources supportées** :
- Medium
- dev.to
- Blogs techniques
- Documentation officielle
- Articles web publics

---

## 🎓 Quiz & Auto-évaluation

### `/quiz`

Menu interactif pour choisir un quiz.

**Fonctionnalités** :
- Sélection par thème (Memory, Commands, Interactive UI)
- Navigation guidée

---

### `/quiz-memory`

Quiz sur le système Memory de Claude Code.

**Couvre** :
- `.claude/CLAUDE.md`
- Hiérarchie Global vs Project
- Best practices
- Patterns avancés

**Format** :
- Questions interactives
- Score final
- Explications détaillées

---

### `/quiz-commands`

Quiz sur les Slash Commands.

**Couvre** :
- Structure des commands
- YAML frontmatter
- Arguments
- Best practices

**Format** :
- QCM interactif
- Correction immédiate

---

### `/quiz-interactive-ui`

Quiz sur AskUserQuestion et Interactive UI.

**Couvre** :
- Tool AskUserQuestion
- Patterns de dialogue
- Multi-select
- Options format

**Format** :
- Questions pratiques
- Exemples de code

---

### `/check-knowledge`

Auto-évaluation complète sur Claude Code.

**Couvre** :
- Memory
- Commands
- Hooks
- MCP
- Sub-agents
- Best practices

**Résultat** :
- Score global
- Points forts/faibles
- Recommandations d'apprentissage

---

## 🎨 Structure des Commandes

Toutes les commandes suivent cette structure :

```markdown
---
name: nom-commande
description: Description courte
---

[Contenu du prompt]
```

---

## 📂 Localisation

```
.claude/commands/
├── add-video.md
├── add-article.md
├── quiz.md
├── quiz-memory.md
├── quiz-commands.md
├── quiz-interactive-ui.md
└── check-knowledge.md
```

---

## 🚀 Ajouter une Nouvelle Commande

### 1. Créer le fichier

```bash
touch .claude/commands/ma-commande.md
```

### 2. Structure de base

```markdown
---
name: ma-commande
description: Description de ma commande
---

Tu es un expert en [domaine].

## CONTEXTE

[Expliquer le contexte]

## WORKFLOW

1. **ÉTAPE 1** : Description
   - Action spécifique
   - **CRITICAL** : Contrainte importante

2. **ÉTAPE 2** : Suite
   - Continuer les actions

## OUTPUT ATTENDU

[Format de sortie attendu]
```

### 3. Utiliser la commande

```bash
/ma-commande
```

---

## 💡 Best Practices pour les Commandes

### ✅ DO

**Ton clair et direct** :
```markdown
✅ "Analyse la vidéo et crée une fiche dans ressources/videos/"
❌ "Tu pourrais peut-être analyser la vidéo si possible..."
```

**Structure numérotée** :
```markdown
## WORKFLOW

1. **ACTION 1** : Description
2. **ACTION 2** : Description
3. **ACTION 3** : Description
```

**Contraintes explicites** :
```markdown
- **OBLIGATOIRE** : Minimum 3 schémas ASCII
- **CRITICAL** : Vérifier que le fichier n'existe pas déjà
- **NEVER** : Ne jamais écraser sans confirmation
```

**Exemples concrets** :
```markdown
**Exemple** :
\```bash
/add-video https://www.youtube.com/watch?v=xxxxx
\```

Résultat attendu:
- Fichier: `ressources/videos/theme-auteur.md`
- Concepts: X, Y, Z
```

### ❌ DON'T

**Pas de prompts vagues** :
```markdown
❌ "Fais quelque chose avec la vidéo"
✅ "Extraire la transcription avec Supadata MCP"
```

**Pas de multi-responsabilités** :
```markdown
❌ Une commande qui fait tout (vidéo + article + quiz)
✅ Commandes séparées et spécialisées
```

**Pas d'outils implicites** :
```markdown
❌ "Récupère la vidéo" (comment ?)
✅ "Utilise mcp__supadata-ai-mcp__supadata_transcript"
```

---

## 🔧 Templates Disponibles

```
.claude/templates/
├── video-analysis.md     → Template fiches vidéo
└── article-analysis.md   → Template fiches article
```

**Usage dans les commandes** :
```markdown
### 5. Utilisation du Template

Utilise le tool `Read` pour lire le template:
\```
.claude/templates/article-analysis.md
\```

Remplace tous les placeholders `{{XXX}}` avec les données extraites.
```

---

## 📊 Statistiques

**Total commandes** : 7

**Par catégorie** :
- 📚 Ressources : 2 (add-video, add-article)
- 🎓 Quiz : 5 (quiz, quiz-*, check-knowledge)

**MCP utilisés** :
- `supadata-ai-mcp` (add-video, add-article)

---

## 🔗 Voir Aussi

- 📄 [Memory](./.claude/CLAUDE.md) - Règles du projet
- 📚 [Themes](./themes/) - Guides thématiques
- 📹 [Vidéos](./ressources/videos/) - Analyses vidéo
- 📄 [Articles](./ressources/articles/) - Analyses articles

---

**🚀 Créez vos propres commandes pour automatiser vos workflows !**
