# Pattern 3 : Parallelization (Concurrent Execution)

> **📚 Vue d'ensemble complète** : Voir [6 Patterns README](./README.md)

## 🎯 En Bref

**Concept**: Lancer plusieurs agents en parallèle (même message) pour tasks indépendantes, réduisant temps total drastiquement.

**Notre implémentation**: Task tool avec concurrent pattern (10-20 agents/wave optimal)

**ROI**: 5-10x speedup pour tasks indépendantes (42s vs 136s pour 4 items)

## 📐 Architecture

```
                ┌─> [AGENT 1] ─┐
Command ─>──────┼─> [AGENT 2] ─┼──> Aggregate → Report
  (same msg)    └─> [AGENT N] ─┘
                   (parallel)

Sequential: A→B→C→D = 136s
Parallel:   max(A,B,C,D) = 42s
Speedup:    3.2x
```

## ⚡ Quick Start

```markdown
<!-- ❌ BAD: Sequential -->
Use Task tool for file1.md
Wait. Use Task tool for file2.md
Wait. Use Task tool for file3.md

<!-- ✅ GOOD: Parallel (same message) -->
Launch ALL Task calls in SINGLE message:
- Task(file1.md)
- Task(file2.md)
- Task(file3.md)
```

## 💡 Patterns Détaillés

### 1️⃣ Concurrent Pattern (2-20 items)

```yaml
Strategy:
  IF 2-10 items  → Single wave (all parallel)
  IF 11-20 items → Batch (waves of 10)
  IF >20 items   → Batch (waves of 10-20)

Batch size optimal: 10-20
  - <5:  Overhead élevé
  - 10-20: ✅ Sweet spot
  - >50:  Risque timeouts
```

### 2️⃣ Batch Pattern (Large Scale)

```yaml
# 200 locales example:
Total: 200 items
Batch size: 20

Wave 1: Items 1-20   (parallel) → 60s
Wave 2: Items 21-40  (parallel) → 58s
Wave 3: Items 41-60  (parallel) → 62s
...
Wave 10: Items 181-200 (parallel) → 45s

Total: ~10 minutes (vs 100 hours sequential!)
Speedup: 600x
```

### 3️⃣ Resource Management

```yaml
Check before wave:
  - API calls remaining
  - Memory available
  - Rate limit status

IF approaching limit:
  - Reduce batch size (20→10)
  - OR delay between waves
  - OR use cache/fallback
```

## 🎯 Best Practices

### ✅ DO
- Launch parallel in same message (multiple Task calls)
- Batch size 10-20 for large scale
- Isolate context (no shared state)
- Monitor resources (rate limits, memory)
- Wave logging ("Wave 2/5: 9/10 success")

### ❌ DON'T
- Launch sequentially (perte de temps)
- Batch size >50 (risque crashes)
- Shared state between agents (race conditions)
- Ignore rate limits (API bans)
- Launch tous d'un coup si >20 items

## 🎓 Points Clés

```
✅ Parallel > Sequential (5-10x speedup)
✅ Task tool same message (SEULE façon)
✅ Batch size 10-20 (sweet spot)
✅ Isolate context (no shared state)
✅ Monitor resources (rate limits)
❌ Never sequential pour tasks indépendantes
❌ Never batch size >50
```

## 🔗 Ressources

- 📄 [Vue d'ensemble 6 Patterns](./README.md)
- 📐 [Command-Agent-Skill Pattern](../architecture/command-coordinator-workers.md)
- 🚀 [Error Handling](../best-practices/error-resilience.md)
- 📄 [Claude Code Task Tool](https://code.claude.com/docs/task-tool)

**Voir** : [Agents Guide](../../themes/6-agents/guide.md) - Verdent Deck architecture
