# 🔧 Commands - Cheatsheet

> **Référence rapide pour Slash Commands Claude Code**

📄 **Docs** : [Claude Code Commands](https://docs.claude.com/en/docs/claude-code/slash-commands)

---

## ⚡ Quick Start

### Command Minimale

```markdown
---
name: hello
description: Say hello
---

Dis bonjour à l'utilisateur de manière amicale.
```

**Usage** : `/hello`

---

## 📂 Localisations

| Type | Path | Usage |
|------|------|-------|
| **Projet** | `.claude/commands/` | Partagé avec équipe (Git) |
| **Personnel** | `~/.claude/commands/` | Local, non versionné |

---

## 📝 Structure Fichier

```markdown
---
name: nom-command              # ✅ Requis - kebab-case
description: Description       # ✅ Requis - courte
arguments:
  - name: arg1                 # ❌ Optionnel
    description: Description
    required: true
---

[Prompt en markdown]

## Variables
- `{arg1}` → Arguments
- Markdown complet supporté
```

---

## 🎯 Templates Courants

### 🟢 Simple Command

```markdown
---
name: test
description: Run tests
---

Lance les tests du projet avec npm test et affiche les résultats.
```

### 🟡 Command avec Argument

```markdown
---
name: create-page
description: Créer une nouvelle page
arguments:
  - name: pageName
    description: Nom de la page
    required: true
---

Crée une nouvelle page **{pageName}** avec :
- Component React/Next.js
- Routing automatique
- Tests unitaires
```

**Usage** : `/create-page contact`

### 🟠 Command avec Workflow

```markdown
---
name: epct
description: Workflow EPCT complet
arguments:
  - name: feature
    description: Feature à implémenter
    required: true
---

# EPCT Workflow : {feature}

**E** - Explore le code existant
**P** - Plan détaillé avant implémentation
**C** - Code avec best practices
**T** - Tests et validation

## Étapes
1. Explore architecture
2. Propose plan
3. Implémente code
4. Crée tests
5. Valide résultat
```

---

## 🔥 Exemples Pratiques

### Frontend

```markdown
/create-component Button    # Créer composant
/create-hook useAuth       # Créer custom hook
/create-context Theme      # Créer Context
```

### Backend

```markdown
/create-api users          # Créer endpoint API
/create-migration AddUsers # Créer migration DB
/deploy staging            # Déployer staging
```

### Testing

```markdown
/generate-tests Button.tsx # Générer tests
/coverage                  # Vérifier coverage
/e2e login                 # Tests E2E
```

---

## 💡 Best Practices

✅ **DO** :
- Noms kebab-case : `create-api` ✅
- Descriptions claires
- Arguments documentés
- Markdown structuré
- Workflows réutilisables

❌ **DON'T** :
- camelCase : `createApi` ❌
- Descriptions vagues
- Prompts trop longs
- Duplication de code

---

## 🚀 Organisation

### Par Domaine

```
.claude/commands/
├── frontend/
│   ├── create-component.md
│   └── create-hook.md
├── backend/
│   ├── create-api.md
│   └── create-migration.md
└── testing/
    ├── generate-tests.md
    └── e2e.md
```

### Par Workflow

```
.claude/commands/
├── setup-project.md
├── feature-epct.md
├── bug-fix.md
└── refactor.md
```

---

## 🔧 Debug Commands

```bash
# Lister commands disponibles
/help

# Voir contenu command
cat .claude/commands/ma-command.md

# Valider frontmatter
# Vérifier --- en début/fin
# Pas de tabs, que des espaces
```

---

## 📦 Packs Commands

**Weston Hobson** : https://github.com/wshobson/commands
- `commit.md` - Smart commits
- `refactor.md` - Code refactoring
- `optimize.md` - Performance

**Edmund Yong** : https://github.com/edmund-io/edmunds-claude-code
- `/epct` - Explore/Plan/Code/Test
- `/fix` - Debug & fix
- `/doc` - Documentation

---

## 🔗 Ressources

- 📖 [Guide Complet](./guide.md)
- 🧪 [Exercices](./exercices/niveau-1.md)
- 📄 [Docs Officielles](https://docs.claude.com/en/docs/claude-code/slash-commands)

---

**💡 Tip** : Commence par EPCT, c'est le workflow le plus puissant ! 🚀
