# Mémoire du Projet - Claude Anthropic Compréhension

## 🎯 Contexte du Projet

Ce projet est un **guide d'apprentissage complet** sur Claude Code et l'écosystème Anthropic.

**Objectif** : Maîtriser Claude Code à travers documentation structurée, cheatsheets pratiques et exercices progressifs.

**Public** : Développeurs francophones apprenant Claude Code de débutant à expert.

## 📝 Style de Documentation

### ✅ Règles d'Écriture

**Ton & Communication** :
- 🗣️ Ton **amical et pédagogue**
- 💡 Expliquer le **"pourquoi"** derrière les solutions
- 📊 Toujours donner des **exemples concrets**
- 🎓 Progressif : du simple au complexe
- 🇫🇷 Français clair et accessible

**Structure de Document** :
```
Chaque guide contient obligatoirement :

📚 THÉORIE
   └─> Concepts fondamentaux expliqués
   └─> Problèmes résolus
   └─> Cas d'usage réels

📋 CHEATSHEET
   └─> Référence rapide
   └─> Syntaxe essentielle
   └─> Quick commands

✏️ EXERCICES
   └─> 🟢 Niveau 1 : Découverte (10-15 min)
   └─> 🟡 Niveau 2 : Utilisation (15-20 min)
   └─> 🟠 Niveau 3 : Maîtrise (20-25 min)
   └─> 🔴 Niveau 4 : Expert (25-30 min) [fichiers majeurs]

🎓 POINTS CLÉS
   └─> Résumé concepts essentiels
   └─> Best practices
   └─> Erreurs à éviter
```

### 🎨 Schémas ASCII - OBLIGATOIRES

**Utilise systématiquement des schémas visuels** :

#### Box Diagrams
```
╔═══════════════════════════════╗
║  Headers importants           ║
╚═══════════════════════════════╝

┌───────────────────────────────┐
│  Boxes simples                │
└───────────────────────────────┘
```

#### Tree Structures
```
📦 Projet/
┣━━ 📁 dossier1/
┃   ┣━━ 📄 fichier1.md
┃   ┗━━ 📄 fichier2.md
┗━━ 📁 dossier2/
    ┗━━ 📄 fichier3.md
```

#### Flows & Pyramides
```
Pyramide de priorité :
        ╔═══════════╗
        ║  NIVEAU 1 ║
        ╚═══════════╝
              ▼
        ┌───────────┐
        │  NIVEAU 2 │
        └───────────┘
              ▼
        ┌───────────┐
        │  NIVEAU 3 │
        └───────────┘

Flow linéaire :
┌─────┐    ┌─────┐    ┌─────┐
│ A   │───>│ B   │───>│ C   │
└─────┘    └─────┘    └─────┘
```

### 🎯 Emojis - Utilisation Pertinente

**Symboles par Contexte** :

**🏗️ Structure & Organisation** :
- 📦 Projet/Package
- 📁 Dossier
- 📄 Fichier
- 🗂️ Organisation
- 📋 Liste/Checklist

**👥 Acteurs & Rôles** :
- 👤 User/Personnel
- 🏢 Enterprise/Entreprise
- 👥 Équipe/Team
- 🤖 AI/Claude
- 💎 Gemini
- 💬 ChatGPT

**⚙️ Technique** :
- ⚡ Quick/Rapide
- 🔧 Config/Outils
- 🔌 Plugins/Extensions
- 🧠 Memory/Mémoire
- ⚙️ Settings
- 🔒 Sécurité

**📊 Workflow & État** :
- ✅ Do/Correct
- ❌ Don't/Incorrect
- ⚠️ Warning/Attention
- 💡 Tip/Astuce
- 🎯 Objectif/Goal
- 🚀 Performance/Boost
- 📈 Progress/Progression

**🎓 Apprentissage** :
- 🟢 Niveau 1 - Découverte
- 🟡 Niveau 2 - Utilisation
- 🟠 Niveau 3 - Maîtrise
- 🔴 Niveau 4 - Expert

**⭐ Priorité & Importance** :
- ⭐ Recommandé
- 🌟 Très important
- 💪 Avancé
- 🔥 Hot/Trending

## 📐 Règles de Formatage

### Code Blocks

**Toujours spécifier le langage** :
```markdown
Bon ✅ :
```bash
command here
\```

```typescript
code here
\```

Mauvais ❌ :
```
code sans langage
\```
```

### Liens & Références

**Format des liens** :
- 📄 Docs officielles : `[Texte](URL)` + emoji 📄
- 📹 Vidéos : `[Titre Vidéo](URL)` + timestamp si pertinent
- 🔗 Cross-refs internes : `[Voir Commands](../commands/guide.md)`

### Hiérarchie Titres

```
# Titre Principal (H1)
## Section Majeure (H2)
### Sous-section (H3)
#### Détail (H4)
```

**Limiter à H4 maximum** pour garder clarté.

## 🛠️ Stack Technique du Projet

**Langues** :
- 🇫🇷 Français (principal)
- 📝 Markdown (documentation)

**Format Documentation** :
- Markdown (.md)
- YAML (frontmatter commands)
- Bash (exemples scripts)

**Outils Claude Code** :
- Memory (.claude/CLAUDE.md) ⭐
- Commands (.claude/commands/*.md)
- MCP Servers (convention npm-like)
- Plugins
- Sub-Agents

## ⚠️ Required MCP Servers

Ce projet de documentation **ne nécessite AUCUN MCP server** pour fonctionner.

**Convention MCP adoptée** : Global install + documentation projet (voir [themes/4-mcp/guide.md](../themes/4-mcp/guide.md))

**Pourquoi pas de MCP ici ?**
- Projet documentation pure (Markdown)
- Pas d'intégration externe
- Pas de base de données
- Pas d'API

**Si tu ajoutes des MCP à tes projets personnels**, documente-les ici selon la convention :

```markdown
## ⚠️ Required MCP Servers

### [Server Name] ([Purpose])

Add to `~/.config/claude-code/config.json`:
\```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@scope/mcp-server"],
      "env": {"API_KEY": "from-1password"}
    }
  }
}
\```

**Why**: [Explication]
**Verify**: Check `mcp__server-name__tool` in Claude
```

## 📋 Checklist Création Document

Avant de créer/modifier un document, vérifier :

- [ ] ✅ Structure respectée (Théorie → Cheatsheet → Exercices → Points Clés)
- [ ] ✅ Schémas ASCII présents (minimum 3 par document)
- [ ] ✅ Emojis pertinents utilisés
- [ ] ✅ Exemples concrets fournis
- [ ] ✅ Code blocks avec langage spécifié
- [ ] ✅ Exercices progressifs (🟢→🟡→🟠→🔴)
- [ ] ✅ Ton amical et pédagogue
- [ ] ✅ Points clés résumés en fin
- [ ] ✅ Liens vers ressources officielles
- [ ] ✅ Cross-références vers autres docs

## 🎯 Best Practices Spécifiques

### DO ✅

**1. Clarté avant tout**
```
✅ "Créer .claude/CLAUDE.md avec vos préférences"
❌ "Configurez le fichier de mémoire"
```

**2. Exemples visuels**
```
Toujours montrer AVANT/APRÈS :

❌ Avant :
[problème]

✅ Après :
[solution]
```

**3. Progressive disclosure**
```
Simple → Avancé → Expert
Pas tout d'un coup !
```

**4. Contexte réel**
```
✅ "Pour un projet Next.js 14 avec Supabase..."
❌ "Pour un projet web..."
```

### DON'T ❌

**1. Pas de jargon non expliqué**
```
❌ "Utilisez le MCP"
✅ "Utilisez MCP (Model Context Protocol) pour..."
```

**2. Pas de murs de texte**
```
❌ Paragraphe de 200 mots
✅ Listes à puces + schémas
```

**3. Pas d'exemples abstraits**
```
❌ "Créez une fonction foo()"
✅ "Créez une fonction validateEmail()"
```

**4. Pas de répétition**
```
Si expliqué ailleurs → lien
Pas copier/coller
```

## 🔄 Workflow de Contribution

### Ajout Nouveau Thème

```
1️⃣ Créer structure
   themes/nom-theme/
   ├── guide.md
   ├── cheatsheet.md
   └── exercices/
       ├── niveau-1.md
       ├── niveau-2.md
       └── niveau-3.md

2️⃣ Rédiger guide.md
   - Suivre template (Théorie/Cheatsheet/Exercices/Points Clés)
   - Minimum 3 schémas ASCII
   - Exemples concrets

3️⃣ Créer cheatsheet.md
   - Référence rapide
   - Syntaxe essentielle
   - Quick commands

4️⃣ Écrire exercices
   - Progressifs (🟢→🟡→🟠)
   - Temps estimé
   - Objectifs clairs

5️⃣ Mettre à jour README.md
   - Ajouter dans navigation
   - Temps estimé global
```

## 📚 Références du Projet

### Documentation Sources

- 📄 **Claude Code Docs** : https://code.claude.com/docs
- 📄 **Memory** : https://code.claude.com/docs/memory
- 📄 **Commands** : https://code.claude.com/docs/slash-commands
- 📄 **MCP** : https://modelcontextprotocol.io/

### Vidéos Analysées

- 🎥 **NetworkChuck** - Terminal AI Workflow (33 min)
- 🎥 **Solo Swift Crafter** - Skills vs MCP vs Subagents (9 min)
- 🎥 **Edmund Yong** - 800h Claude Code (27 oct 2025)

### Repos Communauté

- 🔗 **Weston Hobson Commands** : https://github.com/wshobson/commands
- 🔗 **Edmund Yong Setup** : https://github.com/edmund-io/edmunds-claude-code
- 🔗 **Awesome Sub-Agents** : https://github.com/VoltAgent/awesome-claude-code-subagents

## 🎓 Philosophie du Projet

**Mission** : Rendre Claude Code accessible et maîtrisable par tous les développeurs francophones.

**Principes** :
1. 🎯 **Progressivité** : Du débutant à l'expert, pas de raccourcis
2. 💡 **Pratique** : Exercices concrets, pas que théorie
3. 🎨 **Visuel** : Schémas ASCII, emojis, clarté maximale
4. 🇫🇷 **Accessibilité** : Français clair, exemples du quotidien
5. 📚 **Complétude** : Tous les aspects de Claude Code couverts
6. 🔄 **Maintenu** : À jour avec dernières versions

**Quote Inspirante** :
> "D.R.Y. (Don't Repeat Yourself) - Let Claude remember your preferences"
> — Edmund Yong (800h Claude Code)

---

## 🚀 Prochaines Étapes

**Maintenez ce fichier à jour** quand :
- ✨ Nouveau style de documentation adopté
- 📝 Nouvelle règle de formatage
- 🎯 Changement philosophie projet
- 🔧 Nouveau workflow ajouté

**Ce CLAUDE.md guide TOUTE la documentation du projet !**
