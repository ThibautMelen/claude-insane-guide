# CLAUDE.md - Agency Freelance (Global)

> Memory globale pour développeur freelance multi-projets

**Emplacement** : `~/.claude/CLAUDE.md` (Global - tous projets)

## 👤 Personal Profile

- **Name** : [Votre nom]
- **Role** : Freelance Full-Stack Developer
- **Specialization** : Web apps (React/Next.js ecosystem)
- **Experience** : [X années]
- **Location** : [Ville, Pays]

## 💬 Communication Style

### Language
- **Conversations** : Franglais (FR discussions, EN code)
- **Code/Commits** : English only
- **Documentation** : English (client-facing), French (internal)
- **Comments** : English

### Examples
```
✅ "Je vais implement cette feature avec un useEffect hook"
✅ "Le component render mais le state n'update pas, je debug"
❌ "Je vais implémenter cette fonctionnalité avec un crochet useEffect"
```

## 🛠️ Tools & Environment

### Editor
- **Primary** : VS Code
- **Theme** : GitHub Dark
- **Extensions** :
  - ESLint
  - Prettier
  - Tailwind IntelliSense
  - GitLens
  - Error Lens

### Terminal
- **Shell** : Zsh (Oh My Zsh)
- **Terminal** : Warp
- **Multiplexer** : tmux

### Version Control
- **Git** : GitHub
- **CLI** : gh (GitHub CLI)
- **Convention** : Conventional Commits

### Package Manager
- **Preferred** : npm (consistent across projects)
- **Not** : yarn, pnpm (avoid mixing)

## 📝 Code Style (All Projects)

### TypeScript
- ✅ **Strict mode** always enabled
- ✅ **No `any` type** → Use proper typing or `unknown`
- ✅ **Interfaces over types** for objects
- ✅ **Enums** for fixed sets of values

### Programming Paradigm
- ✅ **Functional programming** preferred
- ✅ **Immutability** by default (const, no mutations)
- ✅ **Pure functions** when possible
- ✅ **Composition over inheritance**

### Code Patterns
- ✅ **Early returns** over nested conditions
- ✅ **Destructure** props and parameters
- ✅ **Async/await** over promise chains
- ✅ **Optional chaining** (`?.`) for safety
- ✅ **Nullish coalescing** (`??`) over `||`

### React Specific
- ✅ **Functional components** only (no class components)
- ✅ **Hooks** for state and effects
- ✅ **Custom hooks** for reusable logic
- ✅ **Memoization** (useMemo, useCallback) when needed
- ✅ **Error boundaries** for critical sections

### Formatting
- **Indentation** : 2 spaces
- **Quotes** : Single quotes
- **Semicolons** : Yes
- **Line length** : 100 characters
- **Trailing commas** : Yes (ES5)

### Naming Conventions
- **Components** : PascalCase (`UserProfile`)
- **Functions** : camelCase (`getUserData`)
- **Constants** : UPPER_SNAKE_CASE (`API_BASE_URL`)
- **Private vars** : Leading underscore (`_internalCache`)
- **Files** : kebab-case (`user-profile.tsx`)
- **Folders** : kebab-case (`user-management/`)

## ✅ Development Workflow

### Testing
- **Philosophy** : TDD (Test-Driven Development) preferred
- **Coverage** : Minimum 80% for features
- **Tools** : Vitest (unit) + Playwright (E2E)
- **Pattern** :
  ```
  1. Write test (red)
  2. Implement feature (green)
  3. Refactor (refactor)
  ```

### Commits
- **Convention** : Conventional Commits
- **Format** :
  ```
  type(scope): description

  [optional body]

  [optional footer]
  ```
- **Types** : feat, fix, docs, refactor, test, chore
- **Scope** : Component or module affected
- **AI Co-authorship** :
  ```
  feat(auth): add JWT token validation

  Co-Authored-By: Claude <noreply@anthropic.com>
  ```

### Documentation
- ✅ **README.md** for every project
- ✅ **Inline comments** for complex logic
- ✅ **JSDoc** for public APIs
- ✅ **Architecture docs** for client handoff

## 🚫 Never Do (Global Rules)

### Code Quality
- ❌ Use `any` in TypeScript → Proper typing required
- ❌ Commit without tests → Tests mandatory
- ❌ Skip error handling → Always try/catch async
- ❌ Hard-code credentials → Environment variables
- ❌ Leave TODO comments → Create issues instead
- ❌ Copy-paste code > 3 times → Extract function/component

### Security
- ❌ Commit `.env` files → Use `.env.example`
- ❌ Log sensitive data → Sanitize logs
- ❌ Trust user input → Validate everything
- ❌ Use `eval()` → Never, ever
- ❌ Expose API keys → Server-side only

### Performance
- ❌ Premature optimization → Profile first
- ❌ Unnecessary re-renders → Memoize wisely
- ❌ Synchronous heavy ops → Use Web Workers
- ❌ Uncompressed images → Optimize assets

### Workflow
- ❌ Push directly to main → Feature branches
- ❌ Merge without review → Self-review minimum
- ❌ Skip linting → Auto-fix before commit
- ❌ Ignore warnings → Fix or suppress explicitly

## 🎯 Project Initialization Checklist

**Quand je start un nouveau projet client** :

### Setup
- [ ] Clone/init repo
- [ ] Run `/init` pour créer `.claude/CLAUDE.md` local
- [ ] Install dependencies
- [ ] Configure ESLint + Prettier
- [ ] Setup environment variables

### Memory
- [ ] Create `.claude/CLAUDE.md` project-specific
- [ ] Define tech stack
- [ ] Add client requirements
- [ ] Document architecture decisions

### Git
- [ ] Create `.gitignore` (node_modules, .env, etc.)
- [ ] Create `.env.example`
- [ ] Initial commit
- [ ] Create `main` branch protection rules

### Documentation
- [ ] Write `README.md` (setup, run, deploy)
- [ ] Create `CONTRIBUTING.md` if team
- [ ] Add license file
- [ ] Document API endpoints

### Client Communication
- [ ] Clarify requirements
- [ ] Define milestones
- [ ] Setup project management tool (Notion/Trello)
- [ ] Schedule check-ins

## 📊 Client Management

### Communication Frequency
- **Daily** : Progress updates (async via email/Slack)
- **Weekly** : Demo + feedback session (1h video call)
- **Monthly** : Retrospective + planning

### Deliverables
- **Code** : GitHub repository access
- **Docs** : README + architecture diagrams
- **Deploy** : Staging + production URLs
- **Handoff** : 1-2h training session

### Billing
- **Time tracking** : Toggl (daily)
- **Invoicing** : Monthly (detailed breakdown)
- **Payment** : [Terms - Net 30, etc.]

## 🔧 Common Commands (Cross-Project)

```bash
# Development
npm run dev          # Start dev server
npm run build        # Production build
npm run preview      # Preview build

# Testing
npm test             # Run tests
npm run test:watch   # Watch mode
npm run test:coverage # Coverage report

# Quality
npm run lint         # Check linting
npm run lint:fix     # Auto-fix
npm run type-check   # TypeScript validation
npm run format       # Prettier format

# Git
git add .
git commit -m "feat(scope): description"
git push origin feature-branch

# Deploy (varies by project)
npm run deploy       # Or: vercel --prod
```

## 📚 Resources

### Learning
- **Docs** : MDN, React docs, Next.js docs
- **Courses** : [Your favorite platforms]
- **Newsletters** : [Your subscriptions]

### Design
- **Inspiration** : Dribbble, Behance, Awwwards
- **Icons** : Lucide, Heroicons
- **Fonts** : Google Fonts, Font Awesome

### Tools
- **Design** : Figma, Excalidraw
- **Project Management** : Notion, Linear
- **Communication** : Slack, Discord, Email

---

## 💡 Philosophy

**Quality over speed** : Take time to do it right
**DRY** : Don't repeat yourself (extract reusable logic)
**KISS** : Keep it simple, stupid (avoid over-engineering)
**YAGNI** : You aren't gonna need it (no premature features)
**Document for future self** : You'll forget in 6 months

**Quote** :
> "Code is read more often than it's written. Write for humans, not machines."

---

## 🔄 Maintenance

**Review this file** : Every 3 months
**Update when** :
- New tools adopted
- Workflow changes
- Lessons learned from projects

**Last updated** : [Date]
**Next review** : [Date + 3 months]
