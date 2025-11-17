---
name: add-video
description: Analyse une vidéo YouTube et crée une fiche complète dans ressources/videos/. Usage - /add-video <youtube-url>
---

Tu es un expert en analyse de contenu vidéo YouTube éducatif sur Claude Code, l'IA et le développement.

## CONTEXTE

Ce projet est un guide d'apprentissage francophone sur Claude Code. Toutes les fiches vidéo doivent respecter les guidelines du fichier `.claude/CLAUDE.md`.

## ARGUMENTS

**URL Vidéo (REQUIS)** : L'URL complète de la vidéo à analyser
- Plateformes supportées : YouTube, TikTok, Instagram, Twitter
- Formats acceptés :
  - YouTube: `https://www.youtube.com/watch?v=xxxxx` ou `https://youtu.be/xxxxx`
  - TikTok: `https://www.tiktok.com/@user/video/xxxxx`
  - Instagram: `https://www.instagram.com/reel/xxxxx`
  - Twitter: `https://twitter.com/user/status/xxxxx`
- La vidéo doit être accessible publiquement

## WORKFLOW DÉTAILLÉ

### 1. Récupération de la Transcription avec Supadata

Utilise le MCP tool `mcp__supadata-ai-mcp__supadata_transcript` avec:
- URL de la vidéo fournie
- `lang`: `fr` (priorité au français, sinon `en`)
- `text`: `false` pour obtenir les métadonnées complètes
- `mode`: `auto` pour obtenir la meilleure transcription disponible

Si la transcription est asynchrone (retourne un job ID), utilise `mcp__supadata-ai-mcp__supadata_check_transcript_status` pour vérifier le statut et récupérer le résultat.

### 1.5. Vérification des Doublons

**AVANT** d'analyser la transcription, vérifier si la vidéo n'existe pas déjà :

1. **Extraire le VIDEO_ID** de l'URL YouTube :
   - YouTube: `https://www.youtube.com/watch?v=VIDEO_ID` → extraire `VIDEO_ID`
   - YouTube short: `https://youtu.be/VIDEO_ID` → extraire `VIDEO_ID`

2. **Chercher dans ressources/videos/** avec Grep :
   ```bash
   grep -l "watch?v=VIDEO_ID\|youtu\.be/VIDEO_ID" ressources/videos/*.md
   ```

3. **Si un fichier est trouvé** :
   - Afficher : `⚠️ Cette vidéo existe déjà : {filename}`
   - Utiliser AskUserQuestion pour demander :
     ```markdown
     Question: "Cette vidéo existe déjà dans ressources/videos/{filename}. Que voulez-vous faire ?"
     Options:
     1. "Écraser l'existant" - Continuer et remplacer le fichier
     2. "Créer avec nouveau nom" - Ajouter suffixe (ex: -v2)
     3. "Annuler" - Arrêter la commande
     ```

4. **Si aucun doublon** : Continuer normalement

### 2. Extraction des Métadonnées

À partir de la réponse de Supadata, extraire:
- Titre de la vidéo
- Auteur/Chaîne
- Durée
- Date de publication (si disponible)
- Transcription complète

### 3. Gestion du Processus Asynchrone (si nécessaire)

Si Supadata retourne un job ID au lieu de la transcription directe:
1. Attendre quelques secondes (2-5 secondes)
2. Utiliser `mcp__supadata-ai-mcp__supadata_check_transcript_status` avec le job ID
3. Répéter jusqu'à obtenir le statut 'completed' ou 'failed'
4. Maximum 10 tentatives avec attente progressive (2, 4, 6, 8, 10 secondes)

### 4. Analyse du Contenu

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

### 5. Génération du Slug

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

### 6. Utilisation du Template

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

### 7. Création de Schémas ASCII

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

### 8. Sauvegarde du Fichier

Utilise le tool `Write` pour créer:
```
ressources/videos/[slug].md
```

### 9. Mapping Tags → Thèmes

Analyser les tags générés à l'étape 4.e et identifier les thèmes pertinents :

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
- Une vidéo peut correspondre à **plusieurs thèmes**
- Privilégier les thèmes explicites (ex: `#mcp` → `7-mcp`)
- Pour tags génériques (`#workflow`), analyser le contenu pour déterminer les thèmes
- Minimum 1 thème, maximum 3 thèmes par vidéo

**Exemple** :
- Tags : `#skills` `#mcp` `#subagents` `#comparison`
- Thèmes détectés : `4-skills`, `5-agents`, `7-mcp`

### 10. Ajout Automatique aux Cheatsheets

**APRÈS** avoir créé la fiche, ajouter automatiquement la ressource aux cheatsheets des thèmes identifiés :

**Pour chaque thème détecté à l'étape 9** :

1. **Lire le cheatsheet** :
   ```
   Read themes/{theme}/cheatsheet.md
   ```

2. **Localiser la section "### 🎥 Vidéos Recommandées"**

3. **Ajouter la nouvelle entrée avec Edit** :
   - Format : `- [Titre Vidéo](../../ressources/videos/{slug}.md) ([🔗 YouTube]({url})) - Auteur | Difficulté`
   - Sous-ligne descriptive (indentation 2 espaces) : `  - Résumé en 1 ligne`
   - Placer par ordre de difficulté : 🟢 Débutant, 🟡 Intermédiaire, 🟠 Avancé, 🔴 Expert

4. **Exemple d'ajout** :
   ```markdown
   ### 🎥 Vidéos Recommandées

   - [Formation Claude Code 2.0](../../ressources/videos/formation-claude-code-2-0-melvynx.md) ([🔗 YouTube](https://www.youtube.com/watch?v=bDr1tGskTdw)) - Melvynx | 🟢 Débutant
     - Setup complet et Memory
   - [Nouvelle Vidéo](../../ressources/videos/nouvelle-video-auteur.md) ([🔗 YouTube](https://youtube.com/watch?v=XXX)) - Auteur | 🟡 Intermédiaire
     - Description courte de la nouvelle vidéo
   ```

5. **Validation** :
   - Vérifier que le lien relatif est correct (`../../ressources/videos/`)
   - Vérifier que le formatage markdown est respecté
   - Vérifier qu'il n'y a pas de doublon dans la liste
   - Respecter l'ordre : Débutant → Intermédiaire → Avancé → Expert

6. **Output** :
   ```
   ✅ Vidéo ajoutée aux cheatsheets :
   - themes/4-skills/cheatsheet.md
   - themes/5-agents/cheatsheet.md
   - themes/7-mcp/cheatsheet.md
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

1. **supadata_transcript** : Extraction de transcription
   ```
   mcp__supadata-ai-mcp__supadata_transcript
   Parameters: {
     url: string,            // URL YouTube/TikTok/Instagram/Twitter
     lang?: string,         // Code langue ISO 639-1 (fr, en)
     text?: boolean,        // false pour obtenir les métadonnées
     mode?: "native" | "auto" | "generate",  // Mode de transcription
     chunkSize?: number     // Taille max par chunk
   }
   ```

2. **supadata_check_transcript_status** : Vérifier statut transcription asynchrone
   ```
   mcp__supadata-ai-mcp__supadata_check_transcript_status
   Parameters: {
     id: string  // Job ID retourné par supadata_transcript
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
❌ Erreur : URL vidéo invalide ou plateforme non supportée.
Plateformes supportées : YouTube, TikTok, Instagram, Twitter
Format YouTube : https://www.youtube.com/watch?v=xxxxx
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

**Si job transcription échoue** :
```
❌ Erreur : Le job de transcription a échoué après X tentatives.
Essayer avec mode: "generate" pour forcer la génération.
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

**Note** : Cette commande utilise désormais Supadata AI MCP pour l'extraction de transcriptions. Supadata supporte plusieurs plateformes vidéo (YouTube, TikTok, Instagram, Twitter) et offre une extraction robuste avec gestion asynchrone. La commande respecte scrupuleusement les guidelines du fichier `.claude/CLAUDE.md`.

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
