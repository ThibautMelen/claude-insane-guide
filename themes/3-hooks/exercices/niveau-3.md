# 🟠 Niveau 3 : Hooks Bloquants & Sécurité

> **Objectif** : Maîtriser les hooks bloquants, sécurité et multi-environnements
>
> **Durée estimée** : 25-30 minutes

---

## 🎯 Ce que vous allez apprendre

- ✅ Créer des hooks **bloquants** (blocking)
- ✅ Implémenter validation de sécurité
- ✅ Gérer multi-environnements (dev, staging, production)
- ✅ Patterns de hooks avancés (chaînage, contexte)

---

## 📋 Prérequis

- Niveaux 1 et 2 terminés ✅
- Comprendre exit codes bash (0 = succès, 1+ = échec)
- Projet `~/claude-hooks-test/`

---

## 🚀 Exercice 1 : Premier Hook Bloquant

### Objectif

Créer un hook qui **empêche** l'exécution d'une commande si validation échoue.

### Instructions

1. **Créer script de validation**

```bash
cd ~/claude-hooks-test

cat > scripts/validate-before-push.sh << 'EOF'
#!/bin/bash

echo "🔍 [PRE-PUSH] Validation en cours..."

# Vérifier que tests passent
echo "  1️⃣ Checking tests..."
# npm test --silent 2>/dev/null
# Simuler pour démo
TESTS_PASS=true

if [ "$TESTS_PASS" = true ]; then
  echo "  ✅ Tests OK"
else
  echo "  ❌ Tests failed - PUSH BLOQUÉ"
  exit 1
fi

# Vérifier que build fonctionne
echo "  2️⃣ Checking build..."
# npm run build --silent 2>/dev/null
# Simuler
BUILD_OK=true

if [ "$BUILD_OK" = true ]; then
  echo "  ✅ Build OK"
else
  echo "  ❌ Build failed - PUSH BLOQUÉ"
  exit 1
fi

echo "✅ [PRE-PUSH] Validation réussie - Push autorisé"
exit 0
EOF

chmod +x scripts/validate-before-push.sh
```

2. **Configuration hook bloquant**

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git push",
      "script": "bash scripts/validate-before-push.sh",
      "blocking": true
    }
  ]
}
```

3. **Tester**

Initialiser git et essayer de push :

```bash
git init
git add .
git commit -m "test"
```

Demander à Claude :
```
Fais un git push
```

### ✅ Validation

**Si validation réussit** :
```
🔍 [PRE-PUSH] Validation en cours...
  1️⃣ Checking tests...
  ✅ Tests OK
  2️⃣ Checking build...
  ✅ Build OK
✅ Validation réussie - Push autorisé

[Git push s'exécute]
```

**Si validation échoue** :
```
❌ Tests failed - PUSH BLOQUÉ

[Git push NE s'exécute PAS]
```

### 💡 Explication

- `"blocking": true` → Si script exit 1, Claude n'exécute PAS la commande
- `PreToolUse` → Validation **avant** exécution
- Exit codes : 0 = succès, 1+ = échec

---

## 🚀 Exercice 2 : Détection de Secrets

### Objectif

**Bloquer** tout commit contenant des secrets (API keys, passwords).

### Instructions

1. **Créer script détection secrets**

```bash
cat > scripts/detect-secrets.sh << 'EOF'
#!/bin/bash

echo "🔒 [SECURITY] Scanning for secrets..."

# Patterns de secrets communs
PATTERNS=(
  "api[_-]?key"
  "password"
  "secret"
  "token"
  "private[_-]?key"
  "AWS_ACCESS_KEY"
  "STRIPE_SECRET"
)

# Vérifier dans les fichiers staged
SECRETS_FOUND=false

for pattern in "${PATTERNS[@]}"; do
  if git diff --cached | grep -iE "$pattern" > /dev/null 2>&1; then
    echo "  ❌ Pattern détecté : $pattern"
    SECRETS_FOUND=true
  fi
done

if [ "$SECRETS_FOUND" = true ]; then
  echo ""
  echo "🚨 SECRETS DÉTECTÉS - COMMIT BLOQUÉ 🚨"
  echo ""
  echo "Vérifiez vos fichiers et retirez les secrets avant de commit."
  echo "Utilisez des variables d'environnement (.env) à la place."
  exit 1
fi

echo "  ✅ Aucun secret détecté"
exit 0
EOF

chmod +x scripts/detect-secrets.sh
```

2. **Configuration**

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git commit",
      "script": "bash scripts/detect-secrets.sh",
      "blocking": true
    }
  ]
}
```

3. **Tester - Cas avec secret**

Créer fichier avec secret :

```bash
cat > config.js << 'EOF'
module.exports = {
  api_key: "sk_live_1234567890abcdef",
  database_password: "super_secret_123"
}
EOF

git add config.js
```

Demander à Claude :
```
Fais un git commit avec message "Add config"
```

**Résultat** : ❌ BLOQUÉ

4. **Tester - Cas sans secret**

```bash
cat > config.js << 'EOF'
module.exports = {
  apiUrl: process.env.API_URL,
  dbPassword: process.env.DB_PASSWORD
}
EOF

git add config.js
```

**Résultat** : ✅ AUTORISÉ

### ✅ Validation

Hook détecte et bloque commits avec secrets.

### 💡 Explication

- Patterns regex cherchent mots-clés sensibles
- `git diff --cached` = fichiers staged
- Exit 1 si secrets trouvés → Commit bloqué

---

## 🚀 Exercice 3 : Multi-Environnements

### Objectif

Configurer hooks **différents** selon environnement (dev, staging, prod).

### Instructions

1. **Structure multi-env**

```bash
mkdir -p hooks
```

2. **Créer hooks par environnement**

**hooks/dev.hooks.json** (léger) :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '🔧 DEV MODE - Hooks allégés'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "script": "echo '✏️ File edited (dev)'"
    }
  ]
}
```

**hooks/staging.hooks.json** (intermédiaire) :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '🟡 STAGING MODE - Validation active'"
    },
    {
      "event": "PostToolUse",
      "tool": "Edit",
      "pattern": "\\.(ts|tsx)$",
      "script": "eslint $FILE"
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git push",
      "script": "npm test",
      "blocking": true
    }
  ]
}
```

**hooks/production.hooks.json** (strict) :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "echo '🔴 PRODUCTION MODE - Sécurité maximale'"
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git commit",
      "script": "bash scripts/detect-secrets.sh",
      "blocking": true
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git push",
      "script": "bash scripts/validate-before-push.sh",
      "blocking": true
    },
    {
      "event": "PostToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "bash scripts/notify-team.sh"
    }
  ]
}
```

3. **Script de chargement**

```bash
cat > load-env.sh << 'EOF'
#!/bin/bash

ENV=${1:-dev}

echo "🔄 Loading $ENV environment..."

# Copier hooks appropriés
cp hooks/${ENV}.hooks.json .claude/settings.json

echo "✅ Hooks $ENV chargés dans .claude/settings.json"
EOF

chmod +x load-env.sh
```

4. **Tester chaque environnement**

```bash
# Dev
./load-env.sh dev
claude

# Staging
./load-env.sh staging
claude

# Production
./load-env.sh production
claude
```

### ✅ Validation

Chaque environnement a son ensemble de hooks :
- **Dev** : Minimal, non-bloquant
- **Staging** : Tests requis
- **Production** : Sécurité maximale + notifications

---

## 🚀 Exercice 4 : Hooks Chaînés avec Contexte

### Objectif

Créer un système de hooks qui partagent du contexte entre eux.

### Instructions

1. **Script pre-deploy (sauvegarde contexte)**

```bash
cat > scripts/pre-deploy.sh << 'EOF'
#!/bin/bash

TIMESTAMP=$(date +%s)
COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "no-git")

# Sauvegarder contexte
mkdir -p /tmp/claude-deploy
cat > /tmp/claude-deploy/context.json << JSON
{
  "timestamp": $TIMESTAMP,
  "commit": "$COMMIT",
  "environment": "${ENV:-dev}",
  "startTime": "$(date)"
}
JSON

echo "📦 [PRE-DEPLOY] Context saved"
echo "   Commit: $COMMIT"
echo "   Env: ${ENV:-dev}"
echo "   Time: $(date)"
EOF
```

2. **Script post-deploy (utilise contexte)**

```bash
cat > scripts/post-deploy.sh << 'EOF'
#!/bin/bash

# Charger contexte
CONTEXT="/tmp/claude-deploy/context.json"

if [ -f "$CONTEXT" ]; then
  START_TIME=$(jq -r .timestamp "$CONTEXT")
  COMMIT=$(jq -r .commit "$CONTEXT")
  ENV=$(jq -r .environment "$CONTEXT")

  END_TIME=$(date +%s)
  DURATION=$((END_TIME - START_TIME))

  echo "✅ [POST-DEPLOY] Déploiement terminé"
  echo "   Commit: $COMMIT"
  echo "   Env: $ENV"
  echo "   Duration: ${DURATION}s"

  # Envoyer métriques (simulé)
  echo "📊 Sending metrics..."
  echo "{\"commit\":\"$COMMIT\",\"duration\":$DURATION}" >> deploy-metrics.log
else
  echo "⚠️ No deploy context found"
fi
EOF

chmod +x scripts/*.sh
```

3. **Configuration hooks chaînés**

```json
{
  "hooks": [
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "bash scripts/pre-deploy.sh"
    },
    {
      "event": "PostToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "bash scripts/post-deploy.sh"
    }
  ]
}
```

4. **Tester**

```bash
# Créer script deploy fictif
echo '#!/bin/bash\necho "Deploying..."\nsleep 2\necho "Done"' > deploy.sh
chmod +x deploy.sh
```

Demander à Claude :
```
Exécute ./deploy.sh
```

### ✅ Validation

```
📦 [PRE-DEPLOY] Context saved
   Commit: abc1234
   Env: dev
   Time: Thu Nov  7 10:30:00 CET 2025

[Déploiement...]

✅ [POST-DEPLOY] Déploiement terminé
   Commit: abc1234
   Env: dev
   Duration: 2s
📊 Sending metrics...
```

### 💡 Explication

- PreToolUse → Sauvegarde contexte dans `/tmp/`
- PostToolUse → Lit contexte et calcule durée
- JSON pour passer données entre hooks
- Utile pour métriques, audits, logs

---

## 🎓 Quiz de Validation

### Question 1
Comment rendre un hook bloquant ?

- [ ] A) `"block": true`
- [x] B) `"blocking": true`
- [ ] C) `"prevent": true`
- [ ] D) Exit code 1 suffit

### Question 2
Quel exit code indique succès dans un script bash ?

- [x] A) 0
- [ ] B) 1
- [ ] C) -1
- [ ] D) 200

### Question 3
Quel événement utiliser pour bloquer AVANT exécution ?

- [x] A) PreToolUse
- [ ] B) PostToolUse
- [ ] C) SessionStart
- [ ] D) BlockToolUse

### Question 4
Comment passer données entre hooks ?

- [ ] A) Variables globales
- [x] B) Fichiers temporaires
- [ ] C) Redis
- [ ] D) Impossible

---

## 🏆 Challenge Bonus

### Système de Validation Complet

Créer un système enterprise-grade avec :

1. **Security Scan** (bloquant)
   - Détection secrets
   - Validation dépendances
   - Scan vulnérabilités

2. **Quality Gates** (bloquant staging/prod)
   - Tests unitaires
   - Coverage > 80%
   - Linting

3. **Audit Trail**
   - Log toutes les actions
   - Métriques performance
   - Notifications Slack

4. **Multi-Environment**
   - Dev : Warnings seulement
   - Staging : Tests requis
   - Prod : Tout bloquant + audit

### Solution (à essayer d'abord !)

<details>
<summary>Voir la solution</summary>

**hooks/production.hooks.json** :

```json
{
  "hooks": [
    {
      "event": "SessionStart",
      "script": "bash scripts/audit-start.sh"
    },
    {
      "event": "PreToolUse",
      "tool": "Edit",
      "pattern": "\\.(env|yaml|json)$",
      "script": "bash scripts/validate-config.sh",
      "blocking": true
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git commit",
      "script": "bash scripts/security-scan.sh",
      "blocking": true
    },
    {
      "event": "PreToolUse",
      "tool": "Bash",
      "pattern": "git push",
      "script": "bash scripts/quality-gates.sh",
      "blocking": true
    },
    {
      "event": "PostToolUse",
      "script": "bash scripts/audit-log.sh"
    },
    {
      "event": "PostToolUse",
      "tool": "Bash",
      "pattern": "deploy",
      "script": "bash scripts/notify-slack.sh"
    }
  ]
}
```

**scripts/security-scan.sh** :

```bash
#!/bin/bash
echo "🔒 Security Scan..."
bash scripts/detect-secrets.sh || exit 1
npm audit --audit-level=moderate || exit 1
echo "✅ Security OK"
```

**scripts/quality-gates.sh** :

```bash
#!/bin/bash
echo "🎯 Quality Gates..."
npm test -- --coverage || exit 1
npm run lint || exit 1
npm run build || exit 1
echo "✅ Quality OK"
```

</details>

---

## 📚 Ressources

- 📖 [Guide Hooks Complet](../guide.md)
- 📋 [Cheatsheet Hooks](../cheatsheet.md)
- 🔗 [Guide Plugins](../../6-plugins/guide.md)
- 🔗 [Guide Best Practices](../../9-best-practices/guide.md)

---

**🎉 Félicitations !** Vous maîtrisez les hooks Claude Code de A à Z ! Vous pouvez maintenant :
- ✅ Créer des hooks bloquants pour sécurité
- ✅ Gérer multi-environnements
- ✅ Construire des workflows automatisés complexes
- ✅ Implémenter audit trail et métriques

**🚀 Prochaine étape** : Explorez [MCP](../../4-mcp/guide.md) pour intégrer services externes ! 🎯
