# CLAUDE.md - Agency Client Project

> Memory projet-spécifique pour client agency

**Emplacement** : `.claude/CLAUDE.md` (Project-specific)

**📋 Combine avec** : `~/.claude/CLAUDE.md` (global preferences)

## 🎯 Project Info

### Client
- **Name** : Fashion Brand XYZ
- **Industry** : E-commerce Fashion
- **Contact** : contact@fashionxyz.com
- **Project Manager** : Marie Dubois

### Project
- **Name** : E-commerce Platform Redesign
- **Type** : Web application (customer-facing + backoffice)
- **Timeline** : 6 months (Jan 2025 - Jun 2025)
- **Budget** : [Confidentiel]
- **Launch Date** : June 1st, 2025

### Team
- **Developers** : 2 (moi + junior dev)
- **Designer** : 1 (client-side)
- **PM** : 1 (client-side)

## 🎨 Brand Guidelines

### Design System
- **Primary Color** : `#FF6B6B` (coral red)
- **Secondary Color** : `#4ECDC4` (turquoise)
- **Accent** : `#FFD93D` (yellow)
- **Neutral** : `#2C3E50` (dark blue-gray)
- **Background** : `#F7F9FB` (light gray)

### Typography
- **Headings** : Playfair Display (serif)
- **Body** : Inter (sans-serif)
- **Code** : JetBrains Mono (monospace)

### Design Files
- **Figma** : https://www.figma.com/file/xxxxx
- **Style Guide** : `docs/design-system.md`
- **Components** : `src/components/design-system/`

## 🏗️ Tech Stack

### Architecture
- **Type** : Monorepo (Turborepo)
- **Structure** :
  ```
  apps/
  ├── web/          # Customer-facing (Next.js)
  ├── admin/        # Backoffice (Next.js)
  └── mobile/       # Future mobile app (React Native)
  packages/
  ├── ui/           # Shared components
  ├── types/        # TypeScript types
  ├── utils/        # Shared utilities
  └── config/       # ESLint, Tailwind configs
  ```

### Frontend (apps/web)
- **Framework** : Next.js 14 (App Router)
- **Language** : TypeScript strict
- **Styling** : Tailwind CSS + Custom design system
- **State** : Zustand (cart, user) + React Query (API)
- **Forms** : React Hook Form + Zod
- **Animation** : Framer Motion

### Backend
- **API** : Next.js API Routes
- **Database** : PostgreSQL (Supabase)
- **Auth** : NextAuth.js (email + Google + Facebook)
- **Payment** : Stripe
- **Email** : SendGrid
- **CMS** : Sanity.io (product content)

### Third-Party Integrations
- **Analytics** : Google Analytics 4
- **Tracking** : Meta Pixel, Google Tag Manager
- **Live Chat** : Intercom
- **Shipping** : Shippo API
- **Inventory** : Client's legacy system (REST API)

## 📝 Client Requirements (CRITICAL)

### Browser Support
- ✅ **Modern browsers** : Chrome, Firefox, Safari, Edge (last 2 versions)
- ✅ **IE11 support** : ⚠️ REQUIRED (client has legacy users)
  - Use polyfills
  - Transpile to ES5
  - Test on BrowserStack

### Languages
- ✅ **Bilingual** : French (primary) + English
- ✅ **i18n** : next-i18next
- ✅ **Currency** : EUR (€) + USD ($)
- ✅ **Date format** : FR (DD/MM/YYYY) + EN (MM/DD/YYYY)

### Compliance
- ✅ **GDPR** : Cookie consent, data privacy, right to be forgotten
- ✅ **Accessibility** : WCAG AA minimum
- ✅ **SEO** : SSR, meta tags, sitemap, structured data
- ✅ **Performance** : LCP < 2.5s, FID < 100ms, CLS < 0.1

### Security
- ✅ **PCI DSS** : Stripe handles payment (compliant)
- ✅ **SSL** : HTTPS everywhere
- ✅ **Rate limiting** : On auth and API endpoints
- ✅ **Data encryption** : At rest and in transit

## 🔄 Workflow

### Branch Strategy (Git Flow)
```
main                   # Production (protected)
  └─> develop          # Staging
       └─> feature/*   # Feature branches
       └─> hotfix/*    # Urgent fixes
```

### Environment Setup
```
Development  : localhost:3000        (local)
Staging      : staging.fashionxyz.com (Vercel)
Production   : www.fashionxyz.com     (Vercel)
```

### Deployment
- **Development** : Auto-deploy on push to `develop`
- **Staging** : Manual trigger via GitHub Actions
- **Production** : Manual approval + deploy (Fridays only)

### Code Review
- ✅ **Required** : 1 approval (moi pour junior dev, client PM optionnel)
- ✅ **Checklist** :
  - Tests pass
  - No console errors
  - Responsive on mobile/tablet/desktop
  - Works on IE11 (if UI changes)
  - Accessible (keyboard nav, screen reader)
  - i18n strings translated

## 📋 Feature Development Pattern

### 1. Product Card Component Example

```typescript
// 1. Define in design system
// packages/ui/src/ProductCard.tsx
interface ProductCardProps {
  product: Product;
  onAddToCart: (id: string) => void;
  locale: 'fr' | 'en';
}

export function ProductCard({ product, onAddToCart, locale }: ProductCardProps) {
  // Responsive
  // Accessible (aria-labels)
  // i18n support
  // Framer Motion animations
  // Optimized images (next/image)
}

// 2. Add to Storybook
// packages/ui/src/ProductCard.stories.tsx
export default {
  title: 'Components/ProductCard',
  component: ProductCard,
};

// 3. Write tests
// packages/ui/src/ProductCard.test.tsx
describe('ProductCard', () => {
  it('renders product info correctly', () => {
    // ...
  });
  it('calls onAddToCart when button clicked', () => {
    // ...
  });
  it('displays correct currency based on locale', () => {
    // ...
  });
});

// 4. Use in app
// apps/web/app/products/page.tsx
import { ProductCard } from '@repo/ui';
```

### 2. API Endpoint Pattern

```typescript
// apps/web/app/api/products/[id]/route.ts
import { z } from 'zod';

const productIdSchema = z.string().uuid();

export async function GET(
  request: Request,
  { params }: { params: { id: string } }
) {
  try {
    // 1. Validate input
    const id = productIdSchema.parse(params.id);

    // 2. Fetch from Sanity CMS
    const product = await sanityClient.fetch(
      `*[_type == "product" && _id == $id][0]`,
      { id }
    );

    // 3. Return response
    return Response.json({ product });
  } catch (error) {
    // 4. Error handling
    if (error instanceof z.ZodError) {
      return Response.json({ error: 'Invalid product ID' }, { status: 400 });
    }
    return Response.json({ error: 'Internal server error' }, { status: 500 });
  }
}
```

## 🚫 Project-Specific Never Do

### Code
- ❌ Use client's competitor brands in examples → Use generic names
- ❌ Hard-code product data → Must come from Sanity CMS
- ❌ Skip IE11 testing → Client requirement (legacy users)
- ❌ Use external CDNs → Self-host assets (client security policy)

### Design
- ❌ Deviate from Figma designs → Must match exactly
- ❌ Use colors outside brand palette → Stick to design system
- ❌ Add animations without approval → Client prefers subtle
- ❌ Change font families → Brand guidelines strict

### Communication
- ❌ Push to production without client approval → Always notify
- ❌ Miss weekly demo deadline → Fridays 3pm CET (hard deadline)
- ❌ Skip progress updates → Daily Slack message required
- ❌ Commit incomplete features to develop → Break into smaller tasks

## 📊 Reporting & Communication

### Daily (Async)
**Slack message to #dev-channel** :
```
📊 Daily Update - [Date]

✅ Completed:
- [Task 1]
- [Task 2]

🔄 In Progress:
- [Task 3] (60% done)

⚠️ Blockers:
- [Issue if any]

🎯 Tomorrow:
- [Plan]
```

### Weekly (Sync)
**Video call - Fridays 3pm CET** :
- Demo new features on staging
- Gather feedback
- Discuss next week priorities
- Address any concerns

### Monthly (Sync)
**Review meeting** :
- Progress vs timeline
- Budget status
- Upcoming milestones
- Adjust scope if needed

## 📚 Resources

### Documentation
- **Figma** : https://www.figma.com/file/xxxxx
- **Sanity Studio** : https://fashionxyz.sanity.studio
- **Staging Admin** : https://staging.fashionxyz.com/admin
- **API Docs** : `docs/api.md`

### Credentials (1Password)
- **Sanity** : [Vault: Fashion XYZ]
- **Stripe** : [Vault: Fashion XYZ]
- **SendGrid** : [Vault: Fashion XYZ]
- **GA4** : [Vault: Fashion XYZ]

### Contacts
- **PM** : Marie Dubois (marie@fashionxyz.com)
- **Designer** : Sophie Martin (sophie@fashionxyz.com)
- **CTO** : Jean Dupont (jean@fashionxyz.com) [Technical approvals]

---

## 💡 Notes

**Client Personality** :
- Detail-oriented (expect pixel-perfect)
- Prefers frequent updates
- Open to suggestions (but final say is theirs)
- Appreciates proactive communication

**Payment Terms** :
- Monthly invoicing (end of month)
- Net 15 days
- 30% upfront, 40% mid-project, 30% at launch

**Project Phase** : Currently in Phase 2 (Development)
- ✅ Phase 1: Discovery & Design (completed)
- 🔄 Phase 2: Development (in progress - 40% done)
- ⏳ Phase 3: Testing & QA (upcoming)
- ⏳ Phase 4: Launch & Handoff (June 2025)

---

## 🔄 Maintenance

**Last updated** : 2025-01-15
**Next client review** : 2025-02-01
**Contract end date** : 2025-06-30

**Update this file when** :
- Requirements change
- New integrations added
- Team members change
- Phase transitions
