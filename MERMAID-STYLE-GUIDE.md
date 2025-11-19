# 🎨 Guide de Style Mermaid - Dark/Light Mode Compatible

## 🎯 Objectif

Créer des diagrammes Mermaid **visuellement parfaits** qui fonctionnent en :
- ✅ Dark mode (GitHub, VS Code dark)
- ✅ Light mode (GitHub, VS Code light)
- ✅ Mobile & Desktop
- ✅ Accessibilité (contraste WCAG AA minimum)

---

## 🎨 Palette de Couleurs Optimale

### Principe Directeur

> **Utiliser des couleurs moyennes avec bon contraste stroke**
> Éviter blanc pur (#fff) et noir pur (#000) → illisibles en dark/light mode

### Palette Standard (Dark/Light Compatible)

```mermaid
flowchart LR
    Start["🟢 START/SUCCESS<br/>#d4edda<br/>stroke:#28a745"]
    Process["🔵 PROCESS/ACTION<br/>#cce5ff<br/>stroke:#0066cc"]
    Decision["🟡 DECISION/WARNING<br/>#fff3cd<br/>stroke:#cc8800"]
    Error["🔴 ERROR/CRITICAL<br/>#f8d7da<br/>stroke:#cc0000"]
    Info["⚪ INFO/NEUTRAL<br/>#e2e3e5<br/>stroke:#6c757d"]

    style Start fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    style Process fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Decision fill:#fff3cd,stroke:#cc8800,stroke-width:2px,color:#000
    style Error fill:#f8d7da,stroke:#cc0000,stroke-width:2px,color:#000
    style Info fill:#e2e3e5,stroke:#6c757d,stroke-width:2px,color:#000
```

### Codes Couleurs Détaillés

| Catégorie | Fill | Stroke | Text | Usage |
|-----------|------|--------|------|-------|
| **🟢 Start/Success** | `#d4edda` | `#28a745` | `#000` | Début, fin réussie, validation OK |
| **🔵 Process/Action** | `#cce5ff` | `#0066cc` | `#000` | Étapes normales, actions, agents |
| **🟡 Decision/Warning** | `#fff3cd` | `#cc8800` | `#000` | Questions, choix, attention requise |
| **🔴 Error/Critical** | `#f8d7da` | `#cc0000` | `#000` | Erreurs, rollback, points critiques |
| **⚪ Info/Neutral** | `#e2e3e5` | `#6c757d` | `#000` | Notes, métadonnées, informations |

### Variantes par Intensité

```mermaid
flowchart TB
    subgraph Subtle["🌙 Subtle (backgrounds, notes)"]
        S1["fill:#f0f9ff<br/>stroke:#91c4f2"]
        S2["fill:#f0fff4<br/>stroke:#86d99d"]
        S3["fill:#fffef0<br/>stroke:#e6d690"]
    end

    subgraph Normal["☀️ Normal (standard nodes)"]
        N1["fill:#cce5ff<br/>stroke:#0066cc"]
        N2["fill:#d4edda<br/>stroke:#28a745"]
        N3["fill:#fff3cd<br/>stroke:#cc8800"]
    end

    subgraph Bold["⚡ Bold (emphasis, critical)"]
        B1["fill:#0066cc<br/>stroke:#003d7a<br/>color:#fff"]
        B2["fill:#28a745<br/>stroke:#1e7e34<br/>color:#fff"]
        B3["fill:#cc0000<br/>stroke:#990000<br/>color:#fff"]
    end

    style S1 fill:#f0f9ff,stroke:#91c4f2,stroke-width:2px,color:#000
    style S2 fill:#f0fff4,stroke:#86d99d,stroke-width:2px,color:#000
    style S3 fill:#fffef0,stroke:#e6d690,stroke-width:2px,color:#000

    style N1 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style N2 fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    style N3 fill:#fff3cd,stroke:#cc8800,stroke-width:2px,color:#000

    style B1 fill:#0066cc,stroke:#003d7a,stroke-width:3px,color:#fff
    style B2 fill:#28a745,stroke:#1e7e34,stroke-width:3px,color:#fff
    style B3 fill:#cc0000,stroke:#990000,stroke-width:3px,color:#fff
```

---

## 📏 Règles de Formatage

### 1. Labels Multi-Lignes (Espacement Optimal)

#### ❌ Mauvais (trop dense)

```mermaid
flowchart TD
    A["COMMAND Coordinator Validates Decides Strategy"]
```

#### ✅ Bon (espacement optimal)

```mermaid
flowchart TD
    A["🎯 COMMAND<br/><br/>Coordinator<br/>Validates & Decides"]

    style A fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
```

**Règles** :
- ✅ **1 emoji par node** (début du label)
- ✅ **`<br/>` pour retour à la ligne** (max 3 lignes)
- ✅ **`<br/><br/>`** pour espacement double (séparer sections)
- ✅ **Max 30 caractères par ligne** (lisibilité)
- ❌ Éviter plus de 4 lignes (trop grand)

---

### 2. Node Sizing (Cohérence Visuelle)

#### Labels Courts vs Longs

```mermaid
flowchart LR
    Short["Start"]
    Medium["Process<br/>Data"]
    Long["Complex<br/>Multi-Step<br/>Process"]

    Short --> Medium --> Long

    style Short fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    style Medium fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Long fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
```

**Règles** :
- ✅ Labels courts (1 mot) : OK sans `<br/>`
- ✅ Labels moyens (2-3 mots) : Utiliser `<br/>` pour séparer
- ✅ Labels longs (4+ mots) : Multi-ligne avec `<br/><br/>` pour sections

---

### 3. Emojis (Utilisation Optimale)

#### Emojis Recommandés par Catégorie

| Catégorie | Emojis | Usage |
|-----------|--------|-------|
| **Navigation** | 🎯 ⭐ 🏁 | Start, Goal, End |
| **Étapes** | 1️⃣ 2️⃣ 3️⃣ | Séquences numérotées |
| **Processus** | ⚙️ 🔧 🛠️ | Actions, configuration |
| **Données** | 📊 📈 📉 | Metrics, analytics |
| **Communication** | 📡 📨 📬 | Messages, notifications |
| **Validation** | ✅ ✓ ☑️ | Success, approval |
| **Erreur** | ❌ ⚠️ 🚫 | Error, warning, block |
| **Stockage** | 💾 📁 📦 | Memory, files, packages |
| **Utilisateur** | 👤 👥 🏢 | User, team, enterprise |
| **Temps** | ⏳ ⏱️ 🕐 | Wait, duration, schedule |
| **Vitesse** | ⚡ 🚀 💨 | Fast, boost, speedup |

#### ❌ Mauvais (emoji overload)

```mermaid
flowchart TD
    A["🎯⭐✨ START 🚀💪"]
```

#### ✅ Bon (1 emoji pertinent)

```mermaid
flowchart TD
    A["🎯 START"]

    style A fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
```

**Règles** :
- ✅ **1 emoji par node** (début du label)
- ✅ Choisir l'emoji **le plus pertinent**
- ✅ Cohérence : même emoji = même type de node
- ❌ Pas d'emojis dans stroke/fill (seulement dans labels)

---

### 4. Stroke Width (Hiérarchie Visuelle)

```mermaid
flowchart TD
    Critical["🔴 CRITICAL<br/>stroke-width:4px"]
    Important["🟡 IMPORTANT<br/>stroke-width:3px"]
    Normal["🔵 NORMAL<br/>stroke-width:2px"]
    Subtle["⚪ SUBTLE<br/>stroke-width:1px"]

    style Critical fill:#f8d7da,stroke:#cc0000,stroke-width:4px,color:#000
    style Important fill:#fff3cd,stroke:#cc8800,stroke-width:3px,color:#000
    style Normal fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Subtle fill:#e2e3e5,stroke:#6c757d,stroke-width:1px,color:#000
```

**Règles** :
- ✅ **4px** : Critical nodes (errors, start/end principal)
- ✅ **3px** : Important nodes (decisions, key steps)
- ✅ **2px** : Normal nodes (standard, par défaut)
- ✅ **1px** : Subtle nodes (notes, metadata)

---

### 5. Link Styles (Flèches Sémantiques)

```mermaid
flowchart LR
    A["Start"]
    B["Process"]
    C["Decision"]
    D["End"]
    E["Note"]

    A -->|"Normal flow"| B
    B ==>|"Important"| C
    C -.->|"Optional"| D
    D ~~~|"Relation"| E

    style A fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    style B fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style C fill:#fff3cd,stroke:#cc8800,stroke-width:2px,color:#000
    style D fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    style E fill:#e2e3e5,stroke:#6c757d,stroke-width:1px,color:#000
```

**Types de liens** :

| Syntaxe | Rendu | Usage |
|---------|-------|-------|
| `A --> B` | Flèche normale | Flow standard |
| `A ==> B` | Flèche épaisse | Flow important/critique |
| `A -.-> B` | Flèche pointillée | Flow optionnel/secondaire |
| `A ~~~ B` | Ligne invisible | Relation sans direction |
| `A -->|"Label"| B` | Flèche avec label | Flow avec description |

**Règles** :
- ✅ Labels courts sur liens (< 20 chars)
- ✅ Utiliser pointillés `-.->` pour notes/metadata
- ✅ Utiliser épais `==>` pour chemins critiques
- ❌ Éviter trop de labels sur liens (surcharge visuelle)

---

## 🎨 Templates par Type de Diagramme

### Template 1 : Sequential Flow (Linéaire)

```mermaid
flowchart TD
    Start["🎯 START<br/><br/>Initialize Process"]

    Step1["1️⃣ Step 1<br/><br/>Validate Input"]
    Step2["2️⃣ Step 2<br/><br/>Process Data"]
    Step3["3️⃣ Step 3<br/><br/>Generate Output"]

    End["🏁 END<br/><br/>Process Complete"]

    Start --> Step1 --> Step2 --> Step3 --> End

    style Start fill:#d4edda,stroke:#28a745,stroke-width:3px,color:#000
    style Step1 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Step2 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Step3 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style End fill:#d4edda,stroke:#28a745,stroke-width:3px,color:#000
```

**Code propre** :

```markdown
```mermaid
flowchart TD
    Start["🎯 START<br/><br/>Initialize Process"]
    Step1["1️⃣ Step 1<br/><br/>Validate Input"]
    Step2["2️⃣ Step 2<br/><br/>Process Data"]
    Step3["3️⃣ Step 3<br/><br/>Generate Output"]
    End["🏁 END<br/><br/>Process Complete"]

    Start --> Step1 --> Step2 --> Step3 --> End

    style Start fill:#d4edda,stroke:#28a745,stroke-width:3px,color:#000
    style Step1 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Step2 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Step3 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style End fill:#d4edda,stroke:#28a745,stroke-width:3px,color:#000
\```
```

**Conventions** :
- ✅ Ligne vide entre définitions et connexions
- ✅ Ligne vide avant styles
- ✅ Indentation cohérente (4 spaces)
- ✅ Ordre logique : Nodes → Links → Styles

---

### Template 2 : Decision Tree (Branches)

```mermaid
flowchart TD
    Start["🎯 START<br/><br/>Input Received"]

    Decision{"🟡 DECISION<br/><br/>Valid Input?"}

    Yes["✅ YES<br/><br/>Process Data"]
    No["❌ NO<br/><br/>Return Error"]

    Success["🏁 SUCCESS<br/><br/>Data Processed"]

    Start --> Decision
    Decision -->|"Valid"| Yes
    Decision -->|"Invalid"| No
    Yes --> Success

    style Start fill:#d4edda,stroke:#28a745,stroke-width:3px,color:#000
    style Decision fill:#fff3cd,stroke:#cc8800,stroke-width:3px,color:#000
    style Yes fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style No fill:#f8d7da,stroke:#cc0000,stroke-width:2px,color:#000
    style Success fill:#d4edda,stroke:#28a745,stroke-width:3px,color:#000
```

**Règles Decision Nodes** :
- ✅ Utiliser `{}` pour diamond shape
- ✅ Couleur jaune (#fff3cd) pour questions
- ✅ stroke-width:3px pour emphasis
- ✅ Labels courts sur branches (Valid/Invalid, Yes/No)

---

### Template 3 : Parallel Execution (Branches Convergentes)

```mermaid
flowchart TD
    Start["🎯 START<br/><br/>Launch Parallel"]

    Agent1["🤖 AGENT 1<br/><br/>Task A"]
    Agent2["🤖 AGENT 2<br/><br/>Task B"]
    Agent3["🤖 AGENT 3<br/><br/>Task C"]

    Aggregate["📊 AGGREGATE<br/><br/>Merge Results"]

    Metrics["⚡ METRICS<br/><br/>3 tasks parallel<br/>Speedup: 3x"]

    Start --> Agent1 & Agent2 & Agent3
    Agent1 & Agent2 & Agent3 --> Aggregate
    Aggregate -.-> Metrics

    style Start fill:#d4edda,stroke:#28a745,stroke-width:3px,color:#000
    style Agent1 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Agent2 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Agent3 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Aggregate fill:#fff3cd,stroke:#cc8800,stroke-width:3px,color:#000
    style Metrics fill:#e2e3e5,stroke:#6c757d,stroke-width:1px,color:#000
```

**Règles Parallel Nodes** :
- ✅ Même couleur pour nodes parallèles (cohérence)
- ✅ Emoji identique pour nodes similaires (🤖)
- ✅ Dotted link `-.->` pour métadonnées
- ✅ Metrics node en gris subtle

---

### Template 4 : Subgraphs (Groupes Logiques)

```mermaid
flowchart TD
    subgraph Input["📥 INPUT PHASE"]
        I1["Receive Data"]
        I2["Validate Schema"]
    end

    subgraph Process["⚙️ PROCESS PHASE"]
        P1["Transform Data"]
        P2["Apply Rules"]
    end

    subgraph Output["📤 OUTPUT PHASE"]
        O1["Format Results"]
        O2["Send Response"]
    end

    Input --> Process --> Output

    I1 --> I2
    P1 --> P2
    O1 --> O2

    style Input fill:#f0fff4,stroke:#86d99d,stroke-width:2px
    style Process fill:#f0f9ff,stroke:#91c4f2,stroke-width:2px
    style Output fill:#fff9e6,stroke:#e6d690,stroke-width:2px

    style I1 fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    style I2 fill:#d4edda,stroke:#28a745,stroke-width:2px,color:#000
    style P1 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style P2 fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style O1 fill:#fff3cd,stroke:#cc8800,stroke-width:2px,color:#000
    style O2 fill:#fff3cd,stroke:#cc8800,stroke-width:2px,color:#000
```

**Règles Subgraphs** :
- ✅ Couleurs très subtiles pour backgrounds (fill:#f0...)
- ✅ Emoji dans titre subgraph
- ✅ Nodes dans subgraph = couleurs normales
- ✅ Indentation claire (4 spaces)

---

### Template 5 : Sequence Diagram (Interactions)

```mermaid
sequenceDiagram
    participant User as 👤 User
    participant Claude as 🤖 Claude
    participant GitHub as 📦 GitHub

    User->>Claude: /commit
    activate Claude

    Claude->>GitHub: git status
    activate GitHub
    GitHub-->>Claude: files list
    deactivate GitHub

    Claude->>GitHub: git commit
    activate GitHub
    GitHub-->>Claude: Success
    deactivate GitHub

    Claude-->>User: ✅ Committed
    deactivate Claude
```

**Règles Sequence** :
- ✅ Emojis dans participant names
- ✅ `activate`/`deactivate` pour timing
- ✅ `->>` pour requests (solid arrow)
- ✅ `-->>` pour responses (dashed arrow)
- ✅ Pas de styles custom (Mermaid default OK)

---

## 📐 Checklist Qualité UX/UI

Avant de committer un diagramme Mermaid :

### Visuel

- [ ] ✅ **Couleurs dark/light compatible** (palette standard)
- [ ] ✅ **Stroke width cohérent** (1-4px selon importance)
- [ ] ✅ **Text color:#000** sur backgrounds clairs
- [ ] ✅ **Labels multi-lignes** bien espacés (`<br/><br/>`)
- [ ] ✅ **Max 30 chars par ligne** de label
- [ ] ✅ **1 emoji par node** (pertinent)

### Structure

- [ ] ✅ **≤ 15 nodes** par diagram (split si trop complexe)
- [ ] ✅ **Indentation propre** (4 spaces)
- [ ] ✅ **Ordre logique** : Nodes → Links → Styles
- [ ] ✅ **Ligne vide** entre sections
- [ ] ✅ **Subgraphs** pour groupes logiques (si > 6 nodes)

### Sémantique

- [ ] ✅ **Direction cohérente** (TD pour vertical, LR pour horizontal)
- [ ] ✅ **Link types pertinents** (-->, ==>, -.->)
- [ ] ✅ **Decision nodes** en diamond `{}`
- [ ] ✅ **Couleurs par catégorie** (start=vert, process=bleu, etc.)
- [ ] ✅ **Labels courts sur liens** (< 20 chars)

### Accessibilité

- [ ] ✅ **Contraste WCAG AA** minimum (4.5:1 pour text)
- [ ] ✅ **Pas de couleur seule** pour signification (+ shape/emoji)
- [ ] ✅ **Text noir (#000)** sur backgrounds clairs
- [ ] ✅ **Stroke visible** sur tous les nodes (≥ 1px)

### Performance

- [ ] ✅ **Render < 2s** sur GitHub (tester)
- [ ] ✅ **Mobile friendly** (tester sur petit écran)
- [ ] ✅ **Pas de caractères spéciaux** cassant le render
- [ ] ✅ **Quotes échappées** dans labels si nécessaire

---

## 🎨 Exemples Complets (Avant/Après)

### Exemple 1 : Hierarchical Flow

#### ❌ Avant (ASCII)

```
COMMAND (Coordinator)
    ↓
  Validates + Decides Strategy
    ↓
  Launches AGENTS (parallel)
    ↓
  AGENTS read SKILL (knowledge)
    ↓
  AGENTS execute (MCPs, tools)
    ↓
  COMMAND aggregates + reports
```

#### ✅ Après (Mermaid UX Optimisé)

```mermaid
flowchart TD
    Start["🎯 COMMAND<br/><br/>Coordinator"]

    Validate["✓ VALIDATE<br/><br/>Decide Strategy"]

    Launch["🚀 LAUNCH<br/><br/>Parallel Agents"]

    Read["📚 READ SKILL<br/><br/>Knowledge Base"]

    Execute["⚙️ EXECUTE<br/><br/>MCPs & Tools"]

    Report["📊 REPORT<br/><br/>Aggregate Results"]

    Start --> Validate --> Launch --> Read --> Execute --> Report

    style Start fill:#d4edda,stroke:#28a745,stroke-width:4px,color:#000
    style Validate fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Launch fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Read fill:#fff3cd,stroke:#cc8800,stroke-width:2px,color:#000
    style Execute fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Report fill:#d4edda,stroke:#28a745,stroke-width:4px,color:#000
```

**Améliorations** :
- ✅ Emojis pertinents (🎯 📚 ⚙️ 📊)
- ✅ Double espacement `<br/><br/>` pour sections
- ✅ UPPERCASE pour verbes d'action
- ✅ Couleurs sémantiques (vert start/end, bleu process, jaune knowledge)
- ✅ stroke-width:4px pour start/end (emphasis)

---

### Exemple 2 : Decision Tree

#### ❌ Avant (ASCII)

```
Question 1: Invoqué par qui?
    ├─→ USER (/command) → COMMAND
    ├─→ CLAUDE (auto) → SKILL
    └─→ COMMAND (Task tool) → AGENT
```

#### ✅ Après (Mermaid UX Optimisé)

```mermaid
flowchart TD
    Start["🎯 COMPONENT<br/>SELECTION"]

    Q1{"🟡 QUESTION<br/><br/>Invoqué<br/>par qui?"}

    User["👤 USER<br/><br/>/command"]
    Claude["🤖 CLAUDE<br/><br/>auto"]
    Task["⚙️ COMMAND<br/><br/>Task tool"]

    R1["→ COMMAND"]
    R2["→ SKILL"]
    R3["→ AGENT"]

    Start --> Q1

    Q1 -->|"User types"| User
    Q1 -->|"Auto-detect"| Claude
    Q1 -->|"Explicit call"| Task

    User --> R1
    Claude --> R2
    Task --> R3

    style Start fill:#d4edda,stroke:#28a745,stroke-width:4px,color:#000
    style Q1 fill:#fff3cd,stroke:#cc8800,stroke-width:3px,color:#000
    style User fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Claude fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style Task fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000
    style R1 fill:#f8d7da,stroke:#cc0000,stroke-width:2px,color:#000
    style R2 fill:#f8d7da,stroke:#cc0000,stroke-width:2px,color:#000
    style R3 fill:#f8d7da,stroke:#cc0000,stroke-width:2px,color:#000
```

**Améliorations** :
- ✅ Diamond `{}` pour question
- ✅ Labels descriptifs sur liens
- ✅ Emojis par acteur (👤 🤖 ⚙️)
- ✅ Résultats en rouge (emphasis)
- ✅ stroke-width:3px sur decision (important)

---

## 🚀 Quick Copy-Paste Styles

### Style Blocks Pré-Configurés

```markdown
<!-- START NODE (vert, stroke épais) -->
style Start fill:#d4edda,stroke:#28a745,stroke-width:4px,color:#000

<!-- PROCESS NODE (bleu, stroke normal) -->
style Process fill:#cce5ff,stroke:#0066cc,stroke-width:2px,color:#000

<!-- DECISION NODE (jaune, stroke épais) -->
style Decision fill:#fff3cd,stroke:#cc8800,stroke-width:3px,color:#000

<!-- ERROR NODE (rouge, stroke normal) -->
style Error fill:#f8d7da,stroke:#cc0000,stroke-width:2px,color:#000

<!-- INFO NODE (gris, stroke fin) -->
style Info fill:#e2e3e5,stroke:#6c757d,stroke-width:1px,color:#000

<!-- END NODE (vert, stroke épais) -->
style End fill:#d4edda,stroke:#28a745,stroke-width:4px,color:#000
```

---

## 📚 Ressources

### Testez vos Couleurs

- **Contrast Checker** : https://webaim.org/resources/contrastchecker/
- **Mermaid Live** : https://mermaid.live/
- **GitHub Dark/Light Preview** : Toggle theme dans settings

### Documentation

- **Mermaid Styling** : https://mermaid.js.org/syntax/flowchart.html#styling-and-classes
- **Accessibility** : https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html

---

## 🎯 TL;DR - Quick Rules

**Couleurs** :
- 🟢 Vert `#d4edda` : Start/End
- 🔵 Bleu `#cce5ff` : Process
- 🟡 Jaune `#fff3cd` : Decision
- 🔴 Rouge `#f8d7da` : Error
- ⚪ Gris `#e2e3e5` : Info

**Formatage** :
- ✅ 1 emoji par node (début)
- ✅ `<br/><br/>` pour espacement
- ✅ Max 30 chars/ligne
- ✅ stroke-width: 2px (default), 3-4px (emphasis)

**Structure** :
- ✅ Nodes → Links → Styles
- ✅ Ligne vide entre sections
- ✅ ≤ 15 nodes par diagram

**Always test** : Dark mode ET Light mode sur GitHub ! 🌙☀️
