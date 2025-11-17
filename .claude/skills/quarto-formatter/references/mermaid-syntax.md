# Mermaid Diagram Syntax Reference

## Quick Start

Mermaid diagrams in Quarto use this syntax:

```markdown
\```{mermaid}
%%| fig-width: 10
%%| fig-height: 6

flowchart LR
    A[Start] --> B[End]
\```
```

## 13 Diagram Types

### 1. Flowchart (Decision Trees, Workflows)

```mermaid
flowchart TD
    A[Start] --> B{Decision?}
    B -->|Yes| C[Action 1]
    B -->|No| D[Action 2]
    C --> E[End]
    D --> E
```

**Shapes:**
- `[Rectangle]` - Process
- `(Rounded)` - Start/End
- `{Diamond}` - Decision
- `[[Subroutine]]`
- `[(Database)]`
- `((Circle))`

### 2. Sequence Diagram (Interactions, API Calls)

```mermaid
sequenceDiagram
    participant User
    participant API
    participant DB

    User->>API: Request
    API->>DB: Query
    DB-->>API: Data
    API-->>User: Response
```

### 3. State Diagram (State Machines, Lifecycles)

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Processing: start()
    Processing --> Complete: finish()
    Processing --> Error: fail()
    Complete --> [*]
    Error --> Idle: retry()
```

### 4. Gantt Chart (Timelines, Planning)

```mermaid
gantt
    title Project Timeline
    dateFormat YYYY-MM-DD
    section Phase 1
    Task 1: 2025-01-01, 30d
    Task 2: after task1, 20d
```

### 5. Pie Chart (Percentages, Distributions)

```mermaid
pie title Distribution
    "Category A" : 45
    "Category B" : 30
    "Category C" : 25
```

### 6. Class Diagram (Architecture, UML)

```mermaid
classDiagram
    class User {
        +String name
        +String email
        +login()
        +logout()
    }
    class Order {
        +int id
        +Date date
        +process()
    }
    User "1" --> "*" Order
```

### 7. Journey Diagram (User Flows)

```mermaid
journey
    title User Journey
    section Browse
      Visit site: 5: User
      Search product: 3: User
    section Purchase
      Add to cart: 4: User
      Checkout: 2: User
```

### 8. Git Graph (Git Workflows)

```mermaid
gitGraph
    commit
    branch develop
    checkout develop
    commit
    commit
    checkout main
    merge develop
```

### 9. Quadrant Chart (Priority Matrices)

```mermaid
quadrantChart
    title Priority Matrix
    x-axis Low Impact --> High Impact
    y-axis Low Effort --> High Effort
    quadrant-1 Quick Wins
    quadrant-2 Major Projects
    quadrant-3 Fill Ins
    quadrant-4 Thankless Tasks
```

### 10. ER Diagram (Entity Relationships)

```mermaid
erDiagram
    USER ||--o{ ORDER : places
    USER {
        int id
        string name
    }
    ORDER {
        int id
        date created
    }
```

### 11. Mindmap (Concept Maps)

```mermaid
mindmap
  root((Claude Code))
    Skills
      Quarto
      PDF
    Commands
      /commit
      /pr
    MCP
      Servers
      Tools
```

### 12. Timeline (Historical Data)

```mermaid
timeline
    title Project Milestones
    2025-01 : Initial Release
    2025-03 : Feature Update
    2025-06 : Major Version
```

### 13. Sankey Diagram (Flow Diagrams)

```mermaid
%%{init: {'theme':'base'}}%%
sankey-beta

Traffic,Direct,1000
Traffic,Organic,800
Traffic,Social,500
Direct,Conversion,200
Organic,Conversion,300
Social,Conversion,100
```

## Adding Colors (Material Design 3)

```mermaid
flowchart LR
    A[Node A] --> B[Node B]
    B --> C[Node C]

    classDef primaryClass fill:#6366F1,stroke:#6366F1,stroke-width:2px,color:#fff
    classDef successClass fill:#10B981,stroke:#10B981,stroke-width:2px,color:#fff
    classDef warningClass fill:#F59E0B,stroke:#F59E0B,stroke-width:2px,color:#fff

    class A primaryClass
    class B successClass
    class C warningClass
```

## Best Practices

1. **Always specify diagram type** (flowchart, sequence, etc.)
2. **Use fig-width and fig-height** for consistent sizing
3. **Add colors** with classDef for Material Design 3
4. **Use descriptive node IDs** (not just A, B, C)
5. **Comment complex diagrams** with `%%`
