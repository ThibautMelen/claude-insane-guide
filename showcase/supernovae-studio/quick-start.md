# 🚀 Supernovae Studio - Quick Start Guide

## 📋 Overview

**Supernovae Studio** est un exemple production-ready d'une marketplace de plugins Claude Code avec architecture moderne et patterns avancés.

---

## ⚡ Setup en 10 Minutes

### 1️⃣ Prérequis

```bash
# Vérifier les prérequis
node --version  # >= 18.x
npm --version   # >= 9.x
git --version   # >= 2.x
```

### 2️⃣ Clone & Install

```bash
# Clone le projet
git clone https://github.com/SuperNovae-studio/marketplace
cd marketplace

# Installer les dépendances
npm install

# Copier l'environnement
cp .env.example .env
```

### 3️⃣ Configuration Claude Code

Ajouter dans `~/.claude/CLAUDE.md` :

```markdown
## 🏢 Supernovae Studio Config

- **Organization**: Supernovae Studio
- **Role**: Developer
- **Project**: Claude Code Marketplace
- **Stack**: Next.js 14, Supabase, Tailwind
```

### 4️⃣ Setup Supabase

```bash
# Installer Supabase CLI
npm install -g supabase

# Initialiser
supabase init

# Lancer localement
supabase start

# Obtenir les clés
supabase status
```

Copier les clés dans `.env` :

```env
NEXT_PUBLIC_SUPABASE_URL=http://localhost:54321
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_KEY=your-service-key
```

### 5️⃣ Installer les Plugins

```bash
# Plugin 1: Local-Global Info
npm install -g @supernovae/local-global-info

# Plugin 2: Traduction
npm install -g @supernovae/plugin-traduction

# Plugin 3: QR Code AI
npm install -g @supernovae/qr-code-ai
```

### 6️⃣ Configuration MCP

Ajouter dans `~/.config/claude-code/config.json` :

```json
{
  "mcpServers": {
    "local-global-info": {
      "command": "npx",
      "args": ["-y", "@supernovae/local-global-info"]
    },
    "plugin-traduction": {
      "command": "npx",
      "args": ["-y", "@supernovae/plugin-traduction"],
      "env": {
        "DEEPL_API_KEY": "your-key-from-1password"
      }
    },
    "qr-code-ai": {
      "command": "npx",
      "args": ["-y", "@supernovae/qr-code-ai"]
    }
  }
}
```

### 7️⃣ Lancer le Projet

```bash
# Mode développement
npm run dev

# Ouvrir
open http://localhost:3000

# Tester les plugins
npm run test:plugins
```

### 8️⃣ Créer un Slash Command

Créer `.claude/commands/marketplace.md` :

```markdown
---
title: Marketplace
description: Ouvrir la marketplace de plugins
---

Ouvre la marketplace Supernovae Studio dans le navigateur :

```bash
open https://marketplace.supernovae.studio
```
```

### 9️⃣ Déployer sur Vercel

```bash
# Installer Vercel CLI
npm install -g vercel

# Déployer
vercel

# Suivre les prompts
# - Link to existing project? No
# - What's your project name? supernovae-marketplace
# - In which directory? ./
# - Override settings? No
```

### 🔟 Vérification Finale

```bash
# Vérifier que tout fonctionne
npm run check:all

# Résultat attendu:
# ✅ TypeScript: No errors
# ✅ ESLint: All files pass
# ✅ Tests: 42 passed
# ✅ Build: Success
# ✅ Plugins: All responding
```

---

## 🏗️ Architecture Technique

### Stack Principal

```
┌─────────────────────────────────┐
│         Next.js 14 (App)        │
├─────────────────────────────────┤
│      Supabase (Backend)         │
│  ┌──────────┬──────────────┐   │
│  │ Auth     │ Database     │   │
│  │ Storage  │ Realtime     │   │
│  └──────────┴──────────────┘   │
├─────────────────────────────────┤
│     Tailwind CSS (Style)        │
├─────────────────────────────────┤
│        Vercel (Deploy)          │
└─────────────────────────────────┘
```

### Patterns Utilisés

1. **Monorepo Structure**
   - Apps: marketplace, admin, docs
   - Packages: ui, utils, types
   - Plugins: local-global, traduction, qr-code

2. **Plugin Architecture**
   - Standard MCP protocol
   - NPM global install
   - Auto-discovery via registry

3. **State Management**
   - Zustand pour client state
   - React Query pour server state
   - Optimistic updates

4. **Type Safety**
   - TypeScript strict mode
   - Zod validation
   - tRPC pour API

---

## 📊 Analyse Technique

### Décisions Architecturales

| Aspect | Choix | Justification |
|--------|-------|---------------|
| **Framework** | Next.js 14 | App Router, RSC, Performance |
| **Database** | Supabase | PostgreSQL + Auth + Realtime intégré |
| **Styling** | Tailwind | Rapid prototyping, consistent design |
| **Deployment** | Vercel | Seamless Next.js integration |
| **Plugins** | MCP Protocol | Standard Claude Code, extensible |

### Performance Metrics

```
┌──────────────────────────────────┐
│   Lighthouse Scores              │
├──────────────────────────────────┤
│ Performance      : 98/100        │
│ Accessibility    : 100/100       │
│ Best Practices   : 100/100       │
│ SEO              : 100/100       │
└──────────────────────────────────┘

┌──────────────────────────────────┐
│   Bundle Size                    │
├──────────────────────────────────┤
│ First Load JS    : 82kb          │
│ Shared Chunks    : 45kb          │
│ Total            : 127kb         │
└──────────────────────────────────┘
```

### Trade-offs

**✅ Avantages:**
- Setup rapide avec Supabase
- Type-safety end-to-end
- Real-time updates natifs
- Auth intégré

**⚠️ Limitations:**
- Vendor lock-in Supabase
- Coût scaling database
- Complexité monorepo

---

## 🎯 Production Insights

### Lessons Learned

1. **MCP Protocol**
   - Standardiser early saves time
   - Global npm install = better UX
   - Registry pattern scales well

2. **Monorepo Benefits**
   - Shared types prevent drift
   - Unified testing strategy
   - Easier refactoring

3. **Supabase ROI**
   - 80% faster MVP delivery
   - Built-in auth saves weeks
   - RLS simplifies security

### Optimisations Appliquées

```javascript
// 1. Dynamic imports pour plugins
const PluginComponent = dynamic(
  () => import(`@/plugins/${pluginName}`),
  { ssr: false }
);

// 2. Image optimization
<Image
  src={plugin.icon}
  alt={plugin.name}
  width={48}
  height={48}
  loading="lazy"
/>

// 3. Database indexes
CREATE INDEX idx_plugins_category ON plugins(category);
CREATE INDEX idx_plugins_downloads ON plugins(downloads DESC);

// 4. Caching strategy
export const revalidate = 3600; // ISR 1 hour
```

---

## 🚀 Next Steps

### Pour Développeurs

1. **Créer votre plugin** : Voir [Plugin Development Guide](./docs/plugin-development.md)
2. **Contribuer** : PRs welcome sur [GitHub](https://github.com/SuperNovae-studio/marketplace)
3. **Report bugs** : [Issues](https://github.com/SuperNovae-studio/marketplace/issues)

### Pour Utilisateurs

1. **Explorer plugins** : [marketplace.supernovae.studio](https://marketplace.supernovae.studio)
2. **Installer favoris** : `npm install -g @supernovae/[plugin-name]`
3. **Donner feedback** : Discord #plugins channel

---

## 📚 Documentation Complète

- [Architecture Détaillée](./architecture.md)
- [Plugin Development](./docs/plugin-development.md)
- [API Reference](./docs/api.md)
- [Contributing Guide](./CONTRIBUTING.md)

---

> 💡 **Pro Tip**: Utilisez le template `create-supernovae-plugin` pour
> démarrer rapidement : `npx create-supernovae-plugin my-awesome-plugin`