# 🤖 AI Orchestration : Multi-LLM Routing & Optimization

> **Durée estimée** : 90 minutes
> **Niveau** : 🔴 Expert
> **Prérequis** : Maîtrise Error Handling, Parallel Execution, State Management

## 📚 Introduction

L'AI orchestration permet d'**optimiser coût, vitesse et qualité** en routant intelligemment les tâches vers différents modèles Claude (Haiku, Sonnet, Opus) selon contexte.

**Cas d'usage** :
- 💰 **Optimisation coût** : Haiku pour tâches simples, Opus pour complexe
- ⚡ **Performance** : Haiku rapide pour batch, Sonnet pour quality
- 🎯 **Quality/Speed trade-offs** : Adapter model au besoin
- 🔄 **Fallback strategies** : Degrader vers model moins cher si échec

---

## 📐 Core Pattern: Intelligent Model Routing

```
╔════════════════════════════════════════════╗
║      Multi-LLM Routing Strategy            ║
╚════════════════════════════════════════════╝

COMMAND analyse task complexity
    ↓
┌────────────────────────────────┐
│ Task Classification            │
│ - Simple → Haiku 🐇            │
│ - Medium → Sonnet 🧠           │
│ - Complex → Opus 🎯            │
└────────────────────────────────┘
    ↓
Route to appropriate model
    ↓
[Success?] ────NO───→ Fallback to cheaper model
    │                  (with reduced expectations)
   YES
    ↓
Return result
```

**Principes clés** :
- **Task complexity analysis** : Auto-déterminer quel model utiliser
- **Cost optimization** : Haiku 80% moins cher qu'Opus
- **Fallback chains** : Opus fail → Sonnet → Haiku (degraded)
- **Context window aware** : Haiku (200k) vs Opus (200k) - même capacity, cost différent

---

## 1️⃣ Model Selection Strategy

### Claude Model Comparison (2025)

| Model | Speed | Cost | Quality | Use Case |
|-------|-------|------|---------|----------|
| **Haiku** | ⚡⚡⚡ Very Fast | 💰 Cheap | 🎯 Good | Batch processing, simple tasks, formatting |
| **Sonnet** | ⚡⚡ Fast | 💰💰 Medium | 🎯🎯 Great | General purpose, analysis, code generation |
| **Opus** | ⚡ Slower | 💰💰💰 Expensive | 🎯🎯🎯 Excellent | Complex reasoning, critical decisions, research |

**Coût relatif** (approximatif) :
- Haiku : 1x (baseline)
- Sonnet : 5x
- Opus : 15x

### Decision Tree: Quelle Model Pour Quelle Tâche?

```
╔════════════════════════════════════════════╗
║      Model Selection Decision Tree         ║
╚════════════════════════════════════════════╝

Start: Analyze Task
    ↓
┌────────────────────────────────┐
│ Question 1: Complexity?        │
└────────────────────────────────┘
    ↓
    ├─→ Simple (format, lint, grep)
    │       ↓
    │   Use: HAIKU 🐇
    │   Examples:
    │   - Fix grammar/spelling
    │   - Format JSON
    │   - Lint code
    │   - Grep patterns
    │
    ├─→ Medium (analysis, refactor)
    │       ↓
    │   ┌────────────────────────────────┐
    │   │ Question 2: Speed critical?    │
    │   └────────────────────────────────┘
    │       ↓
    │       ├─→ YES → Use: HAIKU 🐇
    │       │   (sacrifice quality for speed)
    │       │
    │       └─→ NO → Use: SONNET 🧠
    │           Examples:
    │           - Code review
    │           - Refactoring
    │           - Generate tests
    │           - API integration
    │
    └─→ Complex (reasoning, architecture)
            ↓
        ┌────────────────────────────────┐
        │ Question 3: Budget unlimited?  │
        └────────────────────────────────┘
            ↓
            ├─→ YES → Use: OPUS 🎯
            │   Examples:
            │   - System architecture
            │   - Security audit
            │   - Complex debugging
            │   - Research synthesis
            │
            └─→ NO → Use: SONNET 🧠
                (fallback, good enough)
```

### Exemple: Auto-Selection Logic

```yaml
# .claude/commands/optimize-task.md
---
description: Route task to optimal Claude model
allowed-tools: Task, AskUserQuestion
---

You are a model selection coordinator.

## Workflow

1. **ANALYZE TASK COMPLEXITY**
   ```javascript
   function analyzeComplexity(taskDescription) {
     const SIMPLE_KEYWORDS = ['format', 'lint', 'grep', 'fix grammar', 'spell check'];
     const COMPLEX_KEYWORDS = ['architecture', 'security audit', 'research', 'design system', 'migration strategy'];

     const hasSimple = SIMPLE_KEYWORDS.some(kw => taskDescription.toLowerCase().includes(kw));
     const hasComplex = COMPLEX_KEYWORDS.some(kw => taskDescription.toLowerCase().includes(kw));

     if (hasComplex) return 'complex';
     if (hasSimple) return 'simple';
     return 'medium'; // default
   }

   const complexity = analyzeComplexity(userTask);
   ```

2. **SELECT MODEL**
   ```javascript
   const MODEL_SELECTION = {
     simple: 'claude-3-haiku-20240307',
     medium: 'claude-3-5-sonnet-20250129',
     complex: 'claude-3-opus-20240229'
   };

   const selectedModel = MODEL_SELECTION[complexity];

   console.log(`📊 Task complexity: ${complexity}`);
   console.log(`🤖 Selected model: ${selectedModel}`);
   ```

3. **EXECUTE WITH SELECTED MODEL**
   ```
   Use Task tool with model parameter:
   Task({
     subagent_type: '@task-executor',
     task: userTask,
     model: selectedModel,
     context: {...}
   })
   ```

4. **COST TRACKING**
   ```javascript
   const COST_PER_1K_TOKENS = {
     'haiku': 0.25,
     'sonnet': 1.25,
     'opus': 3.75
   };

   const estimatedCost = (tokens / 1000) * COST_PER_1K_TOKENS[modelType];
   console.log(`💰 Estimated cost: $${estimatedCost.toFixed(4)}`);
   ```
```

---

## 2️⃣ Fallback Strategies (Model Degradation)

### Concept

Si model premium **échoue** (rate limit, timeout, API error), **degrade** vers model moins cher avec expectations ajustées.

### Fallback Chain

```
╔════════════════════════════════════════════╗
║      Model Fallback Chain                  ║
╚════════════════════════════════════════════╝

TRY: OPUS 🎯 (best quality)
    ↓
[Success?] ────YES───→ Return result ✅
    │
    NO (rate limit, timeout)
    ↓
┌────────────────────────────────┐
│ FALLBACK 1: SONNET 🧠          │
│ - Lower expectations           │
│ - Adjust prompt for simplicity │
└────────────────────────────────┘
    ↓
[Success?] ────YES───→ Return result ⚠️ (degraded)
    │
    NO (still failing)
    ↓
┌────────────────────────────────┐
│ FALLBACK 2: HAIKU 🐇           │
│ - Minimal expectations         │
│ - Simple prompt                │
└────────────────────────────────┘
    ↓
[Success?] ────YES───→ Return result ⚠️⚠️ (minimal)
    │
    NO (all models failed)
    ↓
❌ USER VALIDATION:
   "All models failed. Manual intervention?"
```

### Exemple: Fallback Implementation

```yaml
# .claude/commands/research-with-fallback.md
---
description: Research task with model fallback chain
allowed-tools: Task, AskUserQuestion
---

You are a research coordinator with model fallback.

## Workflow

1. **PRIMARY: OPUS** (best quality research)
   ```
   TRY:
     Task({
       subagent_type: '@research',
       task: 'Comprehensive analysis of {topic}',
       model: 'claude-3-opus-20240229',
       prompt: `
         Provide deep analysis with:
         - Historical context
         - Current trends
         - Future predictions
         - 10+ sources cited
       `
     })
   CATCH ApiError (rate limit):
     Log: "Opus rate limited, falling back to Sonnet"
     → FALLBACK 1
   ```

2. **FALLBACK 1: SONNET** (good quality, reduced scope)
   ```
   TRY:
     Task({
       subagent_type: '@research',
       task: 'Analysis of {topic}',
       model: 'claude-3-5-sonnet-20250129',
       prompt: `
         Provide analysis with:
         - Current trends
         - Key insights
         - 5+ sources cited
         (Note: Reduced scope due to fallback)
       `
     })
   CATCH ApiError:
     Log: "Sonnet also failed, falling back to Haiku"
     → FALLBACK 2
   ```

3. **FALLBACK 2: HAIKU** (basic quality, minimal scope)
   ```
   TRY:
     Task({
       subagent_type: '@research',
       task: 'Summary of {topic}',
       model: 'claude-3-haiku-20240307',
       prompt: `
         Provide basic summary:
         - Main points only
         - 2-3 sources
         (Note: Minimal scope due to fallback)
       `
     })
   CATCH ApiError:
     Log: "All models failed"
     → USER VALIDATION
   ```

4. **USER VALIDATION** (all models failed)
   ```
   AskUserQuestion:
     "All Claude models failed (rate limits?). Options:"
       - "Wait 1h and retry" → Schedule later
       - "Use cached data" → Return stale research
       - "Cancel" → Abort task
   ```

5. **REPORT with Fallback Info**
   ```
   ✅ Research complete (using: Sonnet)
   ⚠️ Note: Fallback used (Opus unavailable)
   💡 Recommendation: Review for completeness, quality may be reduced
   ```
```

### Prompt Adaptation for Fallback

| Model | Prompt Style | Expectations |
|-------|-------------|--------------|
| **Opus** | Detailed, complex instructions | Deep analysis, comprehensive |
| **Sonnet** | Medium complexity, clear goals | Good analysis, practical |
| **Haiku** | Simple, concise, single focus | Basic summary, fast |

**Exemple** :

```markdown
# Opus Prompt (full complexity)
Analyze the architectural trade-offs between microservices and monolith:
- Historical context (2000s-2025)
- Performance implications (latency, throughput)
- Cost analysis (infrastructure, devops)
- Team structure impact (Conway's law)
- 5 case studies (successful and failed)
- Future trends (serverless, edge computing)

# Sonnet Prompt (reduced scope)
Compare microservices vs monolith:
- Key differences
- When to use each
- Common pitfalls
- 2-3 examples

# Haiku Prompt (minimal)
List pros/cons: microservices vs monolith
```

---

## 3️⃣ Cost Optimization Patterns

### Concept

Minimiser coûts en **routant intelligemment** : batch simple vers Haiku, critique vers Opus.

### Cost Optimization Flow

```
╔════════════════════════════════════════════╗
║      Cost-Optimized Batch Processing       ║
╚════════════════════════════════════════════╝

COMMAND: Generate 50 locale docs
    ↓
Classify tasks by complexity
    ↓
┌────────────────────────────────┐
│ 40 locales: SIMPLE             │
│ (formatting, standard data)    │
│ → Route to HAIKU 🐇            │
│ Cost: 40 × $0.10 = $4.00       │
└────────────────────────────────┘
    ↓
┌────────────────────────────────┐
│ 8 locales: MEDIUM              │
│ (custom data, some analysis)   │
│ → Route to SONNET 🧠           │
│ Cost: 8 × $0.50 = $4.00        │
└────────────────────────────────┘
    ↓
┌────────────────────────────────┐
│ 2 locales: COMPLEX             │
│ (legal, requires research)     │
│ → Route to OPUS 🎯             │
│ Cost: 2 × $1.50 = $3.00        │
└────────────────────────────────┘
    ↓
Total cost: $11.00

vs ALL OPUS: 50 × $1.50 = $75.00
Savings: 85% 🎉
```

### Exemple: Batch Processing with Model Routing

```yaml
# .claude/commands/generate-locales-optimized.md

## Workflow

3. **CLASSIFY LOCALES BY COMPLEXITY**
   ```javascript
   const COMPLEX_LOCALES = ['ar-SA', 'zh-CN', 'ja-JP']; // RTL, special chars, legal
   const SIMPLE_LOCALES = ['en-US', 'en-GB', 'es-ES']; // Standard, similar structure

   function classifyLocale(locale) {
     if (COMPLEX_LOCALES.includes(locale)) return 'complex';
     if (SIMPLE_LOCALES.includes(locale)) return 'simple';
     return 'medium'; // default
   }

   const classified = locales.reduce((acc, locale) => {
     const complexity = classifyLocale(locale);
     acc[complexity] = acc[complexity] || [];
     acc[complexity].push(locale);
     return acc;
   }, {});

   console.log(`
   📊 Classification:
   - Simple: ${classified.simple?.length || 0} locales → Haiku
   - Medium: ${classified.medium?.length || 0} locales → Sonnet
   - Complex: ${classified.complex?.length || 0} locales → Opus
   `);
   ```

4. **ROUTE TO MODELS**
   ```javascript
   const results = [];

   // Batch 1: Simple locales with Haiku (cheapest)
   if (classified.simple?.length > 0) {
     const haikuResults = await launchParallelAgents(
       classified.simple,
       '@generate-locale',
       'claude-3-haiku-20240307'
     );
     results.push(...haikuResults);
   }

   // Batch 2: Medium locales with Sonnet
   if (classified.medium?.length > 0) {
     const sonnetResults = await launchParallelAgents(
       classified.medium,
       '@generate-locale',
       'claude-3-5-sonnet-20250129'
     );
     results.push(...sonnetResults);
   }

   // Batch 3: Complex locales with Opus
   if (classified.complex?.length > 0) {
     const opusResults = await launchParallelAgents(
       classified.complex,
       '@generate-locale',
       'claude-3-opus-20240229'
     );
     results.push(...opusResults);
   }
   ```

5. **COST REPORT**
   ```javascript
   const costBreakdown = {
     haiku: classified.simple?.length * 0.10,
     sonnet: classified.medium?.length * 0.50,
     opus: classified.complex?.length * 1.50
   };

   const totalCost = Object.values(costBreakdown).reduce((a, b) => a + b, 0);

   console.log(`
   💰 COST BREAKDOWN:
   - Haiku: $${costBreakdown.haiku.toFixed(2)} (${classified.simple?.length} tasks)
   - Sonnet: $${costBreakdown.sonnet.toFixed(2)} (${classified.medium?.length} tasks)
   - Opus: $${costBreakdown.opus.toFixed(2)} (${classified.complex?.length} tasks)
   ──────────────────────────────
   TOTAL: $${totalCost.toFixed(2)}

   vs All Opus: $${(locales.length * 1.50).toFixed(2)}
   Savings: ${((1 - totalCost / (locales.length * 1.50)) * 100).toFixed(0)}%
   `);
   ```
```

### Cost Optimization Strategies

| Strategy | Savings | Use Case |
|----------|---------|----------|
| **Route by complexity** | 70-85% | Batch tasks with mixed complexity |
| **Fallback to cheaper** | 60-75% | Non-critical tasks (accept degraded quality) |
| **Cache results** | 90%+ | Repeated queries (avoid re-processing) |
| **Parallel Haiku** | 80% | Simple tasks (format, lint, grep) |

---

## 4️⃣ Context Window Management

### Concept

Tous les models Claude ont **200k context window**, mais coût varie. **Compacter contexte** réduit tokens = réduit coût.

### Context Compaction Strategies

```
╔════════════════════════════════════════════╗
║      Context Window Cost Optimization      ║
╚════════════════════════════════════════════╝

Before Compaction:
──────────────────────────────────────────
Full context: 150k tokens
  - Verbose logs: 50k
  - Redundant data: 30k
  - Essential: 70k

Cost (Opus): 150k × $0.015 = $2.25

After Compaction:
──────────────────────────────────────────
Compacted: 70k tokens
  - Summarized logs: 10k
  - Deduplicated: 5k
  - Essential: 55k

Cost (Opus): 70k × $0.015 = $1.05
Savings: 53% 🎉
```

### Exemple: Context Compaction Hook

```yaml
# .claude/hooks/before-llm-call.md
---
description: Compact context before sending to model (reduce cost)
event: BeforeLlmCall
---

You are a context compaction agent.

## Workflow

1. **ESTIMATE CONTEXT SIZE**
   ```javascript
   function estimateTokens(context) {
     const jsonString = JSON.stringify(context);
     return Math.ceil(jsonString.length / 4); // ~1 token ≈ 4 chars
   }

   const currentTokens = estimateTokens(context);
   ```

2. **COMPACT IF NEEDED** (>50k tokens)
   ```javascript
   const COMPACT_THRESHOLD = 50000;

   if (currentTokens > COMPACT_THRESHOLD) {
     console.log(`⚠️ Context large (${currentTokens} tokens), compacting...`);

     // Strategy 1: Summarize verbose logs
     context.logs = context.logs.map(log => {
       if (log.level === 'debug') return null; // Drop debug logs
       if (log.message.length > 100) {
         return { ...log, message: log.message.substring(0, 100) + '...' };
       }
       return log;
     }).filter(Boolean);

     // Strategy 2: Deduplicate similar entries
     context.results = deduplicateByKey(context.results, 'locale');

     // Strategy 3: Drop intermediate data (keep first & last)
     if (context.waves && context.waves.length > 5) {
       context.waves = [
         context.waves[0], // first wave
         { summary: `${context.waves.length - 2} waves omitted` },
         context.waves[context.waves.length - 1] // last wave
       ];
     }

     const compactedTokens = estimateTokens(context);
     console.log(`✅ Compacted: ${currentTokens} → ${compactedTokens} tokens (${((1 - compactedTokens/currentTokens) * 100).toFixed(0)}% reduction)`);
   }
   ```

3. **COST SAVINGS REPORT**
   ```javascript
   const COST_PER_1K_TOKENS = {
     'haiku': 0.00025,
     'sonnet': 0.00125,
     'opus': 0.00375
   };

   const originalCost = (currentTokens / 1000) * COST_PER_1K_TOKENS[model];
   const compactedCost = (compactedTokens / 1000) * COST_PER_1K_TOKENS[model];

   console.log(`💰 Cost savings: $${(originalCost - compactedCost).toFixed(4)}`);
   ```
```

---

## 5️⃣ Quality vs Speed Trade-offs

### Concept

**Choisir consciemment** : Vitesse (Haiku) vs Qualité (Opus) selon business need.

### Trade-off Matrix

```
╔════════════════════════════════════════════╗
║      Quality vs Speed Trade-off Matrix     ║
╚════════════════════════════════════════════╝

        QUALITY
          ▲
          │
     🎯 OPUS
          │   Use when:
          │   - Critical decisions
          │   - Security audit
          │   - Architecture design
          │   - Legal compliance
          │
     🧠 SONNET
          │   Use when:
          │   - General coding
          │   - Code review
          │   - Documentation
          │   - Analysis
          │
     🐇 HAIKU
          │   Use when:
          │   - Formatting
          │   - Linting
          │   - Simple queries
          │   - Batch processing
          │
          └──────────────────────────────────> SPEED
```

### Exemple: User Choice for Trade-off

```yaml
# .claude/commands/adaptive-task.md

## Workflow

1. **ASK USER PREFERENCE**
   ```
   AskUserQuestion:
     "This task can be optimized for speed or quality. Choose:"
       - "Speed (Haiku)" → Fast, basic quality, cheap
       - "Balanced (Sonnet)" → Medium speed, good quality
       - "Quality (Opus)" → Slower, best quality, expensive
   ```

2. **ROUTE BASED ON CHOICE**
   ```javascript
   const MODEL_MAPPING = {
     'Speed (Haiku)': {
       model: 'claude-3-haiku-20240307',
       expectations: 'basic',
       cost_multiplier: 1
     },
     'Balanced (Sonnet)': {
       model: 'claude-3-5-sonnet-20250129',
       expectations: 'good',
       cost_multiplier: 5
     },
     'Quality (Opus)': {
       model: 'claude-3-opus-20240229',
       expectations: 'excellent',
       cost_multiplier: 15
     }
   };

   const selected = MODEL_MAPPING[userChoice];

   console.log(`
   🤖 Model: ${selected.model}
   🎯 Expected quality: ${selected.expectations}
   💰 Cost: ${selected.cost_multiplier}x baseline
   `);
   ```

3. **ADJUST PROMPT FOR MODEL**
   ```
   IF model === 'haiku':
     prompt = simplifyPrompt(originalPrompt);
   ELSE IF model === 'opus':
     prompt = enhancePrompt(originalPrompt);
   ELSE:
     prompt = originalPrompt;
   ```
```

---

## 🎯 Best Practices

### ✅ DO

1. **Classify tasks** : Simple → Haiku, Medium → Sonnet, Complex → Opus
2. **Fallback chains** : Opus → Sonnet → Haiku (degraded)
3. **Cost tracking** : Monitor spend per model
4. **Compact context** : Reduce tokens >50k
5. **Batch routing** : Group by complexity, route to appropriate model
6. **User choice** : Ask preference (speed vs quality) pour tâches non-critiques
7. **Cache results** : Avoid re-processing same queries

### ❌ DON'T

1. **Always use Opus** (coût élevé, inutile pour simple tasks)
2. **Ignore fallbacks** (single model = fragile)
3. **Verbose context** (high token cost)
4. **Same model all tasks** (over-pay ou under-quality)
5. **Skip cost tracking** (budget overrun)
6. **Rigid routing** (adapt to context)

---

## 📋 Cheatsheet Rapide

```bash
# Model Selection
Simple task (format, lint) → Haiku 🐇 (1x cost)
Medium task (code review) → Sonnet 🧠 (5x cost)
Complex task (architecture) → Opus 🎯 (15x cost)

# Fallback Chain
TRY Opus → CATCH error → TRY Sonnet → CATCH → TRY Haiku → CATCH → User validation

# Cost Optimization
Batch routing: classify → route to cheapest model possible
Context compaction: summarize logs, deduplicate, drop intermediate
Cache: avoid re-processing

# Quality vs Speed
Speed critical → Haiku
Balanced → Sonnet (default)
Quality critical → Opus

# Context Compaction
IF context > 50k tokens:
  - Drop debug logs
  - Summarize verbose entries
  - Deduplicate
  - Keep first & last (drop intermediate)
```

---

## 🎓 Points Clés

1. **Model selection** : Classifier tâches (simple/medium/complex) → router intelligemment
2. **Coût relatif** : Haiku (1x) < Sonnet (5x) < Opus (15x)
3. **Fallback chains** : Opus → Sonnet → Haiku (degraded quality acceptable)
4. **Cost optimization** : Batch routing + context compaction = 70-85% savings
5. **Context window** : Tous 200k, mais coût varie → compacter pour économiser
6. **Trade-offs conscients** : Speed (Haiku) vs Quality (Opus) selon business need
7. **Cache results** : Avoid re-processing = 90%+ savings

---

## 📚 Ressources

### Documentation Interne
- 📄 [Error Handling](../patterns/error-handling.md) - Fallback chains pattern
- 📄 [Parallel Execution](../patterns/parallel-execution.md) - Batch processing
- 📄 [State Management](../patterns/state-management.md) - Context compaction
- 📄 [Command/Agent Pattern](../patterns/command-agent-skill.md) - Task routing

### Documentation Externe
- 📄 [Claude Models Pricing](https://www.anthropic.com/pricing) - Official cost comparison
- 📄 [Claude 3 Model Card](https://www.anthropic.com/news/claude-3-family) - Capabilities comparison
- 📄 [Context Window Best Practices](https://docs.anthropic.com/claude/docs/context-window) - Token optimization

### Repos Communauté
- 🔗 [Cost Optimization Patterns](https://github.com/search?q=claude+cost+optimization) - Community strategies
- 🔗 [Model Routing Examples](https://github.com/search?q=claude+model+selection) - Real-world implementations
