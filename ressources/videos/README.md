# 🎥 Vidéos - Ressources Visuelles

Fiches d'analyse de vidéos sur Claude Code, workflows AI et développement.

## 🎯 Objectif

Documenter et synthétiser les vidéos clés de l'écosystème Claude Code pour apprentissage rapide avec timestamps et moments clés.

## 📋 Structure d'une Fiche Vidéo

Chaque fiche contient :

```
┌─────────────────────────────────────┐
│  📝 MÉTADONNÉES                     │
│  - Chaîne, Créateur, Date           │
│  - URL, Durée totale                │
│  - Langue (FR/EN)                   │
├─────────────────────────────────────┤
│  📊 RÉSUMÉ EXÉCUTIF                 │
│  - Vue d'ensemble (3-5 phrases)     │
│  - Ce que vous allez apprendre      │
├─────────────────────────────────────┤
│  ⏱️ TIMESTAMPS CLÉS                 │
│  - Navigation rapide par section    │
│  - Moments importants               │
├─────────────────────────────────────┤
│  🎯 CONCEPTS CLÉS                   │
│  - Explications détaillées          │
│  - Schémas ASCII (min. 3)           │
│  - Captures d'écran conceptuelles   │
├─────────────────────────────────────┤
│  💬 CITATIONS MARQUANTES            │
│  - Insights du créateur             │
│  - Best practices mentionnées       │
├─────────────────────────────────────┤
│  💻 DÉMONSTRATIONS PRATIQUES        │
│  - Workflows montrés                │
│  - Commandes utilisées              │
│  - Code snippets (si applicable)    │
├─────────────────────────────────────┤
│  ✅ POINTS D'ACTION                 │
│  - Immédiat / Court / Long terme    │
├─────────────────────────────────────┤
│  📚 RESSOURCES                      │
│  - Repos GitHub mentionnés          │
│  - Docs référencées                 │
│  - Vidéos complémentaires           │
└─────────────────────────────────────┘
```

## 🚀 Utilisation

### Ajouter une Vidéo

```bash
/add-video <url-youtube>
```

**Exemples** :
```bash
# Vidéo YouTube
/add-video https://youtube.com/watch?v=abc123

# Vidéo courte
/add-video https://youtu.be/abc123

# Avec timestamp
/add-video https://youtube.com/watch?v=abc123&t=120s
```

### Lire une Fiche

```bash
# Lister toutes les vidéos
ls ressources/videos/

# Ouvrir une fiche
cat ressources/videos/nom-video.md
```

## 📊 Organisation

**Naming Convention** :
```
titre-principal-createur.md
```

**Exemples** :
- `800h-claude-code-edmund-yong.md`
- `terminal-ai-workflow.md`
- `skills-vs-mcp-vs-subagents.md`
- `formation-claude-code-2-0-melvynx.md`

## 🏷️ Système de Tags

Chaque vidéo est taguée pour faciliter la recherche :

**Thèmes Claude Code** :
- `#memory` - System mémoire
- `#commands` - Slash commands
- `#mcp` - Model Context Protocol
- `#subagents` - Sub-agents
- `#skills` - Skills
- `#hooks` - Hooks
- `#plugins` - Plugins
- `#workflows` - Workflows complets

**Types de Contenu** :
- `#tutorial` - Tutoriel pas-à-pas
- `#demo` - Démonstration
- `#workflow` - Workflow complet
- `#tips` - Astuces rapides
- `#setup` - Configuration
- `#best-practices` - Bonnes pratiques

**Créateurs** :
- `#networkchuck` - NetworkChuck
- `#edmund-yong` - Edmund Yong
- `#melvynx` - Melvynx
- `#solo-swift-crafter` - Solo Swift Crafter
- `#kenny-liao` - Kenny Liao
- `#afar` - Afar

**Niveaux** :
- 🟢 Débutant
- 🟡 Intermédiaire
- 🟠 Avancé
- 🔴 Expert

**Durée** :
- ⚡ Court (< 10 min)
- 🎯 Moyen (10-30 min)
- 📚 Long (30-60 min)
- 🎓 Masterclass (> 60 min)

## 🔍 Recherche de Vidéos

**Par tag** :
```bash
grep -r "#mcp" ressources/videos/
```

**Par créateur** :
```bash
grep -r "Edmund Yong" ressources/videos/
```

**Par durée** :
```bash
grep -r "🎓 Masterclass" ressources/videos/
```

## 📚 Vidéos par Catégorie

### 🌟 Essentiels (Pour Débutants)

1. **[Terminal AI Workflow](./terminal-ai-workflow.md)** - NetworkChuck
   - ⏱️ 33 min | 🟢 Débutant
   - Workflow complet avec MCP et commands

2. **[Skills vs MCP vs Subagents](./skills-vs-mcp-vs-subagents.md)** - Solo Swift Crafter
   - ⏱️ 9 min | 🟡 Intermédiaire
   - Comparaison claire des concepts

3. **[Formation Claude Code 2.0](./formation-claude-code-2-0-melvynx.md)** - Melvynx
   - 🟢 Débutant
   - Introduction complète 2025

### 💪 Avancés

1. **[800h Claude Code](./800h-claude-code-edmund-yong.md)** - Edmund Yong
   - ⏱️ 27 oct 2025 | 🔴 Expert
   - Optimisations et best practices

2. **[500h Optimisation Workflow](./500h-optimisation-workflow-melvynx.md)** - Melvynx
   - 🟠 Avancé
   - Workflow optimization patterns

3. **[Claude Skills Complete Guide](./claude-skills-complete-guide-kenny-liao.md)** - Kenny Liao
   - 🟠 Avancé
   - Deep dive dans les skills

### 🔥 Spécialisés

1. **[Statusline Ultimate](./statusline-ultimate-melvynx.md)** - Melvynx
   - ⚡ Court | 🟡 Intermédiaire
   - Dashboard et monitoring

2. **[Plugins Marketplace](./plugins-marketplace-melvynx.md)** - Melvynx
   - 🎯 Moyen | 🟡 Intermédiaire
   - Système de plugins

3. **[Subagents Usage](./subagents-usage-melvynx.md)** - Melvynx
   - 🎯 Moyen | 🟠 Avancé
   - Orchestration d'agents

4. **[Claude Code 2.0 - 11 Essential Features](./claude-code-2.0-11-essential-features-afar.md)** - Afar
   - 🟡 Intermédiaire
   - Nouvelles features 2025

## 🎬 Parcours d'Apprentissage

### 🆕 Débutant (0-10h)
1. Formation Claude Code 2.0 (Melvynx)
2. Terminal AI Workflow (NetworkChuck)
3. Skills vs MCP vs Subagents (Solo Swift Crafter)

### 🚀 Intermédiaire (10-50h)
1. Claude Skills Complete Guide (Kenny Liao)
2. Plugins Marketplace (Melvynx)
3. Statusline Ultimate (Melvynx)

### 💪 Avancé (50-200h)
1. Subagents Usage (Melvynx)
2. 500h Optimisation Workflow (Melvynx)

### 🎓 Expert (200h+)
1. 800h Claude Code (Edmund Yong)

## 🔍 Tips pour Regarder les Vidéos

✅ **Avant** :
- Lire le résumé exécutif
- Identifier les timestamps clés
- Préparer environnement (Claude Code ouvert)

✅ **Pendant** :
- Pause et pratique après chaque section
- Noter les commands/workflows montrés
- Créer vos propres exemples

✅ **Après** :
- Implémenter au moins 1 concept vu
- Revoir les points d'action
- Explorer les ressources liées

## 🛠️ Outils

**Supadata AI MCP** : Extraction de transcripts
- Transcripts automatiques YouTube
- Timestamps préservés
- Multi-langue (FR/EN)

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

*Mis à jour manuellement*

- **Total vidéos** : 12
- **Par niveau** :
  - 🟢 Débutant : 3
  - 🟡 Intermédiaire : 4
  - 🟠 Avancé : 4
  - 🔴 Expert : 1
- **Durée totale** : ~8-10 heures de contenu
- **Créateurs** : 5 (NetworkChuck, Edmund Yong, Melvynx, Solo Swift Crafter, Kenny Liao, Afar)

## 🔗 Voir Aussi

- 📄 [Articles](../articles/) - Analyses d'articles
- 📚 [Themes](../../themes/) - Guides thématiques
- 🚀 [Workflows](../../workflow-pattern-orchestration/) - Orchestration

---

**Note** : Les vidéos sont complémentaires aux articles. Privilégier les vidéos pour :
- Workflows visuels
- Démonstrations pratiques
- Tutoriels pas-à-pas
- Setup et configuration

Privilégier les articles pour :
- Documentation de référence
- Patterns de code détaillés
- Best practices écrites
- Quick reference
