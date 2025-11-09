# 🟡 Niveau 2 : Filtrage & Patterns Avancés

> **Objectif** : Maîtriser le filtrage précis avec `tool` et `pattern` regex
>
> **Durée estimée** : 20-25 minutes

---

## 🎯 Ce que vous allez apprendre

- ✅ Filtrer hooks par type d'outil (`Edit`, `Bash`, `Read`)
- ✅ Utiliser patterns regex pour cibler fichiers spécifiques
- ✅ Créer des hooks pour différents types de fichiers
- ✅ Combiner filtres pour workflows précis

---

## 📋 Prérequis

- Niveau 1 terminé ✅
- Comprendre les bases de regex (`.`, `*`, `^`, `$`)
- Projet `~/claude-hooks-test/` du niveau 1

---

## 🚀 Exercice 1 : Filtrage par Extension

### Objectif

Créer des hooks différents selon l'extension du fichier modifié.

### Instructions

1. **Créer des fichiers de test**

```bash
cd ~/claude-hooks-test

# Créer différents types de fichiers
echo "console.log('app')" > app.js
echo "function test() {}" > utils.ts
echo "body { margin: 0 }" > styles.css
echo "# Title" > README.md
```

2. **Créer scripts spécialisés**

```bash
# Script pour JavaScript/TypeScript
cat > scripts/lint-js.sh << 'EOF'
#!/bin/bash
FILE=$1
echo "🔍 [JS/TS] Linting $FILE"
# Simuler eslint
echo "  ✅ No errors found"
EOF

# Script pour CSS
cat > scripts/lint-css.sh << 'EOF'
#!/bin/bash
FILE=$1
echo "🎨 [CSS] Checking $FILE"
# Simuler stylelint
echo "  ✅ Styles OK"
EOF

# Script pour Markdown
cat > scripts/lint-md.sh << 'EOF'
#!/bin/bash
FILE=$1
echo "📝 [MD] Validating $FILE"
# Simuler markdownlint
echo "  ✅ Markdown valid"
EOF

chmod +x scripts/*.sh
```

3. **Configuration avec patterns**

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(js|ts|jsx|tsx)$",
      "script": "bash scripts/lint-js.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.css$",
      "script": "bash scripts/lint-css.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.md$",
      "script": "bash scripts/lint-md.sh $FILE"
    }
  ]
}
```

4. **Tester**

Demandez à Claude de modifier chaque fichier :
- `app.js` → Hook lint-js
- `styles.css` → Hook lint-css
- `README.md` → Hook lint-md

### ✅ Validation

**Modification de `app.js`** :
```
🔍 [JS/TS] Linting /path/to/app.js
  ✅ No errors found
```

**Modification de `styles.css`** :
```
🎨 [CSS] Checking /path/to/styles.css
  ✅ Styles OK
```

### 💡 Explication

- `\\.(js|ts|jsx|tsx)$` → Fichiers JavaScript/TypeScript
- `\\.css$` → Fichiers CSS uniquement
- `\\.md$` → Fichiers Markdown uniquement
- Chaque pattern déclenche un hook spécifique

---

## 🚀 Exercice 2 : Filtrage par Dossier

### Objectif

Créer des hooks qui s'exécutent seulement pour certains dossiers.

### Instructions

1. **Créer structure projet**

```bash
mkdir -p src/components
mkdir -p src/utils
mkdir -p tests
mkdir -p config

# Fichiers
echo "export const Button = () => {}" > src/components/Button.tsx
echo "export const formatDate = () => {}" > src/utils/date.ts
echo "test('...', () => {})" > tests/Button.test.tsx
echo '{"key": "value"}' > config/settings.json
```

2. **Créer hooks par dossier**

```bash
# Hook pour components
cat > scripts/lint-component.sh << 'EOF'
#!/bin/bash
FILE=$1
FILENAME=$(basename $FILE)
echo "⚛️ [COMPONENT] Validating React component: $FILENAME"
echo "  ✅ Component structure OK"
echo "  ✅ No prop-types warnings"
EOF

# Hook pour tests
cat > scripts/run-test.sh << 'EOF'
#!/bin/bash
FILE=$1
FILENAME=$(basename $FILE)
echo "🧪 [TEST] Running tests in: $FILENAME"
echo "  ✅ All tests passed"
EOF

# Hook pour config
cat > scripts/validate-config.sh << 'EOF'
#!/bin/bash
FILE=$1
echo "⚙️ [CONFIG] Validating JSON: $FILE"
# Valider JSON
if jq . "$FILE" > /dev/null 2>&1; then
  echo "  ✅ Valid JSON"
else
  echo "  ❌ Invalid JSON syntax"
  exit 1
fi
EOF

chmod +x scripts/*.sh
```

3. **Configuration avec patterns de dossiers**

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/components/.*\\.(tsx|jsx)$",
      "script": "bash scripts/lint-component.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^tests/.*\\.test\\.(ts|tsx)$",
      "script": "bash scripts/run-test.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^config/.*\\.json$",
      "script": "bash scripts/validate-config.sh $FILE"
    }
  ]
}
```

4. **Tester chaque dossier**

Modifier des fichiers dans chaque dossier et vérifier les hooks appropriés.

### ✅ Validation

**`src/components/Button.tsx`** :
```
⚛️ [COMPONENT] Validating React component: Button.tsx
  ✅ Component structure OK
```

**`tests/Button.test.tsx`** :
```
🧪 [TEST] Running tests in: Button.test.tsx
  ✅ All tests passed
```

**`config/settings.json`** :
```
⚙️ [CONFIG] Validating JSON: config/settings.json
  ✅ Valid JSON
```

### 💡 Explication

- `^src/components/` → Commence par ce chemin
- `.*\\.test\\.` → Contient `.test.`
- Combiner path + extension = ciblage précis

---

## 🚀 Exercice 3 : Hooks sur Différents Outils

### Objectif

Créer des hooks pour différents types d'outils (Edit, Bash, Read).

### Instructions

1. **Configuration multi-outils**

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "echo '✏️ Fichier modifié : $FILE'"
    },
    {
      "event": "PostToolUse",
      "tool": "Bash",
      "script": "echo '🔧 Commande bash exécutée : $TOOL'"
    },
    {
      "event": "PostToolUse",
      "tool": "Read",
      "script": "echo '👁️ Fichier lu : $FILE'"
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git push",
      "script": "echo '⚠️ Vérification avant git push...'"
    }
  ]
}
```

2. **Tester chaque outil**

Demandez à Claude :
- Modifier un fichier → Hook `Edit`
- Exécuter `ls` → Hook `Bash`
- Lire un fichier → Hook `Read`
- `git push` → Hook `PreToolUse`

### ✅ Validation

Chaque action déclenche son hook approprié.

### 💡 Explication

- `tool` filtre par type d'outil Claude
- `PreToolUse` + pattern = validation avant exécution
- Utile pour auditer toutes les actions

---

## 🚀 Exercice 4 : Workflow Frontend Complet

### Objectif

Créer un workflow automatisé pour projet React/Next.js.

### Instructions

1. **Structure projet frontend**

```bash
mkdir -p src/{components,pages,hooks,utils,styles}
mkdir -p public

# Fichiers exemples
echo "export default function Home() {}" > src/pages/index.tsx
echo "export const useAuth = () => {}" > src/hooks/useAuth.ts
echo ".button { padding: 10px }" > src/styles/button.css
```

2. **Scripts workflow**

```bash
# Prettier auto-format
cat > scripts/format.sh << 'EOF'
#!/bin/bash
FILE=$1
echo "💅 [PRETTIER] Formatting $FILE"
# prettier --write "$FILE" 2>/dev/null || echo "  ⏭️ Prettier not installed (OK for demo)"
echo "  ✅ Formatted"
EOF

# ESLint check
cat > scripts/eslint.sh << 'EOF'
#!/bin/bash
FILE=$1
echo "🔍 [ESLINT] Checking $FILE"
# eslint "$FILE" 2>/dev/null || echo "  ⏭️ ESLint not installed (OK for demo)"
echo "  ✅ No linting errors"
EOF

# Stylelint pour CSS
cat > scripts/stylelint.sh << 'EOF'
#!/bin/bash
FILE=$1
echo "🎨 [STYLELINT] Checking $FILE"
echo "  ✅ Styles valid"
EOF

# Tests unitaires
cat > scripts/test-related.sh << 'EOF'
#!/bin/bash
FILE=$1
TESTFILE="${FILE%.tsx}.test.tsx"
if [ -f "$TESTFILE" ]; then
  echo "🧪 [TESTS] Running tests for $FILE"
  echo "  ✅ Tests passed"
else
  echo "⏭️ No tests found for $FILE"
fi
EOF

chmod +x scripts/*.sh
```

3. **Configuration workflow complet**

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '⚛️ Frontend Workflow activé | Hooks: Format → Lint → Test'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/.*\\.(tsx|ts|jsx|js)$",
      "script": "bash scripts/format.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/.*\\.(tsx|ts)$",
      "script": "bash scripts/eslint.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/.*\\.css$",
      "script": "bash scripts/stylelint.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/(components|hooks)/.*\\.tsx$",
      "script": "bash scripts/test-related.sh $FILE"
    }
  ]
}
```

4. **Tester le workflow**

Modifier différents fichiers et observer la cascade de hooks :

```
Modification de src/components/Button.tsx
  ↓
💅 [PRETTIER] Formatting
  ↓
🔍 [ESLINT] Checking
  ↓
🧪 [TESTS] Running tests
  ↓
✅ Tout validé !
```

### ✅ Validation

Chaque type de fichier déclenche les hooks appropriés dans l'ordre.

---

## 🎓 Quiz de Validation

### Question 1
Quelle regex matche les fichiers `.tsx` et `.jsx` ?

- [ ] A) `.(tsx|jsx)$`
- [x] B) `\\.(tsx|jsx)$`
- [ ] C) `\\.tsx|jsx$`
- [ ] D) `.tsx|.jsx`

### Question 2
Comment cibler seulement les fichiers dans `src/components/` ?

- [x] A) `^src/components/`
- [ ] B) `src/components/`
- [ ] C) `*src/components/*`
- [ ] D) `/src/components/`

### Question 3
Quel outil est utilisé quand Claude lit un fichier ?

- [ ] A) Edit
- [ ] B) Bash
- [x] C) Read
- [ ] D) View

### Question 4
Comment combiner pattern de dossier + extension ?

- [ ] A) Deux hooks séparés
- [x] B) Une seule regex : `^src/.*\\.tsx$`
- [ ] C) Impossible
- [ ] D) Utiliser `&&` dans pattern

---

## 🏆 Challenge Bonus

### Workflow Backend Node.js

Créer un workflow pour projet Node.js/Express avec :

1. **Linting** sur fichiers `.ts` dans `src/`
2. **Validation** des migrations dans `migrations/`
3. **Tests** auto sur modifications dans `src/`
4. **Validation JSON** pour `package.json`

**Contraintes** :
- 4 hooks différents minimum
- Utiliser patterns regex précis
- Scripts externes pour chaque étape

### Solution (à essayer d'abord !)

<details>
<summary>Voir la solution</summary>

```json
{
  "hooks": [
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/.*\\.ts$",
      "script": "eslint --fix $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^migrations/.*\\.sql$",
      "script": "bash scripts/validate-migration.sh $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "^src/",
      "script": "npm test -- --findRelatedTests $FILE"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "package\\.json$",
      "script": "jq . $FILE && echo '✅ package.json valid'"
    }
  ]
}
```

</details>

---

## 📚 Ressources

- 📖 [Guide Hooks Complet](../guide.md)
- 📋 [Cheatsheet Regex](../cheatsheet.md#-patterns-regex-utiles)
- 🎯 [Niveau 3 : Hooks Bloquants](./niveau-3.md)

---

**🎉 Excellent !** Vous maîtrisez le filtrage des hooks. Passez au [Niveau 3](./niveau-3.md) pour les hooks bloquants et sécurité ! 🚀
