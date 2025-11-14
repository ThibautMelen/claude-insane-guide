# 📄 Articles - Ressources Techniques

Fiches d'analyse d'articles techniques sur Claude Code, l'IA et le développement.

## 🎯 Objectif

Documenter et synthétiser les articles clés de l'écosystème Claude Code pour apprentissage rapide.

## 📋 Structure d'une Fiche Article

Chaque fiche contient :

```
┌─────────────────────────────────────┐
│  📝 MÉTADONNÉES                     │
│  - Source, Auteur, Date             │
│  - URL, Durée de lecture            │
├─────────────────────────────────────┤
│  📊 RÉSUMÉ EXÉCUTIF                 │
│  - Vue d'ensemble (3-5 phrases)     │
├─────────────────────────────────────┤
│  📋 TABLE DES MATIÈRES              │
│  - Navigation rapide                │
├─────────────────────────────────────┤
│  🎯 CONCEPTS CLÉS                   │
│  - Explications détaillées          │
│  - Schémas ASCII (min. 3)           │
│  - Exemples de code                 │
├─────────────────────────────────────┤
│  💬 CITATIONS MARQUANTES            │
│  - Insights de l'auteur             │
├─────────────────────────────────────┤
│  💻 EXEMPLES PRATIQUES              │
│  - Code snippets annotés            │
│  - Cas d'usage réels                │
├─────────────────────────────────────┤
│  ✅ POINTS D'ACTION                 │
│  - Immédiat / Court / Long terme    │
├─────────────────────────────────────┤
│  📚 RESSOURCES                      │
│  - Liens complémentaires            │
└─────────────────────────────────────┘
```

## 🚀 Utilisation

### Ajouter un Article

```bash
/add-article <url-article>
```

**Exemples** :
```bash
# Article Medium
/add-article https://medium.com/@anthropic/article-slug

# Article dev.to
/add-article https://dev.to/author/article-slug

# Documentation officielle
/add-article https://code.claude.com/docs/feature

# Blog technique
/add-article https://blog.company.com/article-path
```

### Lire une Fiche

```bash
# Lister tous les articles
ls ressources/articles/

# Ouvrir une fiche
cat ressources/articles/nom-article.md
```

## 📊 Organisation

**Naming Convention** :
```
theme-principal-source.md
```

**Exemples** :
- `claude-code-best-practices-anthropic.md`
- `mcp-integration-guide-modelcontextprotocol.md`
- `workflow-optimization-dev-to.md`
- `typescript-patterns-medium.md`

## 🏷️ Système de Tags

Chaque article est tagué pour faciliter la recherche :

**Thèmes Claude Code** :
- `#memory` - System mémoire
- `#commands` - Slash commands
- `#mcp` - Model Context Protocol
- `#subagents` - Sub-agents
- `#skills` - Skills
- `#hooks` - Hooks
- `#plugins` - Plugins

**Techniques** :
- `#typescript` - TypeScript
- `#python` - Python
- `#bash` - Bash/Shell
- `#git` - Git workflow

**Concepts** :
- `#best-practices` - Bonnes pratiques
- `#workflow` - Workflows
- `#optimization` - Optimisation
- `#architecture` - Architecture

**Niveaux** :
- 🟢 Débutant
- 🟡 Intermédiaire
- 🟠 Avancé
- 🔴 Expert

## 🔍 Recherche d'Articles

**Par tag** :
```bash
grep -r "#mcp" ressources/articles/
```

**Par concept** :
```bash
grep -r "workflow" ressources/articles/
```

**Par auteur** :
```bash
grep -r "Anthropic" ressources/articles/
```

## 📚 Articles Recommandés

(Cette section sera mise à jour au fur et à mesure)

### 🌟 Essentiels
- *À venir* - Premiers articles à analyser

### 💪 Avancés
- *À venir* - Articles techniques approfondis

### 🔥 Trending
- *À venir* - Dernières nouveautés

## 🤝 Contribution

Pour ajouter manuellement un article :

1. Créer un fichier `theme-source.md` dans ce dossier
2. Respecter la structure de fiche (voir template)
3. Minimum 3 schémas ASCII
4. Code blocks avec langage spécifié
5. Tags pertinents (5-10)

**Template** : Voir `.claude/commands/add-article.md` pour structure complète

## 🛠️ Outils

**Supadata AI MCP** : Scraping de contenu web
- Extraction markdown
- Conservation des liens
- Métadonnées automatiques

**Configuration** :
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

## 📈 Statistiques

*Mis à jour automatiquement*

- **Total articles** : 0
- **Par niveau** :
  - 🟢 Débutant : 0
  - 🟡 Intermédiaire : 0
  - 🟠 Avancé : 0
  - 🔴 Expert : 0

## 🔗 Voir Aussi

- 📹 [Vidéos](../videos/) - Analyses vidéo
- 📚 [Themes](../../themes/) - Guides thématiques
- 🎓 [Exercices](../../themes/*/exercices/) - Pratique

---

**Note** : Les articles sont complémentaires aux vidéos. Privilégier les articles pour :
- Documentation officielle
- Best practices détaillées
- Patterns de code
- Guides de référence

Privilégier les vidéos pour :
- Workflows visuels
- Démonstrations
- Tutoriels pas-à-pas
