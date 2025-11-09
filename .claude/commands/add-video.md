---
name: add-video
description: Analyse une vidéo YouTube et crée une fiche complète dans ressources/videos/. Usage - /add-video <youtube-url>
---

Tu es un expert en analyse de contenu vidéo YouTube éducatif sur Claude Code, l'IA et le développement.

## CONTEXTE

Ce projet est un guide d'apprentissage francophone sur Claude Code. Toutes les fiches vidéo doivent respecter les guidelines du fichier `.claude/CLAUDE.md`.

## ARGUMENTS

**URL YouTube (REQUIS)** : L'URL complète de la vidéo à analyser
- Format: `https://www.youtube.com/watch?v=xxxxx` ou `https://youtu.be/xxxxx`
- La vidéo doit être accessible publiquement

## WORKFLOW DÉTAILLÉ

### 1. Récupération des Métadonnées

Utilise le MCP tool `mcp__MCP_DOCKER__get_video_info` avec l'URL fournie pour obtenir:
- Titre de la vidéo
- Auteur/Chaîne
- Durée
- Date de publication
- Description

### 2. Récupération de la Transcription

Utilise le MCP tool `mcp__MCP_DOCKER__get_transcript` avec:
- URL de la vidéo
- Langue: `fr` (priorité au français, sinon `en`)

Si la transcription est trop longue (> 100K tokens), utilise `next_cursor` pour récupérer par morceaux.

### 3. Analyse du Contenu

Analyse la transcription pour extraire:

**a) Concepts Clés**
- Identifier 3-5 concepts principaux
- Pour chaque concept:
  - Définition claire
  - Avantages/Limitations
  - Cas d'usage concrets
  - **OBLIGATOIRE**: Créer un schéma ASCII illustratif

**b) Timecodes Importants**
- Extraire les timestamps clés de la description
- Formater: `MM:SS - Description`
- Si absents de la description, inférer des sections logiques

**c) Citations Marquantes**
- Identifier 3-5 citations percutantes
- Privilégier les insights uniques ou controversés

**d) Points d'Action**
- Classifier en 3 niveaux:
  - ✅ Immédiat (< 1h)
  - 🔄 Court terme (1 jour - 1 semaine)
  - 💪 Long terme (> 1 semaine)

**e) Tags**
- Générer 5-10 tags pertinents
- Format: backticks `#tag`
- Exemples: `#subagents` `#mcp` `#skills` `#workflow`

### 4. Génération du Slug

Créer un nom de fichier descriptif:
- Format: `theme-principal-auteur.md`
- Exemples:
  - `subagents-usage-melvynx.md`
  - `skills-vs-mcp-vs-subagents.md`
  - `800h-claude-code-edmund-yong.md`
- Règles:
  - Minuscules uniquement
  - Tirets pour séparer les mots
  - Pas d'accents ni caractères spéciaux
  - Maximum 60 caractères

### 5. Utilisation du Template

Utilise le tool `Read` pour lire le template:
```
.claude/templates/video-analysis.md
```

Remplace tous les placeholders `{{XXX}}` avec les données extraites:
- `{{TITLE}}` : Titre de la vidéo
- `{{AUTHOR}}` : Nom de la chaîne
- `{{DURATION}}` : Durée formatée (ex: "22 minutes")
- `{{DATE}}` : Date formatée (ex: "4 septembre 2025")
- `{{URL}}` : URL complète
- `{{VIDEO_ID}}` : ID YouTube (extrait de l'URL)
- `{{TAGS}}` : Liste des tags
- `{{SUMMARY}}` : Résumé exécutif (3-5 phrases)
- `{{KEY_TAKEAWAY}}` : Conclusion principale (1 phrase)
- `{{TIMECODES}}` : Liste des timecodes
- `{{CONCEPT_X_*}}` : Sections de concepts
- `{{ASCII_DIAGRAM_X}}` : Schémas ASCII
- `{{QUOTE_X}}` : Citations
- `{{ACTION_X_*}}` : Points d'action
- `{{RESOURCE_X_*}}` : Ressources mentionnées

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

### 7. Sauvegarde du Fichier

Utilise le tool `Write` pour créer:
```
ressources/videos/[slug].md
```

## GUIDELINES OBLIGATOIRES

### Ton & Style
- 🇫🇷 Français clair et accessible
- 🗣️ Ton amical et pédagogue
- 💡 Expliquer le "pourquoi" derrière les concepts
- 📊 Exemples concrets et visuels
- 🎓 Progressif : du simple au complexe

### Structure
- ✅ Respecter l'ordre du template
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

**Acteurs** :
- 👤 User
- 🏢 Enterprise
- 🤖 AI/Claude

**Technique** :
- ⚡ Quick/Rapide
- 🔧 Config/Outils
- 🔌 Plugins
- 🧠 Memory

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

1. **get_video_info** : Métadonnées vidéo
   ```
   mcp__MCP_DOCKER__get_video_info
   Parameters: { url: string }
   ```

2. **get_transcript** : Transcription complète
   ```
   mcp__MCP_DOCKER__get_transcript
   Parameters: {
     url: string,
     lang: "fr" | "en",
     next_cursor?: string
   }
   ```

3. **Read** : Lire le template
   ```
   Read
   Parameters: { file_path: string }
   ```

4. **Write** : Créer la fiche
   ```
   Write
   Parameters: {
     file_path: string,
     content: string
   }
   ```

## CHECKLIST DE VALIDATION

Avant de sauvegarder, vérifier:

- [ ] ✅ Structure respectée (template complet)
- [ ] ✅ Minimum 3 schémas ASCII présents
- [ ] ✅ Emojis pertinents utilisés
- [ ] ✅ Exemples concrets fournis
- [ ] ✅ Timecodes formatés correctement
- [ ] ✅ Citations entre guillemets
- [ ] ✅ Tags générés (5-10)
- [ ] ✅ Slug approprié et unique
- [ ] ✅ Résumé exécutif clair (3-5 phrases)
- [ ] ✅ Points d'action classifiés (Immédiat/Court/Long terme)
- [ ] ✅ Ressources avec liens cliquables
- [ ] ✅ Niveau de difficulté indiqué
- [ ] ✅ Temps de pratique estimé

## OUTPUT ATTENDU

Après exécution, afficher:

```
✅ Vidéo analysée avec succès !

📄 Fichier créé : ressources/videos/[slug].md

📊 Statistiques :
- Concepts extraits : X
- Schémas ASCII : X
- Citations : X
- Tags : X
- Timecodes : X

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
❌ Erreur : URL YouTube invalide.
Format attendu : https://www.youtube.com/watch?v=xxxxx
```

**Si vidéo privée/indisponible** :
```
❌ Erreur : Impossible d'accéder à la vidéo.
Vérifier que la vidéo est publique et accessible.
```

**Si transcription absente** :
```
⚠️ Attention : Pas de transcription disponible.
Analyse limitée aux métadonnées et description.
```

**Si fichier existe déjà** :
```
⚠️ Attention : Un fichier existe déjà pour cette vidéo.
Voulez-vous :
1. Écraser l'existant
2. Créer avec un nouveau nom
3. Annuler
```

## EXEMPLES D'UTILISATION

### Exemple 1 : Vidéo Melvynx
```bash
/add-video https://www.youtube.com/watch?v=bsQ5Sz-qEh0
```

Résultat attendu:
- Fichier: `ressources/videos/subagents-usage-melvynx.md`
- Concepts: Sub-agents, Pollution contexte, Workflow parallèle
- Schémas: 12 schémas ASCII
- Tags: `#subagents` `#workflow` `#autofix` `#sniper`

### Exemple 2 : Vidéo Solo Swift Crafter
```bash
/add-video https://youtu.be/ZroGqu7GyXM
```

Résultat attendu:
- Fichier: `ressources/videos/skills-vs-mcp-vs-subagents.md`
- Concepts: Skills, MCP, Subagents, Fine-tuning
- Schémas: 5 schémas ASCII
- Tags: `#skills` `#mcp` `#subagents` `#oss-model`

## AMÉLIORATIONS FUTURES

Idées à considérer (non implémentées) :

- 🔄 Auto-détection de vidéos similaires pour cross-references
- 📊 Génération automatique de quiz/exercices
- 🎨 Suggestion de thèmes/catégories
- 🔗 Intégration avec système de tags global
- 📈 Tracking des vidéos analysées (métadonnées)

---

**Note** : Cette commande respecte scrupuleusement les guidelines du fichier `.claude/CLAUDE.md`. Toute modification doit maintenir cette cohérence.
