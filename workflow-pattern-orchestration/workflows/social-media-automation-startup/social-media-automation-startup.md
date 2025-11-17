# 📱 Social Media Post Generator pour Startups

> **Pattern**: Parallel + Conditional
> **Complexité**: Moyenne
> **Cas d'usage**: Génération et distribution automatique de contenu multi-plateformes
> **ROI**: 90% réduction temps, 95% réduction coûts

## 🎯 Contexte Startup

Les startups doivent être actives sur **5+ plateformes sociales** mais manquent de ressources pour un social media manager dédié.

**Problème** :
- Création posts manuels → 30-45min par plateforme
- 5 plateformes × 3 posts/jour = 15 posts/jour
- **Temps total** : 7-11h/jour
- Coût social media manager : $4,000-6,000/mois
- Incohérence entre plateformes

**Solution Claude Code** :
- 1 idée → 15 posts adaptés automatiquement
- Chaque plateforme optimisée (format, ton, hashtags)
- Scheduling intelligent (best times per platform)
- Analytics automatiques
- **Résultat** : 30min/jour + $200/mois en coûts API

---

## 📊 Architecture du Workflow

```
╔═══════════════════════════════════════════════════════════════╗
║         COMMAND: /social-generate                             ║
║  (Génère posts pour toutes plateformes depuis 1 idée)        ║
╚═══════════════════════════════════════════════════════════════╝
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
   │ SUB: Ideas  │    │SUB: Generate│    │SUB: Schedule│
   │  & Research │    │   & Adapt   │    │  & Publish  │
   └─────────────┘    └─────────────┘    └─────────────┘
          │                   │                   │
          ▼                   ▼                   ▼
      [AG1][AG2]      [AG3...AG8] (6 agents)  [AG9][AG10]
                           PARALLEL

🪝 HOOKS: Content-Policy-Check, Visual-Validation, Scheduling-Optimization
```

### Architecture Détaillée

```
Niveau 1: COMMAND (/social-generate)
   │
   ├─ Niveau 2: SUBCOMMAND (Idea Generation)
   │   ├─ Niveau 3: AGENT (Trend-Researcher) - trouve trending topics
   │   └─ Niveau 3: AGENT (Content-Ideator) - génère idées de posts
   │
   ├─ HOOK: Content-Policy-Check (évite contenu inapproprié)
   │
   ├─ Niveau 2: SUBCOMMAND (Multi-Platform Generation)
   │   │
   │   ├─ Niveau 3: AGENT (Twitter-Creator) 🐦
   │   │   └─ Crée: Threads, tweets, polls
   │   │
   │   ├─ Niveau 3: AGENT (LinkedIn-Creator) 💼
   │   │   └─ Crée: Posts professionnels, carrousels
   │   │
   │   ├─ Niveau 3: AGENT (Instagram-Creator) 📸
   │   │   └─ Crée: Posts, captions, stories
   │   │
   │   ├─ Niveau 3: AGENT (Facebook-Creator) 👍
   │   │   └─ Crée: Posts communautaires
   │   │
   │   ├─ Niveau 3: AGENT (TikTok-Creator) 🎵
   │   │   └─ Crée: Scripts vidéo, hooks
   │   │
   │   └─ Niveau 3: AGENT (Visual-Generator) 🎨
   │       └─ Crée: Images, graphics pour tous
   │
   ├─ HOOK: Visual-Validation (quality check)
   │
   └─ Niveau 2: SUBCOMMAND (Scheduling & Publishing)
       ├─ Niveau 3: AGENT (Scheduler) - optimal timing
       └─ Niveau 3: AGENT (Multi-Publisher) - publie partout

🔥 KEY FEATURE: 6 agents en parallèle = 6 plateformes simultanées
```

**Pattern spécial** : Conditional logic pour adapter ton et format par plateforme.

---

## 🔧 Implémentation Complète

### 1. Command Principal

`.claude/commands/social-generate.md` :

```yaml
---
name: social-generate
description: Generate social media posts for all platforms from a single idea
args:
  idea: Core content idea or topic
  variations: Number of variations per platform (default 3)
  schedule: Auto-schedule or return drafts (default false)
  platforms: Comma-separated platforms or "all" (default all)
---

# Social Media Post Generator

You are orchestrating social media content creation across multiple platforms.

## Input
- Idea: {{idea}}
- Variations per platform: {{variations}}
- Auto-schedule: {{schedule}}
- Target platforms: {{platforms}}

## Supported Platforms

### Text-Primary
- 🐦 Twitter/X (threads, tweets, polls)
- 💼 LinkedIn (professional posts, carousels)
- 👍 Facebook (community posts, events)

### Visual-Primary
- 📸 Instagram (posts, stories, reels scripts)
- 🎵 TikTok (video scripts, hooks)
- 📌 Pinterest (pin descriptions)

## Workflow Steps

### PHASE 1: Idea Development & Research
Execute subcommand: `/social-ideate {{idea}}`

**This subcommand coordinates 2 agents in PARALLEL**:
1. Trend-Researcher agent (finds current trending topics, hashtags)
2. Content-Ideator agent (expands idea into platform-specific angles)

**HOOK: content-policy-check**
- Verify content is brand-safe
- Check for sensitive topics
- Ensure compliance with platform policies
- Flag potential issues for human review

### PHASE 2: Multi-Platform Content Creation
Execute subcommand: `/social-create {{developed_idea}} {{platforms}}`

**This subcommand launches 6 platform agents in PARALLEL**:

Each agent creates {{variations}} posts optimized for their platform:
- Twitter-Creator: Threads, standalone tweets, polls
- LinkedIn-Creator: Professional narratives, carousels
- Instagram-Creator: Captions, story scripts, reel hooks
- Facebook-Creator: Community-focused posts
- TikTok-Creator: Video scripts with hooks
- Visual-Generator: Images, graphics, templates

All agents use:
- Brand-Voice skill (platform-specific adaptation)
- Hashtag-Strategy skill (trending + niche tags)
- Engagement-Patterns skill (proven formats)

**HOOK: visual-validation**
- Check image quality and dimensions
- Verify brand consistency (colors, fonts)
- Ensure text overlays are readable
- Validate aspect ratios per platform

### PHASE 3: Scheduling & Publishing
Execute subcommand: `/social-schedule {{all_posts}}`

**This subcommand coordinates 2 agents in SEQUENCE**:
1. Scheduler agent (determines optimal posting times)
2. Multi-Publisher agent (publishes to all platforms)

**HOOK: scheduling-optimization**
- Check audience time zones
- Avoid conflicts with existing posts
- Spread posts throughout week
- Optimize for engagement windows

## Output
Return:
- ✅ Posts created per platform
- 📅 Scheduled times or draft links
- 📊 Predicted engagement scores
- 🎨 Visual assets generated
- ⏱️ Total time taken

## Success Criteria
- Posts created for all target platforms
- Brand voice consistent across platforms
- Visual assets optimized
- Optimal scheduling applied
- Total time < 30 minutes (vs 7-11 hours manual)
```

---

### 2. Subcommands

#### `/social-ideate` - Idea Development

`.claude/commands/social-ideate.md` :

```yaml
---
name: social-ideate
description: Research trends and develop content ideas
args:
  core_idea: Core topic or idea
---

# Social Media Idea Development

Research trends and expand core idea into platform-specific angles.

## Agent 1: Trend Researcher
Launch agent with prompt:
```
You are a Trend-Researcher agent.

Task: Find trending topics, hashtags, and content formats

Input: {{core_idea}}

Research:
1. **Trending hashtags**:
   - Use MCP tools to check trending hashtags on each platform
   - Find hashtags related to {{core_idea}}
   - Mix of high-volume (>100K) and niche (<10K) tags

2. **Trending formats**:
   - Twitter: Threads, polls, quote tweets
   - LinkedIn: Document carousels, personal stories
   - Instagram: Reels, carousel posts, story templates
   - TikTok: Duets, stitches, trending sounds

3. **Competitor analysis**:
   - Check what competitors are posting
   - Identify engagement patterns
   - Find content gaps

4. **Seasonal/timely hooks**:
   - Current events related to {{core_idea}}
   - Upcoming holidays or events
   - Industry-specific timing (product launches, conferences)

Use MCP tools:
- mcp__firecrawl__firecrawl_search (research competitors)
- Social media trending APIs (if available)

Output:
```json
{
  "trending_hashtags": {
    "twitter": ["#trending1", "#trending2"],
    "linkedin": ["#ProfessionalTopic"],
    "instagram": ["#VisualTrend"]
  },
  "trending_formats": {
    "twitter": "thread with data",
    "linkedin": "personal story + lesson",
    "instagram": "carousel with tips"
  },
  "timely_hooks": [
    "Product Hunt launch next week",
    "Industry conference in 2 days",
    "Viral topic about {{core_idea}}"
  ],
  "competitor_insights": [
    "Competitor A got 10K engagement with personal story",
    "Format X performing 3x better than Y"
  ]
}
```
```

## Agent 2: Content Ideator
Launch agent with prompt:
```
You are a Content-Ideator agent.

Task: Expand core idea into platform-specific content angles

Input:
- Core idea: {{core_idea}}
- Trends from Trend-Researcher

Use Skills:
- Brand-Voice skill (startup tone and positioning)
- Platform-Formats skill (best practices per platform)

Create angles:
Each platform needs different approach:

1. **Twitter angle**:
   - Concise, punchy statements
   - Data-driven insights
   - Question to spark discussion
   - Example: "{{core_idea}} increased our MRR by 40% in 3 months. Here's how: [thread]"

2. **LinkedIn angle**:
   - Professional narrative
   - Lessons learned
   - Behind-the-scenes
   - Example: "The mistake we made with {{core_idea}} that cost us $50K (and what we learned)"

3. **Instagram angle**:
   - Visual-first story
   - Inspirational/aspirational
   - Behind-the-scenes
   - Example: "{{core_idea}} transformation: Before vs After"

4. **Facebook angle**:
   - Community discussion
   - Question-based
   - Relatable story
   - Example: "Who else struggles with {{core_idea}}? Here's what finally worked for us"

5. **TikTok angle**:
   - Quick, engaging hook
   - Educational + entertaining
   - Trend participation
   - Example: "POV: You finally figure out {{core_idea}} [trending sound]"

Output:
```json
{
  "platform_angles": {
    "twitter": {
      "hook": "...",
      "format": "thread",
      "key_points": [...]
    },
    "linkedin": {
      "hook": "...",
      "format": "personal story",
      "key_points": [...]
    }
    // ... all platforms
  },
  "common_themes": ["efficiency", "ROI", "simplicity"],
  "cta_per_platform": {
    "twitter": "Join our community",
    "linkedin": "Connect for more insights",
    "instagram": "Link in bio"
  }
}
```
```

## Wait for Both Agents
Launch in parallel using `Task` tool.

## Output Format
```json
{
  "research": {
    "trending_hashtags": {...},
    "trending_formats": {...}
  },
  "ideas": {
    "platform_angles": {...},
    "common_themes": [...]
  },
  "estimated_engagement": {
    "twitter": "high (trending topic)",
    "linkedin": "medium-high (professional angle)",
    "instagram": "medium (visual needed)"
  }
}
```
```

---

#### `/social-create` - Multi-Platform Content Creation

`.claude/commands/social-create.md` :

```yaml
---
name: social-create
description: Generate optimized posts for each platform
args:
  idea: Developed idea with platform angles
  platforms: Target platforms
  variations: Number of posts per platform
---

# Multi-Platform Content Creation

Launch specialized agents for each platform in PARALLEL.

## Platform-Specific Agents

### Twitter Creator Agent

Launch agent with prompt:
```
You are a Twitter-Creator agent.

Task: Create engaging Twitter/X content

Input: {{idea.platform_angles.twitter}}

Create {{variations}} Twitter posts (each can be standalone or thread):

**Tweet Guidelines**:
- Max 280 characters per tweet
- Thread: 5-10 tweets for complex topics
- Hook in first tweet (stop the scroll)
- Use line breaks for readability
- Include 1-2 relevant emojis
- 2-3 hashtags max (overcrowding looks spammy)

**Thread Structure** (if applicable):
```
1/🧵 [HOOK - controversial or intriguing statement]

2/ [Context/problem]

3-7/ [Steps, insights, data]

8/ [Conclusion + CTA]

9/ [Optional: Ask for RT/engagement]
```

**Tone**: Conversational, slightly casual, authentic

**Engagement tactics**:
- Ask questions
- Use data/numbers
- Create polls when relevant
- Quote tweets for discussion

Use Skills:
- Brand-Voice skill (adapt to Twitter's casual tone)
- Hashtag-Strategy skill (mix trending + niche)

Output:
```json
{
  "posts": [
    {
      "type": "thread",
      "tweets": [
        "Tweet 1 text...",
        "Tweet 2 text..."
      ],
      "hashtags": ["#Startup", "#ProductivityHack"],
      "poll": null
    },
    {
      "type": "single",
      "text": "Standalone tweet...",
      "hashtags": ["#Tech"],
      "poll": {
        "question": "Which feature do you use most?",
        "options": ["A", "B", "C", "D"]
      }
    }
  ],
  "best_posting_time": "9am or 3pm EST (workday breaks)",
  "predicted_engagement": "high"
}
```
```

### LinkedIn Creator Agent

Launch agent with prompt:
```
You are a LinkedIn-Creator agent.

Task: Create professional LinkedIn content

Input: {{idea.platform_angles.linkedin}}

Create {{variations}} LinkedIn posts:

**LinkedIn Guidelines**:
- Max 3,000 characters (but keep under 1,500 for readability)
- Professional yet personal tone
- Story-driven (personal experiences, lessons learned)
- Line breaks every 1-2 sentences (mobile readability)
- First 2 lines are critical (preview text)
- Hashtags: 3-5 relevant professional tags
- Tag relevant people/companies (when appropriate)

**Post Structures**:

1. **Personal Story Format**:
```
[Hook: Bold statement or question]

[Story: Personal experience with {{core_idea}}]

[Challenge: What went wrong initially]

[Solution: What you learned/changed]

[Results: Data or tangible outcomes]

[Lesson: Key takeaway]

[CTA: Ask audience for their experience]
```

2. **Carousel/Document Format**:
```
Slide 1: Title + Hook
Slide 2-9: Key points (1 per slide)
Slide 10: Recap + CTA
```

**Tone**: Professional, authoritative, but approachable (not corporate-speak)

**Engagement tactics**:
- Ask for experiences in comments
- Tag relevant people
- Share vulnerability (challenges faced)
- Use data to establish credibility

Use Skills:
- Brand-Voice skill (professional but authentic)
- LinkedIn-Formats skill (document carousel templates)

Output:
```json
{
  "posts": [
    {
      "type": "text_post",
      "text": "Full post text with line breaks...",
      "hashtags": ["#StartupLife", "#ProductManagement"],
      "tags": ["@RelevantPerson"],
      "format_notes": "Personal story format"
    },
    {
      "type": "document_carousel",
      "slides": [
        {
          "slide_number": 1,
          "title": "...",
          "content": "..."
        }
      ],
      "caption": "Post caption..."
    }
  ],
  "best_posting_time": "7-8am or 12pm EST (before work, lunch break)",
  "predicted_engagement": "medium-high"
}
```
```

### Instagram Creator Agent

Launch agent with prompt:
```
You are an Instagram-Creator agent.

Task: Create visual-first Instagram content

Input: {{idea.platform_angles.instagram}}

Create {{variations}} Instagram posts:

**Instagram Guidelines**:
- Visual-first platform (caption supports image)
- Caption: 150-300 characters (first 125 visible without "more")
- Save long-form for carousel (10 slides max)
- Hashtags: 5-10 relevant (in first comment or end of caption)
- Story: 15-second video/image slides
- Reels: 30-60 seconds (hook in first 3 seconds)

**Post Types**:

1. **Feed Post**:
   - Image dimensions: 1080x1080 (square) or 1080x1350 (portrait)
   - Caption structure:
     ```
     [Hook line]

     [Main content - 2-3 lines]

     [CTA - comment/save/share]

     .
     .
     .
     [Hashtags if not in comment]
     ```

2. **Carousel Post** (high engagement):
   - 10 slides max
   - Slide 1: Eye-catching hook
   - Slides 2-9: Tips, steps, before/after
   - Slide 10: Recap + CTA

3. **Story Script**:
   - 5-7 slides
   - Text overlays (large, readable font)
   - Polls, questions, quizzes (engagement stickers)

4. **Reels Script**:
   - Hook (first 3 sec): "Wait, did you know...?"
   - Content (20-40 sec): Quick tips/insights
   - CTA (last 5 sec): "Follow for more"

**Tone**: Casual, inspirational, aspirational

**Visual specs for Visual-Generator agent**:
- Colors: Brand colors
- Fonts: Modern, readable (min 40pt for stories)
- Style: Clean, minimal, professional but friendly

Use Skills:
- Brand-Voice skill (Instagram casual tone)
- Visual-Templates skill (proven layouts)

Output:
```json
{
  "posts": [
    {
      "type": "feed_post",
      "caption": "Caption text...",
      "hashtags": ["#StartupTips", "#Productivity"],
      "visual_specs": {
        "type": "quote_graphic",
        "text_overlay": "Key quote from post",
        "style": "minimal"
      }
    },
    {
      "type": "carousel",
      "caption": "Swipe for tips on {{core_idea}} →",
      "slides": [
        {
          "slide_number": 1,
          "text": "Hook",
          "visual": "Bold text on brand background"
        }
      ]
    },
    {
      "type": "story_script",
      "slides": [
        {
          "text": "Did you know?",
          "sticker": "poll"
        }
      ]
    },
    {
      "type": "reel_script",
      "hook": "First 3 sec script",
      "content": "Main 40 sec content",
      "cta": "Follow @yourbrand"
    }
  ],
  "best_posting_time": "11am or 7pm EST (lunch, evening scroll)",
  "predicted_engagement": "high (visual platform)"
}
```
```

### Facebook Creator Agent

Launch agent with prompt:
```
You are a Facebook-Creator agent.

Task: Create community-focused Facebook content

Input: {{idea.platform_angles.facebook}}

**Facebook Guidelines**:
- Community and discussion focus
- Longer-form OK (2,000+ characters)
- Questions drive engagement
- Mix of text, images, videos, polls
- Groups vs Pages (different strategies)
- Casual, friendly tone

**Post Structures**:

1. **Question Post**:
```
[Relatable problem/situation]

[Your experience with {{core_idea}}]

[Question to community]

What's YOUR experience? Drop a comment! 👇
```

2. **Story Post**:
```
[Engaging story about {{core_idea}}]

[Lesson learned]

[Tag friends who need this]
```

3. **Poll Post**:
```
[Context/question]

[Poll options A/B/C]

[Encouragement to vote and comment why]
```

**Tone**: Warm, community-oriented, conversational

Output:
```json
{
  "posts": [
    {
      "type": "question_post",
      "text": "...",
      "cta": "Comment below!"
    },
    {
      "type": "poll",
      "text": "...",
      "poll_options": ["Option A", "Option B"]
    }
  ],
  "best_posting_time": "1-3pm EST (afternoon Facebook time)",
  "predicted_engagement": "medium (depends on community size)"
}
```
```

### TikTok Creator Agent

Launch agent with prompt:
```
You are a TikTok-Creator agent.

Task: Create engaging TikTok video scripts

Input: {{idea.platform_angles.tiktok}}

**TikTok Guidelines**:
- 15-60 seconds (30 optimal)
- Hook in first 1-3 seconds (CRITICAL)
- Fast-paced, entertaining
- Educational + entertaining = "Edutainment"
- Trending sounds/formats
- Captions on video (80% watch without sound)

**Script Structure**:
```
[0-3 sec]: HOOK
- "Wait, you're doing {{core_idea}} wrong"
- "POV: You finally figure out {{core_idea}}"
- "[Trending sound] when you realize..."

[3-15 sec]: CONTENT/SETUP
- Quick explanation or setup

[15-45 sec]: PAYOFF/TIPS
- Solution, tips, reveal

[45-60 sec]: CTA
- "Follow for more startup tips"
- "Comment if you relate"
```

**Video Concepts**:
1. POV format
2. Before/After
3. "Things I wish I knew about {{core_idea}}"
4. "How to {{core_idea}} in 30 seconds"
5. Trend participation (duet, stitch, sound)

**Tone**: Casual, authentic, entertaining

**On-screen text**: Big, bold captions (Gen Z prefers reading while watching)

Output:
```json
{
  "videos": [
    {
      "hook": "Script for first 3 sec",
      "content": "Script for main 30 sec",
      "cta": "Script for last 5 sec",
      "on_screen_text": ["Text 1", "Text 2"],
      "trending_sound": "Sound name (if applicable)",
      "hashtags": ["#StartupTok", "#ProductivityHack"]
    }
  ],
  "best_posting_time": "7-9am or 7-10pm EST (commute, evening)",
  "predicted_engagement": "high (if hook is strong)"
}
```
```

### Visual Generator Agent

Launch agent with prompt:
```
You are a Visual-Generator agent.

Task: Create visual assets for all posts

Input: All posts from platform agents

Use MCP tools:
- Image generation API (DALL-E, Midjourney)
- Canva API (if available)
- Stock image search (Unsplash, Pexels)

For EACH platform, create:

1. **Twitter**: Simple graphics, charts, memes
   - Dimensions: 1200x675 (16:9)
   - Style: Clean, data-focused

2. **LinkedIn**: Professional graphics, infographics
   - Dimensions: 1200x627 (1.91:1)
   - Style: Corporate, data-driven, charts

3. **Instagram**: Eye-catching visuals
   - Feed: 1080x1080 or 1080x1350
   - Story: 1080x1920 (9:16)
   - Style: Aesthetic, brand colors, quote overlays

4. **Facebook**: Community-friendly images
   - Dimensions: 1200x630
   - Style: Warm, inviting, relatable

5. **TikTok**: Vertical video thumbnails
   - Dimensions: 1080x1920 (9:16)
   - Style: Bold text, attention-grabbing

**Design principles**:
- Brand colors and fonts
- Readable text (40pt+ for social)
- High contrast (legibility on mobile)
- Consistent style across platforms
- Optimize file sizes (<1MB)

Output:
```json
{
  "visuals": [
    {
      "platform": "twitter",
      "post_id": "post_1",
      "image_url": "...",
      "alt_text": "...",
      "dimensions": "1200x675"
    }
    // ... all visuals
  ],
  "templates_used": ["quote_graphic", "data_viz", "before_after"],
  "total_assets": 15
}
```
```

---

## Wait for ALL Platform Agents
Launch all 6 agents (5 platforms + visuals) in parallel using `Task` tool.

Platform-specific optimization ensures:
- Native feel per platform (not copy-paste)
- Format optimization (threads, carousels, stories)
- Tone adaptation (professional vs casual)

## Output Format
```json
{
  "posts_by_platform": {
    "twitter": [...],
    "linkedin": [...],
    "instagram": [...],
    "facebook": [...],
    "tiktok": [...]
  },
  "visuals": [...],
  "summary": {
    "total_posts": 15,
    "total_visuals": 15,
    "time_taken": "18 minutes",
    "platforms_covered": 5
  }
}
```
```

---

#### `/social-schedule` - Scheduling & Publishing

`.claude/commands/social-schedule.md` :

```yaml
---
name: social-schedule
description: Schedule and publish posts across platforms
args:
  posts: All generated posts
  auto_publish: Auto-publish or return schedule
---

# Social Media Scheduling & Publishing

Optimize timing and publish to all platforms.

## Agent 1: Scheduler
Launch agent with prompt:
```
You are a Scheduler agent.

Task: Determine optimal posting times for each platform

Input: {{posts}}

Use Skills:
- Platform-TimingActivity skill (best times per platform)
- Audience-Analytics skill (user's audience timezone data)

For EACH post, determine:

1. **Platform-specific best times**:
   - Twitter: 9am, 12pm, 3pm, 6pm (workday breaks + evening)
   - LinkedIn: 7-8am, 12pm, 5-6pm (before work, lunch, after work)
   - Instagram: 11am, 1pm, 7-9pm (lunch, afternoon, evening scroll)
   - Facebook: 1-3pm (afternoon browsing)
   - TikTok: 7-9am, 7-11pm (commute + evening)

2. **Audience timezone considerations**:
   - If audience is US: Use EST/PST
   - If global: Stagger posts or pick primary timezone
   - If B2B: Avoid weekends

3. **Posting frequency**:
   - Twitter: 3-5x per day (high volume OK)
   - LinkedIn: 1x per day (max 2x)
   - Instagram: 1-2x per day feed, 3-5 stories
   - Facebook: 1x per day
   - TikTok: 1-3x per day

4. **Spread strategy**:
   - Distribute {{variations}} posts over 3-7 days
   - Avoid posting same content to multiple platforms simultaneously
   - Leave 2-3 hour gaps between posts on same platform

5. **Content mix**:
   - Balance promotional vs educational vs entertaining
   - Follow 80/20 rule (80% value, 20% promotion)

Use MCP tools:
- Analytics API (if available) to check past performance
- Timezone data for audience

Output:
```json
{
  "schedule": [
    {
      "platform": "twitter",
      "post_id": "twitter_post_1",
      "scheduled_time": "2025-11-18 09:00:00 EST",
      "timezone": "America/New_York",
      "reason": "Morning engagement peak on Twitter"
    },
    {
      "platform": "linkedin",
      "post_id": "linkedin_post_1",
      "scheduled_time": "2025-11-18 07:30:00 EST",
      "timezone": "America/New_York",
      "reason": "Before-work LinkedIn check"
    }
    // ... all posts
  ],
  "distribution": {
    "week_1": 10,
    "week_2": 5
  },
  "conflicts_avoided": 3
}
```
```

## Agent 2: Multi-Publisher
Launch agent with prompt:
```
You are a Multi-Publisher agent.

Task: Publish posts to all platforms via APIs

Input:
- {{posts}} (all posts with content)
- {{schedule}} (optimized timing)
- {{auto_publish}} (true/false)

Use MCP tools:
- Twitter API MCP
- LinkedIn API MCP
- Facebook/Instagram Graph API MCP
- TikTok API MCP (if available)

For EACH post:

1. **Upload media first**:
   - Upload images/videos to platform
   - Get media IDs

2. **Create post**:
   - Use platform API to create post
   - Include text, media, hashtags
   - Set scheduling time (if {{auto_publish}} = true)

3. **Handle platform-specific requirements**:
   - Twitter: Thread posts sequentially
   - LinkedIn: Document carousel format
   - Instagram: Stories vs Feed vs Reels
   - Facebook: Choose Page vs Group
   - TikTok: Video upload with captions

4. **Generate tracking links**:
   - UTM parameters for link posts
   - Track source (platform, campaign)

5. **Save post IDs**:
   - Store platform post IDs for later analytics

If {{auto_publish}} = false:
- Save as drafts
- Generate preview links
- Return scheduling instructions

Output:
```json
{
  "published_posts": [
    {
      "platform": "twitter",
      "post_id": "twitter_12345",
      "url": "https://twitter.com/user/status/12345",
      "status": "scheduled",
      "scheduled_for": "2025-11-18 09:00:00 EST"
    }
    // ... all posts
  ],
  "drafts": [
    {
      "platform": "instagram",
      "draft_link": "https://...",
      "instructions": "Upload manually via Instagram app"
    }
  ],
  "total_published": 12,
  "total_drafts": 3,
  "time_taken": "8 minutes"
}
```
```

## Sequential Execution
Agent 1 (Scheduler) MUST complete before Agent 2 (Publisher).

Schedule optimization → then publishing.

## Output Format
```json
{
  "schedule": {
    "total_posts": 15,
    "span_days": 7,
    "posts_per_day": 2.1
  },
  "publishing_results": {
    "successful": 15,
    "failed": 0,
    "draft_only": 0
  },
  "analytics_tracking": {
    "utm_campaign": "social_automation_nov",
    "tracking_enabled": true
  }
}
```
```

---

## 🛠️ Skills Requis

### 1. Brand-Voice Skill

`.claude/skills/brand-voice.md` :

```markdown
# Brand Voice Skill

Adapt brand tone per platform while maintaining consistency.

## Core Brand Identity
- Mission: Help startups scale efficiently
- Values: Simplicity, ROI, practical advice
- Target: Startup founders, 25-40 years old
- Personality: Friendly expert (not corporate, not too casual)

## Platform-Specific Tone Adaptation

### Twitter 🐦
- **Tone**: Conversational, slightly edgy, authentic
- **Length**: Concise, punchy
- **Style**: Bold statements, threads, data
- **Example**: "Your startup doesn't need a social media manager. It needs a system. Here's ours: [thread]"

### LinkedIn 💼
- **Tone**: Professional, storytelling, vulnerable
- **Length**: Medium-long (800-1,500 chars)
- **Style**: Personal stories, lessons learned, data
- **Example**: "I wasted $10K on social media before I learned this one principle..."

### Instagram 📸
- **Tone**: Inspirational, aspirational, casual
- **Length**: Short caption (150-300 chars)
- **Style**: Visual-first, quote-driven, lifestyle
- **Example**: "Simplicity wins. Every. Single. Time. ✨"

### Facebook 👍
- **Tone**: Warm, community-focused, relatable
- **Length**: Medium (500-1,000 chars)
- **Style**: Questions, stories, discussions
- **Example**: "Who else felt overwhelmed by social media marketing? Here's what finally worked for us..."

### TikTok 🎵
- **Tone**: Casual, entertaining, authentic
- **Length**: Very short (script for 30-60 sec)
- **Style**: Hook-driven, educational + entertaining
- **Example**: "POV: You finally stop wasting time on social media and start THIS"

## Consistency Rules
- Always value-first (no hard sells)
- Use data when possible
- Share wins AND failures (authenticity)
- End with clear CTA
```

### 2. Hashtag-Strategy Skill

`.claude/skills/hashtag-strategy.md` :

```markdown
# Hashtag Strategy Skill

Optimize hashtag usage per platform.

## Platform Guidelines

### Twitter
- **Count**: 1-2 max (hashtags look spammy on Twitter)
- **Type**: Trending + branded
- **Placement**: End of tweet or integrated naturally
- **Example**: "Our startup journey #StartupLife"

### LinkedIn
- **Count**: 3-5
- **Type**: Professional, industry-specific
- **Placement**: End of post
- **Mix**: Broad + niche
- **Example**: #StartupGrowth #SaaS #ProductManagement #B2BMarketing

### Instagram
- **Count**: 5-10 (can go up to 30 but quality > quantity)
- **Type**: Mix of popular + niche
- **Placement**: First comment or end of caption
- **Strategy**: 3 high-volume (>100K), 4 medium (10-100K), 3 niche (<10K)
- **Example**:
  - High: #Startup #Entrepreneur #SmallBusiness
  - Medium: #StartupLife #SaaSTips #ProductivityHacks
  - Niche: #StartupFounder #B2BSaaS #MarketingAutomation

### Facebook
- **Count**: 2-3
- **Type**: Community-focused
- **Placement**: End of post
- **Example**: #StartupCommunity #Entrepreneurship

### TikTok
- **Count**: 3-5
- **Type**: Trending + niche
- **Placement**: Caption
- **Mix**: Trending sounds + content hashtags
- **Example**: #StartupTok #ProductivityTok #EntrepreneurLife #LifeHack

## Research Strategy
1. Check competitors' top-performing posts
2. Use platform search to find hashtag volume
3. Mix sizes (large, medium, niche)
4. Update monthly (trends change)
5. Track performance per hashtag
```

### 3. Platform-Formats Skill

`.claude/skills/platform-formats.md` :

```markdown
# Platform Formats Skill

Proven content formats per platform.

## High-Performing Formats

### Twitter
1. **Threads** (5-10 tweets)
   - Engagement: Very high
   - Best for: Step-by-step, stories, insights

2. **Data tweets**
   - Engagement: High
   - Format: "We analyzed X and found Y"

3. **Polls**
   - Engagement: High (easy interaction)
   - Best for: Quick feedback, fun questions

### LinkedIn
1. **Personal story posts**
   - Engagement: Very high
   - Structure: Challenge → Solution → Lesson

2. **Document carousels**
   - Engagement: High (10x organic reach boost)
   - 10 slides, educational

3. **Video posts**
   - Engagement: High
   - Native video > links

### Instagram
1. **Carousel posts**
   - Engagement: Highest on Instagram
   - 10 slides of tips, before/after, etc.

2. **Reels**
   - Reach: Highest (algorithm favors)
   - 30-60 sec, hook in first 3 sec

3. **Story series**
   - Engagement: Medium
   - Use polls, questions, quizzes

### Facebook
1. **Question posts**
   - Engagement: High (discussion)
   - Ask community for input

2. **Video posts**
   - Reach: High
   - Native video performs best

3. **Poll posts**
   - Engagement: Medium-high
   - Easy interaction

### TikTok
1. **"Things I wish I knew"**
   - Engagement: Very high
   - Relatable, educational

2. **Before/After**
   - Engagement: High
   - Transformation stories

3. **Trend participation**
   - Reach: Very high (if trending)
   - Duets, stitches, sounds
```

---

## 🪝 Hooks Implémentés

### 1. Content Policy Check Hook

`.claude/hooks/content-policy-check.sh` :

```bash
#!/bin/bash
# Hook: Check content against platform policies and brand guidelines

CONTENT_FILE="$1"

echo "🪝 Running Content Policy Check..."

CONTENT=$(jq -r '.content' "$CONTENT_FILE")
VALID=true

# Check for sensitive topics
SENSITIVE_TERMS=("politics" "religion" "controversial")
for TERM in "${SENSITIVE_TERMS[@]}"; do
  if echo "$CONTENT" | grep -qi "$TERM"; then
    echo "⚠️  Sensitive topic detected: $TERM. Human review recommended."
    VALID=false
  fi
done

# Check for excessive caps (looks spammy)
CAPS_COUNT=$(echo "$CONTENT" | grep -o '[A-Z]' | wc -l)
TOTAL_CHARS=$(echo "$CONTENT" | wc -c)
CAPS_RATIO=$(echo "scale=2; $CAPS_COUNT / $TOTAL_CHARS" | bc)

if (( $(echo "$CAPS_RATIO > 0.3" | bc -l) )); then
  echo "⚠️  Too many capital letters ($CAPS_RATIO ratio). Looks spammy."
  VALID=false
fi

# Check for promotional language (balance value vs promotion)
PROMO_WORDS=("buy now" "limited time" "click here" "sign up now")
PROMO_COUNT=0
for WORD in "${PROMO_WORDS[@]}"; do
  if echo "$CONTENT" | grep -qi "$WORD"; then
    ((PROMO_COUNT++))
  fi
done

if (( PROMO_COUNT > 2 )); then
  echo "⚠️  Too promotional ($PROMO_COUNT promotional phrases). Follow 80/20 rule (80% value)."
  VALID=false
fi

# Check for broken links (basic check)
if echo "$CONTENT" | grep -qE 'http[s]?://[^\s]+'; then
  LINKS=$(echo "$CONTENT" | grep -oE 'http[s]?://[^\s]+')
  for LINK in $LINKS; do
    HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" "$LINK")
    if [[ "$HTTP_CODE" != "200" ]]; then
      echo "⚠️  Broken link detected: $LINK (HTTP $HTTP_CODE)"
      VALID=false
    fi
  done
fi

if [[ "$VALID" == true ]]; then
  echo "✅ Content policy check passed!"
  exit 0
else
  echo "❌ Content policy check failed. Review and adjust."
  exit 1
fi
```

### 2. Visual Validation Hook

`.claude/hooks/visual-validation.sh` :

```bash
#!/bin/bash
# Hook: Validate visual assets quality and specifications

VISUALS_FILE="$1"

echo "🪝 Running Visual Validation..."

VALID=true

# Parse visuals JSON
VISUALS=$(jq -c '.visuals[]' "$VISUALS_FILE")

while IFS= read -r VISUAL; do
  PLATFORM=$(echo "$VISUAL" | jq -r '.platform')
  IMAGE_URL=$(echo "$VISUAL" | jq -r '.image_url')
  EXPECTED_DIMS=$(echo "$VISUAL" | jq -r '.dimensions')

  # Download image temporarily
  TEMP_FILE="/tmp/visual_check_$(uuidgen).jpg"
  curl -s -o "$TEMP_FILE" "$IMAGE_URL"

  # Check file size (<1MB for social media)
  FILE_SIZE=$(wc -c < "$TEMP_FILE")
  if (( FILE_SIZE > 1048576 )); then
    echo "⚠️  Image too large for $PLATFORM: $((FILE_SIZE / 1024))KB (max 1MB)"
    VALID=false
  fi

  # Check dimensions (requires ImageMagick: brew install imagemagick)
  if command -v identify &> /dev/null; then
    ACTUAL_DIMS=$(identify -format "%wx%h" "$TEMP_FILE")
    if [[ "$ACTUAL_DIMS" != "$EXPECTED_DIMS" ]]; then
      echo "⚠️  Incorrect dimensions for $PLATFORM: $ACTUAL_DIMS (expected: $EXPECTED_DIMS)"
      VALID=false
    fi
  fi

  # Check if image is corrupted
  if ! file "$TEMP_FILE" | grep -q "image"; then
    echo "❌ Corrupted image file for $PLATFORM"
    VALID=false
  fi

  # Cleanup
  rm "$TEMP_FILE"

done <<< "$VISUALS"

# Check for alt text (accessibility)
ALT_TEXTS=$(jq -r '.visuals[].alt_text' "$VISUALS_FILE")
if echo "$ALT_TEXTS" | grep -q "null"; then
  echo "⚠️  Missing alt text on some images. Add for accessibility."
  VALID=false
fi

if [[ "$VALID" == true ]]; then
  echo "✅ Visual validation passed!"
  exit 0
else
  echo "❌ Visual validation failed. Fix issues."
  exit 1
fi
```

---

## 🔌 MCP Servers Utilisés

### 1. Social Media APIs MCP

```json
{
  "mcpServers": {
    "social-apis": {
      "command": "npx",
      "args": ["-y", "@social/mcp-unified"],
      "env": {
        "TWITTER_API_KEY": "from-1password",
        "LINKEDIN_API_KEY": "from-1password",
        "FACEBOOK_API_KEY": "from-1password",
        "INSTAGRAM_API_KEY": "from-1password"
      }
    }
  }
}
```

### 2. Image Generation MCP

```json
{
  "mcpServers": {
    "dalle": {
      "command": "npx",
      "args": ["-y", "@openai/mcp-dalle"],
      "env": {
        "OPENAI_API_KEY": "from-1password"
      }
    }
  }
}
```

### 3. Analytics MCP

```json
{
  "mcpServers": {
    "social-analytics": {
      "command": "npx",
      "args": ["-y", "@analytics/mcp-social"],
      "env": {
        "ANALYTICS_API_KEY": "from-1password"
      }
    }
  }
}
```

---

## 📊 Benchmarks & ROI

### Avant Claude Code (Manuel)

```
Création manuelle par plateforme:
  ├─ Twitter (3 posts): 45min
  ├─ LinkedIn (2 posts): 1h
  ├─ Instagram (2 posts + stories): 1.5h
  ├─ Facebook (2 posts): 45min
  ├─ TikTok (2 scripts): 1h
  └─ Création visuels: 2h

Total par jour: 6.75 heures

Par mois (30 jours): 202 heures
Coût (social media manager @ $25/h): $5,050/mois
```

### Avec Claude Code (Automatisé)

```
Ideation & Research:       10 minutes
Multi-Platform Generation: 20 minutes (6 agents en parallèle)
Visual Assets:             15 minutes
Scheduling & Publishing:   10 minutes

─────────────────────────────────
TOTAL par jour:            55 minutes
Par mois (30 jours):       27.5 heures
Coût API:                  ~$200/mois
```

### ROI Détaillé

```
┌────────────────────────────────────────────────┐
│  Métrique           Manuel      Automatisé     │
├────────────────────────────────────────────────┤
│  Temps/jour         6.75h       55min          │
│  Temps/mois         202h        27.5h          │
│  Coût/mois          $5,050      $200           │
│  Posts/mois         60-90       300+           │
│  Cohérence          Variable    Constante      │
│  Scheduling         Manual      Optimisé       │
│  Visuals            Stock       Custom Brand   │
│  Engagement         Variable    Data-driven    │
└────────────────────────────────────────────────┘

Gains:
✅ 86% réduction temps (202h → 27.5h)
✅ 96% réduction coûts ($5,050 → $200)
✅ 3-5x augmentation production (60-90 → 300+ posts)
✅ Cohérence parfaite entre plateformes
✅ Scheduling optimisé par data
✅ Visuals brand-consistent automatiques
```

---

## 🚀 Quick Start

```bash
# Installation complète
mkdir -p .claude/commands/social
mkdir -p .claude/skills
mkdir -p .claude/hooks

# [Créer tous les fichiers listés ci-dessus]

# Configuration MCP
# [Ajouter social-apis, dalle, analytics dans config.json]

# Test du workflow
claude
/social-generate "How we scaled to 100K users in 6 months" 3 false all

# Résultat attendu:
# - 15 posts créés (3 per platform × 5 platforms)
# - 15 visuels custom générés
# - Schedule optimisé sur 7 jours
# Total: 55 minutes (vs 6.75 heures manual)
```

---

## 🎓 Points Clés

### Architecture
✅ 6 agents en parallèle (1 per platform + visuals)
✅ Plateforme-specific optimization (format, ton, hashtags)
✅ Hiérarchie plate (Command → Subcommand → Agent)

### Content Quality
✅ Native feel per platform (pas copy-paste)
✅ Format optimization (threads, carousels, stories, scripts)
✅ Brand voice consistent mais adapté
✅ Visual assets custom et brand-aligned

### Automation
✅ 86% réduction temps (6.75h → 55min par jour)
✅ 96% réduction coûts ($5,050 → $200/mois)
✅ Scheduling data-driven (optimal times)
✅ Analytics tracking automatique

---

## 📚 Ressources

### Documentation
- 📄 [Twitter Best Practices](https://business.twitter.com/en/blog/best-practices.html)
- 📄 [LinkedIn Marketing Guide](https://business.linkedin.com/marketing-solutions/blog)
- 📄 [Instagram for Business](https://business.instagram.com/)

### Workflows Associés
- 🔗 [Blog Automation](./blog-automation-startup.md) - Source content
- 🔗 [Content Repurposing](./content-repurposing-startup.md) - Reuse content

---

**Prochaine étape** : [Community Management Automation →](./community-management-startup.md)
