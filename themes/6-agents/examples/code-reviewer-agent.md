# 🔍 Exemple : Code Reviewer Agent

> **Agent spécialisé dans la review de code (qualité, sécurité, performance)**

## 🎯 Objectif

Créer un agent qui analyse du code et fournit un rapport détaillé sur :
- Qualité du code
- Vulnérabilités de sécurité
- Problèmes de performance
- Respect des best practices

## 📁 Fichier : `.claude/plugins/code-agents/index.ts`

```typescript
export default {
  subAgents: {
    'code-reviewer': {
      systemPrompt: `You are an expert code reviewer with deep knowledge of:

- **Security**: OWASP Top 10, SQL injection, XSS, CSRF, etc.
- **Performance**: Time complexity, memory usage, caching strategies
- **Quality**: Clean code, SOLID principles, design patterns
- **Best Practices**: Language-specific conventions and idioms

## Review Process

1. **Read the code** thoroughly
2. **Analyze** for issues in security, performance, quality
3. **Prioritize** findings by severity (Critical, High, Medium, Low)
4. **Provide** specific fix suggestions with code examples

## Output Format

\`\`\`markdown
## 🔴 Critical Issues
- [Line X] Description
  Fix: \`\`\`code example\`\`\`

## 🟠 High Priority
- [Line Y] Description
  Fix: \`\`\`code example\`\`\`

## 🟡 Medium Priority
- [Line Z] Description
  Fix: Suggestion

## ✅ Strengths
- What's done well
\`\`\`

## Rules
- Focus on actionable feedback
- Provide code examples for fixes
- Explain WHY something is an issue
- Acknowledge good patterns when present
`,
      description: 'Expert code reviewer (security, performance, quality)',
      model: 'opus'  // Premium for critical code review
    }
  }
};
```

## 💻 Utilisation

### Via Task Tool (Automatique)

```bash
claude
> "Review this authentication code for security issues"
```

Claude invoquera automatiquement le `code-reviewer` agent.

### Invocation Explicite

```bash
> "Lance l'agent code-reviewer sur src/auth/login.ts"
```

## 📊 Exemple Output

```markdown
╔════════════════════════════════════════════╗
║  CODE REVIEW REPORT - src/auth/login.ts    ║
╚════════════════════════════════════════════╝

## 🔴 Critical Issues

### [Line 42] SQL Injection Vulnerability
**Risk**: User input directly in SQL query

❌ Current code:
```typescript
const user = await db.query(
  `SELECT * FROM users WHERE email = '${email}'`
);
```

✅ Fix with parameterized query:
```typescript
const user = await db.query(
  'SELECT * FROM users WHERE email = $1',
  [email]
);
```

**Impact**: Critical - Database compromise possible
**Effort**: 5 min

---

## 🟠 High Priority

### [Line 67] Password Stored in Plain Text
**Risk**: Passwords not hashed

❌ Current:
```typescript
user.password = password;
```

✅ Fix with bcrypt:
```typescript
import bcrypt from 'bcrypt';
const saltRounds = 10;
user.password = await bcrypt.hash(password, saltRounds);
```

**Impact**: High - Account takeover risk
**Effort**: 15 min

---

## 🟡 Medium Priority

### [Line 89] Missing Rate Limiting
**Risk**: Brute force attacks possible

Suggestion: Add rate limiting middleware
```typescript
import rateLimit from 'express-rate-limit';

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 attempts
  message: 'Too many login attempts'
});

app.post('/login', loginLimiter, loginHandler);
```

**Impact**: Medium - Abuse prevention
**Effort**: 30 min

---

## ✅ Strengths

- ✅ Input validation present (lines 23-30)
- ✅ Clear error messages (lines 55-60)
- ✅ Proper async/await usage throughout
- ✅ JWT token generation secure (line 103)

---

## 📊 Summary

- **Critical**: 1 issue (SQL injection)
- **High**: 1 issue (plain text passwords)
- **Medium**: 3 issues (rate limiting, logging, CORS)
- **Low**: 2 issues (error messages, comments)

**Estimated Fix Time**: 2-3 hours
**Priority**: Address Critical + High immediately
```

## 🎯 Cas d'Usage

### 1. Review PR Avant Merge

```bash
> "Review all changed files in current PR for security and quality"
```

### 2. Audit Complet Module

```bash
> "Review complete authentication module for OWASP Top 10"
```

### 3. Performance Analysis

```bash
> "Review API endpoints for performance bottlenecks"
```

## 🔧 Customisation

### Adapter pour Framework Spécifique

```typescript
'react-reviewer': {
  systemPrompt: `Expert React code reviewer.

  Focus on:
  - Component structure and hooks usage
  - Performance (useMemo, useCallback)
  - Accessibility (a11y best practices)
  - TypeScript types strictness
  `,
  model: 'opus'
}
```

### Adapter pour Langage Spécifique

```typescript
'python-reviewer': {
  systemPrompt: `Expert Python code reviewer.

  Check:
  - PEP 8 compliance
  - Type hints usage
  - Security (SQL injection, XSS)
  - Pythonic patterns
  `,
  model: 'sonnet'
}
```

## 💰 Coût Optimisation

**Pourquoi Opus ?**
- Code review = tâche critique (sécurité)
- Nécessite raisonnement profond
- Coût justifié par qualité output

**Alternative Sonnet** (si budget limité) :
```typescript
model: 'sonnet'  // 5x cheaper, légèrement moins précis
```

## 🔗 Combiner avec Autres Features

### + Commands

```markdown
---
name: review-pr
---

Review all changed files in current PR using code-reviewer agent.

1. Get changed files with `git diff --name-only`
2. For each file, invoke code-reviewer agent
3. Compile report
```

### + Hooks

```json
{
  "pre-commit": {
    "command": "claude --agent code-reviewer --files staged"
  }
}
```

### + Parallel Agents

```bash
> "Lance EN PARALLÈLE : code-reviewer (security), perf-analyzer (bottlenecks), a11y-checker (accessibility)"
```

## 📚 Ressources

- 📖 [Guide Agents](../guide.md#création-de-sub-agents)
- ⚡ [Cheatsheet](../cheatsheet.md)
- 🔌 [Plugins Guide](../../7-plugins/guide.md)
- 🔗 [OWASP Top 10](https://owasp.org/www-project-top-ten/)

---

**💡 Tip** : Combinez code-reviewer avec test-generator pour coverage complet !
