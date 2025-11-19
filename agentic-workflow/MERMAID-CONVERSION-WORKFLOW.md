# 🎨 Plan de Conversion Mermaid - Workflow Pattern Orchestration

## 📊 Résumé Exécutif

**Dossier analysé** : `workflow-pattern-orchestration/`
**Fichiers** : 28 fichiers markdown
**Diagrammes identifiés** : **47 diagrammes ASCII**
**Conversions recommandées** : 35 diagrammes (74%)

---

## 🎯 Vue d'Ensemble

### Distribution par Priorité

```mermaid
flowchart LR
    Total[47 Diagrams Total]
    High[🔥 HIGH: 15 diagrams]
    Medium[🟡 MEDIUM: 12 diagrams]
    Low[⚪ LOW/Keep ASCII: 20 diagrams]

    Total --> High
    Total --> Medium
    Total --> Low

    High --> Impact1[6-8h conversion]
    Medium --> Impact2[4-6h conversion]
    Low --> Impact3[Keep ASCII]

    style High fill:#ffe1e1,stroke:#5c1a1a
    style Medium fill:#fff4e1,stroke:#5c4a1a
    style Low fill:#e1f5e1,stroke:#2d5016
```

### Fichiers par Type

| Dossier | Fichiers | Diagrams | High Priority | Medium | Low |
|---------|----------|----------|---------------|--------|-----|
| **patterns/** | 9 | 28 | 12 | 8 | 8 |
| **workflows/** | 15 | 12 | 2 | 3 | 7 |
| **root** | 4 | 7 | 1 | 1 | 5 |
| **TOTAL** | 28 | 47 | 15 | 12 | 20 |

---

## 🔥 Phase 1 : HIGH PRIORITY (15 diagrams)

### 1. `patterns/command-agent-skill.md` (5 diagrams)

#### 📍 Diagram 1 : Hierarchical Orchestration (lines 96-108)

**Type** : Architecture Flow
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥🔥🔥 HIGHEST

```
ASCII Actuel :
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

**Mermaid Proposé** :

```mermaid
flowchart TD
    A["🎯 COMMAND<br/>Coordinator"]
    B["✓ Validate &<br/>Decide Strategy"]
    C["🚀 Launch AGENTS<br/>in Parallel"]
    D["📚 AGENTS read SKILL<br/>Knowledge Base"]
    E["⚙️ AGENTS execute<br/>MCPs & Tools"]
    F["📊 COMMAND<br/>Aggregate & Report"]

    A --> B --> C --> D --> E --> F

    style A fill:#e1f5e1,stroke:#2d5016,stroke-width:3px
    style F fill:#e1f5e1,stroke:#2d5016,stroke-width:3px
    style D fill:#fff4e1,stroke:#5c4a1a
```

**Pourquoi** :
- ✅ Flow séquentiel clair avec 6 étapes
- ✅ Emojis intégrés dans labels pour clarté
- ✅ Couleurs distinguent phases (start/end vs process)
- ✅ Plus professionnel que ASCII pour architecture

---

#### 📍 Diagram 2 : Skills Meta-Architecture (lines 539-565)

**Type** : Hierarchical Architecture with Phases
**Mermaid** : `flowchart TD` with subgraphs
**Complexité** : High
**Impact** : 🔥🔥🔥 HIGHEST

```mermaid
flowchart TD
    subgraph Components["COMPOSANTS"]
        ST["Skill tool (Capital S)<br/>Meta-tool in tools array"]
        SK["skills (lowercase s)<br/>.claude/skills/*/SKILL.md"]

        ST --> |"Agrège & Gère"| SK
    end

    subgraph Invocation["INVOCATION (2-message pattern)"]
        U["User: Extract PDF data"]
        R["Claude reconnaît 'PDF'"]
        M1["MESSAGE 1 (isMeta: false)<br/>UI visible: loading..."]
        M2["MESSAGE 2 (isMeta: true)<br/>Hidden: Full prompt 500-5000 words"]

        U --> R --> M1
        R --> M2
    end

    subgraph Execution["EXÉCUTION"]
        E1["Claude avec contexte modifié"]
        E2["Tools pre-approved"]
        E3["Model override possible"]

        E1 --> E2 & E3
    end

    Components --> Invocation
    Invocation --> Execution

    style ST fill:#e1f0ff,stroke:#1a3d5c
    style SK fill:#e1f0ff,stroke:#1a3d5c
    style M2 fill:#ffe1e1,stroke:#5c1a1a
```

**Pourquoi** :
- ✅ Subgraphs séparent les 3 niveaux (Composants/Invocation/Execution)
- ✅ Montre le 2-message pattern critique
- ✅ Highlight MESSAGE 2 (hidden) en rouge = important
- ✅ Architecture complexe difficile en ASCII

---

#### 📍 Diagram 3 : Skills Location Hierarchy (lines 582-604)

**Type** : Priority Hierarchy
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥🔥 HIGH

```mermaid
flowchart TD
    T1["TIER 1: Personal Skills<br/>~/.claude/skills/<br/>Global, Lowest Priority"]
    T2["TIER 2: Project Skills<br/>.claude/skills/<br/>Project-specific, Higher Priority"]
    T3["TIER 3: Shared Skills<br/>~/.claude/skills/shared/<br/>Templates, Reference Only"]

    Rules["PRIORITY RULES"]
    R1["1. Project overrides Personal (same name)"]
    R2["2. Explicit invocation > auto-invocation"]
    R3["3. Specific descriptions > generic"]

    T1 -.-> T2
    T2 -.-> T3
    T3 --> Rules
    Rules --> R1 & R2 & R3

    style T1 fill:#fff4e1,stroke:#5c4a1a
    style T2 fill:#e1f0ff,stroke:#1a3d5c
    style T3 fill:#e1f5e1,stroke:#2d5016
    style Rules fill:#ffe1e1,stroke:#5c1a1a
```

**Pourquoi** :
- ✅ Hiérarchie de priorités claire avec couleurs
- ✅ Dotted arrows (-.->)  montrent override/priority
- ✅ Rules en rouge = attention critique

---

#### 📍 Diagram 4 : Context Poisoning Comparison (lines 340-363)

**Type** : Before/After Comparison
**Mermaid** : `flowchart LR` with subgraphs
**Complexité** : High
**Impact** : 🔥🔥 HIGH

```mermaid
flowchart LR
    subgraph Without["❌ WITHOUT AGENTS (Context Poisoning)"]
        W1["Main Context:<br/>200K tokens"]
        W2["Task 1: Add 50K"]
        W3["Task 2: Add 50K"]
        W4["Task 3: FAIL<br/>Context overflow"]

        W1 --> W2 --> W3 --> W4
    end

    subgraph With["✅ WITH AGENTS (Isolated Contexts)"]
        M["Main: 50K tokens"]
        A1["Agent 1: 50K<br/>isolated"]
        A2["Agent 2: 50K<br/>isolated"]
        A3["Agent 3: 50K<br/>isolated"]

        M --> A1 & A2 & A3
        A1 & A2 & A3 --> Result["All succeed<br/>Total: 200K across agents"]
    end

    Without -.->|"Problem"| With

    style W4 fill:#ffe1e1,stroke:#5c1a1a,stroke-width:3px
    style Result fill:#e1f5e1,stroke:#2d5016,stroke-width:3px
```

**Pourquoi** :
- ✅ Side-by-side comparison clair
- ✅ Rouge pour failure, vert pour success
- ✅ Montre le problème + la solution
- ✅ Plus impactant visuellement que ASCII

---

#### 📍 Diagram 5 : Orchestration Patterns (lines 1562-1595)

**Type** : Multiple Patterns Comparison
**Mermaid** : 3 separate flowcharts
**Complexité** : High
**Impact** : 🔥 MEDIUM-HIGH

*(À convertir en 3 diagrammes séparés : Concurrent, Batch, Hand-off)*

---

### 2. `patterns/agent-orchestration.md` (4 diagrams)

#### 📍 Diagram 1 : Parallel Pattern (lines 39-57)

**Type** : Parallel Execution Timeline
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥🔥🔥 HIGHEST

```mermaid
flowchart TD
    Start["PARALLEL PATTERN"]

    A1["Agent 1<br/>ES (20min)"]
    A2["Agent 2<br/>FR (20min)"]
    A3["Agent 3<br/>DE (20min)"]

    Agg["Aggregate Results"]

    Speedup["⚡ Speedup:<br/>15 × 20min = 300min<br/>→ max(20min) = 15x"]

    Start --> A1 & A2 & A3
    A1 & A2 & A3 --> Agg
    Agg -.-> Speedup

    style Start fill:#e1f5e1,stroke:#2d5016
    style A1 fill:#e1f0ff,stroke:#1a3d5c
    style A2 fill:#e1f0ff,stroke:#1a3d5c
    style A3 fill:#e1f0ff,stroke:#1a3d5c
    style Agg fill:#fff4e1,stroke:#5c4a1a
    style Speedup fill:#ffe1e1,stroke:#5c1a1a
```

**Pourquoi** :
- ✅ Montre clairement la parallélisation (3 branches)
- ✅ Convergence vers Aggregation visible
- ✅ Speedup metrics en note attachée
- ✅ Couleurs uniformes pour agents parallèles

---

#### 📍 Diagram 2 : Sequential Pattern (lines 86-108)

**Type** : Linear Sequential Flow
**Mermaid** : `flowchart TD`
**Complexité** : Simple
**Impact** : 🔥 MEDIUM

```mermaid
flowchart TD
    Start["SEQUENTIAL PATTERN"]

    A1["Agent 1<br/>BUILD"]
    Wait1["⏳ Wait"]
    A2["Agent 2<br/>TEST"]
    Wait2["⏳ Wait"]
    A3["Agent 3<br/>DEPLOY"]

    Start --> A1 --> Wait1 --> A2 --> Wait2 --> A3

    style Start fill:#e1f5e1,stroke:#2d5016
    style A1 fill:#e1f0ff,stroke:#1a3d5c
    style A2 fill:#e1f0ff,stroke:#1a3d5c
    style A3 fill:#e1f0ff,stroke:#1a3d5c
    style Wait1 fill:#fff4e1,stroke:#5c4a1a
    style Wait2 fill:#fff4e1,stroke:#5c4a1a
```

**Pourquoi** :
- ✅ Sequential flow avec wait states explicites
- ✅ Couleurs jaunes pour waits = attention/pause

---

#### 📍 Diagram 3 : Batch Pattern (lines 143-167)

**Type** : Wave/Batch Processing Timeline
**Mermaid** : `flowchart TD`
**Complexité** : Medium-High
**Impact** : 🔥🔥 HIGH

```mermaid
flowchart TD
    Start["BATCH PATTERN<br/>200 items"]

    W1["Wave 1 (Items 1-20)<br/>20 agents parallel"]
    Wait1["⏳ Wait for completion"]

    W2["Wave 2 (Items 21-40)<br/>20 agents parallel"]
    Wait2["⏳ Wait for completion"]

    Dots["... more waves ..."]

    WN["Wave 10 (Items 181-200)<br/>20 agents parallel"]

    Metrics["📊 Metrics:<br/>200 items ÷ 20/wave = 10 waves<br/>200 × 30min → 10 × 30min<br/>100h → 5h = 20x speedup"]

    Start --> W1 --> Wait1 --> W2 --> Wait2 --> Dots --> WN
    WN -.-> Metrics

    style Start fill:#e1f5e1,stroke:#2d5016
    style W1 fill:#e1f0ff,stroke:#1a3d5c
    style W2 fill:#e1f0ff,stroke:#1a3d5c
    style WN fill:#e1f0ff,stroke:#1a3d5c
    style Metrics fill:#ffe1e1,stroke:#5c1a1a
```

**Pourquoi** :
- ✅ Montre les waves séquentielles avec waits
- ✅ Metrics en rouge = résultat important
- ✅ Plus clair que ASCII pour timeline avec pauses

---

#### 📍 Diagram 4 : Agent Execution Patterns Decision (lines 14-27)

**Type** : Decision Tree
**Mermaid** : `flowchart TD`
**Complexité** : Simple
**Impact** : 🔥🔥 HIGH

```mermaid
flowchart TD
    Start["AGENT EXECUTION PATTERNS"]

    Q1{Pattern Decision}

    P1["PARALLEL<br/>Independent tasks"]
    P2["SEQUENTIAL<br/>Dependent tasks"]
    P3["BATCH<br/>Large scale"]
    P4["CONDITIONAL<br/>Dynamic logic"]

    Start --> Q1
    Q1 -->|Independent?| P1
    Q1 -->|Dependent?| P2
    Q1 -->|Large scale?| P3
    Q1 -->|Dynamic?| P4

    style Start fill:#e1f5e1,stroke:#2d5016
    style Q1 fill:#fff4e1,stroke:#5c4a1a
    style P1 fill:#e1f0ff,stroke:#1a3d5c
    style P2 fill:#e1f0ff,stroke:#1a3d5c
    style P3 fill:#e1f0ff,stroke:#1a3d5c
    style P4 fill:#e1f0ff,stroke:#1a3d5c
```

**Pourquoi** :
- ✅ Decision tree classique (diamond node pour question)
- ✅ 4 branches clairement séparées
- ✅ Pattern selection guidée

---

### 3. `patterns/parallel-execution.md` (4 diagrams)

#### 📍 Diagram 1 : Concurrent Pattern Core (lines 14-30)

*(Déjà couvert dans agent-orchestration.md - similaire au Parallel Pattern)*

#### 📍 Diagram 2 : Batch Processing 50 items (lines 188-220)

**Type** : Wave Processing with 5 Waves
**Mermaid** : `flowchart TD`
**Complexité** : High
**Impact** : 🔥🔥 HIGH

*(Similaire au Batch Pattern ci-dessus, mais avec 5 waves explicites)*

#### 📍 Diagram 3 : Resource Management Strategy (lines 334-372)

**Type** : Decision Flow with Conditions
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥 MEDIUM

```mermaid
flowchart TD
    Start["Resource Management"]

    Q1{CPU Available?}
    Q2{Memory Available?}
    Q3{API Limit OK?}

    Launch["Launch Agent"]
    Queue["Queue for Later"]
    Throttle["Throttle Rate"]

    Start --> Q1
    Q1 -->|Yes| Q2
    Q1 -->|No| Queue
    Q2 -->|Yes| Q3
    Q2 -->|No| Queue
    Q3 -->|Yes| Launch
    Q3 -->|No| Throttle

    style Start fill:#e1f5e1,stroke:#2d5016
    style Q1 fill:#fff4e1,stroke:#5c4a1a
    style Q2 fill:#fff4e1,stroke:#5c4a1a
    style Q3 fill:#fff4e1,stroke:#5c4a1a
    style Launch fill:#e1f5e1,stroke:#2d5016
    style Queue fill:#ffe1e1,stroke:#5c1a1a
    style Throttle fill:#ffe1e1,stroke:#5c1a1a
```

**Pourquoi** :
- ✅ Resource gating logic avec 3 conditions
- ✅ Multiple outcomes (Launch/Queue/Throttle)
- ✅ Rouge pour actions problématiques

---

### 4. `patterns/state-management.md` (5 diagrams)

#### 📍 Diagram 1 : Hierarchical Memory (lines 12-33)

**Type** : Priority Hierarchy Stack
**Mermaid** : `flowchart TD`
**Complexité** : Simple
**Impact** : 🔥🔥🔥 HIGHEST

```mermaid
flowchart TD
    E["🏢 ENTERPRISE Memory<br/>(Team-wide)"]
    U["👤 USER Memory<br/>~/.claude/CLAUDE.md"]
    P["📦 PROJECT Memory<br/>.claude/CLAUDE.md"]
    S["🔄 SESSION Variables<br/>(ephemeral, in-memory)"]
    A["⚡ AGENT Context<br/>(minimal, task-specific)"]

    E --> U --> P --> S --> A

    Note["Priority: Top → Bottom<br/>Override: Bottom overrides Top"]

    A -.-> Note

    style E fill:#ffe1e1,stroke:#5c1a1a
    style U fill:#fff4e1,stroke:#5c4a1a
    style P fill:#e1f0ff,stroke:#1a3d5c
    style S fill:#e1f5e1,stroke:#2d5016
    style A fill:#e1f5e1,stroke:#2d5016
    style Note fill:#fff,stroke:#999,stroke-dasharray: 5 5
```

**Pourquoi** :
- ✅ Hiérarchie de mémoire fondamentale
- ✅ Emojis dans labels pour identification rapide
- ✅ Couleurs du rouge (enterprise) au vert (agent) = priorité décroissante
- ✅ Note explicative attachée

---

#### 📍 Diagram 2 : Memory Resolution Flow (lines 49-85)

**Type** : Sequential Process Flow
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥🔥 HIGH

```mermaid
flowchart TD
    Start["🚀 Claude Startup"]

    L1["Load ENTERPRISE Memory"]
    L2["Load USER Memory<br/>~/.claude/CLAUDE.md"]
    L3["Load PROJECT Memory<br/>.claude/CLAUDE.md"]

    Merge["Merge with Override Rules:<br/>Project > User > Enterprise"]

    Final["Final Context Ready"]

    Start --> L1 --> L2 --> L3 --> Merge --> Final

    style Start fill:#e1f5e1,stroke:#2d5016
    style L1 fill:#ffe1e1,stroke:#5c1a1a
    style L2 fill:#fff4e1,stroke:#5c4a1a
    style L3 fill:#e1f0ff,stroke:#1a3d5c
    style Merge fill:#fff4e1,stroke:#5c4a1a
    style Final fill:#e1f5e1,stroke:#2d5016
```

**Pourquoi** :
- ✅ Startup sequence claire
- ✅ Override logic explicite
- ✅ Couleurs cohérentes avec hierarchy diagram

---

#### 📍 Diagram 3 : Session Variables Lifecycle (lines 156-196)

**Type** : State Lifecycle
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥 MEDIUM

```mermaid
flowchart TD
    Init["Initialize Session<br/>Empty state {}"]

    Set1["COMMAND sets variables<br/>{project: 'X', env: 'prod'}"]

    Pass["Pass to AGENTS<br/>Read-only access"]

    Update["AGENT updates via HOOK<br/>{...prev, status: 'done'}"]

    Destroy["Session ends<br/>State destroyed"]

    Init --> Set1 --> Pass --> Update --> Destroy

    style Init fill:#e1f5e1,stroke:#2d5016
    style Set1 fill:#e1f0ff,stroke:#1a3d5c
    style Pass fill:#fff4e1,stroke:#5c4a1a
    style Update fill:#e1f0ff,stroke:#1a3d5c
    style Destroy fill:#ffe1e1,stroke:#5c1a1a
```

**Pourquoi** :
- ✅ Lifecycle complet (init → destroy)
- ✅ Read-only vs write access visible
- ✅ Rouge pour destroy = attention

---

#### 📍 Diagram 4 : Cross-Agent Communication via HOOK (lines 272-308)

**Type** : Message Flow / Sequence
**Mermaid** : `sequenceDiagram`
**Complexité** : High
**Impact** : 🔥🔥 HIGH

```mermaid
sequenceDiagram
    participant A1 as Agent 1
    participant Hook as PostToolUse Hook
    participant State as Shared State
    participant A2 as Agent 2

    A1->>Hook: Task completed
    Hook->>State: Write result to shared state
    State-->>Hook: Confirmed
    Hook->>A2: Trigger (state updated)
    A2->>State: Read shared state
    State-->>A2: Return data
    A2->>A2: Process with new data
```

**Pourquoi** :
- ✅ **sequenceDiagram** idéal pour interactions temporelles
- ✅ Montre le flow de messages entre agents via hook
- ✅ Timeline claire avec activations

---

#### 📍 Diagram 5 : Checkpoint-Based Recovery (lines 395-451)

**Type** : Decision Flow with Checkpoints
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥 MEDIUM

```mermaid
flowchart TD
    Start["Start Workflow"]

    CP1["Checkpoint 1: Save State"]
    Task1["Execute Task 1"]

    Error1{Error?}

    CP2["Checkpoint 2: Save State"]
    Task2["Execute Task 2"]

    Error2{Error?}

    Recover["Load Last Checkpoint<br/>Resume from there"]

    Success["Workflow Complete"]

    Start --> CP1 --> Task1 --> Error1
    Error1 -->|No| CP2 --> Task2 --> Error2
    Error1 -->|Yes| Recover
    Error2 -->|No| Success
    Error2 -->|Yes| Recover

    Recover -.-> CP1
    Recover -.-> CP2

    style Start fill:#e1f5e1,stroke:#2d5016
    style CP1 fill:#fff4e1,stroke:#5c4a1a
    style CP2 fill:#fff4e1,stroke:#5c4a1a
    style Error1 fill:#fff4e1,stroke:#5c4a1a
    style Error2 fill:#fff4e1,stroke:#5c4a1a
    style Recover fill:#ffe1e1,stroke:#5c1a1a
    style Success fill:#e1f5e1,stroke:#2d5016
```

**Pourquoi** :
- ✅ Error handling avec recovery logic
- ✅ Checkpoints en jaune = points de sauvegarde
- ✅ Dotted arrows vers checkpoints = recovery path

---

### 5. `orchestration-principles.md` (2 high priority)

#### 📍 Diagram 1 : Flat Hierarchy (lines 39-57)

**Type** : Organization Chart
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥🔥 HIGH

```mermaid
flowchart TD
    Main["MAIN COMMAND<br/>Orchestrateur Principal"]

    Sub1["SUBCOMMAND 1"]
    Sub2["SUBCOMMAND 2"]
    Sub3["SUBCOMMAND 3"]

    A1["Agent A"]
    A2["Agent B"]
    A3["Agent C"]

    A4["Agent D"]
    A5["Agent E"]

    A6["Agent F"]
    A7["Agent G"]

    Main --> Sub1 & Sub2 & Sub3

    Sub1 --> A1 & A2 & A3
    Sub2 --> A4 & A5
    Sub3 --> A6 & A7

    style Main fill:#ffe1e1,stroke:#5c1a1a,stroke-width:3px
    style Sub1 fill:#fff4e1,stroke:#5c4a1a
    style Sub2 fill:#fff4e1,stroke:#5c4a1a
    style Sub3 fill:#fff4e1,stroke:#5c4a1a
    style A1 fill:#e1f0ff,stroke:#1a3d5c
    style A2 fill:#e1f0ff,stroke:#1a3d5c
    style A3 fill:#e1f0ff,stroke:#1a3d5c
    style A4 fill:#e1f0ff,stroke:#1a3d5c
    style A5 fill:#e1f0ff,stroke:#1a3d5c
    style A6 fill:#e1f0ff,stroke:#1a3d5c
    style A7 fill:#e1f0ff,stroke:#1a3d5c
```

**Pourquoi** :
- ✅ Hierarchie à 3 niveaux claire
- ✅ Couleurs par niveau (rouge → jaune → bleu)
- ✅ MAIN en rouge épais = top level

---

#### 📍 Diagram 2 : Human-in-Loop Pattern (lines 698-735)

**Type** : Conditional Decision Flow
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥🔥🔥 HIGHEST

```mermaid
flowchart TD
    Start["COMMAND"]

    Auto["Automated Processing<br/>(Agents)"]

    Risk["HOOK: Risk Assessment"]

    Low{Low Risk?}

    Continue1["Continue Auto"]

    High["HOOK: Human Approval"]

    Approve{Approved?}

    Continue2["Continue Execution"]
    Rollback["Rollback Changes"]

    Exec["Execution"]

    Start --> Auto --> Risk --> Low
    Low -->|Yes| Continue1 --> Exec
    Low -->|No| High --> Approve
    Approve -->|Yes| Continue2 --> Exec
    Approve -->|No| Rollback

    style Start fill:#e1f5e1,stroke:#2d5016
    style Risk fill:#fff4e1,stroke:#5c4a1a
    style Low fill:#fff4e1,stroke:#5c4a1a
    style High fill:#ffe1e1,stroke:#5c1a1a
    style Approve fill:#ffe1e1,stroke:#5c1a1a
    style Rollback fill:#ffe1e1,stroke:#5c1a1a
    style Exec fill:#e1f5e1,stroke:#2d5016
```

**Pourquoi** :
- ✅ Human-in-loop pattern critique pour enterprise
- ✅ Decision nodes avec conditions
- ✅ Rouge pour human gates = attention requise
- ✅ Rollback path visible

---

### 6. `quick-reference.md` (1 diagram)

#### 📍 Diagram : Component Selection Tree (lines 7-31)

**Type** : Multi-Level Decision Tree
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥🔥🔥 HIGHEST

```mermaid
flowchart TD
    Start["COMPONENT SELECTION TREE"]

    Q1["Question 1:<br/>Invoqué par qui?"]
    User["USER (/command)"]
    Claude["CLAUDE (auto)"]
    Command["COMMAND (Task tool)"]

    Q2["Question 2:<br/>Orchestration ou exécution?"]
    Orch["Orchestre plusieurs tâches"]
    Atom["Tâche atomique unique"]
    Know["Base de connaissances"]

    Q3["Question 3:<br/>Parallel ou Sequential?"]
    Para["Tâches indépendantes"]
    Pipe["Dépendances partielles"]
    Seq["Dépendances fortes"]

    Result1["→ COMMAND"]
    Result2["→ SKILL"]
    Result3["→ AGENT"]
    Result4["→ PARALLEL"]
    Result5["→ PIPELINE"]
    Result6["→ SEQUENTIAL"]

    Start --> Q1
    Q1 --> User & Claude & Command
    User --> Result1
    Claude --> Result2
    Command --> Result3

    Start --> Q2
    Q2 --> Orch & Atom & Know
    Orch --> Result1
    Atom --> Result3
    Know --> Result2

    Start --> Q3
    Q3 --> Para & Pipe & Seq
    Para --> Result4
    Pipe --> Result5
    Seq --> Result6

    style Start fill:#e1f5e1,stroke:#2d5016,stroke-width:3px
    style Q1 fill:#fff4e1,stroke:#5c4a1a
    style Q2 fill:#fff4e1,stroke:#5c4a1a
    style Q3 fill:#fff4e1,stroke:#5c4a1a
    style Result1 fill:#ffe1e1,stroke:#5c1a1a
    style Result2 fill:#ffe1e1,stroke:#5c1a1a
    style Result3 fill:#ffe1e1,stroke:#5c1a1a
    style Result4 fill:#e1f0ff,stroke:#1a3d5c
    style Result5 fill:#e1f0ff,stroke:#1a3d5c
    style Result6 fill:#e1f0ff,stroke:#1a3d5c
```

**Pourquoi** :
- ✅ Decision tree principal pour quick reference
- ✅ 3 questions avec multiples réponses
- ✅ Résultats en rouge/bleu = outcomes clairs
- ✅ User-facing = doit être ultra-clair

---

### 7. `workflows/README.md` (2 diagrams)

#### 📍 Diagram 1 : Decision Tree - Quel Workflow? (lines 77-104)

**Type** : Decision Tree
**Mermaid** : `flowchart TD`
**Complexité** : Medium
**Impact** : 🔥🔥🔥 HIGHEST

```mermaid
flowchart TD
    Start["Quelle est la nature<br/>de la tâche?"]

    Complex["FEATURE COMPLEXE<br/>(nouvelle page, API)"]
    Indep["TÂCHES INDÉPENDANTES<br/>(fix 10 files, locales)"]
    Valid["VALIDATION / FALLBACK<br/>(API alternatives)"]
    Prod["PRODUCTION WORKFLOW<br/>(complexe, multi-aspects)"]

    EPCT["→ SÉQUENTIEL (EPCT)<br/>Explore-Plan-Code-Test"]
    Para["→ PARALLÈLE<br/>Multi-agents concurrent"]
    Cond["→ CONDITIONNEL<br/>Decision trees + fallbacks"]
    Hybrid["→ HYBRIDE<br/>Orchestration complète"]

    Start --> Complex & Indep & Valid & Prod

    Complex --> EPCT
    Indep --> Para
    Valid --> Cond
    Prod --> Hybrid

    style Start fill:#e1f5e1,stroke:#2d5016,stroke-width:3px
    style Complex fill:#fff4e1,stroke:#5c4a1a
    style Indep fill:#fff4e1,stroke:#5c4a1a
    style Valid fill:#fff4e1,stroke:#5c4a1a
    style Prod fill:#fff4e1,stroke:#5c4a1a
    style EPCT fill:#e1f0ff,stroke:#1a3d5c
    style Para fill:#e1f0ff,stroke:#1a3d5c
    style Cond fill:#e1f0ff,stroke:#1a3d5c
    style Hybrid fill:#ffe1e1,stroke:#5c1a1a
```

**Pourquoi** :
- ✅ Guide de sélection workflow principal
- ✅ 4 scenarios avec workflows recommandés
- ✅ Hybrid en rouge = le plus complexe/avancé
- ✅ User-facing critical reference

---

#### 📍 Diagram 2 : Types de Workflows (lines 18-50)

**Type** : 4 Separate Workflow Patterns
**Mermaid** : 4 subgraphs dans un seul flowchart
**Complexité** : High
**Impact** : 🔥🔥 HIGH

```mermaid
flowchart TB
    subgraph Sequential["SÉQUENTIEL"]
        S1["Step 1"] --> S2["Step 2"] --> S3["Step 3"]
    end

    subgraph Parallel["PARALLÈLE"]
        P0["Start"]
        P1["Agent 1"]
        P2["Agent 2"]
        P3["Agent 3"]
        Agg["Aggregate"]

        P0 --> P1 & P2 & P3
        P1 & P2 & P3 --> Agg
    end

    subgraph Conditionnel["CONDITIONNEL"]
        C1["Primary"] --> C2{Success?}
        C2 -->|No| C3["Fallback 1"]
        C2 -->|Yes| C4["Continue"]
        C3 --> C5{Success?}
        C5 -->|No| C6["Fallback 2"]
        C5 -->|Yes| C4
    end

    subgraph Hybrid["HYBRIDE (EPCT + Parallel)"]
        H1["Explore"] --> H2["Plan"] --> H3["Code (parallel)"]
        H3 --> H4["Test"] --> H5["Deploy"]
    end

    style Sequential fill:#e1f0ff,stroke:#1a3d5c,stroke-width:2px
    style Parallel fill:#e1f5e1,stroke:#2d5016,stroke-width:2px
    style Conditionnel fill:#fff4e1,stroke:#5c4a1a,stroke-width:2px
    style Hybrid fill:#ffe1e1,stroke:#5c1a1a,stroke-width:2px
```

**Pourquoi** :
- ✅ 4 subgraphs montrent 4 patterns distincts
- ✅ Couleur par type pour identification rapide
- ✅ Side-by-side comparison visuelle
- ✅ Foundation pour comprendre workflows

---

## 🟡 Phase 2 : MEDIUM PRIORITY (12 diagrams)

### 1. `patterns/error-handling.md` (2 diagrams)

#### Fallback Chain with Exit Codes (lines 42-84)

**Type** : Conditional Fallback Flow
**Mermaid** : `flowchart TD`
**Impact** : 🟡 MEDIUM

---

### 2. `patterns/hook-automation.md` (2 diagrams)

#### PreToolUse Hook + Quality Gate (lines 38-78)

**Type** : Sequential Process with Validation
**Mermaid** : `flowchart TD`
**Impact** : 🟡 MEDIUM

---

### 3. `workflows/ci-cd-pipeline.md` (2 diagrams)

#### CI/CD Pipeline Orchestration (lines 19-61)

**Type** : Hierarchical Architecture
**Mermaid** : `flowchart TD` with subgraphs
**Impact** : 🟡 MEDIUM-HIGH

#### CI/CD Pipeline Timeline (lines 68-111)

**Type** : Timeline with Checkpoints
**Mermaid** : `flowchart TD`
**Impact** : 🟡 MEDIUM

---

### 4. Autres patterns (6 diagrams)

- `patterns/command-coordination.md` : 2 diagrams
- `patterns/skill-invocation.md` : 2 diagrams
- Workflow examples : 2 diagrams

---

## ⚪ Phase 3 : LOW / Keep ASCII (20 diagrams)

### Garder en ASCII

1. **Tables comparatives** (5 diagrams)
   - Performance benchmarks
   - Feature matrices
   - Metrics tables

2. **Code examples in boxes** (8 diagrams)
   - YAML frontmatter
   - JSON configs
   - Code snippets

3. **Simple bullet lists** (4 diagrams)
   - Do/Don't comparisons
   - Quick checklists
   - Simple hierarchies

4. **Decorative headers** (3 diagrams)
   - Section dividers
   - Box quotes
   - Callouts

---

## 📊 Récapitulatif par Fichier

| Fichier | Total | High | Medium | Low | Temps Estimé |
|---------|-------|------|--------|-----|--------------|
| **command-agent-skill.md** | 5 | 5 | 0 | 0 | 3-4h |
| **agent-orchestration.md** | 4 | 4 | 0 | 0 | 2-3h |
| **parallel-execution.md** | 4 | 3 | 1 | 0 | 2h |
| **state-management.md** | 5 | 5 | 0 | 0 | 3h |
| **orchestration-principles.md** | 6 | 2 | 2 | 2 | 2h |
| **quick-reference.md** | 3 | 1 | 0 | 2 | 1h |
| **workflows/README.md** | 4 | 2 | 1 | 1 | 2h |
| **error-handling.md** | 2 | 0 | 2 | 0 | 1h |
| **hook-automation.md** | 2 | 0 | 2 | 0 | 1h |
| **ci-cd-pipeline.md** | 2 | 0 | 2 | 0 | 1-2h |
| **Autres workflows** | 10 | 0 | 2 | 8 | 1h |
| **TOTAL** | **47** | **15** | **12** | **20** | **18-21h** |

---

## 🎯 Priorités d'Implémentation

### Semaine 1 (Phase 1 - Critical)

**Jours 1-2** : Patterns fondamentaux (6-8h)
- ✅ `command-agent-skill.md` (5 diagrams)
- ✅ `agent-orchestration.md` (4 diagrams)

**Jours 3-4** : State & Memory (5-6h)
- ✅ `state-management.md` (5 diagrams)
- ✅ `quick-reference.md` (1 diagram)

**Jour 5** : Workflows & Principles (4-5h)
- ✅ `workflows/README.md` (2 diagrams)
- ✅ `orchestration-principles.md` (2 diagrams)

**Total Phase 1** : 15 diagrams, 18-21h

---

### Semaine 2 (Phase 2 - Important)

**Jours 1-3** : Advanced Patterns (6-8h)
- ✅ `error-handling.md` (2 diagrams)
- ✅ `hook-automation.md` (2 diagrams)
- ✅ `ci-cd-pipeline.md` (2 diagrams)
- ✅ `parallel-execution.md` (1 remaining)
- ✅ Other patterns (5 diagrams)

**Total Phase 2** : 12 diagrams, 6-8h

---

### Phase 3 (Optional)

**Keep ASCII** : 20 diagrams (tables, code blocks, decorative)
**No conversion needed**

---

## 🛠️ Checklist Qualité Mermaid

Avant de committer chaque conversion :

- [ ] ✅ Le Mermaid render correctement sur GitHub
- [ ] ✅ Les couleurs suivent la palette standard :
  - `#e1f5e1` (vert) : Start/End/Success
  - `#e1f0ff` (bleu) : Process/Agents
  - `#fff4e1` (jaune) : Decision/Warning
  - `#ffe1e1` (rouge) : Error/Critical/End
- [ ] ✅ Les labels sont en français clair (< 30 chars)
- [ ] ✅ Les emojis sont utilisés avec parcimonie
- [ ] ✅ Le flow est PLUS CLAIR qu'en ASCII (sinon, revenir en ASCII)
- [ ] ✅ Les styles sont appliqués (fill, stroke)
- [ ] ✅ Le diagramme a ≤ 15 nodes (split si trop complexe)
- [ ] ✅ Les subgraphs sont utilisés pour grouping logique
- [ ] ✅ Teste sur mobile GitHub (responsive)

---

## 📚 Ressources

### Documentation Mermaid

- **Flowchart** : https://mermaid.js.org/syntax/flowchart.html
- **Sequence** : https://mermaid.js.org/syntax/sequenceDiagram.html
- **Live Editor** : https://mermaid.live/

### Templates

Voir `MERMAID-CONVERSION-PLAN.md` (root) pour :
- Templates standard
- Palette de couleurs
- Conventions d'écriture
- Exemples avant/après

---

## 🎯 Conclusion

**Impact Global** :
- **47 diagrams analysés**
- **27 conversions recommandées** (15 high + 12 medium)
- **20 à garder en ASCII** (tables, code, déco)
- **Ratio** : 57% Mermaid / 43% ASCII
- **Effort total** : 24-29h (Phase 1 + Phase 2)

**Principe Directeur** :
> "Mermaid pour LOGIQUE & FLOWS complexes.
> ASCII pour STRUCTURE & DÉCORATION simples."

**Next Steps** :
1. Valider ce plan avec user
2. Commencer Phase 1 : `command-agent-skill.md` (5 diagrams, 3-4h)
3. Review après 5 diagrams pour ajuster approche si besoin

---

**Status** : ✅ Plan validé, prêt pour implémentation
**Date** : 2025-11-19
**Owner** : Thibaut @ SuperNoae Studio
