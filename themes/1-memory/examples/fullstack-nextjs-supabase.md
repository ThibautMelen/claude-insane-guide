# CLAUDE.md - Startup Full-Stack (Next.js + Supabase)

> Exemple réel : Memory pour une startup en phase MVP

## 🎯 Project Context

- **Type** : Web app SaaS
- **Objectif** : MVP pour product launch Q1 2025
- **Team** : 2 devs + 1 designer
- **Stack** : Next.js 14 + Supabase + Tailwind
- **Timeline** : 3 mois sprint vers lancement

## 🏗️ Tech Stack

### Frontend
- **Framework** : Next.js 14 (App Router)
- **Language** : TypeScript (strict mode)
- **Styling** : Tailwind CSS + shadcn/ui
- **State** : Zustand (global) + React Query (server state)
- **Forms** : React Hook Form + Zod validation
- **Icons** : Lucide React

### Backend
- **BaaS** : Supabase (Auth + Database + Storage + Edge Functions)
- **Database** : PostgreSQL (via Supabase)
- **ORM** : Supabase Client SDK
- **Validation** : Zod schemas
- **API** : Next.js API Routes + Server Actions

### Testing
- **Unit** : Vitest
- **E2E** : Playwright
- **Coverage target** : 80% minimum

### Deployment
- **Platform** : Vercel (production + preview)
- **CI/CD** : GitHub Actions
- **Monitoring** : Vercel Analytics + Sentry

## 📝 Code Style

### Formatting
- **Indentation** : 2 spaces
- **Quotes** : single quotes
- **Semicolons** : yes
- **Line length** : 100 characters

### Naming Conventions
- **Components** : PascalCase (`UserProfile.tsx`)
- **Functions** : camelCase (`getUserData()`)
- **Constants** : UPPER_SNAKE_CASE (`API_BASE_URL`)
- **Files** : kebab-case (`api-client.ts`)

### Language
- **Code/Commits** : English only
- **Comments** : English
- **Documentation** : English

## ✅ Development Rules

### CRITICAL (Must Have)
1. ✅ **All features require tests** (80% coverage minimum)
2. ✅ **Zod validation** on all API routes and Server Actions
3. ✅ **Error boundaries** on all pages and critical components
4. ✅ **Responsive design** mobile-first (Tailwind breakpoints)
5. ✅ **Accessibility** WCAG AA minimum (aria labels, keyboard nav)

### IMPORTANT (Should Have)
- **Loading states** : Suspense boundaries + skeleton loaders
- **Error states** : User-friendly error messages
- **Optimistic updates** : React Query optimistic mutations
- **SEO** : Metadata API for all public pages
- **Performance** : Lighthouse score > 90

### OPTIONAL (Nice to Have)
- **Storybook** : For design system components
- **E2E tests** : Critical user flows only
- **Performance monitoring** : Web Vitals tracking

## 🏗️ Project Architecture

```
src/
├── app/                    # Next.js App Router
│   ├── (auth)/            # Auth pages group
│   ├── (dashboard)/       # Protected dashboard
│   └── api/               # API routes
├── components/
│   ├── ui/                # shadcn/ui components
│   ├── features/          # Feature-specific components
│   └── layouts/           # Layout components
├── lib/
│   ├── supabase/          # Supabase client & helpers
│   ├── hooks/             # Custom React hooks
│   └── utils/             # Utility functions
├── types/                 # TypeScript types
└── schemas/               # Zod validation schemas
```

## 🔐 Security

### CRITICAL Rules
- ✅ **Never commit** `.env` files (use `.env.example`)
- ✅ **Use Supabase RLS** (Row Level Security) for ALL tables
- ✅ **Validate all user inputs** with Zod schemas
- ✅ **Sanitize all database queries** (use parameterized queries)
- ✅ **Use HTTPS only** in production
- ✅ **Implement rate limiting** on auth endpoints

### Best Practices
- Store secrets in Vercel Environment Variables
- Use Supabase Vault for sensitive data
- Implement CSRF protection on forms
- Add security headers (via next.config.js)

## 📋 Workflow

### Branch Strategy
**GitHub Flow** (simple for small team):
```
main (production)
  ↓
feature/add-user-profile
  ↓
Merge to main after review
```

### Commit Convention
**Conventional Commits** :
```
feat(auth): add email verification flow
fix(api): handle null response in getUserData
docs(readme): update installation steps
refactor(hooks): simplify useAuth logic
test(auth): add edge case for expired tokens
chore(deps): update React to v18
```

### PR Process
1. ✅ Create feature branch from `main`
2. ✅ Run `npm test` locally (must pass)
3. ✅ Run `npm run lint` (auto-fix if needed)
4. ✅ Push to remote
5. ✅ Open PR with template
6. ✅ Request review from 1 team member
7. ✅ Deploy to preview (automatic via Vercel)
8. ✅ Merge when approved (squash merge)

### Pre-Commit Checklist
```bash
# Always run before commit
npm run type-check  # TypeScript compilation
npm run lint        # ESLint
npm test            # Vitest
```

## 🚫 Never Do

### Code Quality
- ❌ Use `any` type in TypeScript → Use proper typing
- ❌ Skip error handling → Always try/catch async
- ❌ Hard-code credentials → Use env variables
- ❌ Commit without tests → Tests required

### Supabase Specific
- ❌ Query without RLS → Enable RLS on all tables
- ❌ Expose service key → Use anon key in client
- ❌ Skip migration files → Always create migrations
- ❌ Direct SQL in client → Use Supabase client methods

### Workflow
- ❌ Push directly to `main` → Use feature branches
- ❌ Merge without review → 1 approval required
- ❌ Skip PR template → Always fill template
- ❌ Deploy without testing → Test locally first

## 🎯 Feature Development Template

**Quand tu crées une nouvelle feature, suis ce pattern** :

```typescript
// 1. Define Zod schema
export const createUserSchema = z.object({
  email: z.string().email(),
  name: z.string().min(2),
});

// 2. Create Server Action
export async function createUser(data: z.infer<typeof createUserSchema>) {
  try {
    const validated = createUserSchema.parse(data);
    const { data: user, error } = await supabase
      .from('users')
      .insert(validated);
    if (error) throw error;
    return { success: true, data: user };
  } catch (error) {
    return { success: false, error: error.message };
  }
}

// 3. Create component with form
export function CreateUserForm() {
  // React Hook Form + Zod
  // Loading/error states
  // Optimistic updates
  // Accessibility
}

// 4. Write tests
describe('createUser', () => {
  it('should create user with valid data', async () => {
    // ...
  });
  it('should reject invalid email', async () => {
    // ...
  });
});
```

## 📚 Resources

### Documentation
- **Design System** : https://www.figma.com/file/xxx (Figma)
- **API Docs** : `docs/api.md` (internal)
- **Architecture** : `docs/architecture.md` (internal)

### Team Communication
- **Slack** : #dev-team (daily updates)
- **Stand-ups** : Every morning 9:30 AM (async on Slack)
- **Retros** : Every 2 weeks (Friday)
- **Planning** : Monthly (first Monday)

### Quick Links
- **Production** : https://myapp.com
- **Staging** : https://staging.myapp.com
- **Supabase Dashboard** : https://app.supabase.com/project/xxx
- **Vercel Dashboard** : https://vercel.com/team/myapp

---

## 💡 Notes

**Last updated** : 2025-01-15
**Maintainer** : @dev-team
**Review frequency** : Monthly

**Changelog** :
- 2025-01-15 : Initial setup
- 2025-01-20 : Added Zod validation requirement
- 2025-02-01 : Increased test coverage to 80%
