# 🌍 Multi-Language Content Generator pour Startups

> **Pattern**: Parallel + Batch Processing
> **Complexité**: Avancée
> **Cas d'usage**: Translation et localisation de contenu à l'échelle internationale
> **ROI**: 95% réduction temps, 98% réduction coûts

## 🎯 Contexte Startup

Les startups qui se développent à l'international ont besoin de **contenu localisé** dans 10+ langues, mais les services de traduction traditionnels sont lents et coûteux.

**Problème** :
- Traduction professionnelle → $0.10-0.25/mot
- Article 1500 mots × 10 langues = $1,500-3,750
- Délai : 2-5 jours par langue
- Localisation culturelle → coût supplémentaire
- **Total** : $1,500-3,750 + 20-50 jours

**Solution Claude Code** :
- Traduction automatisée avec context culturel
- Batch processing de 15+ langues en parallèle
- Localisation intelligente (dates, devises, références)
- Quality assurance automatique
- **Résultat** : $50-100 + 2-3 heures

---

## 📊 Architecture du Workflow

```
╔═══════════════════════════════════════════════════════════════╗
║        COMMAND: /translate-content                            ║
║  (Traduction + Localisation de contenu source)               ║
╚═══════════════════════════════════════════════════════════════╝
                              │
           ┌──────────────────┼──────────────────┐
           ▼                  ▼                  ▼
    ┌─────────────┐   ┌─────────────┐   ┌─────────────┐
    │SUB: Analyze │   │SUB: Batch   │   │SUB: Validate│
    │   Source    │   │ Translate   │   │  & Publish  │
    └─────────────┘   └─────────────┘   └─────────────┘
           │                  │                  │
           ▼                  ▼                  ▼
       [AG1][AG2]    [AG3...AG17] (15 agents)   [AG18][AG19]
                          PARALLEL

🪝 HOOKS: Source-Validation, Cultural-Check, Quality-Gate
```

### Architecture Détaillée

```
Niveau 1: COMMAND (/translate-content)
   │
   ├─ Niveau 2: SUBCOMMAND (Source Analysis)
   │   ├─ Niveau 3: AGENT (Content-Parser)
   │   └─ Niveau 3: AGENT (Context-Extractor)
   │
   ├─ HOOK: Source-Validation
   │
   ├─ Niveau 2: SUBCOMMAND (Batch Translation)
   │   │
   │   ├─ Regional Batch: EMEA (Parallel)
   │   │   ├─ Niveau 3: AGENT (French-Translator)
   │   │   ├─ Niveau 3: AGENT (German-Translator)
   │   │   ├─ Niveau 3: AGENT (Spanish-Translator)
   │   │   ├─ Niveau 3: AGENT (Italian-Translator)
   │   │   └─ Niveau 3: AGENT (Dutch-Translator)
   │   │
   │   ├─ Regional Batch: APAC (Parallel)
   │   │   ├─ Niveau 3: AGENT (Japanese-Translator)
   │   │   ├─ Niveau 3: AGENT (Korean-Translator)
   │   │   ├─ Niveau 3: AGENT (Chinese-Simplified-Translator)
   │   │   ├─ Niveau 3: AGENT (Chinese-Traditional-Translator)
   │   │   └─ Niveau 3: AGENT (Hindi-Translator)
   │   │
   │   └─ Regional Batch: AMERICAS (Parallel)
   │       ├─ Niveau 3: AGENT (Portuguese-BR-Translator)
   │       ├─ Niveau 3: AGENT (Spanish-LATAM-Translator)
   │       └─ Niveau 3: AGENT (French-CA-Translator)
   │
   ├─ HOOK: Cultural-Check (verify localization)
   │
   └─ Niveau 2: SUBCOMMAND (Validation & Publishing)
       ├─ Niveau 3: AGENT (QA-Validator) - checks all translations
       └─ Niveau 3: AGENT (Multi-CMS-Publisher) - publishes to all markets

🔥 KEY FEATURE: 15 agents en parallèle = 15 langues simultanées
```

**Pattern spécial** : Batch processing régional pour optimiser coûts API et latence.

---

## 🔧 Implémentation Complète

### 1. Command Principal

`.claude/commands/translate-content.md` :

```yaml
---
name: translate-content
description: Translate and localize content to 15+ languages simultaneously
args:
  source_file: Path to source content (markdown/HTML)
  source_lang: Source language code (default: en)
  target_markets: Comma-separated market codes or "all" (default: all)
  publish: Auto-publish or save drafts (default: false)
---

# Multi-Language Content Generator

You are orchestrating a complete translation and localization workflow.

## Input
- Source: {{source_file}}
- From: {{source_lang}}
- To markets: {{target_markets}}
- Auto-publish: {{publish}}

## Supported Markets

### EMEA
- `fr` - French (France)
- `de` - German (Germany)
- `es` - Spanish (Spain)
- `it` - Italian (Italy)
- `nl` - Dutch (Netherlands)

### APAC
- `ja` - Japanese (Japan)
- `ko` - Korean (South Korea)
- `zh-CN` - Chinese Simplified (China)
- `zh-TW` - Chinese Traditional (Taiwan)
- `hi` - Hindi (India)

### AMERICAS
- `pt-BR` - Portuguese (Brazil)
- `es-MX` - Spanish (Mexico/LATAM)
- `fr-CA` - French (Canada)

### ADDITIONAL (optional)
- `ru` - Russian
- `ar` - Arabic

## Workflow Steps

### PHASE 1: Source Analysis
Execute subcommand: `/translate-analyze {{source_file}}`

**This subcommand coordinates 2 agents in PARALLEL**:
1. Content-Parser agent (extracts structure, metadata, special elements)
2. Context-Extractor agent (identifies cultural references, idioms, brand terms)

**HOOK: source-validation**
- Verify source content is complete
- Check for placeholder text or TODOs
- Ensure all links are absolute (not relative)
- Validate image paths are accessible
- If validation fails → fix source before proceeding

### PHASE 2: Batch Translation
Execute subcommand: `/translate-batch {{parsed_content}} {{target_markets}}`

**This subcommand launches 15 translation agents in PARALLEL**:

Regional coordination for API efficiency:
- EMEA batch (5 agents): FR, DE, ES, IT, NL
- APAC batch (5 agents): JA, KO, ZH-CN, ZH-TW, HI
- AMERICAS batch (3 agents): PT-BR, ES-MX, FR-CA

Each agent:
- Translates content using Translation-Guidelines skill
- Localizes cultural references (dates, currencies, units)
- Adapts brand voice for target market
- Maintains formatting and structure
- Preserves code blocks and technical terms

**HOOK: cultural-check**
- Verify no offensive terms in target culture
- Check date formats (DD/MM vs MM/DD)
- Validate currency symbols and formats
- Ensure idioms are localized (not literal translation)
- Flag culturally sensitive content for human review

### PHASE 3: Quality Assurance
Execute subcommand: `/translate-validate {{all_translations}}`

**This subcommand coordinates 2 agents in SEQUENCE**:
1. QA-Validator agent (runs automated quality checks)
2. Multi-CMS-Publisher agent (publishes to regional CMS instances)

**HOOK: quality-gate**
- Check translation completeness (no missing sections)
- Verify formatting consistency
- Validate links work in all languages
- Ensure images have localized alt text
- Check SEO metadata is translated
- If quality fails → regenerate problematic translations

### PHASE 4: Publishing
If {{publish}} = true:
- Push to regional CMS instances
- Update hreflang tags for SEO
- Create language switcher navigation
- Set up regional analytics tracking

If {{publish}} = false:
- Save all translations as drafts
- Generate preview links
- Create review checklist per language

## Output
Return:
- ✅ Translations completed: [list of languages]
- 📊 Quality scores per language
- 🔗 Published URLs or draft links
- ⏱️ Total time taken
- 💰 Translation cost breakdown

## Success Criteria
- All target languages translated
- Quality score > 85/100 per language
- Cultural localization applied
- SEO metadata translated
- Total time < 3 hours (vs 20-50 days manual)
```

---

### 2. Subcommands

#### `/translate-analyze` - Source Analysis

`.claude/commands/translate-analyze.md` :

```yaml
---
name: translate-analyze
description: Parse and analyze source content before translation
args:
  source_file: Path to source content
---

# Translation Source Analysis

Prepare source content for batch translation.

## Agent 1: Content Parser
Launch agent with prompt:
```
You are a Content-Parser agent.

Task: Extract and structure content for translation

Input: {{source_file}}

Extract:
1. **Content structure**:
   - Title, headings (H1, H2, H3)
   - Paragraphs and lists
   - Code blocks (DO NOT translate)
   - Blockquotes
   - Tables

2. **Metadata**:
   - SEO title and description
   - Author, publish date
   - Categories and tags
   - Featured image URL

3. **Special elements**:
   - Product names (DO NOT translate)
   - Brand terms (localize per market)
   - Technical terms (preserve or translate based on glossary)
   - URLs and links (preserve structure)
   - Numbers and units (prepare for localization)

4. **Formatting**:
   - Bold, italic, underline
   - Emoji usage
   - Line breaks and spacing

Output format:
```json
{
  "content": {
    "title": "...",
    "sections": [
      {
        "type": "h2",
        "text": "...",
        "subsections": [...]
      }
    ]
  },
  "metadata": {...},
  "special_elements": {
    "preserve": ["ProductName", "BrandName"],
    "localize": ["currency", "date_format"],
    "code_blocks": [...]
  }
}
```
```

## Agent 2: Context Extractor
Launch agent with prompt:
```
You are a Context-Extractor agent.

Task: Identify cultural context and translation challenges

Input: {{source_file}}

Identify:
1. **Cultural references**:
   - Idioms and expressions
   - Pop culture references
   - Regional examples (US-specific, UK-specific, etc.)
   - Humor that may not translate

2. **Date and time references**:
   - Explicit dates (format varies by locale)
   - Seasons (reversed in Southern Hemisphere)
   - Holidays (different per culture)
   - Time zones

3. **Measurement units**:
   - Imperial vs Metric (miles → km, lbs → kg)
   - Currency ($ → €, ¥, etc.)
   - Temperature (F → C)

4. **Legal/compliance terms**:
   - GDPR (EU-specific)
   - Regional privacy laws
   - Terms of service variations

5. **Tone and formality**:
   - Casual vs formal (varies by culture)
   - Use of "you" vs formal pronouns
   - Direct vs indirect communication

Use Skill:
- Cultural-Context skill (cultural norms per market)

Output:
```json
{
  "cultural_challenges": [
    {
      "original": "Black Friday deals",
      "challenge": "US shopping event, unknown in Asia",
      "suggestion": "Localize to equivalent local event or generic 'special offer'"
    }
  ],
  "localization_rules": {
    "dates": "DD/MM/YYYY for EU, MM/DD/YYYY for US",
    "currency": "$ → € (EU), ¥ (JP/CN), £ (UK)",
    "formality": "formal for DE/JP, casual for US/UK"
  }
}
```
```

## Wait for Both Agents
Launch in parallel using `Task` tool.

Once complete, merge outputs into Translation Brief.

## Output Format
```json
{
  "source_analysis": {
    "structure": {...},
    "cultural_context": {...},
    "translation_brief": {
      "total_words": 1500,
      "estimated_time_per_language": "10-15 minutes",
      "complexity": "medium",
      "special_instructions": [...]
    }
  }
}
```
```

---

#### `/translate-batch` - Batch Translation

`.claude/commands/translate-batch.md` :

```yaml
---
name: translate-batch
description: Translate content to multiple languages in parallel
args:
  source_content: Parsed source content JSON
  target_markets: List of target market codes
---

# Batch Translation Subcommand

Launch 15+ translation agents in parallel, grouped by region.

## Regional Batching Strategy

Why regional batching?
- API rate limiting (distribute load)
- Similar cultural context per region
- Optimize latency (geographic proximity)

## EMEA Batch (5 agents in parallel)

### French (France)
Launch agent:
```
You are a French-Translator agent.

Task: Translate content to French (France)

Use Skills:
- Translation-Guidelines skill (translation best practices)
- Cultural-Context skill (French market specifics)
- Brand-Voice skill (adapt brand tone for French market)

Input: {{source_content}}

Translation rules:
1. **Formal "vous" vs informal "tu"**:
   - Use "vous" for B2B content
   - "Tu" acceptable for B2C if brand is casual

2. **French punctuation**:
   - Space before : ; ! ?
   - Use « guillemets français » not "English quotes"

3. **Localization**:
   - Dates: DD/MM/YYYY (e.g., 17/11/2025)
   - Currency: € (symbol after number: 99 €)
   - Units: Metric system

4. **Cultural adaptation**:
   - Replace US examples with French/EU equivalents
   - Adapt humor (French prefer wordplay over slapstick)
   - Legal: Mention GDPR compliance

5. **SEO**:
   - Translate keywords naturally
   - Adapt meta description for French searchers
   - Use French search intent patterns

Quality checks:
- Grammar and spelling (no errors)
- Consistency of terminology
- Readability (natural French, not translation-ese)

Output:
```json
{
  "language": "fr",
  "translated_content": "...",
  "metadata": {
    "seo_title": "...",
    "meta_description": "...",
    "keywords": [...]
  },
  "localization_applied": [
    "Dates converted to DD/MM/YYYY",
    "Currency changed to €",
    "Replaced Thanksgiving example with Bastille Day"
  ],
  "quality_score": 92
}
```
```

### German (Germany)
Launch agent:
```
You are a German-Translator agent.

Task: Translate content to German (Germany)

Use Skills:
- Translation-Guidelines skill
- Cultural-Context skill (German market)
- Brand-Voice skill (adapt for German formality)

Translation rules:
1. **Formal "Sie" vs informal "du"**:
   - Always use "Sie" for professional content
   - "Du" only for very casual brands targeting Gen Z

2. **Compound words**:
   - German loves compounds (Datenschutzgrundverordnung = GDPR)
   - Use hyphens for readability when needed

3. **Localization**:
   - Dates: DD.MM.YYYY (e.g., 17.11.2025)
   - Currency: € (symbol after: 99 €)
   - Decimal comma: 1.500,50 € (not 1,500.50)

4. **Cultural adaptation**:
   - Germans value precision and detail
   - Direct communication (less fluff)
   - Quality over quantity
   - Data privacy is CRITICAL (emphasize security)

5. **Title case**:
   - Capitalize all nouns (German grammar rule)

Output: [Same JSON structure as French]
```

### Spanish (Spain)
Launch agent:
```
You are a Spanish-Translator agent (Spain).

Task: Translate to European Spanish (NOT Latin American)

Translation rules:
1. **Vosotros vs Ustedes**:
   - Spain uses "vosotros" (informal plural)
   - Latin America uses "ustedes" (we'll handle LATAM separately)

2. **Localization**:
   - Dates: DD/MM/YYYY
   - Currency: € (before or after number acceptable)
   - Use European Spanish vocabulary (ordenador not computadora)

3. **Cultural adaptation**:
   - Adapt US references to Spanish/EU equivalents
   - Respect Spanish work culture (siesta, late dinners)
   - Soccer > American football

Output: [Same JSON structure]
```

### Italian (Italy)
Launch agent:
```
You are an Italian-Translator agent.

Translation rules:
1. **Formal "Lei" vs "tu"**:
   - "Lei" for professional B2B
   - "Tu" for casual B2C

2. **Localization**:
   - Dates: DD/MM/YYYY
   - Currency: € (with space: 99 €)
   - Italian phrases (ciao, grazie) are fine if contextual

3. **Cultural adaptation**:
   - Italians value style and design
   - Emotional, expressive language accepted
   - Family and tradition matter

Output: [Same JSON structure]
```

### Dutch (Netherlands)
Launch agent:
```
You are a Dutch-Translator agent.

Translation rules:
1. **"Je" vs "u"**:
   - "Je" is increasingly common even in B2B
   - "U" for very formal/legal contexts

2. **Localization**:
   - Dates: DD-MM-YYYY (hyphens not slashes)
   - Currency: € (before number: €99)

3. **Cultural adaptation**:
   - Dutch value directness and honesty
   - Egalitarian culture (no excessive formality)
   - Sustainability and social responsibility matter

Output: [Same JSON structure]
```

---

## APAC Batch (5 agents in parallel)

### Japanese (Japan)
Launch agent:
```
You are a Japanese-Translator agent.

Task: Translate to Japanese with appropriate formality

Translation rules:
1. **Keigo (polite language)**:
   - Use です/ます form (polite) for business content
   - Avoid casual だ/である unless brand is youth-focused

2. **Writing system**:
   - Mix of Kanji, Hiragana, Katakana
   - Use Katakana for foreign loanwords
   - Furigana for difficult Kanji (if audience is broad)

3. **Localization**:
   - Dates: YYYY年MM月DD日 (e.g., 2025年11月17日)
   - Currency: ¥ (before number: ¥9,900)
   - Units: Metric

4. **Cultural adaptation**:
   - Indirect communication (avoid bluntness)
   - Respect hierarchy and tradition
   - Group harmony > individualism
   - Quality and craftsmanship highly valued
   - Remove overly casual US humor

5. **Layout considerations**:
   - Vertical text may be preferred for some content
   - Right-to-left reading option

Quality checks:
- Appropriate formality level
- Natural Japanese (not "translation Japanese")
- Cultural sensitivity

Output: [Same JSON structure, include romaji for non-Japanese speakers]
```

### Korean (South Korea)
Launch agent:
```
You are a Korean-Translator agent.

Translation rules:
1. **Honorifics (존댓말)**:
   - Use -습니다/-ㅂ니다 endings for formal content
   - -요 ending for semi-formal
   - Avoid banmal (casual) unless brand targets teens

2. **Hangul only**:
   - Use Hangul for everything
   - Hanja (Chinese characters) rarely used now
   - English words often kept in English or Konglish

3. **Localization**:
   - Dates: YYYY년 MM월 DD일
   - Currency: ₩ (e.g., ₩99,000)
   - Age system (Korean age +1 or +2 years)

4. **Cultural adaptation**:
   - Respect for elders and hierarchy
   - Tech-savvy population (cutting-edge examples work)
   - K-culture pride (reference K-pop, K-drama if relevant)
   - Fast-paced lifestyle

Output: [Same JSON structure]
```

### Chinese Simplified (China)
Launch agent:
```
You are a Chinese-Simplified-Translator agent (Mainland China).

Translation rules:
1. **Simplified characters** (简体中文):
   - Use simplified characters ONLY (not traditional)
   - Example: 学习 not 學習

2. **Localization**:
   - Dates: YYYY年MM月DD日
   - Currency: ¥ or 元 (e.g., ¥99 or 99元)
   - RMB not CNY in casual contexts

3. **Cultural adaptation**:
   - Collectivist society (group > individual)
   - Government sensitivity (avoid political topics)
   - Numbers: 4 is unlucky, 8 is lucky
   - Red = good luck, white = mourning
   - Adapt Western brand names (phonetic or meaning-based)

4. **Digital ecosystem**:
   - Mention WeChat, Weibo (not Facebook, Twitter)
   - Alipay/WeChat Pay (not credit cards)
   - Baidu SEO (not Google)

5. **Tone**:
   - More formal than US English
   - Avoid controversial topics
   - Emphasize quality and status

Output: [Same JSON structure, include pinyin]
```

### Chinese Traditional (Taiwan/Hong Kong)
Launch agent:
```
You are a Chinese-Traditional-Translator agent (Taiwan/Hong Kong).

Translation rules:
1. **Traditional characters** (繁體中文):
   - Use traditional characters: 學習 not 学习

2. **Variant**: Specify Taiwan or Hong Kong
   - Taiwanese Mandarin vs Hong Kong Cantonese
   - Different vocabulary and expressions

3. **Localization**:
   - Dates: YYYY/MM/DD (Taiwan) or DD/MM/YYYY (HK)
   - Currency: NT$ (Taiwan) or HK$ (Hong Kong)

4. **Cultural adaptation**:
   - Taiwan: Democratic, open internet (can mention Google, Facebook)
   - HK: International, bilingual (English + Cantonese)
   - Different from Mainland China culturally

Output: [Same JSON structure]
```

### Hindi (India)
Launch agent:
```
You are a Hindi-Translator agent (India).

Translation rules:
1. **Devanagari script** (हिन्दी):
   - Use Devanagari for Hindi text
   - Provide romanized version (transliteration)

2. **English mixing**:
   - Code-switching is normal (Hinglish)
   - Technical terms often kept in English
   - OK to mix English words in Hindi sentences

3. **Localization**:
   - Dates: DD/MM/YYYY
   - Currency: ₹ (Rupee symbol) or रु
   - Lakhs and crores (not millions/billions)
   - Example: ₹10,00,000 (10 lakhs) not ₹1,000,000

4. **Cultural adaptation**:
   - Diverse audience (urban English-speakers vs Hindi-first users)
   - Family-oriented culture
   - Value for money important
   - Cricket > other sports

Output: [Same JSON + Romanized version]
```

---

## AMERICAS Batch (3 agents in parallel)

### Portuguese (Brazil)
Launch agent:
```
You are a Portuguese-BR-Translator agent (Brazil).

Task: Translate to Brazilian Portuguese (NOT European Portuguese)

Translation rules:
1. **Você vs Tu**:
   - Brazil uses "você" (even informally)
   - European Portuguese uses "tu"

2. **Vocabulary differences**:
   - BR: trem (train), ônibus (bus)
   - PT: comboio (train), autocarro (bus)
   - Use Brazilian terms

3. **Localization**:
   - Dates: DD/MM/YYYY
   - Currency: R$ (before number: R$ 99,90)
   - Decimal comma: R$ 1.500,50

4. **Cultural adaptation**:
   - Warm, friendly tone (Brazilians are expressive)
   - Soccer culture (futebol)
   - Carnival, beaches, samba
   - Growing tech startup scene

Output: [Same JSON structure]
```

### Spanish (Latin America)
Launch agent:
```
You are a Spanish-LATAM-Translator agent.

Task: Translate to neutral Latin American Spanish

Translation rules:
1. **Ustedes (NOT vosotros)**:
   - All of Latin America uses "ustedes"
   - Never use "vosotros" (that's Spain)

2. **Neutral vocabulary**:
   - Use terms understood across LATAM
   - Avoid regional slang (Mexican, Argentine, etc.)
   - Computadora (computer) is more neutral than ordenador

3. **Localization**:
   - Dates: DD/MM/YYYY
   - Currency: $ or USD (varies by country)
   - Mention "América Latina" not "Latinoamérica"

4. **Cultural adaptation**:
   - Family-oriented
   - Emphasis on personal relationships
   - Adapt US holidays to local equivalents

Output: [Same JSON structure]
```

### French (Canada)
Launch agent:
```
You are a French-CA-Translator agent (Quebec, Canada).

Task: Translate to Canadian French (Québécois)

Translation rules:
1. **Québécois vs France French**:
   - Different vocabulary (char vs voiture for car)
   - Different expressions
   - Anglicisms more accepted in Quebec

2. **Localization**:
   - Dates: YYYY-MM-DD (ISO format used in Canada)
   - Currency: $ CAD (dollar symbol)
   - Bilingual environment (French + English)

3. **Cultural adaptation**:
   - Pride in French language preservation
   - North American culture (similar to US but French)
   - Winters, hockey, maple syrup

Output: [Same JSON structure]
```

---

## Wait for ALL Regional Batches
Use `Task` tool to launch all 13-15 agents concurrently.

Regional coordination ensures:
- API rate limits not exceeded
- Parallel processing maximized
- Regional cultural consistency

## Output Format
Return array of all translations:
```json
{
  "translations": [
    {
      "language": "fr",
      "content": "...",
      "quality_score": 92,
      "time_taken": "12 minutes"
    },
    {
      "language": "de",
      "content": "...",
      "quality_score": 89,
      "time_taken": "14 minutes"
    }
    // ... all languages
  ],
  "batch_summary": {
    "total_languages": 13,
    "total_time": "18 minutes (parallelized)",
    "average_quality": 90.5,
    "cost_breakdown": {
      "translation_api": "$45",
      "quality_check": "$3",
      "total": "$48"
    }
  }
}
```
```

---

#### `/translate-validate` - Validation & Publishing

`.claude/commands/translate-validate.md` :

```yaml
---
name: translate-validate
description: Quality check and publish all translations
args:
  translations: Array of all translations
  publish: Auto-publish or save drafts
---

# Translation Validation & Publishing

Run QA checks and publish to regional CMS instances.

## Agent 1: QA Validator
Launch agent with prompt:
```
You are a QA-Validator agent.

Task: Run automated quality checks on all translations

Input: {{translations}} (13-15 language versions)

For EACH translation, check:

1. **Completeness**:
   - All sections translated (no missing parts)
   - No placeholder text ([TRANSLATE], TODO, etc.)
   - Same number of paragraphs as source

2. **Formatting consistency**:
   - Headings (H1, H2, H3) preserved
   - Lists and bullets maintained
   - Code blocks untranslated (preserved as-is)
   - Links functional and absolute
   - Images present with localized alt text

3. **Localization applied**:
   - Dates in correct format for locale
   - Currency symbols appropriate
   - Units converted (metric for most markets)
   - Cultural references adapted

4. **SEO metadata**:
   - Title tag translated and < 60 chars
   - Meta description translated and ~ 155 chars
   - Keywords translated naturally
   - URL slug appropriate for language

5. **Language quality**:
   - No grammatical errors (use grammar checker API if available)
   - Natural phrasing (not "translation-ese")
   - Consistent terminology throughout
   - Appropriate formality level for market

6. **Technical checks**:
   - Character encoding correct (UTF-8)
   - No broken special characters
   - RTL languages (Arabic) have correct directionality

Scoring (per translation):
- Completeness: 0-25 points
- Formatting: 0-25 points
- Localization: 0-25 points
- Language quality: 0-25 points
- **Total**: 0-100

Threshold: Minimum 85/100 to pass

Output:
```json
{
  "validation_results": [
    {
      "language": "fr",
      "score": 92,
      "passed": true,
      "issues": []
    },
    {
      "language": "ja",
      "score": 78,
      "passed": false,
      "issues": [
        "Missing localization of date formats in section 3",
        "Inconsistent formality (mix of です and だ)"
      ]
    }
  ],
  "overall_pass_rate": "12/13 (92%)",
  "failed_languages": ["ja"]
}
```

If any language fails:
- Regenerate that specific translation
- Re-run validation
- Repeat until pass or max 2 retries
```

## Agent 2: Multi-CMS Publisher
Launch agent with prompt:
```
You are a Multi-CMS-Publisher agent.

Task: Publish all validated translations to regional CMS instances

Input:
- {{translations}} (validated translations)
- {{publish}} (true/false)

Use MCP tools:
- WordPress MCP (multi-site support)
- Or custom CMS API

For EACH language:

1. **Select regional CMS**:
   - fr → https://fr.yoursite.com
   - de → https://de.yoursite.com
   - ja → https://ja.yoursite.com
   - etc.

2. **Create/update post**:
   - Upload images to regional media library
   - Create post with translated content
   - Set title, meta, slug
   - Add categories/tags (translated)
   - Set featured image

3. **Configure hreflang tags** (SEO):
   - Add alternate language links
   - Ensure x-default points to English
   - Example:
     ```html
     <link rel="alternate" hreflang="fr" href="https://fr.yoursite.com/article" />
     <link rel="alternate" hreflang="de" href="https://de.yoursite.com/artikel" />
     ```

4. **Set language switcher**:
   - Update navigation to show language options
   - Ensure user can switch between versions

5. **Publish or save**:
   - If {{publish}} = true → publish immediately
   - Else → save as draft with preview link

6. **Setup tracking**:
   - Google Analytics with language dimension
   - Track conversions per market
   - UTM parameters for regional campaigns

Output:
```json
{
  "published": [
    {
      "language": "fr",
      "url": "https://fr.yoursite.com/blog/article",
      "status": "published",
      "cms_id": 12345
    }
    // ... all languages
  ],
  "hreflang_configured": true,
  "analytics_tracking": true,
  "total_time": "8 minutes"
}
```
```

## Sequential Execution
Agent 1 (QA-Validator) MUST complete and pass before Agent 2 (Publisher) starts.

If validation fails → regenerate → re-validate → then publish.

## Output Format
```json
{
  "validation_passed": true,
  "published_count": 13,
  "published_urls": {
    "fr": "https://fr.yoursite.com/...",
    "de": "https://de.yoursite.com/...",
    // ... all languages
  },
  "failed_languages": [],
  "total_time": "25 minutes (validation 8min + publishing 17min)"
}
```
```

---

## 🛠️ Skills Requis

### 1. Translation-Guidelines Skill

`.claude/skills/translation-guidelines.md` :

```markdown
# Translation Guidelines Skill

Best practices for high-quality translation.

## Core Principles

1. **Accuracy > Literalness**:
   - Translate meaning, not words
   - Adapt idioms and expressions
   - Preserve intent and tone

2. **Natural language**:
   - Sound like native speaker wrote it
   - Avoid "translation-ese" (word-for-word awkwardness)
   - Use common phrases and expressions

3. **Consistency**:
   - Use terminology glossary
   - Consistent brand terms
   - Consistent formality level

4. **Cultural adaptation**:
   - Localize examples and references
   - Respect cultural norms
   - Adapt humor and tone

## Technical Terms

Create glossary for:
- Product names (usually DON'T translate)
- Feature names (translate if common term, preserve if branded)
- Industry jargon (check target market conventions)
- UI elements (translate for UX)

## Common Mistakes

❌ **DON'T**:
- Translate brand names (keep "iPhone", "Slack", etc.)
- Literal translation of idioms ("It's raining cats and dogs" → ?)
- Ignore cultural context
- Use machine translation without review
- Mix formality levels (vous → tu randomly)

✅ **DO**:
- Research target market terminology
- Use native speaker reviewers when possible
- Check competitor translations for conventions
- Maintain consistent glossary
- Test with native speakers

## Quality Checklist

Before submitting translation:
- [ ] Reads naturally in target language
- [ ] Culturally appropriate
- [ ] Terminology consistent
- [ ] Formatting preserved
- [ ] Links and images work
- [ ] SEO metadata translated
- [ ] Localized (dates, currency, units)
```

### 2. Cultural-Context Skill

`.claude/skills/cultural-context.md` :

```markdown
# Cultural Context Skill

Cultural norms and sensitivities per market.

## Formality Levels

### High formality (use formal pronouns):
- 🇩🇪 Germany (Sie)
- 🇯🇵 Japan (です/ます)
- 🇰🇷 Korea (습니다)
- 🇫🇷 France B2B (vous)

### Medium formality:
- 🇪🇸 Spain (varies by brand)
- 🇮🇹 Italy (varies by brand)
- 🇨🇳 China (formal tone)

### Low formality (informal OK):
- 🇺🇸 US (casual brands)
- 🇬🇧 UK (depends on brand)
- 🇳🇱 Netherlands (je increasingly common)
- 🇧🇷 Brazil (friendly and warm)

## Communication Styles

### Direct:
- 🇺🇸 US, 🇩🇪 Germany, 🇳🇱 Netherlands
- Say what you mean
- Efficiency valued

### Indirect:
- 🇯🇵 Japan, 🇨🇳 China, 🇰🇷 Korea
- Avoid bluntness
- Read between lines
- Harmony valued

## Cultural Sensitivities

### Colors:
- 🇨🇳 Red = good luck, white = mourning
- 🇯🇵 White = purity, black = formality
- 🇮🇳 Saffron/orange = sacred, green = prosperity

### Numbers:
- 🇨🇳/🇯🇵 4 = unlucky (sounds like "death")
- 🇨🇳 8 = lucky (sounds like "prosperity")
- 🇮🇹 17 = unlucky

### Gestures:
- 👍 Thumbs up: positive (US/EU), offensive (Middle East)
- 👌 OK sign: positive (US), offensive (Brazil, Turkey)
- Cultural variation in emoji interpretation

## Religious/Political Sensitivities

### Avoid mentioning:
- 🇨🇳 China: Taiwan independence, Tibet, Tiananmen
- 🇹🇷 Turkey: Armenian genocide, Kurdish conflict
- 🇮🇱 Israel/Palestine: highly sensitive
- 🇮🇳 India: Kashmir, caste system

### Respect religious norms:
- 🇸🇦 Saudi Arabia: No alcohol, pork; modest imagery
- 🇮🇱 Israel: Sabbath (Friday sundown - Saturday sundown)
- 🇮🇳 India: Vegetarianism common, cow is sacred

## Localization Tips

### Holidays:
- Don't assume Christmas/Thanksgiving universally celebrated
- Localize to regional holidays:
  - 🇨🇳 Chinese New Year
  - 🇯🇵 Golden Week
  - 🇮🇳 Diwali
  - 🇧🇷 Carnival

### Sports:
- ⚽ Soccer/Football: global (except US)
- 🏏 Cricket: India, Pakistan, UK, Australia
- ⚾ Baseball: US, Japan, Latin America
- 🏈 American Football: US only

### Examples:
- Replace US-specific examples with local equivalents
- Mention local brands, not just US brands
- Use local success stories
```

---

## 🪝 Hooks Implémentés

### 1. Source Validation Hook

`.claude/hooks/source-validation.sh` :

```bash
#!/bin/bash
# Hook: Validate source content before translation

SOURCE_FILE="$1"

echo "🪝 Running Source Validation..."

# Check if file exists
if [[ ! -f "$SOURCE_FILE" ]]; then
  echo "❌ Source file not found: $SOURCE_FILE"
  exit 1
fi

VALID=true

# Check for placeholder text
if grep -q '\[TRANSLATE\]' "$SOURCE_FILE" || grep -q 'TODO' "$SOURCE_FILE"; then
  echo "⚠️  Found placeholder text ([TRANSLATE] or TODO). Remove before translating."
  VALID=false
fi

# Check for relative links (should be absolute for translations)
if grep -qE 'href="\./' "$SOURCE_FILE" || grep -qE 'src="\./' "$SOURCE_FILE"; then
  echo "⚠️  Found relative links. Convert to absolute URLs for translations."
  VALID=false
fi

# Check for broken image paths
if grep -qE 'src="[^"]*\.(jpg|png|gif|webp)"' "$SOURCE_FILE"; then
  # Extract image URLs and test if accessible
  IMAGES=$(grep -oE 'src="[^"]*\.(jpg|png|gif|webp)"' "$SOURCE_FILE" | sed 's/src="//;s/"//')
  for IMG in $IMAGES; do
    if [[ ! "$IMG" =~ ^http ]]; then
      echo "⚠️  Image path not absolute: $IMG"
      VALID=false
    fi
  done
fi

# Check content completeness
WORD_COUNT=$(wc -w < "$SOURCE_FILE")
if (( WORD_COUNT < 500 )); then
  echo "⚠️  Source content very short ($WORD_COUNT words). Verify completeness."
  VALID=false
fi

if [[ "$VALID" == true ]]; then
  echo "✅ Source validation passed!"
  exit 0
else
  echo "❌ Source validation failed. Fix issues before translating."
  exit 1
fi
```

### 2. Cultural Check Hook

`.claude/hooks/cultural-check.sh` :

```bash
#!/bin/bash
# Hook: Verify cultural localization applied

TRANSLATION_FILE="$1"
TARGET_LANG="$2"

echo "🪝 Running Cultural Check for $TARGET_LANG..."

VALID=true

# Parse translation JSON
CONTENT=$(jq -r '.translated_content' "$TRANSLATION_FILE")
LOCALIZATION_APPLIED=$(jq -r '.localization_applied[]' "$TRANSLATION_FILE")

# Language-specific checks
case "$TARGET_LANG" in
  fr|de|es|it|nl)
    # European markets - check date format
    if echo "$CONTENT" | grep -qE '[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}' && [[ "$TARGET_LANG" != "fr" ]]; then
      # MM/DD/YYYY found (US format), should be DD/MM/YYYY for EU
      echo "⚠️  US date format detected. Should use DD/MM/YYYY for European markets."
      VALID=false
    fi
    # Check currency
    if echo "$CONTENT" | grep -q '\$[0-9]' && ! echo "$LOCALIZATION_APPLIED" | grep -q "Currency"; then
      echo "⚠️  Dollar sign ($) found. Should use € for European markets."
      VALID=false
    fi
    ;;

  ja)
    # Japanese - check formality
    if echo "$CONTENT" | grep -qE 'だ。|である。'; then
      echo "⚠️  Casual/plain form detected in Japanese. Should use です/ます for business content."
      VALID=false
    fi
    # Check date format
    if ! echo "$CONTENT" | grep -qE '[0-9]{4}年[0-9]{1,2}月[0-9]{1,2}日'; then
      echo "⚠️  Japanese date format not found. Should use YYYY年MM月DD日."
      VALID=false
    fi
    ;;

  zh-CN)
    # Check for traditional characters (should be simplified)
    if echo "$CONTENT" | grep -qE '學|習|風'; then
      echo "⚠️  Traditional Chinese characters detected. Should use Simplified for zh-CN."
      VALID=false
    fi
    # Check for blocked terms (basic check)
    BLOCKED_TERMS=("taiwan independence" "tibet" "tiananmen")
    for TERM in "${BLOCKED_TERMS[@]}"; do
      if echo "$CONTENT" | grep -qi "$TERM"; then
        echo "❌ CRITICAL: Politically sensitive term detected: $TERM"
        echo "This content may be blocked in China. Human review required."
        VALID=false
      fi
    done
    ;;

  de)
    # German - check noun capitalization
    # (Simple check: look for common nouns that should be capitalized)
    COMMON_NOUNS=("projekt" "produkt" "kunde" "firma")
    for NOUN in "${COMMON_NOUNS[@]}"; do
      if echo "$CONTENT" | grep -qE " $NOUN "; then
        echo "⚠️  Found '$NOUN' not capitalized. German nouns must be capitalized."
        VALID=false
      fi
    done
    ;;
esac

# Universal checks for all languages
# Check if localization was applied
if [[ -z "$LOCALIZATION_APPLIED" ]]; then
  echo "⚠️  No localization applied. Dates, currency, and units should be localized."
  VALID=false
fi

# Check quality score
QUALITY_SCORE=$(jq -r '.quality_score' "$TRANSLATION_FILE")
if (( $(echo "$QUALITY_SCORE < 85" | bc -l) )); then
  echo "⚠️  Quality score too low: $QUALITY_SCORE (minimum: 85)"
  VALID=false
fi

if [[ "$VALID" == true ]]; then
  echo "✅ Cultural check passed for $TARGET_LANG!"
  exit 0
else
  echo "❌ Cultural check failed. Review translation."
  exit 1
fi
```

---

## 🔌 MCP Servers Utilisés

### 1. Translation API MCP

```json
{
  "mcpServers": {
    "deepl": {
      "command": "npx",
      "args": ["-y", "@deepl/mcp-server"],
      "env": {
        "DEEPL_API_KEY": "from-1password"
      }
    }
  }
}
```

**Usage** : High-quality neural translation (agents can use as base, then refine)

### 2. CMS MCP (Multi-site WordPress)

```json
{
  "mcpServers": {
    "wordpress-multisite": {
      "command": "npx",
      "args": ["-y", "@wordpress/mcp-multisite"],
      "env": {
        "WP_NETWORK_URL": "https://yoursite.com",
        "WP_API_KEY": "from-1password"
      }
    }
  }
}
```

**Usage** : Publish to regional WordPress instances (fr.site.com, de.site.com, etc.)

### 3. Grammar Check MCP

```json
{
  "mcpServers": {
    "languagetool": {
      "command": "npx",
      "args": ["-y", "@languagetool/mcp"],
      "env": {}
    }
  }
}
```

**Usage** : Grammar and spelling checks for all languages

---

## 📊 Benchmarks & ROI

### Avant Claude Code (Manuel)

```
Traduction professionnelle:
  ├─ 1500 mots × $0.15/mot × 13 langues = $2,925
  ├─ Délai: 3-5 jours par langue
  └─ Total: $2,925 + 39-65 jours

Ou traduction automatique basique:
  ├─ Google Translate gratuit
  ├─ Qualité: 60-70/100 (nombreuses erreurs)
  ├─ Pas de localisation culturelle
  └─ Révision manuelle requise: +$500-1,000

─────────────────────────────────
Meilleur cas manuel:
TOTAL:                      40 jours + $3,000
```

### Avec Claude Code (Automatisé)

```
Source Analysis:            10 minutes
  └─ 2 agents en parallèle

Batch Translation:          20 minutes
  └─ 13 agents en parallèle (groupés régionalement)

Quality Assurance:          15 minutes
  └─ Automated QA + fixes

Publishing:                 10 minutes
  └─ Multi-CMS deployment

─────────────────────────────────
TOTAL:                      55 minutes
Coût API:                   ~$80-120
  ├─ Translation API: $60-90
  ├─ Grammar check: $10-20
  └─ CMS operations: $10
```

### ROI Détaillé

```
┌────────────────────────────────────────────────┐
│  Métrique           Manuel      Automatisé     │
├────────────────────────────────────────────────┤
│  Temps              40 jours    55 minutes     │
│  Coût               $3,000      $100           │
│  Langues/jour       0.3         Illimité       │
│  Qualité            Variable    Constant 85+   │
│  Localization       Partielle   Complète       │
│  Révisions          Multiple    Automated QA   │
│  Time-to-market     Slow        Immediate      │
└────────────────────────────────────────────────┘

Gains:
✅ 99% réduction temps (40 jours → 55min)
✅ 97% réduction coûts ($3,000 → $100)
✅ Qualité constante (85-92/100)
✅ Localisation culturelle automatique
✅ Scalable à 50+ langues sans effort additionnel
✅ Same-day international launch possible
```

---

## 🚀 Quick Start

```bash
# 1. Installation des commands et subcommands
mkdir -p .claude/commands/translate
# [Créer tous les fichiers .md listés ci-dessus]

# 2. Installation des skills
mkdir -p .claude/skills
# [Créer translation-guidelines.md et cultural-context.md]

# 3. Installation des hooks
mkdir -p .claude/hooks
# [Créer source-validation.sh et cultural-check.sh]
chmod +x .claude/hooks/*.sh

# 4. Configuration MCP (voir section MCP ci-dessus)

# 5. Test du workflow
claude
/translate-content my-article.md en all false

# Résultat attendu:
# - 13 translations complètes en 55 minutes
# - Quality scores 85-92/100
# - Drafts prêts pour review
```

---

## ⚠️ Anti-Patterns

### ❌ Sequential Translation

```
MAUVAIS:
Traduire FR → attendre → traduire DE → attendre → ...

POURQUOI: 13 langues × 15min = 3h15min

BON:
13 agents en parallèle → 15-20min total
```

### ❌ Ignorer Localisation

```
MAUVAIS:
Traduire mots uniquement, garder dates/currency US

RÉSULTAT: "November 11, 2025" et "$99" en article français

BON:
Localiser: "11 novembre 2025" et "99 €"
```

### ❌ Machine Translation Brute

```
MAUVAIS:
Google Translate direct sans review ni adaptation

PROBLÈME: Idioms littéraux, errors, pas de context culturel

BON:
AI translation + cultural adaptation + QA validation
```

---

## 🎓 Points Clés

### Architecture
✅ Batch processing régional (EMEA, APAC, AMERICAS)
✅ 13-15 agents en parallèle = 13-15 langues simultanées
✅ Hierarchie plate respectée (Command → Subcommand → Agent)

### Localisation
✅ Pas juste traduction, mais adaptation culturelle
✅ Dates, devises, unités adaptés par marché
✅ References culturelles localisées
✅ Tone et formality appropriés

### Qualité
✅ Automated QA avec threshold 85/100
✅ Cultural sensitivity checks (political, religious)
✅ Grammar verification per language
✅ Human-review option pour contenu sensible

### Performance
✅ 99% réduction temps (40 jours → 55min)
✅ 97% réduction coûts ($3,000 → $100)
✅ Scalable à 50+ langues
✅ Same-day international launch

---

## 📚 Ressources

### Documentation
- 📄 [Translation Best Practices](https://developers.google.com/style/translation)
- 📄 [Cultural Localization Guide](https://www.w3.org/International/questions/qa-i18n)

### Workflows Associés
- 🔗 [Blog Automation](./blog-automation-startup.md) - Source content creation
- 🔗 [Social Media Generator](./social-media-automation-startup.md) - Multilingual social posts

---

**Prochaine étape** : [Social Media Post Generator →](./social-media-automation-startup.md)
