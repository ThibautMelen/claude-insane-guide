# 🧪 Exemple : Test Generator Agent

> **Agent spécialisé dans la génération de tests unitaires complets avec coverage élevé**

## 🎯 Objectif

Créer un agent qui génère automatiquement :
- Tests unitaires (Jest/Vitest)
- Tests d'edge cases
- Mocking des dépendances
- Coverage > 80%

## 📁 Fichier : `.claude/plugins/test-agents/index.ts`

```typescript
export default {
  subAgents: {
    'test-generator': {
      systemPrompt: `You are an expert test engineer specializing in comprehensive test coverage.

## Test Strategy

1. **Read** the code to understand logic and dependencies
2. **Identify** all code paths and edge cases
3. **Generate** unit tests with Jest/Vitest syntax
4. **Mock** external dependencies appropriately
5. **Cover** edge cases: null, undefined, empty arrays, errors

## Test Structure

Use AAA pattern (Arrange-Act-Assert):

\`\`\`typescript
describe('functionName', () => {
  it('should handle normal case', () => {
    // Arrange
    const input = validInput;

    // Act
    const result = functionName(input);

    // Assert
    expect(result).toBe(expectedOutput);
  });

  it('should throw on invalid input', () => {
    expect(() => functionName(null)).toThrow('Error message');
  });
});
\`\`\`

## Coverage Requirements

- **Branches**: 100% (all if/else paths)
- **Lines**: > 80%
- **Functions**: 100%
- **Edge cases**: null, undefined, empty, errors

## Output Format

Generate tests as complete .test.ts files ready to run.
Include:
- All necessary imports
- Mock setup when needed
- Clear test descriptions
- Edge cases coverage
`,
      description: 'Generates comprehensive unit tests (80%+ coverage)',
      model: 'sonnet'  // Standard for test generation
    }
  }
};
```

## 💻 Utilisation

### Générer Tests pour Fichier

```bash
claude
> "Generate unit tests for src/utils/validation.ts with 80%+ coverage"
```

### Générer Tests pour Fonction

```bash
> "Generate tests for the calculateTotal function covering all edge cases"
```

## 📊 Exemple Output

### Code Original : `src/utils/validation.ts`

```typescript
export function validateEmail(email: string): boolean {
  if (!email) return false;

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

export function validatePassword(password: string): {
  valid: boolean;
  errors: string[];
} {
  const errors: string[] = [];

  if (!password) {
    errors.push('Password is required');
  }

  if (password.length < 8) {
    errors.push('Password must be at least 8 characters');
  }

  if (!/[A-Z]/.test(password)) {
    errors.push('Password must contain uppercase letter');
  }

  if (!/[0-9]/.test(password)) {
    errors.push('Password must contain number');
  }

  return {
    valid: errors.length === 0,
    errors
  };
}
```

### Tests Générés : `src/utils/validation.test.ts`

```typescript
import { describe, it, expect } from 'vitest';
import { validateEmail, validatePassword } from './validation';

describe('validateEmail', () => {
  it('should return true for valid email', () => {
    // Arrange
    const email = 'user@example.com';

    // Act
    const result = validateEmail(email);

    // Assert
    expect(result).toBe(true);
  });

  it('should return true for email with subdomains', () => {
    expect(validateEmail('user@mail.example.com')).toBe(true);
  });

  it('should return true for email with plus sign', () => {
    expect(validateEmail('user+tag@example.com')).toBe(true);
  });

  it('should return false for email without @', () => {
    expect(validateEmail('userexample.com')).toBe(false);
  });

  it('should return false for email without domain', () => {
    expect(validateEmail('user@')).toBe(false);
  });

  it('should return false for email with spaces', () => {
    expect(validateEmail('user @example.com')).toBe(false);
  });

  it('should return false for empty string', () => {
    expect(validateEmail('')).toBe(false);
  });

  it('should return false for null (type coercion)', () => {
    // @ts-expect-error Testing runtime behavior
    expect(validateEmail(null)).toBe(false);
  });

  it('should return false for undefined (type coercion)', () => {
    // @ts-expect-error Testing runtime behavior
    expect(validateEmail(undefined)).toBe(false);
  });
});

describe('validatePassword', () => {
  it('should return valid for strong password', () => {
    // Arrange
    const password = 'SecurePass123';

    // Act
    const result = validatePassword(password);

    // Assert
    expect(result.valid).toBe(true);
    expect(result.errors).toEqual([]);
  });

  it('should return error for empty password', () => {
    const result = validatePassword('');

    expect(result.valid).toBe(false);
    expect(result.errors).toContain('Password is required');
  });

  it('should return error for password less than 8 characters', () => {
    const result = validatePassword('Pass1');

    expect(result.valid).toBe(false);
    expect(result.errors).toContain('Password must be at least 8 characters');
  });

  it('should return error for password without uppercase', () => {
    const result = validatePassword('password123');

    expect(result.valid).toBe(false);
    expect(result.errors).toContain('Password must contain uppercase letter');
  });

  it('should return error for password without number', () => {
    const result = validatePassword('Password');

    expect(result.valid).toBe(false);
    expect(result.errors).toContain('Password must contain number');
  });

  it('should return multiple errors for weak password', () => {
    const result = validatePassword('pass');

    expect(result.valid).toBe(false);
    expect(result.errors).toHaveLength(3);
    expect(result.errors).toContain('Password must be at least 8 characters');
    expect(result.errors).toContain('Password must contain uppercase letter');
    expect(result.errors).toContain('Password must contain number');
  });

  it('should handle null password (type coercion)', () => {
    // @ts-expect-error Testing runtime behavior
    const result = validatePassword(null);

    expect(result.valid).toBe(false);
    expect(result.errors.length).toBeGreaterThan(0);
  });

  it('should accept password with special characters', () => {
    const result = validatePassword('Pass@word123!');

    expect(result.valid).toBe(true);
    expect(result.errors).toEqual([]);
  });
});
```

### Coverage Report Simulé

```
╔════════════════════════════════════════════╗
║  TEST COVERAGE REPORT - validation.ts      ║
╚════════════════════════════════════════════╝

File         | % Stmts | % Branch | % Funcs | % Lines
-------------|---------|----------|---------|--------
validation.ts|   100   |   100    |   100   |   100

validateEmail:
✅ All branches covered (valid, invalid formats)
✅ Edge cases: empty, null, undefined
✅ Total tests: 9

validatePassword:
✅ All validation rules tested
✅ Multiple errors scenario covered
✅ Edge cases: empty, null, special chars
✅ Total tests: 8

📊 Total: 17 tests
⏱️ Duration: 0.45s
✅ All tests passing
```

## 🎯 Cas d'Usage

### 1. TDD (Test-Driven Development)

```bash
# Étape 1: Générer tests AVANT impl
> "Generate tests for a function that calculates compound interest"

# Étape 2: Implémenter fonction
# (Les tests échouent)

# Étape 3: Refactorer jusqu'à tests verts
```

### 2. Legacy Code Coverage

```bash
> "Generate missing tests for src/legacy/payment.ts to reach 80% coverage"
```

### 3. PR Requirement

```bash
> "Generate tests for all new functions in current PR"
```

## 🔧 Customisation

### Tests avec Mocking

```typescript
'test-generator-with-mocks': {
  systemPrompt: `Generate tests with proper mocking.

  Mock external dependencies:
  - API calls (fetch, axios)
  - Database queries
  - File system operations
  - Date/Time (Date.now())

  Use vitest mocking:
  \`\`\`typescript
  import { vi } from 'vitest';

  vi.mock('./api', () => ({
    fetchUser: vi.fn(() => Promise.resolve({ id: 1 }))
  }));
  \`\`\`
  `,
  model: 'sonnet'
}
```

### Tests E2E (Playwright)

```typescript
'e2e-test-generator': {
  systemPrompt: `Generate E2E tests with Playwright.

  Test user flows:
  - Login → Dashboard → Action → Logout
  - Happy paths + error scenarios

  Use Playwright syntax:
  \`\`\`typescript
  test('user can login', async ({ page }) => {
    await page.goto('/login');
    await page.fill('[name=email]', 'user@example.com');
    await page.fill('[name=password]', 'password');
    await page.click('button[type=submit]');
    await expect(page).toHaveURL('/dashboard');
  });
  \`\`\`
  `,
  model: 'opus'  // E2E tests complexes
}
```

## 💰 Coût Optimisation

**Pourquoi Sonnet ?**
- Tests = tâche répétitive
- Patterns bien définis
- Sonnet = bon rapport qualité/coût

**Downgrade à Haiku** (si tests simples) :
```typescript
model: 'haiku'  // 10x cheaper, pour tests unitaires basiques
```

## 🔗 Combiner avec Autres Features

### + Code Reviewer

```bash
> "Lance EN PARALLÈLE : code-reviewer (quality), test-generator (coverage 80%)"
```

### + Pre-commit Hook

```json
{
  "pre-commit": {
    "command": "claude --agent test-generator --uncovered-only && npm test"
  }
}
```

### + CI/CD Integration

```yaml
# .github/workflows/tests.yml
- name: Generate Missing Tests
  run: claude --agent test-generator --coverage-threshold 80

- name: Run Tests
  run: npm test
```

## 📚 Ressources

- 📖 [Guide Agents](../guide.md#création-de-sub-agents)
- ⚡ [Cheatsheet](../cheatsheet.md)
- 🧪 [Vitest Docs](https://vitest.dev/)
- 🧪 [Jest Docs](https://jestjs.io/)

---

**💡 Tip** : Combinez avec code-reviewer pour TDD complet (tests → impl → review) !
