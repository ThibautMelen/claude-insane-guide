# 🟢 Niveau 1 : Découverte - Plugins Claude Code

> **Objectif** : Créer votre premier plugin et le tester avec une marketplace locale
>
> **Durée estimée** : 15 minutes
>
> **Prérequis** : Avoir Claude Code installé

---

## 🎯 Ce que vous allez apprendre

- ✅ Créer la structure minimale d'un plugin
- ✅ Écrire un `plugin.json` valide
- ✅ Ajouter une slash command
- ✅ Créer une marketplace locale
- ✅ Installer et tester votre plugin

---

## 📚 Exercice 1.1 : Premier Plugin avec Command

### 🎬 Contexte

Vous êtes développeur et vous voulez créer un plugin pour vous aider à générer du code boilerplate React rapidement.

### ✏️ Instructions

**Étape 1 : Créer la structure**

```bash
# Créer dossier plugin
mkdir mon-premier-plugin
cd mon-premier-plugin

# Créer structure minimale
mkdir -p .claude-plugin
mkdir commands
```

**Étape 2 : Créer plugin.json**

Créez le fichier `.claude-plugin/plugin.json` :

```json
{
  "name": "react-quickstart",
  "version": "1.0.0",
  "description": "Plugin pour démarrer rapidement avec React",
  "author": {
    "name": "Votre Nom"
  },
  "commands": ["./commands"]
}
```

**Étape 3 : Créer votre première command**

Créez le fichier `commands/composant-react.md` :

```markdown
---
name: composant-react
description: Créer un composant React fonctionnel avec TypeScript
---

Crée un composant React fonctionnel avec :

1. **TypeScript** avec interface Props
2. **Fichier .module.css** associé
3. **Export** par défaut

Demande-moi le nom du composant, puis génère :
- `NomComposant.tsx`
- `NomComposant.module.css`
- Export dans `index.ts` si présent

Utilise les conventions :
- PascalCase pour le nom
- Props interface nommée `NomComposantProps`
- CSS Modules pour styles
```

**Étape 4 : Vérifier la structure**

```bash
# Votre structure doit ressembler à :
mon-premier-plugin/
├── .claude-plugin/
│   └── plugin.json
└── commands/
    └── composant-react.md

# Vérifier JSON valide
cat .claude-plugin/plugin.json | jq .
```

### ✅ Validation

Votre plugin est prêt si :
- ✅ `.claude-plugin/plugin.json` existe et est valide JSON
- ✅ Le champ `name` est présent
- ✅ `commands/composant-react.md` existe avec frontmatter
- ✅ Pas d'erreur avec `jq`

---

## 📚 Exercice 1.2 : Marketplace Locale

### 🎬 Contexte

Vous voulez tester votre plugin localement avant de le partager.

### ✏️ Instructions

**Étape 1 : Créer marketplace**

```bash
# Remonter d'un niveau
cd ..

# Créer marketplace test
mkdir ma-marketplace-test
cd ma-marketplace-test
```

**Étape 2 : Copier votre plugin**

```bash
# Copier le plugin dans la marketplace
cp -r ../mon-premier-plugin ./
```

**Étape 3 : Créer marketplace.json**

Créez `marketplace.json` :

```json
{
  "name": "mes-outils-dev",
  "owner": {
    "name": "Votre Nom"
  },
  "description": "Mes outils de développement personnels",
  "plugins": [
    {
      "name": "react-quickstart",
      "source": "./mon-premier-plugin",
      "description": "Helpers React",
      "version": "1.0.0"
    }
  ]
}
```

**Étape 4 : Vérifier la structure**

```bash
# Structure finale :
ma-marketplace-test/
├── marketplace.json
└── mon-premier-plugin/
    ├── .claude-plugin/
    │   └── plugin.json
    └── commands/
        └── composant-react.md

# Valider JSON
cat marketplace.json | jq .
```

### ✅ Validation

Votre marketplace est prête si :
- ✅ `marketplace.json` valide
- ✅ `plugins[]` contient votre plugin
- ✅ `source` pointe vers `./mon-premier-plugin`
- ✅ Plugin copié dans marketplace

---

## 📚 Exercice 1.3 : Installation et Test

### 🎬 Contexte

Testez votre plugin dans Claude Code !

### ✏️ Instructions

**Étape 1 : Ajouter la marketplace**

Dans Claude Code :

```bash
/plugin marketplace add /chemin/absolu/vers/ma-marketplace-test
```

**💡 Astuce** : Utilisez `pwd` dans le terminal pour obtenir le chemin absolu :
```bash
cd ma-marketplace-test
pwd
# Copiez ce chemin
```

**Étape 2 : Lister marketplaces**

```bash
/plugin marketplace list

# Vous devriez voir "mes-outils-dev"
```

**Étape 3 : Installer votre plugin**

```bash
/plugin install react-quickstart@mes-outils-dev

# Ou si c'est votre marketplace par défaut :
/plugin install react-quickstart
```

**Étape 4 : Vérifier installation**

```bash
/plugin list

# Vous devriez voir :
# ✅ react-quickstart (enabled)
```

**Étape 5 : Tester la command !**

```bash
/composant-react

# Claude devrait vous demander le nom du composant
# Répondez par exemple : "UserProfile"
```

### ✅ Validation

Le test est réussi si :
- ✅ Marketplace ajoutée sans erreur
- ✅ Plugin installé avec succès
- ✅ `/composant-react` reconnu par Claude
- ✅ Claude génère fichiers `.tsx` et `.module.css`

---

## 🎓 Points Clés de Niveau 1

### 📐 Structure Minimale

```
Plugin minimal = 2 fichiers :
1. .claude-plugin/plugin.json  (juste "name" requis)
2. commands/ma-command.md      (avec frontmatter)
```

### 📝 plugin.json Essentiel

```json
{
  "name": "mon-plugin"  ← Seul champ OBLIGATOIRE
}
```

Tout le reste est optionnel !

### 🏪 Marketplace Locale

```json
{
  "plugins": [{
    "name": "nom-plugin",
    "source": "./chemin-relatif"  ← Chemin local
  }]
}
```

Parfait pour développement et tests.

### ⚡ Commandes Essentielles

```bash
/plugin marketplace add ./chemin   # Ajouter
/plugin install nom@marketplace    # Installer
/plugin list                       # Lister
/nom-command                       # Utiliser
```

---

## 🚀 Bonus : Aller Plus Loin

### Bonus 1 : Ajouter une 2ème Command

Créez `commands/hook-react.md` :

```markdown
---
name: hook-react
description: Créer un custom React hook
---

Crée un custom hook React avec :
- TypeScript
- Tests Jest
- Documentation JSDoc
- Exemple d'utilisation
```

**Pas besoin de modifier plugin.json** ! Claude charge automatiquement tous les `.md` dans `commands/`.

### Bonus 2 : Versionner

```bash
cd mon-premier-plugin
git init
git add .
git commit -m "feat: initial plugin"
git tag v1.0.0
```

Prêt pour GitHub !

### Bonus 3 : Modifier le Plugin

```bash
# Éditer commands/composant-react.md
# Ajouter tests Jest au template

# Mettre à jour version
# plugin.json : "version": "1.0.1"

# Dans Claude Code
/plugin update react-quickstart
```

---

## ✏️ Mini-Défi

**Créez un deuxième plugin** avec une command de votre choix :

Idées :
- `/api-endpoint` - Créer endpoint Express/Next.js
- `/test-unitaire` - Générer tests Jest
- `/readme` - Créer README.md projet
- `/gitignore` - Générer .gitignore par stack

**Structure** :
1. Nouveau dossier plugin
2. `.claude-plugin/plugin.json`
3. `commands/votre-command.md`
4. Ajoutez à `marketplace.json`
5. Installez et testez !

---

## 🎯 Résumé Niveau 1

**Ce que vous maîtrisez maintenant** :

✅ Structure minimale plugin (`.claude-plugin/plugin.json`)
✅ Créer commands avec frontmatter
✅ Marketplace locale pour tests
✅ Installation et utilisation plugins
✅ Commandes CLI de base

**Prochaine étape** :
➡️ [🟡 Niveau 2 - Multi-composants](./niveau-2.md) : Agents + Hooks + GitHub

**Temps investi** : 15 minutes
**Compétence acquise** : Création plugin basique ✨

---

**🎉 Félicitations !** Vous avez créé votre premier plugin Claude Code !

[← Retour Guide](../guide.md) | [Niveau 2 →](./niveau-2.md)
