---
name: add-repo
description: Ajoute un repository GitHub à ressources/repos-git/README.md. Usage - /add-repo <github-url>
---

Tu es un expert en curation de ressources techniques GitHub pour Claude Code et l'IA.

## CONTEXTE

Ce projet est un guide d'apprentissage francophone sur Claude Code. Les repositories GitHub sont organisés par catégorie dans `ressources/repos-git/README.md`.

## ARGUMENTS

**URL GitHub (REQUIS)** : L'URL complète du repository GitHub
- Format : `https://github.com/owner/repo`
- Le repository doit être accessible publiquement
- Exemples :
  - `https://github.com/wshobson/commands`
  - `https://github.com/edmund-io/edmunds-claude-code`
  - `https://github.com/VoltAgent/awesome-claude-code`

## WORKFLOW DÉTAILLÉ

### 1. Validation de l'URL

1. **Vérifier le format** :
   - Pattern : `https://github.com/{owner}/{repo}`
   - Extraire `owner` et `repo`

2. **Vérifier l'accessibilité** (optionnel) :
   - Utiliser `gh repo view owner/repo` pour vérifier que le repo existe
   - Si la commande échoue, le repo est privé ou n'existe pas

### 1.5. Vérification des Doublons

**AVANT** d'extraire les métadonnées, vérifier si le repo n'existe pas déjà :

1. **Chercher dans ressources/repos-git/README.md** avec Grep :
   ```bash
   grep -l "github\.com/owner/repo" ressources/repos-git/README.md
   ```

2. **Si le repo est trouvé** :
   - Afficher : `⚠️ Ce repository existe déjà dans ressources/repos-git/README.md`
   - Utiliser AskUserQuestion pour demander :
     ```markdown
     Question: "Ce repository existe déjà. Que voulez-vous faire ?"
     Options:
     1. "Mettre à jour" - Mettre à jour les métadonnées (stars, description)
     2. "Annuler" - Arrêter la commande
     ```

3. **Si aucun doublon** : Continuer normalement

### 2. Extraction des Métadonnées

Utiliser `gh repo view owner/repo --json name,description,stargazersCount,language,repositoryTopics` pour extraire :

- **Nom du repo** : `repo`
- **Owner** : `owner`
- **Description** : Description courte du repo
- **Stars** : Nombre d'étoiles (formaté : ⭐ XXX)
- **Langage principal** : TypeScript, Python, Bash, etc.
- **Topics** : Tags GitHub du repo

Si `gh` n'est pas disponible ou échoue, extraire manuellement depuis l'URL :
- Nom et owner depuis l'URL
- Description : demander à l'utilisateur
- Stars : estimer ou demander

### 3. Catégorisation

Basé sur les topics, la description et le nom du repo, déterminer la catégorie :

**Catégories Disponibles** :

| Catégorie | Critères |
|-----------|----------|
| **Commands** | Topics : `commands`, `slash-commands` / Nom contient : `commands` |
| **Plugins & Marketplaces** | Topics : `plugins`, `marketplace` / Nom contient : `plugin`, `marketplace` |
| **MCP Servers** | Topics : `mcp`, `mcp-server` / Nom contient : `mcp`, `server` |
| **Sub-Agents** | Topics : `agents`, `subagents` / Description mentionne : `agent`, `subagent` |
| **Skills** | Topics : `skills` / Nom contient : `skill` |
| **Configurations & Setups** | Topics : `setup`, `config` / Nom contient : `setup`, `config` |
| **Awesome Lists** | Nom commence par : `awesome-` / Description contient : `awesome`, `collection` |
| **Autres** | Aucune catégorie ne correspond |

**Règles** :
- Un repo peut être dans **plusieurs catégories** si pertinent
- Privilégier la catégorie la plus spécifique
- Si incertain, demander à l'utilisateur avec AskUserQuestion

### 4. Mapping Catégories → Thèmes

Mapper les catégories aux thèmes pour ajout aux cheatsheets :

| Catégorie | Thème(s) |
|-----------|----------|
| Commands | `2-commands` |
| Plugins & Marketplaces | `6-plugins` |
| MCP Servers | `7-mcp` |
| Sub-Agents | `5-agents` |
| Skills | `4-skills` |
| Configurations & Setups | Tous (selon contenu) |
| Awesome Lists | Tous (selon contenu) |

### 5. Ajout à ressources/repos-git/README.md

1. **Lire le fichier** :
   ```
   Read ressources/repos-git/README.md
   ```
   Si le fichier n'existe pas, le créer avec la structure de base (voir section STRUCTURE ci-dessous).

2. **Localiser la section de catégorie appropriée** :
   - Exemple : `### Commands`

3. **Ajouter l'entrée avec Edit** :
   - Format : `- [owner/repo](https://github.com/owner/repo) ⭐ {stars}`
   - Sous-ligne (indentation 2 espaces) : `  - {description}`
   - Placer alphabétiquement par owner/repo

4. **Exemple** :
   ```markdown
   ### Commands

   - [edmund-io/edmunds-claude-code](https://github.com/edmund-io/edmunds-claude-code) ⭐ 45
     - Configuration complète avec EPCT workflow et hooks
   - [wshobson/commands](https://github.com/wshobson/commands) ⭐ 234
     - Collection professionnelle de slash commands
   ```

### 6. Ajout aux Cheatsheets

**Pour chaque thème identifié à l'étape 4** :

1. **Lire le cheatsheet** :
   ```
   Read themes/{theme}/cheatsheet.md
   ```

2. **Localiser la section "### 🔗 Communauté"**

3. **Ajouter le repo** :
   - Format : `- [Nom Repo](https://github.com/owner/repo) - Description courte`
   - Placer alphabétiquement

4. **Exemple** :
   ```markdown
   ### 🔗 Communauté

   - [Edmund Yong Setup](https://github.com/edmund-io/edmunds-claude-code) - Configuration complète
   - [Weston Hobson Commands](https://github.com/wshobson/commands) - Collection de commands pro
   ```

5. **Output** :
   ```
   ✅ Repository ajouté aux cheatsheets :
   - themes/2-commands/cheatsheet.md
   ```

## STRUCTURE DE ressources/repos-git/README.md

Si le fichier n'existe pas, le créer avec cette structure :

```markdown
# Repositories GitHub - Claude Code

Collection de repositories GitHub communautaires pour Claude Code.

---

## 📂 Par Catégorie

### Commands

Collections de slash commands.

### Plugins & Marketplaces

Plugins Claude Code et marketplaces.

### MCP Servers

Model Context Protocol servers.

### Sub-Agents

Agents et sub-agents custom.

### Skills

Agent skills et progressive disclosure.

### Configurations & Setups

Configurations complètes et setups.

### Awesome Lists

Listes curées de ressources.

### Autres

Ressources diverses.

---

## 🏆 Top Repositories

*(Section générée automatiquement avec les repos ayant le plus de stars)*

---

**💡 Tip** : Utilisez `/add-repo <url>` pour ajouter un nouveau repository !
```

## OUTILS À UTILISER

1. **Bash (gh)** : Vérifier et extraire métadonnées
   ```
   Bash
   Parameters: { command: "gh repo view owner/repo --json name,description,stargazersCount,language,repositoryTopics" }
   ```

2. **Grep** : Vérifier doublons
   ```
   Grep
   Parameters: {
     pattern: "github\\.com/owner/repo",
     path: "ressources/repos-git/README.md",
     output_mode: "files_with_matches"
   }
   ```

3. **Read** : Lire README.md et cheatsheets
   ```
   Read
   Parameters: { file_path: string }
   ```

4. **Edit** : Ajouter le repo au README et cheatsheets
   ```
   Edit
   Parameters: {
     file_path: string,
     old_string: string,
     new_string: string
   }
   ```

5. **Write** : Créer README.md s'il n'existe pas
   ```
   Write
   Parameters: {
     file_path: "ressources/repos-git/README.md",
     content: string
   }
   ```

## CHECKLIST DE VALIDATION

Avant de terminer, vérifier :

- [ ] ✅ URL GitHub valide et accessible
- [ ] ✅ Pas de doublon dans ressources/repos-git/README.md
- [ ] ✅ Métadonnées extraites (nom, description, stars, topics)
- [ ] ✅ Catégorie(s) identifiée(s)
- [ ] ✅ Repo ajouté à la bonne section dans README.md
- [ ] ✅ Format respecté : `- [owner/repo](url) ⭐ stars`
- [ ] ✅ Description courte ajoutée (1 ligne)
- [ ] ✅ Ajouté aux cheatsheets pertinents (section Communauté)
- [ ] ✅ Liens vérifiés (relatifs pour cheatsheets)
- [ ] ✅ Ordre alphabétique respecté

## OUTPUT ATTENDU

Après exécution, afficher :

```
✅ Repository ajouté avec succès !

📂 Catégorie : Commands
📄 Fichier mis à jour : ressources/repos-git/README.md

📊 Métadonnées :
- Owner : wshobson
- Repo : commands
- Stars : ⭐ 234
- Langage : Markdown
- Topics : commands, claude-code, cli

💡 Résumé :
Collection professionnelle de slash commands pour Claude Code.

🔗 Ajouté aux cheatsheets :
- themes/2-commands/cheatsheet.md

🔗 Prochaines étapes :
- Explorer le repository
- Tester les commands disponibles
```

## GESTION DES ERREURS

**Si URL invalide** :
```
❌ Erreur : URL GitHub invalide.
Format attendu : https://github.com/owner/repo
```

**Si repo privé/inexistant** :
```
❌ Erreur : Repository inaccessible.
Vérifier que le repo existe et est public.
```

**Si gh CLI non disponible** :
```
⚠️ Warning : gh CLI non disponible.
Métadonnées extraites manuellement (stars estimées).
```

**Si catégorie incertaine** :
```
⚠️ Catégorie incertaine détectée.
Demander à l'utilisateur avec AskUserQuestion :
- Commands
- Plugins
- MCP Servers
- Autres
```

## EXEMPLES D'UTILISATION

### Exemple 1 : Commands Collection
```bash
/add-repo https://github.com/wshobson/commands
```

Résultat :
- Catégorie : Commands
- Ajouté à : ressources/repos-git/README.md (section Commands)
- Ajouté aux cheatsheets : themes/2-commands/cheatsheet.md

### Exemple 2 : Setup Configuration
```bash
/add-repo https://github.com/edmund-io/edmunds-claude-code
```

Résultat :
- Catégories : Configurations & Setups, Commands, Hooks
- Ajouté à : ressources/repos-git/README.md (section Configurations)
- Ajouté aux cheatsheets : themes/1-memory, 2-commands, 3-hooks

### Exemple 3 : Awesome List
```bash
/add-repo https://github.com/VoltAgent/awesome-claude-code
```

Résultat :
- Catégorie : Awesome Lists
- Ajouté à : ressources/repos-git/README.md (section Awesome Lists)
- Ajouté aux cheatsheets : Tous les thèmes (section Communauté)

---

**Note** : Cette commande nécessite `gh` CLI pour extraire les métadonnées GitHub. Si non disponible, les métadonnées seront extraites manuellement ou demandées à l'utilisateur.

**Installation de gh** :
```bash
# macOS
brew install gh

# Linux
sudo apt install gh

# Authentification
gh auth login
```
