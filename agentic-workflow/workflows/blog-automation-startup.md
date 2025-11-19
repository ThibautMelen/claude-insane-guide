# 📝 Blog Automation Pipeline pour Startups

> **Pattern**: Sequential + Parallel Hybrid
> **Complexité**: Moyenne
> **Cas d'usage**: Automatisation complète de la création et publication de contenu blog
> **ROI**: 85% réduction temps, 92% réduction coûts

## 🎯 Contexte Startup

Les startups ont besoin de **contenu régulier** pour le SEO et l'acquisition clients, mais manquent de ressources pour une équipe éditoriale complète.

**Problème** :
- Écriture manuelle → 8-12h par article
- SEO optimization → 2-3h supplémentaires
- Révisions multiples → 4-6h
- Publication et promotion → 2h
- **Total** : 16-23h par article

**Solution Claude Code** :
- Automatisation complète de la chaîne éditoriale
- Parallélisation des tâches (recherche, écriture, SEO)
- Hooks de qualité à chaque étape
- Memory pour cohérence de la marque

---

## 📊 Architecture du Workflow

```
╔════════════════════════════════════════════════════════════╗
║           COMMAND: /blog-automation                        ║
║  (Orchestrateur principal - 1 article de A à Z)           ║
╚════════════════════════════════════════════════════════════╝
                           │
           ┌───────────────┼───────────────┐
           ▼               ▼               ▼
    ┌──────────┐    ┌──────────┐    ┌──────────┐
    │ SUB: Plan│    │SUB: Write│    │SUB: Promo│
    └──────────┘    └──────────┘    └──────────┘
           │               │               │
    ┌──────┴──────┐ ┌─────┴─────┐  ┌─────┴─────┐
    ▼      ▼      ▼ ▼     ▼     ▼  ▼      ▼     ▼
 [AG1] [AG2] [AG3][AG4] [AG5] [AG6][AG7] [AG8] [AG9]

🪝 HOOKS: Validation, SEO-Check, Human-Approval, Format
```

### Niveaux de la Hiérarchie

```
Niveau 1: COMMAND (/blog-automation)
   │
   ├─ Niveau 2: SUBCOMMAND (Planning)
   │   ├─ Niveau 3: AGENT (Keyword-Researcher)
   │   ├─ Niveau 3: AGENT (Competitor-Analyzer)
   │   └─ Niveau 3: AGENT (Outline-Generator)
   │
   ├─ HOOK: Content-Brief-Validation
   │
   ├─ Niveau 2: SUBCOMMAND (Writing)
   │   ├─ Niveau 3: AGENT (Draft-Writer)
   │   ├─ Niveau 3: AGENT (SEO-Optimizer)
   │   └─ Niveau 3: AGENT (Visual-Curator)
   │
   ├─ HOOK: Quality-Gate
   ├─ HOOK: Human-in-Loop (Optional Review)
   │
   ├─ Niveau 2: SUBCOMMAND (Publishing)
   │   ├─ Niveau 3: AGENT (CMS-Publisher)
   │   └─ Niveau 3: AGENT (Analytics-Tracker)
   │
   └─ Niveau 2: SUBCOMMAND (Promotion)
       ├─ Niveau 3: AGENT (Social-Media-Creator)
       ├─ Niveau 3: AGENT (Newsletter-Builder)
       └─ Niveau 3: AGENT (SEO-Submitter)
```

**Règle Anthropic respectée** : Hiérarchie plate à 3 niveaux max (Command → Subcommand → Agent), jamais agent → agent.

---

## 🔧 Implémentation Complète

### 1. Command Principal

`.claude/commands/blog-automation.md` :

```yaml
---
name: blog-automation
description: Pipeline complet de création et publication d'article de blog optimisé SEO
args:
  topic: Topic or keyword for the blog post
  target_length: Target word count (default 1500)
  publish: Auto-publish or save as draft (default false)
---

# Blog Automation Pipeline

You are orchestrating a complete blog post creation workflow for a startup.

## Input
- Topic: {{topic}}
- Target length: {{target_length}} words
- Auto-publish: {{publish}}

## Workflow Steps

### PHASE 1: Planning & Research
Execute subcommand: `/blog-plan {{topic}}`

**This subcommand coordinates 3 agents in PARALLEL**:
1. Keyword-Researcher agent (finds primary + secondary keywords)
2. Competitor-Analyzer agent (analyzes top 10 SERP results)
3. Outline-Generator agent (creates structured outline)

Wait for all 3 agents to complete, then trigger HOOK.

**HOOK: content-brief-validation**
- Verify keyword difficulty < 70
- Ensure outline has 5-8 H2 sections
- Check competitor gaps identified
- If validation fails → ask user to adjust topic

### PHASE 2: Content Creation
Execute subcommand: `/blog-write {{topic}} {{outline}}`

**This subcommand coordinates 3 agents in PARALLEL**:
1. Draft-Writer agent (writes full article using Brand-Voice skill)
2. SEO-Optimizer agent (optimizes meta, headers, internal links)
3. Visual-Curator agent (finds/generates images, creates alt text)

Wait for all 3 agents to complete, then trigger HOOK.

**HOOK: quality-gate**
- Check word count matches target ±10%
- Verify keyword density 1-2%
- Ensure readability score > 60 (Flesch)
- Check all H2/H3 have content
- If quality fails → regenerate problematic sections

**HOOK: human-in-loop** (Optional)
- If {{publish}} = false → present draft for review
- User can edit, approve, or request revisions
- If revisions needed → loop back to specific agent

### PHASE 3: Publishing
Execute subcommand: `/blog-publish {{article}} {{metadata}}`

**This subcommand coordinates 2 agents in SEQUENCE**:
1. CMS-Publisher agent (pushes to WordPress/Ghost via MCP)
2. Analytics-Tracker agent (sets up tracking, creates dashboard)

**HOOK: format-normalization**
- Ensure HTML is clean
- Verify images are optimized (<200KB)
- Check mobile responsiveness
- Validate all links work

### PHASE 4: Promotion
Execute subcommand: `/blog-promote {{article_url}} {{title}}`

**This subcommand coordinates 3 agents in PARALLEL**:
1. Social-Media-Creator agent (creates 5 posts: Twitter, LinkedIn, Facebook)
2. Newsletter-Builder agent (adds to next newsletter queue)
3. SEO-Submitter agent (submits to Google Search Console, pings backlinks)

## Output
Return:
- ✅ Published URL
- 📊 SEO score breakdown
- 📱 Social media posts generated
- 📈 Analytics dashboard link
- ⏱️ Total time taken

## Success Criteria
- Article published successfully
- SEO score > 80/100
- All promotion channels activated
- Total time < 2 hours (vs 16-23h manual)
```

---

### 2. Subcommands

#### `/blog-plan` - Planning Phase

`.claude/commands/blog-plan.md` :

```yaml
---
name: blog-plan
description: Research and planning phase for blog post
args:
  topic: Main topic or keyword
---

# Blog Planning Subcommand

Coordinate 3 specialized agents in PARALLEL to create comprehensive content brief.

## Agent 1: Keyword Research
Launch agent with prompt:
```
You are a Keyword-Researcher agent.

Task: Find optimal keywords for topic "{{topic}}"

Use MCP tools:
- mcp__ahrefs__keywords-explorer-overview (keyword metrics)
- mcp__ahrefs__keywords-explorer-matching-terms (related keywords)

Output:
- Primary keyword (volume, difficulty, CPC)
- 5-10 secondary keywords
- 10-15 long-tail variations
- Search intent analysis
- SERP features present

Constraints:
- Primary keyword difficulty < 70
- Minimum volume 500/month
- Prefer informational intent for blog
```

## Agent 2: Competitor Analysis
Launch agent with prompt:
```
You are a Competitor-Analyzer agent.

Task: Analyze top 10 SERP results for "{{topic}}"

Use MCP tools:
- mcp__firecrawl__firecrawl_search (find top results)
- mcp__firecrawl__firecrawl_scrape (analyze each article)

Output:
- Average word count of top 10
- Common H2/H3 structure patterns
- Topics covered by ALL top results (must-have)
- Content gaps (topics missing - opportunity!)
- Unique angles found
- Backlink profile summary

Constraints:
- Analyze only top 10 organic results
- Exclude ads and featured snippets
- Focus on content structure, not copying
```

## Agent 3: Outline Generation
Launch agent with prompt:
```
You are an Outline-Generator agent.

Task: Create structured outline for "{{topic}}"

Use Skills:
- Brand-Voice skill (tone, style, audience)
- SEO-Best-Practices skill (structure rules)

Input from other agents:
- Keywords from Keyword-Researcher
- Gaps from Competitor-Analyzer

Output:
- Title (with primary keyword)
- Meta description (155 chars)
- Introduction hook
- 5-8 H2 sections (with keywords)
- 2-4 H3 per H2 section
- Internal linking opportunities
- CTA placement suggestions

Constraints:
- Follow inverted pyramid structure
- Include keyword in first 100 words
- Each H2 should target secondary keyword
- Suggest 2-3 internal links per section
```

## Wait for All Agents
Use `Task` tool to launch all 3 agents concurrently.

Once all complete, consolidate into Content Brief document.

## Output Format
Return structured JSON:
```json
{
  "primary_keyword": "...",
  "secondary_keywords": ["...", "..."],
  "target_word_count": 1500,
  "outline": {
    "title": "...",
    "meta_description": "...",
    "sections": [
      {
        "h2": "...",
        "h3": ["...", "..."],
        "keywords": ["..."],
        "internal_links": ["..."]
      }
    ]
  },
  "competitor_insights": {
    "avg_word_count": 2000,
    "content_gaps": ["...", "..."]
  }
}
```
```

---

#### `/blog-write` - Writing Phase

`.claude/commands/blog-write.md` :

```yaml
---
name: blog-write
description: Content creation phase with SEO optimization
args:
  topic: Main topic
  outline: JSON outline from planning phase
---

# Blog Writing Subcommand

Coordinate 3 specialized agents in PARALLEL to create complete article.

## Agent 1: Draft Writer
Launch agent with prompt:
```
You are a Draft-Writer agent.

Task: Write complete blog post for "{{topic}}"

Use Skills:
- Brand-Voice skill (company tone, style, audience preferences)
- Content-Templates skill (proven blog structures)

Use Memory:
- Read .claude/CLAUDE.md for brand guidelines
- Check previous blog posts for consistency

Input:
{{outline}}

Requirements:
- Follow outline structure EXACTLY
- Write in engaging, conversational tone
- Include examples and case studies
- Add statistics with citations
- Use transition phrases between sections
- Include "you" language (direct address)
- Break up text with bullet points and short paragraphs
- End with strong CTA

Constraints:
- Target word count: {{target_length}} words (±10%)
- Reading level: Grade 8-10 (Flesch-Kincaid)
- No plagiarism - original content only
- Cite all statistics with [source] links
```

## Agent 2: SEO Optimizer
Launch agent with prompt:
```
You are an SEO-Optimizer agent.

Task: Optimize article for search engines

Use Skills:
- SEO-Best-Practices skill (on-page SEO rules)

Input:
- Draft from Draft-Writer agent
- Keywords from planning phase

Optimize:
1. **Keyword placement**:
   - Primary keyword in title, first 100 words, conclusion
   - Secondary keywords in H2 headers
   - Long-tail keywords naturally throughout
   - Keyword density 1-2% (not stuffing!)

2. **Meta elements**:
   - Title tag (50-60 chars, includes keyword)
   - Meta description (150-155 chars, compelling CTA)
   - URL slug (short, keyword-rich, hyphens)

3. **Internal linking**:
   - 3-5 internal links to related posts
   - Descriptive anchor text (not "click here")
   - Link to cornerstone content

4. **Header optimization**:
   - One H1 (title only)
   - Logical H2/H3 hierarchy
   - Keywords in headers without forcing

5. **Readability**:
   - Short paragraphs (2-3 sentences)
   - Transition words
   - Active voice > passive voice
   - Varied sentence length

Output:
- Optimized article HTML
- SEO score breakdown
- Improvement suggestions
```

## Agent 3: Visual Curator
Launch agent with prompt:
```
You are a Visual-Curator agent.

Task: Find/generate images and visual elements

Use MCP tools:
- mcp__firecrawl__firecrawl_search (find free stock images)
- Image generation API (if available)

Requirements:
1. **Featured image**:
   - Relevant to topic
   - High quality (min 1200x630px)
   - Optimized file size (<200KB)
   - Alt text with keyword

2. **In-article images**:
   - 1 image per 300-500 words
   - Breaks up text walls
   - Illustrates key concepts
   - All with descriptive alt text

3. **Infographics** (if applicable):
   - Visualize statistics
   - Process diagrams
   - Comparison tables

4. **Image optimization**:
   - Compress all images
   - Lazy loading attributes
   - Responsive sizing
   - WebP format preferred

Output:
- Image URLs with alt text
- Image placement suggestions (after which H2)
- Optimized image files
```

## Wait for All Agents
Launch all 3 agents in parallel using `Task` tool.

Once complete, merge outputs into final article.

## Output Format
Return complete article package:
```json
{
  "article": {
    "html": "...",
    "markdown": "...",
    "word_count": 1523
  },
  "metadata": {
    "title": "...",
    "meta_description": "...",
    "url_slug": "...",
    "primary_keyword": "...",
    "featured_image": "..."
  },
  "seo_score": {
    "overall": 87,
    "keyword_optimization": 90,
    "readability": 85,
    "internal_linking": 80
  },
  "images": [
    {
      "url": "...",
      "alt": "...",
      "placement": "after_h2_1"
    }
  ]
}
```
```

---

#### `/blog-publish` - Publishing Phase

`.claude/commands/blog-publish.md` :

```yaml
---
name: blog-publish
description: Publish article to CMS and setup tracking
args:
  article: Complete article JSON
  auto_publish: true/false
---

# Blog Publishing Subcommand

Coordinate 2 agents in SEQUENCE to publish and track article.

## Agent 1: CMS Publisher
Launch agent with prompt:
```
You are a CMS-Publisher agent.

Task: Publish article to WordPress/Ghost CMS

Use MCP tools:
- WordPress MCP (if available)
- Or use REST API via Bash

Input:
{{article}}

Steps:
1. **Upload images**:
   - Upload all images to media library
   - Get final URLs
   - Update image references in content

2. **Create post**:
   - Set title, content, meta description
   - Set featured image
   - Add categories and tags
   - Set URL slug

3. **Configure settings**:
   - Set publish date (now or scheduled)
   - Enable comments (if applicable)
   - Set author

4. **Publish or save as draft**:
   - If {{auto_publish}} = true → publish immediately
   - Else → save as draft for review

Output:
- Published URL (or draft URL)
- Post ID
- Publish timestamp
- Status (published/draft)
```

## Agent 2: Analytics Tracker
Launch agent with prompt:
```
You are an Analytics-Tracker agent.

Task: Setup tracking and monitoring for published article

Use MCP tools:
- Google Analytics API (if available)
- Google Search Console API

Steps:
1. **Create UTM links**:
   - Generate tracking URLs for social sharing
   - Different UTM per channel (Twitter, LinkedIn, etc.)

2. **Submit to Search Console**:
   - Request indexing for new URL
   - Verify sitemap includes new post

3. **Create dashboard**:
   - Setup Google Analytics goal for article
   - Create custom dashboard for article performance
   - Set alerts for traffic milestones

4. **Track baseline**:
   - Record initial metrics
   - Set benchmarks for success

Output:
- UTM tracking links
- Search Console submission confirmation
- Dashboard URL
- Baseline metrics
```

## Wait for Sequential Completion
Agent 1 (CMS-Publisher) MUST complete before Agent 2 (Analytics-Tracker) starts.

## Output Format
```json
{
  "published_url": "https://...",
  "post_id": 12345,
  "status": "published",
  "analytics": {
    "utm_links": {
      "twitter": "...",
      "linkedin": "...",
      "newsletter": "..."
    },
    "dashboard_url": "...",
    "search_console_submitted": true
  }
}
```
```

---

#### `/blog-promote` - Promotion Phase

`.claude/commands/blog-promote.md` :

```yaml
---
name: blog-promote
description: Create and distribute promotional content
args:
  article_url: Published article URL
  title: Article title
  excerpt: Short excerpt
---

# Blog Promotion Subcommand

Coordinate 3 agents in PARALLEL to maximize article reach.

## Agent 1: Social Media Creator
Launch agent with prompt:
```
You are a Social-Media-Creator agent.

Task: Create optimized posts for multiple platforms

Use Skills:
- Brand-Voice skill (tone per platform)
- Social-Templates skill (proven formats)

Input:
- Article URL: {{article_url}}
- Title: {{title}}
- Excerpt: {{excerpt}}

Create posts for:

1. **Twitter/X** (5 variations):
   - Thread format (5-7 tweets)
   - Quote tweet with key insight
   - Poll related to article topic
   - Stat-focused tweet
   - Question to drive engagement

2. **LinkedIn** (2 variations):
   - Professional narrative post (1500 chars)
   - Carousel post (10 slides summary)

3. **Facebook**:
   - Community-focused post
   - Conversational tone
   - Question at end

4. **Instagram**:
   - Caption with hashtags
   - Story slide suggestions (5 slides)

Requirements:
- Include link in every post
- Use relevant hashtags (3-5 per platform)
- Add emoji where appropriate
- Include CTA (comment, share, click)
- Vary posting times (suggest schedule)

Output:
- All posts in platform-ready format
- Hashtag research
- Optimal posting times
- Image suggestions per platform
```

## Agent 2: Newsletter Builder
Launch agent with prompt:
```
You are a Newsletter-Builder agent.

Task: Add article to newsletter queue with engaging format

Use Skills:
- Email-Templates skill (proven layouts)
- Brand-Voice skill (newsletter tone)

Input:
- Article URL: {{article_url}}
- Title: {{title}}
- Excerpt: {{excerpt}}

Create:
1. **Email subject lines** (5 variations):
   - Curiosity-driven
   - Benefit-focused
   - Question-based
   - Stat-focused
   - Urgency/FOMO

2. **Email preview text** (3 variations)

3. **Email body section**:
   - Attention-grabbing opening
   - Article summary (3-4 sentences)
   - Visual element (featured image)
   - Clear CTA button
   - P.S. with additional hook

4. **Segmentation suggestions**:
   - Which subscriber segments should receive?
   - Personalization tokens to use

Output:
- Complete email HTML
- Subject line recommendations
- Segmentation strategy
- Send time optimization
```

## Agent 3: SEO Submitter
Launch agent with prompt:
```
You are an SEO-Submitter agent.

Task: Distribute article to relevant channels for SEO boost

Use MCP tools:
- Google Search Console API
- Bing Webmaster Tools API (if available)

Steps:
1. **Search engine submission**:
   - Submit URL to Google Search Console
   - Submit to Bing Webmaster Tools
   - Request priority indexing

2. **Ping relevant sites**:
   - Ping aggregators (if applicable)
   - Submit to niche directories
   - Notify linked sites (if cited sources)

3. **Create shareable assets**:
   - Featured image with quote overlay
   - Key stat graphics
   - Pull quotes for sharing

4. **Monitor initial indexing**:
   - Check if Google cached
   - Verify in search results
   - Monitor for featured snippet opportunities

Output:
- Submission confirmations
- Indexing status
- Shareable assets URLs
- Monitoring checklist
```

## Wait for All Agents
Launch all 3 agents in parallel using `Task` tool.

## Output Format
```json
{
  "social_media": {
    "twitter": ["...", "...", "..."],
    "linkedin": ["...", "..."],
    "facebook": "...",
    "instagram": {...},
    "schedule": [...]
  },
  "newsletter": {
    "subject_lines": ["...", "..."],
    "html": "...",
    "segments": ["..."]
  },
  "seo": {
    "submitted_to": ["Google", "Bing"],
    "indexing_status": "pending",
    "shareable_assets": ["...", "..."]
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

Shared knowledge about company's tone, style, and audience.

## Tone
- Friendly and approachable
- Professional but not corporate
- Educational without being condescending
- Enthusiastic about helping startups

## Style Guidelines
- Use "you" and "your" (direct address)
- Short paragraphs (2-3 sentences max)
- Bullet points for scannability
- Examples and case studies
- Conversational language
- Active voice > passive voice

## Audience
- Startup founders (25-40 years old)
- Tech-savvy but not developers
- Time-constrained
- ROI-focused
- Value practical advice over theory

## Vocabulary
- ✅ Use: "simple", "practical", "actionable", "ROI", "efficiency"
- ❌ Avoid: "synergy", "leverage", "paradigm shift", "disruptive" (overused)

## Content Principles
1. Lead with value (what's in it for them)
2. Use data and examples
3. Keep it actionable
4. End with clear next steps
```

### 2. SEO-Best-Practices Skill

`.claude/skills/seo-best-practices.md` :

```markdown
# SEO Best Practices Skill

Proven on-page SEO techniques for 2025.

## Keyword Optimization
- Primary keyword density: 1-2%
- Include keyword in:
  - Title (ideally at start)
  - First 100 words
  - At least one H2
  - Meta description
  - URL slug
  - Image alt text

## Content Structure
- One H1 tag (title only)
- 5-8 H2 sections
- 2-4 H3 per H2
- Logical hierarchy
- Short paragraphs (<150 words)

## Readability
- Target: Grade 8-10 (Flesch-Kincaid)
- Short sentences (avg 15-20 words)
- Active voice preference
- Transition words (however, therefore, additionally)
- Varied sentence length

## Technical SEO
- Internal links: 3-5 per post
- External links: 2-3 authoritative sources
- Image optimization: <200KB each
- Alt text on all images
- Mobile-responsive format
- Clean HTML structure

## User Engagement
- Hook in first 100 words
- Clear value proposition
- Scannable content (bullets, numbers, bolding)
- Visual breaks every 300-500 words
- Strong CTA at end
```

### 3. Content-Templates Skill

`.claude/skills/content-templates.md` :

```markdown
# Content Templates Skill

Proven blog post structures with high engagement.

## Template 1: How-To Guide
```
Title: How to [Achieve Outcome] in [Timeframe]

Structure:
1. Introduction (pain point + promise)
2. Why this matters (context)
3. Step-by-step process (5-8 steps)
4. Common mistakes to avoid
5. Real example/case study
6. Conclusion + CTA
```

## Template 2: Listicle
```
Title: [Number] [Topic] That [Benefit]

Structure:
1. Introduction (why this list matters)
2. Item #1 (with explanation and example)
3. Item #2...
[Repeat]
N. Conclusion (recap + CTA)
```

## Template 3: Problem-Solution
```
Title: [Problem]? Here's How to [Solution]

Structure:
1. Introduction (describe problem vividly)
2. Why traditional solutions fail
3. Our solution approach
4. How it works (step-by-step)
5. Results and proof
6. Getting started (CTA)
```

## Template 4: Comparison
```
Title: [Option A] vs [Option B]: Which is Better for [Use Case]?

Structure:
1. Introduction (decision dilemma)
2. Quick comparison table
3. Option A deep dive (pros, cons, best for)
4. Option B deep dive (pros, cons, best for)
5. Decision framework
6. Recommendation + CTA
```
```

---

## 🪝 Hooks Implémentés

### 1. Content Brief Validation Hook

`.claude/hooks/content-brief-validation.sh` :

```bash
#!/bin/bash
# Hook: Validate content brief quality before writing

BRIEF_FILE="$1"

echo "🪝 Running Content Brief Validation..."

# Check if brief file exists
if [[ ! -f "$BRIEF_FILE" ]]; then
  echo "❌ Brief file not found: $BRIEF_FILE"
  exit 1
fi

# Parse JSON and validate
KEYWORD_DIFFICULTY=$(jq -r '.primary_keyword_difficulty' "$BRIEF_FILE")
SECTIONS_COUNT=$(jq -r '.outline.sections | length' "$BRIEF_FILE")
GAPS_COUNT=$(jq -r '.competitor_insights.content_gaps | length' "$BRIEF_FILE")

# Validation rules
VALID=true

if (( $(echo "$KEYWORD_DIFFICULTY > 70" | bc -l) )); then
  echo "⚠️  Warning: Keyword difficulty too high ($KEYWORD_DIFFICULTY)"
  VALID=false
fi

if (( SECTIONS_COUNT < 5 || SECTIONS_COUNT > 8 )); then
  echo "⚠️  Warning: Outline should have 5-8 sections (found: $SECTIONS_COUNT)"
  VALID=false
fi

if (( GAPS_COUNT == 0 )); then
  echo "⚠️  Warning: No content gaps identified from competitors"
  VALID=false
fi

if [[ "$VALID" == true ]]; then
  echo "✅ Content brief validation passed!"
  exit 0
else
  echo "❌ Content brief validation failed. Review and adjust."
  exit 1
fi
```

### 2. Quality Gate Hook

`.claude/hooks/quality-gate.sh` :

```bash
#!/bin/bash
# Hook: Validate article quality before publishing

ARTICLE_FILE="$1"
TARGET_LENGTH="$2"

echo "🪝 Running Quality Gate..."

# Extract metrics
WORD_COUNT=$(jq -r '.article.word_count' "$ARTICLE_FILE")
SEO_SCORE=$(jq -r '.seo_score.overall' "$ARTICLE_FILE")
READABILITY=$(jq -r '.seo_score.readability' "$ARTICLE_FILE")
IMAGES_COUNT=$(jq -r '.images | length' "$ARTICLE_FILE")

# Calculate word count tolerance (±10%)
MIN_WORDS=$(echo "$TARGET_LENGTH * 0.9" | bc | cut -d'.' -f1)
MAX_WORDS=$(echo "$TARGET_LENGTH * 1.1" | bc | cut -d'.' -f1)

VALID=true

# Validation rules
if (( WORD_COUNT < MIN_WORDS || WORD_COUNT > MAX_WORDS )); then
  echo "⚠️  Word count out of range: $WORD_COUNT (target: $MIN_WORDS-$MAX_WORDS)"
  VALID=false
fi

if (( SEO_SCORE < 80 )); then
  echo "⚠️  SEO score too low: $SEO_SCORE (minimum: 80)"
  VALID=false
fi

if (( READABILITY < 60 )); then
  echo "⚠️  Readability score too low: $READABILITY (minimum: 60)"
  VALID=false
fi

if (( IMAGES_COUNT < 3 )); then
  echo "⚠️  Not enough images: $IMAGES_COUNT (minimum: 3)"
  VALID=false
fi

if [[ "$VALID" == true ]]; then
  echo "✅ Quality gate passed!"
  exit 0
else
  echo "❌ Quality gate failed. Improve article before publishing."
  exit 1
fi
```

---

## 🔌 MCP Servers Utilisés

### 1. Ahrefs MCP (SEO Data)

```json
{
  "mcpServers": {
    "ahrefs": {
      "command": "npx",
      "args": ["-y", "@ahrefs/mcp-server"],
      "env": {
        "AHREFS_API_KEY": "from-1password-or-env"
      }
    }
  }
}
```

**Usage** :
- `mcp__ahrefs__keywords-explorer-overview` : Keyword metrics
- `mcp__ahrefs__keywords-explorer-matching-terms` : Related keywords
- `mcp__ahrefs__site-explorer-organic-keywords` : Competitor analysis

### 2. Firecrawl MCP (Web Scraping)

```json
{
  "mcpServers": {
    "firecrawl": {
      "command": "npx",
      "args": ["-y", "@firecrawl/mcp"],
      "env": {
        "FIRECRAWL_API_KEY": "from-environment"
      }
    }
  }
}
```

**Usage** :
- `mcp__firecrawl__firecrawl_search` : Find top SERP results
- `mcp__firecrawl__firecrawl_scrape` : Analyze competitor content
- `mcp__firecrawl__firecrawl_map` : Map website structure

### 3. WordPress MCP (CMS Integration)

```json
{
  "mcpServers": {
    "wordpress": {
      "command": "npx",
      "args": ["-y", "@wordpress/mcp-server"],
      "env": {
        "WP_SITE_URL": "https://your-site.com",
        "WP_API_KEY": "from-1password"
      }
    }
  }
}
```

**Usage** :
- Publish posts via REST API
- Upload media
- Manage categories and tags

---

## 🧠 Memory Configuration

`.claude/CLAUDE.md` (Project-specific) :

```markdown
# Blog Automation Memory

## Brand Voice
- Tone: Friendly, professional, educational
- Audience: Startup founders (25-40)
- Style: Short paragraphs, bullet points, conversational

## SEO Preferences
- Target keyword difficulty: <60 (medium competition)
- Preferred word count: 1500-2000 words
- Internal linking: Always link to cornerstone content
- Image style: Clean, modern, no cheesy stock photos

## Publishing Defaults
- Auto-publish: false (save as draft for review)
- Default categories: ["Startup Tips", "Growth"]
- Author: "Marketing Team"
- Comments: enabled

## Promotion Preferences
- Social media: Twitter, LinkedIn (primary), Facebook (secondary)
- Newsletter: Add to "Weekly Digest" segment
- Posting times: Twitter 9am/3pm EST, LinkedIn 8am EST

## Quality Standards
- Minimum SEO score: 85/100
- Minimum readability: 65 (Flesch)
- Minimum images: 3 per article
- Citations required for all statistics
```

---

## 📊 Benchmarks & ROI

### Avant Claude Code (Manuel)

```
Planning & Research:        4-6 heures
  ├─ Keyword research:      1-2h
  ├─ Competitor analysis:   2-3h
  └─ Outline creation:      1h

Writing & Editing:          8-12 heures
  ├─ First draft:           4-6h
  ├─ Revisions:             2-3h
  ├─ SEO optimization:      1-2h
  └─ Visual curation:       1h

Publishing:                 1-2 heures
  ├─ Formatting:            0.5h
  ├─ Image upload:          0.5h
  └─ CMS setup:             0.5h

Promotion:                  2-3 heures
  ├─ Social posts:          1h
  ├─ Newsletter:            1h
  └─ Distribution:          0.5h

─────────────────────────────────
TOTAL:                      15-23 heures
Coût ($100/h):              $1,500-2,300
```

### Avec Claude Code (Automatisé)

```
Planning & Research:        15 minutes
  └─ 3 agents en parallèle

Writing & Editing:          20 minutes
  └─ 3 agents en parallèle

Publishing:                 5 minutes
  └─ 2 agents en séquence

Promotion:                  10 minutes
  └─ 3 agents en parallèle

─────────────────────────────────
TOTAL:                      50 minutes
Coût API:                   ~$5-8
```

### ROI

```
┌─────────────────────────────────────────┐
│  Métrique          Manuel    Automatisé │
├─────────────────────────────────────────┤
│  Temps             18h       0.83h      │
│  Coût              $1,900    $7         │
│  Articles/mois     4-6       60+        │
│  Qualité SEO       Variable  Constant   │
│  Erreurs humaines  Élevé     Minimal    │
└─────────────────────────────────────────┘

Gains:
✅ 96% réduction temps (18h → 50min)
✅ 99.6% réduction coûts ($1,900 → $7)
✅ 10-15x augmentation production
✅ Qualité constante et reproductible
```

---

## 🚀 Quick Start

### Installation

```bash
# 1. Créer le command principal
cat > .claude/commands/blog-automation.md << 'EOF'
[Coller le contenu du command ci-dessus]
EOF

# 2. Créer les subcommands
mkdir -p .claude/commands/blog
cat > .claude/commands/blog/plan.md << 'EOF'
[Coller blog-plan.md]
EOF

cat > .claude/commands/blog/write.md << 'EOF'
[Coller blog-write.md]
EOF

cat > .claude/commands/blog/publish.md << 'EOF'
[Coller blog-publish.md]
EOF

cat > .claude/commands/blog/promote.md << 'EOF'
[Coller blog-promote.md]
EOF

# 3. Créer les skills
mkdir -p .claude/skills
cat > .claude/skills/brand-voice.md << 'EOF'
[Coller brand-voice.md]
EOF

cat > .claude/skills/seo-best-practices.md << 'EOF'
[Coller seo-best-practices.md]
EOF

# 4. Créer les hooks
mkdir -p .claude/hooks
cat > .claude/hooks/content-brief-validation.sh << 'EOF'
[Coller content-brief-validation.sh]
EOF
chmod +x .claude/hooks/content-brief-validation.sh

cat > .claude/hooks/quality-gate.sh << 'EOF'
[Coller quality-gate.sh]
EOF
chmod +x .claude/hooks/quality-gate.sh

# 5. Configurer MCP servers (voir section MCP ci-dessus)
# Ajouter Ahrefs, Firecrawl, WordPress dans ~/.config/claude-code/config.json

# 6. Configurer Memory
cat > .claude/CLAUDE.md << 'EOF'
[Coller configuration memory ci-dessus]
EOF
```

### Premier Test

```bash
# Lancer Claude Code
claude

# Tester le workflow
/blog-automation "How to automate marketing for startups" 1500 false

# Résultat attendu:
# - Content brief généré (15min)
# - Article complet écrit (20min)
# - Brouillon WordPress créé (5min)
# - Posts sociaux générés (10min)
# Total: ~50 minutes
```

---

## ⚠️ Anti-Patterns à Éviter

### ❌ Agent → Agent Communication

```
MAUVAIS:
Draft-Writer agent → appelle → SEO-Optimizer agent

POURQUOI: Viole la règle Anthropic "agents ne peuvent pas spawner d'autres agents"

BON:
Subcommand /blog-write → lance Draft-Writer ET SEO-Optimizer en parallèle
```

### ❌ Over-Engineering

```
MAUVAIS:
Créer 15 agents ultra-spécialisés (Title-Writer, Intro-Writer, Body-Writer...)

POURQUOI: Augmente la complexité sans valeur ajoutée

BON:
1 Draft-Writer agent qui gère toute l'écriture avec des sections claires
```

### ❌ Bloquer sur Perfection

```
MAUVAIS:
Quality gate qui rejette si SEO score < 95/100

POURQUOI: Trop strict, bloque la production, diminishing returns

BON:
Quality gate à 80/100 + option human-review pour améliorer si besoin
```

### ❌ Ignorer Human-in-Loop

```
MAUVAIS:
Auto-publish sans review pour contenu sensible

POURQUOI: Risque de publier contenu non aligné ou incorrect

BON:
Hook human-in-loop optionnel, activé par défaut, bypass possible si confiance haute
```

---

## 🎓 Points Clés

### Architecture
✅ Command orchestre, subcommands coordonnent, agents exécutent
✅ Maximum 3 niveaux de hiérarchie (Command → Subcommand → Agent)
✅ Jamais agent → agent (toujours Command fait orchestration)
✅ Parallélisation des agents indépendants (research, writing, visuals)

### Skills & Memory
✅ Skills partagent connaissances entre agents (Brand-Voice, SEO-Rules)
✅ Memory stocke préférences projet (.claude/CLAUDE.md)
✅ Évite répétition d'instructions (DRY principle)

### Hooks
✅ Validation à chaque phase (content-brief, quality, format)
✅ Fail-fast : arrêt immédiat si validation échoue
✅ Human-in-loop pour décisions critiques

### MCP
✅ Abstraction des outils externes (Ahrefs, WordPress, Analytics)
✅ Agents n'appellent JAMAIS directement APIs (passent par MCP)
✅ Centralisé dans config globale, réutilisable entre projets

### Production
✅ 96% réduction temps (18h → 50min)
✅ 99.6% réduction coûts ($1,900 → $7)
✅ Qualité constante et reproductible
✅ Scalable à 60+ articles/mois

---

## 📚 Ressources

### Documentation Officielle
- 📄 [Claude Code Commands](https://code.claude.com/docs/slash-commands)
- 📄 [Subagents Best Practices](https://code.claude.com/docs/agents)
- 📄 [MCP Protocol](https://modelcontextprotocol.io/)

### Workflows Associés
- 🔗 [Multi-language Content Generator](./multi-language-content-startup.md) - Translation workflow
- 🔗 [Social Media Post Generator](./social-media-automation-startup.md) - Distribution workflow
- 🔗 [Orchestration Principles](../orchestration-principles.md) - Architecture patterns

### Articles de Référence
- 📄 [Anthropic Orchestration Rules](../../ressources/articles/orchestration-workflows-enterprise-perplexity.md)
- 📄 [Content Workflow Best Practices 2025](https://planable.io/blog/content-workflow/)

---

**Prochaine étape** : [Multi-language Content Generator →](./multi-language-content-startup.md)
