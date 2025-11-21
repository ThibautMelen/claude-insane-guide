# 🎬 Exemple : Production Vidéo avec 7 Agents Parallèles

> **Cas réel : Production complète vidéo YouTube avec orchestration multi-agents**

## 🎯 Contexte

**Problème** : Analyser une vidéo de 12 minutes et produire un rapport complet de production prend **9 minutes** en séquentiel.

**Solution** : 7 agents spécialisés travaillant **en parallèle** → **2 minutes** seulement !

**Gain** : **77% de temps économisé** 🚀

## 📊 Architecture

```
╔═══════════════════════════════════════════════════════════╗
║  PROJET: YouTube Video Production (7 Agents Parallèles)   ║
╚═══════════════════════════════════════════════════════════╝

                 👤 User: "Process tutorial.mp4"
                           │
                           ▼
              ┌─────────────────────────┐
              │  🤖 MAIN AGENT          │
              │  (Orchestrateur)        │
              └────────┬────────────────┘
                       │
    ┌──────────────────┼──────────────────┐
    │                  │                  │
    ▼                  ▼                  ▼
┌─────────┐      ┌─────────┐       ┌─────────┐
│ Agent 1 │      │ Agent 2 │       │ Agent 3 │
│Transcribe│      │ Analyze │       │ Editor  │
│ (Haiku) │      │(Sonnet) │       │(Sonnet) │
│  30s    │      │  90s    │       │  90s    │
└─────────┘      └─────────┘       └─────────┘
    │                  │                  │
    ▼                  ▼                  ▼
┌─────────┐      ┌─────────┐       ┌─────────┐
│ Agent 4 │      │ Agent 5 │       │ Agents  │
│Repetition│      │Timeline │       │ 6-7     │
│ (Haiku) │      │ (Opus)  │       │(Sonnet) │
│  30s    │      │ 120s    │       │  90s    │
└─────────┘      └─────────┘       └─────────┘
    │                  │                  │
    └──────────────────┴──────────────────┘
                       │
                       ▼
          ┌───────────────────────────┐
          │  Main Agent Compile       │
          │  → Video Production Report│
          └───────────────────────────┘

⏱️ Temps total : 120s (agent le plus lent)
⚡ Sans parallélisation : 540s (30+90+90+30+120+90+90)
🚀 Gain : 77% de temps économisé !
```

## 🛠️ Configuration Agents

### 📁 Fichier : `.claude/plugins/video-production/index.ts`

```typescript
export default {
  subAgents: {
    // Agent 1: Transcription (Haiku - Fast & Cheap)
    'transcriber': {
      systemPrompt: `You transcribe audio to text with timestamps.

      Output format:
      [00:00] - Intro starts
      [00:15] - "Welcome to this tutorial..."
      [02:34] - Topic explanation begins

      Flag unclear audio sections.
      `,
      description: 'Transcribes video audio to text with timestamps',
      model: 'haiku'  // Simple task, Haiku perfect
    },

    // Agent 2: Content Analysis (Sonnet - Balanced)
    'content-analyzer': {
      systemPrompt: `Analyze video content structure.

      Evaluate:
      - Hook strength (0-10)
      - Content retention (HIGH/MEDIUM/LOW per section)
      - Pacing issues
      - Key moments

      Output structured breakdown.
      `,
      description: 'Analyzes video content and structure',
      model: 'sonnet'
    },

    // Agent 3: Editor Notes (Sonnet)
    'editor-notes': {
      systemPrompt: `Generate editing notes.

      Identify:
      - Cut points (timestamps)
      - Transition suggestions
      - B-roll opportunities
      - Audio issues

      Output actionable editor checklist.
      `,
      description: 'Creates detailed editing notes',
      model: 'sonnet'
    },

    // Agent 4: Repetition Detection (Haiku - Fast)
    'repetition-detector': {
      systemPrompt: `Detect repetitive words and phrases.

      Find:
      - Filler words ("um", "uh", "you know")
      - Repeated phrases
      - Recommend which to remove

      Output list with timestamps.
      `,
      description: 'Detects repetitive words to remove',
      model: 'haiku'  // Pattern matching = Haiku
    },

    // Agent 5: Timeline Analysis (Opus - Premium)
    'timeline-analyzer': {
      systemPrompt: `Deep timeline and retention analysis.

      Analyze:
      - Intro hook effectiveness
      - Drop-off risk sections
      - Engagement score per segment
      - Pacing optimization

      This is critical for video success.
      `,
      description: 'Premium timeline and retention analysis',
      model: 'opus'  // Critical analysis = Opus
    },

    // Agent 6: B-roll Suggestions (Sonnet)
    'broll-suggester': {
      systemPrompt: `Suggest B-roll footage moments.

      For each moment:
      - Timestamp
      - Suggested B-roll type
      - Duration needed
      - Visual description

      Match content narrative.
      `,
      description: 'Suggests B-roll footage insertions',
      model: 'sonnet'
    },

    // Agent 7: Effects Plan (Sonnet)
    'effects-planner': {
      systemPrompt: `Plan visual effects and transitions.

      Suggest:
      - Transitions (types, timestamps)
      - Lower thirds (text overlays)
      - Color grading approach
      - Animation moments

      Match video style.
      `,
      description: 'Plans visual effects and transitions',
      model: 'sonnet'
    }
  }
};
```

## 💻 Commande Utilisateur

```bash
claude
> "Process tutorial.mp4 for complete video production with all agents in parallel"
```

## 📋 Workflow Main Agent

Le main agent orchestre automatiquement :

```typescript
// Pseudo-code du main agent
async function processVideo(videoPath: string) {
  // Launch all 7 agents IN PARALLEL
  const [
    transcript,
    contentAnalysis,
    editorNotes,
    repetitions,
    timelineAnalysis,
    brollSuggestions,
    effectsPlan
  ] = await Promise.all([
    launchAgent('transcriber', videoPath),
    launchAgent('content-analyzer', videoPath),
    launchAgent('editor-notes', videoPath),
    launchAgent('repetition-detector', videoPath),
    launchAgent('timeline-analyzer', videoPath),
    launchAgent('broll-suggester', videoPath),
    launchAgent('effects-planner', videoPath)
  ]);

  // Compile comprehensive report
  return compileVideoProductionReport({
    transcript,
    contentAnalysis,
    editorNotes,
    repetitions,
    timelineAnalysis,
    brollSuggestions,
    effectsPlan
  });
}
```

## 📊 Rapport Généré

```markdown
╔════════════════════════════════════════════════╗
║  VIDEO PRODUCTION REPORT - tutorial.mp4        ║
╚════════════════════════════════════════════════╝

📄 TRANSCRIPTION (@transcriber - Haiku - 30s)
═══════════════════════════════════════════════
✅ Full transcript with timestamps
   Duration: 12:34 | Words: 2,847
   Flagged 3 unclear audio sections:
   - [03:12] Background noise
   - [07:45] Microphone pop
   - [10:23] Volume dip

📊 CONTENT ANALYSIS (@content-analyzer - Sonnet - 90s)
════════════════════════════════════════════════════
✅ Structure breakdown
   Hook strength: 8/10 ("Strong opening, clear value prop")
   Retention prediction:
   - 0-3min: HIGH (intro + hook)
   - 3-6min: MEDIUM (tutorial section)
   - 6-9min: MEDIUM (advanced concepts)
   - 9-12min: HIGH (conclusion + CTA)

   Key moments:
   - [00:34] Value proposition clear
   - [05:12] Breakthrough moment (highlight!)
   - [11:02] Strong CTA

✂️ EDITOR NOTES (@editor-notes - Sonnet - 90s)
═════════════════════════════════════════════════
✅ 47 cut points identified
   12 transitions recommended
   8 B-roll moments flagged

   Critical cuts:
   - [01:23-01:27] Remove pause (4s)
   - [03:45-03:52] Tighten explanation (7s)
   - [08:15-08:18] Cut repetition (3s)

   Transitions:
   - [02:30] Fade to next section
   - [06:00] Quick cut for pace
   - [09:45] Smooth transition to conclusion

🔄 REPETITION REPORT (@repetition-detector - Haiku - 30s)
═════════════════════════════════════════════════════════
⚠️ Filler words detected
   "you know" x23 instances (remove 20, keep 3 for natural flow)
   "basically" x18 instances (remove 15)
   "um/uh" x47 instances (remove all)

   Timestamps for removal provided in separate file

⏱️ TIMELINE ANALYSIS (@timeline-analyzer - Opus - 120s)
════════════════════════════════════════════════════════
✅ Premium retention analysis
   Intro hook: 9/10 (Excellent - keeps attention)

   Drop-off risks:
   - Segment 3 (5:30-6:45): Pacing slow, condense 40%
   - Segment 5 (8:00-9:00): Technical jargon, add visuals

   Engagement score: 7.8/10 (Above average)
   Recommended final duration: 10:30 (cut 2min)

🎬 B-ROLL SUGGESTIONS (@broll-suggester - Sonnet - 90s)
═══════════════════════════════════════════════════════
✅ 15 B-roll moments identified

   Priority B-roll:
   1. [00:15-00:30] Screen recording: Dashboard demo
   2. [02:45-03:00] Code editor: Function implementation
   3. [05:12-05:25] Animation: Concept visualization
   4. [07:30-07:45] Screen recording: API call demo
   5. [09:00-09:15] Graphic: Architecture diagram

   8 screen recordings needed (list provided)
   7 graphics/animations needed (descriptions provided)

✨ EFFECTS PLAN (@effects-planner - Sonnet - 90s)
═════════════════════════════════════════════════
✅ Visual effects strategy

   Transitions (12 total):
   - Opening: Fade from black (0:00)
   - Section breaks: Quick cuts (2:30, 6:00, 9:45)
   - Conclusion: Smooth fade (11:30)

   Lower thirds (5 placements):
   - [00:05] "Your Name - Title"
   - [02:15] "Key Concept #1"
   - [05:10] "Advanced Technique"
   - [08:00] "Pro Tip"
   - [11:00] "Subscribe for more!"

   Color grading:
   - Overall: Warm, energetic tone
   - Intro: Slightly desaturated → saturate
   - Conclusion: Maintain warmth

   Animations:
   - 3 text animations (timestamps provided)
   - 2 logo reveals (intro + outro)

═══════════════════════════════════════════════

🎯 NEXT STEPS:
══════════════
1. ✂️ Edit video with cut points (Est: 3-4h)
2. 🎬 Record/find B-roll footage (Est: 1h)
3. ✨ Apply effects and transitions (Est: 1h)
4. 🔊 Clean audio (remove filler words) (Est: 30min)
5. 🎨 Color grading (Est: 45min)
6. 📝 Final review and export (Est: 30min)

Total post-production estimate: 6.5-8h

💰 COST BREAKDOWN:
═══════════════════
Agent 1 (Haiku): $0.0003
Agent 2 (Sonnet): $0.0045
Agent 3 (Sonnet): $0.0045
Agent 4 (Haiku): $0.0003
Agent 5 (Opus): $0.0180
Agent 6 (Sonnet): $0.0045
Agent 7 (Sonnet): $0.0045
─────────────────────────
Total: $0.0366 (~4 cents)

⏱️ TIME SAVED: 7 minutes (77% faster than sequential)
```

## 💰 Optimisation Coût

**Mix Modèles Intelligent** :

| Agent | Modèle | Justification | Coût |
|-------|--------|---------------|------|
| Transcriber | Haiku | Pattern matching simple | $0.0003 |
| Repetition | Haiku | Detection patterns | $0.0003 |
| Content Analyzer | Sonnet | Compréhension contextuelle | $0.0045 |
| Editor Notes | Sonnet | Créativité modérée | $0.0045 |
| B-roll Suggester | Sonnet | Créativité visuelle | $0.0045 |
| Effects Planner | Sonnet | Planification créative | $0.0045 |
| Timeline Analyzer | Opus | **Critique pour succès vidéo** | $0.0180 |

**Total** : $0.0366 (4 cents)

**Si tous Opus** : $0.126 (13 cents) → **3.4x plus cher**

## 🎯 Patterns Clés

### 1. Spécialisation par Expertise

Chaque agent a UNE responsabilité claire :
- Transcriber → Text only
- Content Analyzer → Structure only
- Effects Planner → Visual effects only

### 2. Optimisation par Complexité

- Tâches simples (pattern matching) → **Haiku**
- Tâches standard (analysis, creativity) → **Sonnet**
- Tâches critiques (retention analysis) → **Opus**

### 3. Parallélisation Maximale

7 agents travaillent **simultanément** :
- Temps = max(agent le plus lent) = 120s (Timeline Analyzer)
- Sans parallélisation = 540s
- Gain = **77%**

## 🔧 Adaptation pour Autres Vidéos

### Vidéo Courte (< 5 min)

Réduire à 4 agents :
```typescript
{
  'transcriber': 'haiku',
  'content-analyzer': 'sonnet',
  'editor-notes': 'sonnet',
  'effects-planner': 'sonnet'
}
```

### Vidéo Longue (> 30 min)

Ajouter agents :
```typescript
{
  // ... agents existants
  'chapter-segmenter': 'sonnet',     // Découper en chapitres
  'thumbnail-suggester': 'opus',     // Thumbnail critical
  'seo-optimizer': 'sonnet'          // Title, description, tags
}
```

### Vidéo Live Stream

Focus différent :
```typescript
{
  'highlight-detector': 'opus',      // Moments viraux
  'clip-extractor': 'sonnet',        // Clips courts
  'engagement-analyzer': 'opus'      // Chat analysis
}
```

## 📚 Ressources

- 📖 [Guide Agents](../guide.md#architecture-cas-réel-production-vidéo)
- ⚡ [Cheatsheet](../cheatsheet.md)
- 🎥 [Formation Melvynx](https://www.youtube.com/watch?v=bDr1tGskTdw) (45:00 - Section Agents Parallèles)
- 📄 [Pattern Parallelization](../../../agentic-workflow/6-composable-patterns/3-parallelization.md)

---

**💡 Tip** : Ce pattern s'applique à TOUT workflow complexe : data analysis, code review, content creation !
