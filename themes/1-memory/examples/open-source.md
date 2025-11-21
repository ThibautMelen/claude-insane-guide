# CLAUDE.md - Open Source Project

> Memory pour maintainer d'un projet open source populaire

**Emplacement** : `.claude/CLAUDE.md` (Project root)

## 📦 Project Info

### Identity
- **Name** : awesome-library
- **Description** : Modern, type-safe utility library for JavaScript/TypeScript
- **Repository** : https://github.com/yourorg/awesome-library
- **License** : MIT
- **Homepage** : https://awesome-library.dev
- **npm** : https://www.npmjs.com/package/awesome-library

### Stats
- **Stars** : 10,000+
- **Downloads** : 500k/month
- **Contributors** : 50+
- **Issues** : ~100 open
- **PRs** : ~20 open

### Maintainers
- **Lead** : @yourname (you)
- **Core Team** : @dev1, @dev2, @dev3 (4 total)
- **Emeritus** : @founder (original creator, stepped down)

## 🎯 Project Mission

**Goal** : Provide a modern, lightweight, type-safe utility library that's:
- ✅ Zero dependencies
- ✅ Tree-shakeable
- ✅ < 10kb gzipped
- ✅ 100% TypeScript
- ✅ Well-documented
- ✅ Highly tested (100% coverage)

**Philosophy** :
- Quality over quantity (fewer, better utilities)
- DX-first (great developer experience)
- Stability over bleeding-edge (semver strict)
- Community-driven (RFC process for major changes)

## 👥 Community Guidelines

### Code of Conduct
- ✅ Follow `CODE_OF_CONDUCT.md` (Contributor Covenant)
- ✅ Be respectful, inclusive, welcoming
- ✅ No harassment, discrimination, or trolling
- ✅ Report violations to conduct@awesome-library.dev

### Communication Channels
- **GitHub Issues** : Bug reports, feature requests
- **GitHub Discussions** : Questions, ideas, showcase
- **Discord** : Real-time chat (https://discord.gg/awesome)
- **Twitter** : @awesome_library (announcements)

## 📝 Contributing Standards

### Before Contributing
1. ✅ Read `CONTRIBUTING.md`
2. ✅ Check existing issues/PRs (avoid duplicates)
3. ✅ Discuss major changes first (open issue or discussion)
4. ✅ Fork the repo
5. ✅ Create feature branch from `main`

### Code Requirements
- ✅ **TypeScript only** (no JavaScript files)
- ✅ **100% test coverage** for new features
- ✅ **Documentation** in README + docs/ folder
- ✅ **Examples** in examples/ folder (if applicable)
- ✅ **Changeset** added (for releases)
- ✅ **No breaking changes** without RFC

### PR Requirements
- ✅ Use PR template (auto-filled)
- ✅ Link related issue (#123)
- ✅ Pass all CI checks (tests, lint, types, build)
- ✅ Request review from 2 maintainers
- ✅ Address feedback promptly
- ✅ Squash commits before merge

### Review Process
```
1. Contributor opens PR
   ↓
2. CI runs (tests, lint, types)
   ↓
3. Maintainers review (2 approvals needed)
   ↓
4. Feedback → contributor fixes
   ↓
5. Final approval → merge to main
   ↓
6. Auto-release on next version bump
```

## 🏗️ Project Structure

```
awesome-library/
├── src/
│   ├── index.ts           # Main exports
│   ├── utils/             # Utility functions
│   │   ├── array.ts
│   │   ├── object.ts
│   │   ├── string.ts
│   │   └── ...
│   └── types/             # TypeScript types
├── tests/
│   ├── unit/              # Unit tests (Vitest)
│   └── integration/       # Integration tests
├── docs/
│   ├── api/               # API documentation
│   ├── guides/            # How-to guides
│   └── examples/          # Usage examples
├── examples/              # Runnable examples
│   ├── basic/
│   ├── advanced/
│   └── ...
├── scripts/               # Build & maintenance scripts
├── .changeset/            # Changesets for releases
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── LICENSE
├── README.md
└── package.json
```

## 📋 Development Workflow

### Setup
```bash
# Clone
git clone https://github.com/yourorg/awesome-library.git
cd awesome-library

# Install
npm install

# Build
npm run build

# Test
npm test

# Dev mode
npm run dev  # Watch mode for development
```

### Commands
```bash
# Development
npm run dev              # Watch mode
npm run build            # Production build
npm run clean            # Clean dist/

# Testing
npm test                 # Run all tests
npm run test:watch       # Watch mode
npm run test:coverage    # Coverage report (must be 100%)
npm run test:types       # Type tests

# Quality
npm run lint             # ESLint
npm run lint:fix         # Auto-fix
npm run type-check       # TypeScript check
npm run format           # Prettier
npm run format:check     # Check formatting

# Documentation
npm run docs:dev         # Serve docs locally
npm run docs:build       # Build docs

# Release (maintainers only)
npm run changeset        # Create changeset
npm run release          # Publish to npm
```

### Branching Strategy
```
main                     # Stable, always deployable
  └─> feature/add-foo    # Feature branches
  └─> fix/issue-123      # Bug fix branches
  └─> docs/improve-api   # Documentation branches
```

**No `develop` branch** : We use trunk-based development (merge to main directly after review)

## 🧪 Testing Standards

### Coverage Requirements
- ✅ **100% coverage** mandatory (enforced by CI)
- ✅ **All edge cases** must be tested
- ✅ **Error paths** must be tested
- ✅ **Type tests** for TypeScript utilities

### Test Structure
```typescript
// tests/unit/array.test.ts
import { describe, it, expect } from 'vitest';
import { chunk } from '../src/utils/array';

describe('chunk', () => {
  it('should split array into chunks of specified size', () => {
    expect(chunk([1, 2, 3, 4, 5], 2)).toEqual([[1, 2], [3, 4], [5]]);
  });

  it('should handle empty array', () => {
    expect(chunk([], 2)).toEqual([]);
  });

  it('should throw on invalid chunk size', () => {
    expect(() => chunk([1, 2], 0)).toThrow('Chunk size must be > 0');
  });

  // Type tests
  it('should preserve types', () => {
    const result = chunk(['a', 'b'], 1);
    expectTypeOf(result).toEqualTypeOf<string[][]>();
  });
});
```

## 📚 Documentation Standards

### README Structure
```markdown
# awesome-library

[Badges: npm, build, coverage, license]

## Features
[Quick bullet points]

## Installation
[npm, yarn, pnpm]

## Quick Start
[Minimal example]

## API
[Link to full docs]

## Contributing
[Link to CONTRIBUTING.md]

## License
[MIT]
```

### API Documentation
```markdown
# chunk

Splits an array into chunks of specified size.

## Signature
```typescript
function chunk<T>(array: T[], size: number): T[][]
\```

## Parameters
- `array` (T[]): Array to split
- `size` (number): Chunk size (must be > 0)

## Returns
(T[][]): Array of chunks

## Example
```typescript
chunk([1, 2, 3, 4, 5], 2);
// => [[1, 2], [3, 4], [5]]
\```

## Throws
- `Error`: If size <= 0

## See Also
- [flatMap](#flatmap)
- [partition](#partition)
```

### Changelog (Keep a Changelog format)
```markdown
# Changelog

## [Unreleased]

## [2.1.0] - 2025-01-15
### Added
- New `chunk` utility for arrays
- TypeScript 5.3 support

### Fixed
- Bug in `deepMerge` with circular references (#123)

### Changed
- Improved performance of `groupBy` by 30%

## [2.0.0] - 2024-12-01
### Breaking Changes
- Removed deprecated `flatten` (use `flat` instead)
- Node.js 16+ required (dropped 14 support)
```

## 🔄 Release Process

### Versioning (Semver Strict)
```
Major.Minor.Patch
  │     │     └─> Bug fixes (no breaking changes)
  │     └─> New features (backward compatible)
  └─> Breaking changes (require major bump)
```

### Release Workflow
```bash
# 1. Update changelog
npm run changeset
# → Answer prompts (major/minor/patch + description)

# 2. Version bump
npm run changeset version
# → Updates package.json + CHANGELOG.md

# 3. Commit
git add .
git commit -m "chore: release v2.1.0"

# 4. Tag
git tag v2.1.0

# 5. Build
npm run build
npm test  # Ensure all tests pass

# 6. Publish to npm (requires npm auth)
npm run release
# → Publishes to npm
# → Creates GitHub release
# → Updates docs site

# 7. Push
git push origin main --tags

# 8. Announce
# → Twitter @awesome_library
# → Discord #announcements
# → GitHub Discussions
```

### Release Schedule
- **Patch** : As needed (bug fixes)
- **Minor** : Every 2-4 weeks (new features)
- **Major** : Every 6-12 months (breaking changes, with migration guide)

## 🚫 Never Do

### Code
- ❌ Add dependencies (zero-dep philosophy)
- ❌ Breaking changes without RFC
- ❌ Merge without 2 approvals
- ❌ Skip tests (100% coverage enforced)
- ❌ Use `any` type (strict TypeScript)

### Community
- ❌ Close issues without explanation
- ❌ Ignore code of conduct violations
- ❌ Merge controversial PRs without discussion
- ❌ Release without testing on all supported Node versions

### Security
- ❌ Ignore security vulnerabilities (Dependabot alerts)
- ❌ Commit secrets/tokens
- ❌ Use `eval()` or similar unsafe patterns
- ❌ Trust user input without validation

## 🌍 Internationalization

### Supported Languages (Docs)
- **English** (primary) - All docs start here
- **French** - Community translations (docs/fr/)
- **Spanish** - Community translations (docs/es/)
- **German** - Community translations (docs/de/)

### Translation Process
1. English docs updated first
2. Community translators notified (Discord #translations)
3. PRs submitted for translations
4. Core team reviews for accuracy

### Translation Requirements
- ✅ Keep same structure as English
- ✅ Preserve code examples (English OK in code)
- ✅ Add `[Translated from English vX.X.X]` note
- ✅ Update when English docs change

## 📊 Metrics & Analytics

### Track
- **Downloads** : npm stats (public)
- **Usage** : GitHub Insights (public)
- **Issues** : Response time (aim: < 48h)
- **PRs** : Time to merge (aim: < 7 days)
- **Bundle size** : Track every release (stay < 10kb)

### Goals (2025)
- [ ] 1M downloads/month
- [ ] 100 contributors
- [ ] < 50 open issues (triage regularly)
- [ ] Response time < 24h for critical bugs

## 🙏 Acknowledgments

**Thanks to** :
- All contributors (see CONTRIBUTORS.md)
- Sponsors (see README.md)
- Community for feedback and support

**Inspired by** :
- lodash (utility library design)
- date-fns (modular approach)
- zod (TypeScript-first philosophy)

---

## 💡 Maintainer Notes

**Time Commitment** : ~10h/week average
- Issue triage: 2h
- PR reviews: 4h
- Development: 3h
- Community: 1h

**Burnout Prevention** :
- Take breaks (it's OK to slow down)
- Delegate to core team
- Set boundaries (response time expectations)
- Prioritize high-impact work

**Decision Making** :
- **Solo decision** : Bug fixes, small improvements
- **Core team vote** : New features, architecture changes
- **RFC process** : Breaking changes, major features

---

## 🔄 Maintenance

**Last updated** : 2025-01-15
**Next review** : Quarterly
**Current version** : v2.1.0
**Next planned release** : v2.2.0 (February 2025)

**Upcoming** :
- [ ] Add `debounce` and `throttle` utilities
- [ ] Performance benchmarks suite
- [ ] VSCode extension for autocomplete
- [ ] Video tutorials on YouTube
