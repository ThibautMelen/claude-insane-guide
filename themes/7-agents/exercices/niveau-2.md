# 🟡 Niveau 2 : Custom Agent Spécialisé Code Review
> **Durée** : 20-25 min
> **Difficulté** : Intermédiaire
> **Prérequis** : Niveau 1 complété, repository Git avec code

## 🎯 Objectif

Créer un agent spécialisé `code-reviewer` qui analyse automatiquement votre code pour détecter :
- 🐛 Bugs potentiels
- 🔒 Failles de sécurité
- ⚡ Problèmes de performance
- 📏 Violations de style
- ✅ Couverture de tests manquante

## 📚 Théorie Rapide

### Qu'est-ce qu'un Agent Custom ?

Un agent custom est une **instance spécialisée de Claude** avec :
- **Contexte dédié** : Isolé du contexte principal
- **Mission précise** : Une responsabilité unique
- **Tools limités** : Seulement les outils nécessaires
- **Prompt optimisé** : Instructions spécifiques au domaine

```
╔════════════════════════════════════════════╗
║         ANATOMIE D'UN AGENT CUSTOM         ║
╚════════════════════════════════════════════╝

┌─── METADATA (YAML) ────────────────────────┐
│ name: code-reviewer                        │
│ description: Expert review proactive       │
│ tools: Read, Grep, Glob, Bash             │
│ model: sonnet                             │
└────────────────────────────────────────────┘
                    ↓
┌─── PROMPT (MARKDOWN) ──────────────────────┐
│ You are a senior code reviewer...         │
│                                            │
│ Focus on:                                  │
│ - Security vulnerabilities                │
│ - Performance bottlenecks                  │
│ - Code smells                             │
│ - Missing tests                           │
└────────────────────────────────────────────┘
```

## ✏️ Exercice Step-by-Step

### Étape 1 : Créer la Structure

```bash
# Créer le dossier agents
mkdir -p .claude/agents

# Créer le fichier agent
cat > .claude/agents/code-reviewer.md << 'EOF'
---
name: code-reviewer
description: Expert code review specialist. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.
tools: Read, Grep, Glob, Bash
model: inherit
---

You are a senior code reviewer with 15+ years of experience across multiple languages and frameworks.

## Your Mission
Perform comprehensive code reviews focusing on critical issues that could impact production.

## Review Process

1. **Initial Analysis**
   - Run `git diff` to see recent changes
   - Identify modified files and their purpose
   - Check file extensions and languages

2. **Security Review** 🔒
   - SQL injection vulnerabilities
   - XSS (Cross-Site Scripting) risks
   - Authentication/Authorization flaws
   - Exposed secrets or API keys
   - Input validation issues
   - CORS misconfigurations

3. **Performance Analysis** ⚡
   - O(n²) or worse algorithms
   - Database query optimization (N+1 problems)
   - Memory leaks potential
   - Unnecessary re-renders (React/Vue)
   - Missing indexes
   - Large bundle sizes

4. **Code Quality** 📏
   - DRY violations (Don't Repeat Yourself)
   - SOLID principles adherence
   - Cyclomatic complexity
   - Function/class size
   - Naming conventions
   - Comments and documentation

5. **Testing Coverage** ✅
   - Missing unit tests
   - Integration test gaps
   - Edge cases not covered
   - Error scenarios untested

## Output Format

Provide feedback organized by priority:

### 🔴 Critical Issues (Must Fix)
- [Issue description]
- File: `path/to/file.js:42`
- Why it's critical: [explanation]
- Fix: ```[code example]```

### 🟡 Warnings (Should Fix)
- [Issue description]
- File: `path/to/file.js:42`
- Impact: [explanation]
- Suggestion: ```[code example]```

### 🟢 Suggestions (Consider)
- [Improvement description]
- Benefits: [explanation]

## Example Review

For this code:
```javascript
function getUserData(userId) {
  const query = `SELECT * FROM users WHERE id = ${userId}`;
  return db.query(query);
}
```

Your review:
### 🔴 Critical Issues
- **SQL Injection Vulnerability**
  - File: `api/users.js:15`
  - Why it's critical: Direct string interpolation allows SQL injection
  - Fix:
  ```javascript
  function getUserData(userId) {
    const query = 'SELECT * FROM users WHERE id = ?';
    return db.query(query, [userId]);
  }
  ```

## Important Rules
1. Be constructive, not destructive
2. Explain WHY something is an issue
3. Always provide a fix or alternative
4. Prioritize security and data integrity
5. Consider the context and business logic
EOF

echo "✅ Agent code-reviewer créé dans .claude/agents/"
```

### Étape 2 : Tester l'Agent

```bash
# Créer un fichier avec des problèmes intentionnels
cat > test-code.js << 'EOF'
// Fichier de test avec problèmes
function authenticateUser(username, password) {
    // Problème 1: SQL Injection
    const query = `SELECT * FROM users WHERE username='${username}' AND password='${password}'`;

    // Problème 2: Password en clair
    if (password == "admin123") {
        return true;
    }

    // Problème 3: Pas de validation d'input
    const result = db.query(query);

    // Problème 4: Information leak
    if (!result) {
        throw new Error("User " + username + " not found in database");
    }

    // Problème 5: Pas de hash pour password
    return result.password === password;
}

// Problème 6: Fonction trop complexe
function processOrder(order) {
    if (order.status == 'pending') {
        if (order.payment == 'credit') {
            if (order.amount > 1000) {
                if (order.customer.vip) {
                    // Nested hell...
                    order.discount = 0.2;
                    order.priority = 'high';
                    // 50 more lines...
                }
            }
        }
    }
}

// Problème 7: Pas de gestion d'erreur
async function fetchUserData(id) {
    const response = await fetch('/api/users/' + id);
    return response.json(); // What if error?
}
EOF

echo "✅ Fichier test créé avec problèmes intentionnels"
```

### Étape 3 : Invoquer l'Agent

Dans Claude Code, exécutez :

```
> Use the code-reviewer agent to review test-code.js
```

**Résultat attendu** : L'agent devrait identifier tous les problèmes et proposer des corrections.

### Étape 4 : Créer un Second Agent (Performance)

```bash
cat > .claude/agents/perf-analyzer.md << 'EOF'
---
name: perf-analyzer
description: Performance optimization specialist. Analyzes code for bottlenecks and suggests optimizations.
tools: Read, Grep, Bash
model: haiku
---

You are a performance optimization expert.

## Focus Areas
1. Algorithm complexity
2. Database queries
3. Memory usage
4. Rendering performance
5. Bundle size

## Analysis Process
1. Identify hot paths
2. Measure complexity
3. Find bottlenecks
4. Suggest optimizations

Provide specific metrics and benchmarks.
EOF

echo "✅ Agent perf-analyzer créé"
```

### Étape 5 : Test Multi-Agents Parallèles

```bash
# Dans Claude Code, lancer les deux agents EN PARALLÈLE :
```

```
> Use agents IN PARALLEL: code-reviewer for security review, perf-analyzer for performance analysis on test-code.js
```

## 🔍 Validation

### Checklist de Validation

- [ ] **Structure créée** : `.claude/agents/` existe
- [ ] **Agent principal** : `code-reviewer.md` créé avec metadata YAML
- [ ] **Description claire** : Rôle et déclenchement définis
- [ ] **Tools limités** : Seulement Read, Grep, Glob, Bash
- [ ] **Prompt détaillé** : Instructions spécifiques et exemples
- [ ] **Test réussi** : Agent identifie les problèmes
- [ ] **Output structuré** : Feedback par priorité (🔴🟡🟢)
- [ ] **Second agent** : `perf-analyzer.md` créé
- [ ] **Parallel execution** : Deux agents lancés simultanément
- [ ] **Résultats pertinents** : Problèmes réels identifiés

### Test Final

Créez un vrai fichier de votre projet avec du code réel :

```bash
# Choisir un fichier de votre projet
FILE="src/components/YourComponent.js"  # Adapter

# Lancer review complète
echo "Lance review sur $FILE"
```

Dans Claude :
```
> Use the code-reviewer agent to perform a thorough review of src/components/YourComponent.js
```

## 🎓 Ce que vous avez appris

✅ **Architecture d'agent** : Structure metadata + prompt
✅ **Spécialisation** : Agent focalisé sur une mission
✅ **Tools restriction** : Limiter aux outils nécessaires
✅ **Prompt engineering** : Instructions claires et exemples
✅ **Invocation** : Utilisation du Task tool
✅ **Parallel execution** : Lancer plusieurs agents simultanément
✅ **Output structuré** : Formatage cohérent des résultats

## 🚀 Aller plus loin

### Idées d'Agents Additionnels

1. **test-generator** : Génère tests unitaires manquants
2. **doc-writer** : Crée documentation depuis code
3. **security-scanner** : Audit sécurité approfondi
4. **i18n-checker** : Vérifie traductions manquantes
5. **a11y-auditor** : Accessibilité validation

### Pattern Avancé : Agent Chain

```markdown
# .claude/agents/review-chain.md
---
name: review-chain
description: Orchestrates multiple review agents in sequence
---

Chain workflow:
1. security-scanner → Identify vulnerabilities
2. perf-analyzer → Find bottlenecks
3. test-generator → Create missing tests
4. doc-writer → Update documentation
```

## 🔗 Ressources

- 📄 [Guide Agents Complet](../guide.md)
- 📄 [Sub-agents Documentation](https://code.claude.com/docs/en/sub-agents)
- 📹 [Video: Advanced Agent Patterns](https://youtube.com/...)

## ❓ Troubleshooting

**Agent ne se lance pas ?**
```bash
# Vérifier syntaxe YAML
head -n 10 .claude/agents/code-reviewer.md

# Vérifier formatting
# - Les --- sont sur leur propre ligne
# - Pas de tabs (espaces seulement)
# - Indentation cohérente
```

**Agent ne trouve pas les fichiers ?**
```bash
# S'assurer d'être à la racine du projet
pwd
ls .claude/agents/
```

**Résultats non pertinents ?**
- Affiner le prompt avec plus d'exemples
- Limiter le scope de l'agent
- Vérifier que les tools sont appropriés

---

🎉 **Bravo !** Vous maîtrisez maintenant la création d'agents custom !

**Prochaine étape** → [Niveau 3 : Orchestration Multi-Agents](./niveau-3.md) ou [Workflows EPCT](../../8-workflows/guide.md)
