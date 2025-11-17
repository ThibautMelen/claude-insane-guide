# 🗿 Ultra Status Line - Guide Complet

Status line ultra stylée pour Claude Code avec vraies données, emojis tropicaux et progress bars colorées !

---

## 📊 Vue d'ensemble

La status line affiche **3 lignes** d'informations en temps réel :

```
Ligne 1: Git & Path & Model
Ligne 2: Session avec progress bar colorée
Ligne 3: Stats de la session
```

---

## 🎨 Exemples Visuels

### 🌴 Usage Très Bas (< 10%)

```
main* (+42 -15) ◆ ~/.claude/my-project ◆ 💎 Sonnet 4.5
┣━━ 🗿 Session → 💰 $0.03 • 🧠 12.5k/200k • [▰░░░░░░░░░] 🌴🥥 6%
┗━━ 📊 Stats → ⏱️ 2m 15s • 📝 +42 -15 • 💸 $0.013/min
```

**Signification :**
- 🌴🥥 = Contexte quasi vide, coconut chill vibes
- Vert lime = Tout va bien
- 6% de contexte utilisé

---

### 🏝️ Usage Minimal (10-20%)

```
feature/auth ◆ ~/projects/api ◆ 🌸 Haiku 3.5
┣━━ 🗿 Session → 💰 $0.08 • 🧠 25.3k/200k • [▰▰░░░░░░░░] 🏝️🦜 12%
┗━━ 📊 Stats → ⏱️ 5m 42s • 📝 +128 -64 • 💸 $0.014/min
```

**Signification :**
- 🏝️🦜 = Minimal usage, island parrot
- 🌸 Haiku = Modèle rapide et économique
- 12% de contexte

---

### 🐬 Usage Bas (20-30%)

```
no-git ◆ ~/.claude/scripts ◆ 👑 Opus 4.1
┣━━ 🗿 Session → 💰 $0.45 • 🧠 52.1k/200k • [▰▰▰░░░░░░░] 🌴🐬 26%
┗━━ 📊 Stats → ⏱️ 8m 12s • 📝 +256 -89 • 💸 $0.055/min
```

**Signification :**
- 🌴🐬 = Très bas, dolphin vibes
- 👑 Opus = Modèle le plus puissant
- 26% de contexte

---

### 🌺 Usage Moyen-Bas (30-40%)

```
dev ◆ ~/workspace/frontend ◆ 💎 Sonnet 4.5
┣━━ 🗿 Session → 💰 $1.23 • 🧠 78.4k/200k • [▰▰▰▰░░░░░░] 🌴🌺 39%
┗━━ 📊 Stats → ⏱️ 15m 33s • 📝 +512 -203 • 💸 $0.079/min
```

**Signification :**
- 🌴🌺 = Usage bas, hibiscus flowers
- Vert lime = Toujours safe
- 39% de contexte

---

### 🌊 Usage Moyen (40-50%)

```
main* (+185 -75) ◆ ~/dev/app ◆ 💎 Sonnet 4.5
┣━━ 🗿 Session → 💰 $2.15 • 🧠 95.7k/200k • [▰▰▰▰▰░░░░░] 🌊💙 47%
┗━━ 📊 Stats → ⏱️ 22m 18s • 📝 +1024 -456 • 💸 $0.096/min
```

**Signification :**
- 🌊💙 = Moyen-bas, ocean waves vibes
- Turquoise = Transition vers usage normal
- 47% de contexte

---

### ✨ Usage Normal (50-60%)

```
hotfix/bug-123 ◆ ~/.config ◆ 💎 Sonnet 4.5
┣━━ 🗿 Session → 💰 $3.45 • 🧠 112k/200k • [▰▰▰▰▰▰░░░░] ✨⭐ 56%
┗━━ 📊 Stats → ⏱️ 35m 47s • 📝 +1337 -420 • 💸 $0.096/min
```

**Signification :**
- ✨⭐ = Usage moyen, starry
- Cyan = Usage normal
- 56% de contexte

---

### 💫 Usage Moyen-Haut (60-70%)

```
refactor ◆ ~/projects/backend ◆ 👑 Opus 4.1
┣━━ 🗿 Session → 💰 $5.67 • 🧠 135k/200k • [▰▰▰▰▰▰▰░░░] 💫✨ 67%
┗━━ 📊 Stats → ⏱️ 48m 22s • 📝 +2048 -1024 • 💸 $0.117/min
```

**Signification :**
- 💫✨ = Moyen-haut, sparkles
- Jaune/Gold = Commence à monter
- 67% de contexte

---

### ⚡ Usage Élevé (70-80%)

```
main* (+456 -234) ◆ ~/work/api ◆ 💎 Sonnet 4.5
┣━━ 🗿 Session → 💰 $8.92 • 🧠 152k/200k • [▰▰▰▰▰▰▰▰░░] ⚡🌟 76%
┗━━ 📊 Stats → ⏱️ 1h 12m 35s • 📝 +3456 -1789 • 💸 $0.123/min
```

**Signification :**
- ⚡🌟 = Usage élevé, electric star
- Jaune/Gold = Attention, ça monte
- 76% de contexte

---

### 🔥 Attention Haute (80-85%)

```
feature/* ◆ ~/dev/monorepo ◆ 👑 Opus 4.1
┣━━ 🗿 Session → 💰 $12.34 • 🧠 168k/200k • [▰▰▰▰▰▰▰▰▰░] 🔥⚠️ 84%
┗━━ 📊 Stats → ⏱️ 1h 45m 18s • 📝 +5123 -2456 • 💸 $0.117/min
```

**Signification :**
- 🔥⚠️ = Attention haute !
- Orange = Warning zone
- 84% de contexte - pense à /compact bientôt

---

### 💥 Dangereux (85-90%)

```
no-git ◆ ~/.claude/projects ◆ 💎 Sonnet 4.5
┣━━ 🗿 Session → 💰 $15.78 • 🧠 175k/200k • [▰▰▰▰▰▰▰▰▰░] 🔥💥 87%
┗━━ 📊 Stats → ⏱️ 2h 8m 42s • 📝 +7890 -3456 • 💸 $0.123/min
```

**Signification :**
- 🔥💥 = Dangereux, explosion imminent
- Rouge = Danger zone
- 87% de contexte - **compact recommandé**

---

### 💀 Très Dangereux (90-95%)

```
main* (+1024 -512) ◆ ~/mega-project ◆ 👑 Opus 4.1
┣━━ 🗿 Session → 💰 $23.45 • 🧠 185k/200k • [▰▰▰▰▰▰▰▰▰▰] 💀☠️ 92%
┗━━ 📊 Stats → ⏱️ 3h 15m 33s • 📝 +12345 -6789 • 💸 $0.120/min
```

**Signification :**
- 💀☠️ = Très dangereux, skulls !
- Rouge vif = Critical zone
- 92% de contexte - **COMPACT MAINTENANT**

---

### 🔥💀 CRITIQUE ! (> 95%)

```
hotfix ◆ ~/urgent/prod-fix ◆ 👑 Opus 4.1
┣━━ 🗿 Session → 💰 $28.90 • 🧠 193k/200k • [▰▰▰▰▰▰▰▰▰▰] 🔥💀 96%
┗━━ 📊 Stats → ⏱️ 4h 2m 18s • 📝 +15678 -8901 • 💸 $0.120/min
```

**Signification :**
- 🔥💀 = DANGER CRITIQUE !!!
- Rouge intense = Limite atteinte
- 96% de contexte - **AUTO-COMPACT IMMINENT**

---

## 📖 Légende des Éléments

### Ligne 1 : Git & Path & Model

```
main* (+185 -75) ◆ ~/.claude/scripts ◆ 💎 Sonnet 4.5
│    │   │    │    │                  │   │
│    │   │    │    │                  │   └─ Nom du modèle (italic bleu clair)
│    │   │    │    │                  └───── Emoji du modèle
│    │   │    │    └──────────────────────── Path du projet
│    │   │    └───────────────────────────── Séparateur
│    │   └────────────────────────────────── Lignes supprimées
│    └────────────────────────────────────── Lignes ajoutées
└─────────────────────────────────────────── Branche Git (* = dirty)
```

### Ligne 2 : Session

```
┣━━ 🗿 Session → 💰 $2.15 • 🧠 95.7k/200k • [▰▰▰▰▰░░░░░] 🌊💙 47%
│   │           │        │         │          │             │    │
│   │           │        │         │          │             │    └─ Pourcentage
│   │           │        │         │          │             └────── Double emoji thématique
│   │           │        │         │          └──────────────────── Progress bar colorée
│   │           │        │         └─────────────────────────────── Tokens (utilisés/max)
│   │           │        └───────────────────────────────────────── Coût en USD
│   │           └────────────────────────────────────────────────── Flèche jaune
│   └────────────────────────────────────────────────────────────── Moai (toujours 🗿)
└────────────────────────────────────────────────────────────────── Décoration ASCII
```

### Ligne 3 : Stats

```
┗━━ 📊 Stats → ⏱️ 22m 18s • 📝 +1024 -456 • 💸 $0.096/min
│              │            │              │
│              │            │              └─ Coût par minute
│              │            └──────────────── Lignes ajoutées/supprimées
│              └───────────────────────────── Durée de la session
└──────────────────────────────────────────── Décoration ASCII (fin)
```

---

## 🎯 Emojis des Modèles

| Emoji | Modèle | Couleur | Style |
|-------|--------|---------|-------|
| 👑 | Opus | Turquoise | Italic |
| 💎 | Sonnet | Turquoise | Italic |
| 🌸 | Haiku | Turquoise | Italic |
| 🤖 | Autres | Turquoise | Italic |

---

## 🌴 Tableau des Emojis de Contexte

| % | Emojis | Couleur | Ambiance |
|---|--------|---------|----------|
| **0-10%** | 🌴🥥 | 🟢 Lime | Coconut chill, quasi vide |
| **10-20%** | 🏝️🦜 | 🟢 Lime | Island parrot, minimal |
| **20-30%** | 🌴🐬 | 🟢 Lime | Dolphin vibes, très bas |
| **30-40%** | 🌴🌺 | 🟢 Lime | Hibiscus flowers, bas |
| **40-50%** | 🌊💙 | 🔵 Turquoise | Ocean waves, moyen-bas |
| **50-60%** | ✨⭐ | 🔵 Cyan | Starry night, normal |
| **60-70%** | 💫✨ | 🟡 Gold | Sparkles, moyen-haut |
| **70-80%** | ⚡🌟 | 🟡 Gold | Electric star, élevé |
| **80-85%** | 🔥⚠️ | 🟠 Orange | Warning, attention |
| **85-90%** | 🔥💥 | 🔴 Red | Explosion, danger |
| **90-95%** | 💀☠️ | 🔴 Red | Skulls, très dangereux |
| **95-100%** | 🔥💀 | 🔴 Red | Fire skull, CRITIQUE |

---

## 🎨 Palette de Couleurs

| Élément | Couleur | Code |
|---------|---------|------|
| **Modèles** | Turquoise | `#33CED8` |
| **Session/Stats** | Jaune/Gold | `#F4C430` |
| **Flèches** | Jaune/Gold | `#F4C430` |
| **Cost 💰** | Vert | `#00FF00` |
| **Tokens 🧠** | Turquoise | `#33CED8` |
| **Lines +** | Lime | `#76EE00` |
| **Lines -** | Coral | `#FF6B6B` |
| **Progress < 30%** | Lime | `#76EE00` |
| **Progress 30-50%** | Cyan | `#00FFFF` |
| **Progress 50-70%** | Gold | `#FFD700` |
| **Progress 70-90%** | Orange | `#FFA500` |
| **Progress > 90%** | Red | `#FF0000` |

---

## 💡 Calcul du Contexte

Le pourcentage affiché inclut :

```
Total = Transcript + System + Tools/MCP + Memory + Buffer

Détails :
- Transcript (Messages)    : ~104k tokens (52%)
- System prompts           : ~2.5k tokens (1%)
- System tools             : ~15k tokens (7%)
- MCP tools                : ~31k tokens (16%)
- Custom agents            : ~212 tokens (0.1%)
- Memory files             : ~743 tokens (0.4%)
- Autocompact buffer       : ~45k tokens (23%)
────────────────────────────────────────────
Total                      : ~199k/200k (99%)
```

---