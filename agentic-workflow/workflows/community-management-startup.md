# 👥 Community Management Automation pour Startups

> **Pattern**: Sequential + Conditional + Human-in-Loop
> **Complexité**: Avancée
> **Cas d'usage**: Modération, réponses automatiques, escalation intelligente
> **ROI**: 80% réduction temps, 90% réduction coûts

## 🎯 Contexte Startup

Les startups reçoivent **100-500+ commentaires/messages/jour** sur réseaux sociaux, mais n'ont pas de community manager 24/7.

**Problème** :
- Répondre manuellement → 2-3min par message
- 200 messages/jour × 2.5min = 8.3 heures/jour
- Community manager : $3,500-5,000/mois
- Temps de réponse lent → clients insatisfaits
- Spam et trolls non modérés

**Solution Claude Code** :
- Monitoring automatique 24/7
- Catégorisation intelligente (support, sales, spam, feedback)
- Réponses automatiques pour 60-70% des messages
- Escalation human-in-loop pour 30-40%
- **Résultat** : 2h/jour + $150/mois en coûts API

---

## 📊 Architecture du Workflow

```
╔════════════════════════════════════════════════════════════════╗
║         COMMAND: /community-manage                             ║
║  (Monitoring, Triage, Réponse, Escalation)                    ║
╚════════════════════════════════════════════════════════════════╝
                              │
          ┌───────────────────┼───────────────────┐
          ▼                   ▼                   ▼
   ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
   │SUB: Monitor │    │ SUB: Triage │    │ SUB: Respond│
   │  & Collect  │    │  & Classify │    │  or Escalate│
   └─────────────┘    └─────────────┘    └─────────────┘
          │                   │                   │
          ▼                   ▼                   ▼
    [AG1][AG2][AG3]    [AG4][AG5]        [AG6][AG7][AG8]
     PARALLEL           PARALLEL         CONDITIONAL

🪝 HOOKS: Spam-Filter, Sentiment-Check, Human-in-Loop, Response-Quality
```

### Architecture Détaillée

```
Niveau 1: COMMAND (/community-manage)
   │
   ├─ Niveau 2: SUBCOMMAND (Monitoring)
   │   ├─ Niveau 3: AGENT (Social-Monitor) - scrape comments/DMs
   │   ├─ Niveau 3: AGENT (Email-Monitor) - check support email
   │   └─ Niveau 3: AGENT (Chat-Monitor) - check live chat
   │
   ├─ HOOK: Spam-Filter (remove spam before processing)
   │
   ├─ Niveau 2: SUBCOMMAND (Triage & Classification)
   │   ├─ Niveau 3: AGENT (Categorizer) - classify by type
   │   └─ Niveau 3: AGENT (Prioritizer) - assign urgency
   │
   ├─ HOOK: Sentiment-Check (flag negative sentiment)
   │
   ├─ Niveau 2: SUBCOMMAND (Response)
   │   │
   │   ├─ Conditional Branch: AUTO-RESPOND (60-70% of messages)
   │   │   ├─ Niveau 3: AGENT (FAQ-Responder)
   │   │   ├─ Niveau 3: AGENT (Support-Responder)
   │   │   └─ Niveau 3: AGENT (Sales-Responder)
   │   │
   │   └─ Conditional Branch: ESCALATE (30-40% of messages)
   │       └─ Niveau 3: AGENT (Escalator) - human-in-loop
   │
   └─ HOOK: Response-Quality (validate before sending)

🔥 KEY FEATURE: Conditional logic + human-in-loop pour messages complexes
```

**Pattern spécial** : Triage intelligent avec escalation automatique vers humains pour messages complexes/sensibles.

---

## 🔧 Implémentation Complète

### 1. Command Principal

`.claude/commands/community-manage.md` :

```yaml
---
name: community-manage
description: Automate community management across all channels
args:
  channels: Comma-separated channels or "all" (default all)
  mode: "monitor" (read-only) or "respond" (auto-respond enabled)
  escalation_threshold: Complexity score 1-10 for human escalation (default 7)
---

# Community Management Automation

You are orchestrating community monitoring, triage, and response.

## Input
- Channels: {{channels}} (twitter, linkedin, instagram, facebook, email, chat)
- Mode: {{mode}} (monitor or respond)
- Escalation threshold: {{escalation_threshold}} (1-10, higher = more escalation)

## Workflow Steps

### PHASE 1: Monitoring & Collection
Execute subcommand: `/community-monitor {{channels}}`

**This subcommand coordinates 3 agents in PARALLEL**:
1. Social-Monitor agent (scrapes comments, DMs, mentions from social platforms)
2. Email-Monitor agent (checks support@, hello@, contact@ inboxes)
3. Chat-Monitor agent (fetches live chat messages from website)

Collect ALL unread/unresponded messages from last 24 hours.

**HOOK: spam-filter**
- Remove obvious spam (phishing, bots, irrelevant)
- Filter out duplicate messages
- Block known spam accounts
- Reduce noise before processing

### PHASE 2: Triage & Classification
Execute subcommand: `/community-triage {{messages}}`

**This subcommand coordinates 2 agents in PARALLEL**:
1. Categorizer agent (classifies into: Support, Sales, Feedback, Compliment, Complaint, Spam)
2. Prioritizer agent (assigns urgency: P0-Critical, P1-High, P2-Medium, P3-Low)

**HOOK: sentiment-check**
- Analyze sentiment (positive, neutral, negative, very negative)
- Flag negative sentiment for priority handling
- Escalate very negative immediately to human
- Track sentiment trends over time

### PHASE 3: Response or Escalation
Execute subcommand: `/community-respond {{triaged_messages}} {{mode}}`

**Conditional logic based on message complexity**:

IF complexity_score < {{escalation_threshold}}:
  → AUTO-RESPOND (3 specialized agents in parallel):
    - FAQ-Responder: Common questions with canned responses
    - Support-Responder: Technical issues with troubleshooting steps
    - Sales-Responder: Product inquiries with information

ELSE IF complexity_score >= {{escalation_threshold}}:
  → ESCALATE to human:
    - Create ticket in support system
    - Notify human via Slack/email
    - Provide context and suggested response
    - Human reviews and sends (or approves auto-response)

**HOOK: response-quality**
- Check grammar and spelling
- Verify tone is professional yet friendly
- Ensure no sensitive info leaked
- Validate links work
- If quality fails → regenerate or escalate

### PHASE 4: Analytics & Learning
Track metrics:
- Response time (average, median, P95)
- Resolution rate (auto vs human)
- Sentiment trends
- Common issues (update FAQ)

## Output
Return:
- ✅ Messages processed
- 🤖 Auto-responded count
- 👤 Escalated to human count
- 📊 Sentiment breakdown
- ⏱️ Average response time
- 📈 Top issues identified

## Success Criteria
- 100% of messages categorized
- 60-70% auto-responded (mode=respond)
- <5 minutes response time for P0/P1
- Zero spam in escalated messages
- Total time < 2 hours/day (vs 8+ hours manual)
```

---

### 2. Subcommands

#### `/community-monitor` - Monitoring & Collection

`.claude/commands/community-monitor.md` :

```yaml
---
name: community-monitor
description: Monitor and collect messages from all channels
args:
  channels: Target channels to monitor
---

# Community Monitoring Subcommand

Collect all unread/unresponded messages from multiple channels.

## Agent 1: Social Monitor
Launch agent with prompt:
```
You are a Social-Monitor agent.

Task: Collect comments, DMs, and mentions from social platforms

Channels to monitor:
- Twitter: @mentions, DMs, post comments
- LinkedIn: Post comments, DMs
- Instagram: Post comments, DMs, story mentions
- Facebook: Page comments, Messenger

Use MCP tools:
- Twitter API MCP
- LinkedIn API MCP
- Instagram Graph API MCP
- Facebook Graph API MCP

For EACH channel:
1. Fetch unread messages (last 24 hours)
2. Fetch unanswered comments
3. Fetch @mentions
4. Fetch DMs

Extract:
- Message ID (for deduplication)
- Author (username, profile URL)
- Content (text, images, links)
- Platform and channel
- Timestamp
- Parent post context (if comment)
- Engagement (likes, replies on original message)

Output:
```json
{
  "social_messages": [
    {
      "id": "twitter_12345",
      "platform": "twitter",
      "type": "comment",
      "author": {
        "username": "user123",
        "profile_url": "...",
        "follower_count": 5000
      },
      "content": "How do I reset my password?",
      "timestamp": "2025-11-17T14:30:00Z",
      "parent_post": "...",
      "engagement": {
        "likes": 2,
        "replies": 0
      }
    }
    // ... all messages
  ],
  "total_collected": 150
}
```
```

## Agent 2: Email Monitor
Launch agent with prompt:
```
You are an Email-Monitor agent.

Task: Check support inboxes and extract unread emails

Inboxes to monitor:
- support@yourcompany.com
- hello@yourcompany.com
- contact@yourcompany.com

Use MCP tools:
- Gmail API MCP or IMAP MCP

For EACH inbox:
1. Fetch unread emails (last 24 hours)
2. Exclude spam folder
3. Skip automated emails (no-reply, notifications)

Extract:
- Email ID
- From (name, email address)
- Subject
- Body (plain text, first 500 chars if long)
- Attachments (if any)
- Timestamp
- Thread context (if reply)

Output:
```json
{
  "emails": [
    {
      "id": "email_abc123",
      "from": {
        "name": "John Doe",
        "email": "john@example.com"
      },
      "subject": "Feature request: Dark mode",
      "body": "Hi, I love your product but would really appreciate...",
      "attachments": [],
      "timestamp": "2025-11-17T10:15:00Z",
      "is_reply": false
    }
    // ... all emails
  ],
  "total_collected": 45
}
```
```

## Agent 3: Chat Monitor
Launch agent with prompt:
```
You are a Chat-Monitor agent.

Task: Fetch live chat messages from website

Chat platforms to monitor:
- Intercom
- Drift
- Zendesk Chat
- Custom chat widget

Use MCP tools:
- Intercom API MCP (or relevant chat platform)

Fetch:
1. Open conversations (not closed)
2. Unanswered messages
3. Messages from last 24 hours

Extract:
- Conversation ID
- User (name, email if provided)
- Messages (all in conversation)
- Timestamp of last message
- User context (page visited, referrer, location)

Output:
```json
{
  "chat_conversations": [
    {
      "id": "conv_xyz789",
      "user": {
        "name": "Jane Smith",
        "email": "jane@example.com"
      },
      "messages": [
        {
          "from": "user",
          "text": "Is there a free trial?",
          "timestamp": "2025-11-17T16:00:00Z"
        }
      ],
      "context": {
        "page": "/pricing",
        "referrer": "google",
        "location": "US"
      }
    }
    // ... all conversations
  ],
  "total_collected": 30
}
```
```

## Wait for All 3 Agents
Launch in parallel using `Task` tool.

Once complete, merge all messages into unified format.

## Output Format
```json
{
  "all_messages": [
    {
      "id": "unified_id_1",
      "source": "twitter",
      "type": "comment",
      "author": {...},
      "content": "...",
      "timestamp": "...",
      "context": {...}
    }
    // ... all messages from all channels
  ],
  "summary": {
    "total_messages": 225,
    "by_channel": {
      "twitter": 80,
      "linkedin": 20,
      "instagram": 50,
      "email": 45,
      "chat": 30
    }
  }
}
```
```

---

#### `/community-triage` - Triage & Classification

`.claude/commands/community-triage.md` :

```yaml
---
name: community-triage
description: Categorize and prioritize messages
args:
  messages: All collected messages
---

# Community Triage Subcommand

Classify messages by type and assign priority.

## Agent 1: Categorizer
Launch agent with prompt:
```
You are a Categorizer agent.

Task: Classify each message into categories

Input: {{messages}}

Categories:
1. **Support** - Technical issues, how-to questions, troubleshooting
2. **Sales** - Product inquiries, pricing questions, demo requests
3. **Feedback** - Feature requests, suggestions, product feedback
4. **Compliment** - Positive feedback, thank you messages
5. **Complaint** - Negative feedback, bugs, dissatisfaction
6. **Spam** - Irrelevant, promotional, phishing

For EACH message:
1. Analyze content
2. Identify intent
3. Assign primary category (and secondary if applicable)
4. Extract key entities (product names, features mentioned)

Use Skill:
- Support-Categories skill (common issue types)

Classification logic:
- Look for question marks → likely Support or Sales
- "How do I...", "Can you help..." → Support
- "How much...", "Pricing...", "Demo..." → Sales
- "I wish...", "It would be great if..." → Feedback
- "Love it!", "Thank you!", "Awesome!" → Compliment
- "Disappointed", "Not working", "Frustrating" → Complaint
- Unrelated links, generic spam → Spam

Output:
```json
{
  "categorized_messages": [
    {
      "id": "unified_id_1",
      "primary_category": "support",
      "secondary_category": null,
      "confidence": 0.95,
      "entities": {
        "product": "Dashboard",
        "feature": "export CSV",
        "issue_type": "not_working"
      },
      "keywords": ["export", "CSV", "not working"]
    }
    // ... all messages
  ]
}
```
```

## Agent 2: Prioritizer
Launch agent with prompt:
```
You are a Prioritizer agent.

Task: Assign urgency priority to each message

Input: {{categorized_messages}}

Priority levels:
- **P0 - Critical** (respond within 1 hour)
  - Service outage reports
  - Security issues
  - Payment failures
  - Very negative sentiment + high-value customer

- **P1 - High** (respond within 4 hours)
  - Product not working for user
  - Negative complaint
  - Sales inquiry from enterprise lead
  - Churn risk signals

- **P2 - Medium** (respond within 24 hours)
  - General support questions
  - Sales inquiries (SMB)
  - Feature requests
  - Positive feedback

- **P3 - Low** (respond within 48 hours)
  - General questions
  - Compliments
  - Non-urgent feedback

Prioritization factors:
1. **Sentiment** (negative = higher priority)
2. **Category** (Complaint > Support > Sales > Feedback > Compliment)
3. **Customer value** (enterprise > pro > free trial > not a customer)
4. **Time sensitivity** (payment issue > general question)
5. **Author influence** (high follower count on social = higher priority)

Use Skills:
- Customer-Context skill (check if customer, plan level, LTV)

Calculate complexity score (1-10):
- Simple FAQ → 2-3
- Standard support → 4-6
- Complex issue → 7-8
- Sensitive/legal → 9-10

Output:
```json
{
  "prioritized_messages": [
    {
      "id": "unified_id_1",
      "category": "support",
      "priority": "P1",
      "complexity_score": 5,
      "reasoning": "Product not working, negative sentiment, paying customer",
      "customer_context": {
        "is_customer": true,
        "plan": "pro",
        "ltv": 1200,
        "churn_risk": "low"
      },
      "recommended_action": "auto_respond_with_troubleshooting"
    }
    // ... all messages
  ]
}
```
```

## Wait for Both Agents
Launch in parallel.

Merge categorization + prioritization.

## Output Format
```json
{
  "triaged_messages": [
    {
      "id": "...",
      "content": "...",
      "category": "support",
      "priority": "P1",
      "complexity_score": 5,
      "sentiment": "negative",
      "customer_context": {...},
      "recommended_action": "auto_respond"
    }
  ],
  "summary": {
    "by_category": {
      "support": 100,
      "sales": 40,
      "feedback": 30,
      "complaint": 20,
      "compliment": 30,
      "spam": 5
    },
    "by_priority": {
      "P0": 2,
      "P1": 30,
      "P2": 150,
      "P3": 43
    }
  }
}
```
```

---

#### `/community-respond` - Response or Escalation

`.claude/commands/community-respond.md` :

```yaml
---
name: community-respond
description: Auto-respond or escalate to human
args:
  messages: Triaged messages
  mode: monitor or respond
  escalation_threshold: Complexity threshold for human escalation
---

# Community Response Subcommand

Conditional logic: Auto-respond vs Escalate.

## Conditional Branching

For EACH message:
```
IF complexity_score < escalation_threshold AND mode == "respond":
  → Route to AUTO-RESPOND agents
ELSE:
  → Route to ESCALATE agent (human-in-loop)
```

## AUTO-RESPOND Branch (Parallel agents)

### Agent 1: FAQ Responder
Launch agent with prompt:
```
You are an FAQ-Responder agent.

Task: Answer common questions with canned responses

Input: Messages where category == "support" OR "sales" AND complexity_score < 5

Use Skills:
- FAQ-Database skill (common questions + approved answers)
- Brand-Voice skill (friendly, helpful tone)

Matching logic:
1. Extract question from message
2. Match against FAQ database (semantic similarity)
3. If match confidence > 85% → use FAQ answer
4. Personalize response (use customer name, acknowledge specific context)
5. Add helpful links (docs, tutorials)

Response template:
```
Hi [Name],

Thanks for reaching out! [Acknowledge their question]

[FAQ Answer - personalized]

[Additional helpful resources]

Let me know if you have any other questions!

Best,
[Your Company] Team
```

Output:
```json
{
  "responses": [
    {
      "message_id": "...",
      "response_text": "Hi John, Thanks for reaching out! To reset your password...",
      "confidence": 0.92,
      "faq_matched": "password_reset",
      "links_included": ["https://docs.../reset-password"],
      "estimated_satisfaction": "high"
    }
  ]
}
```
```

### Agent 2: Support Responder
Launch agent with prompt:
```
You are a Support-Responder agent.

Task: Provide troubleshooting steps for technical issues

Input: Messages where category == "support" AND complexity_score 5-7

Use Skills:
- Troubleshooting-Guides skill (step-by-step fixes)
- Product-Knowledge skill (features, limitations, bugs)

Response structure:
```
Hi [Name],

I understand you're experiencing [issue]. Let's get this resolved!

Here's what to try:

1. [Step 1]
2. [Step 2]
3. [Step 3]

If that doesn't work:
- [Alternative solution]
- [Link to detailed guide]

Still stuck? Reply here and I'll escalate to our technical team.

Best,
[Your Company] Support
```

Include:
- Clear step-by-step instructions
- Screenshots/GIFs if available
- Escalation path if solution doesn't work

Output: [Same JSON structure as FAQ Responder]
```

### Agent 3: Sales Responder
Launch agent with prompt:
```
You are a Sales-Responder agent.

Task: Answer product inquiries and provide information

Input: Messages where category == "sales" AND complexity_score < 7

Use Skills:
- Product-Info skill (features, pricing, plans)
- Sales-Playbook skill (objection handling, demos)

Response types:
1. **Pricing inquiry**:
   ```
   Hi [Name],

   Great question! Here's our pricing:

   [Pricing tiers with key features]

   [Link to full pricing page]

   Want to see it in action? [Book demo link]
   ```

2. **Feature inquiry**:
   ```
   Hi [Name],

   Yes, we support [feature]! Here's how it works:

   [Brief explanation]

   [Use case examples]

   [Link to feature demo/docs]

   Want to try it? [Free trial CTA]
   ```

3. **Demo request**:
   ```
   Hi [Name],

   I'd love to show you a demo!

   [Calendar link to book time]

   Or check out our self-guided product tour: [link]
   ```

Output: [Same JSON structure]
```

---

## ESCALATE Branch (Human-in-Loop)

### Agent: Escalator
Launch agent with prompt:
```
You are an Escalator agent.

Task: Prepare escalation for human review

Input: Messages where complexity_score >= escalation_threshold OR very_negative_sentiment

For EACH message to escalate:

1. **Create ticket** in support system (Zendesk, Intercom, Linear)
2. **Summarize context**:
   - Customer info (name, plan, LTV)
   - Issue summary
   - Sentiment analysis
   - Why escalated (complexity, sentiment, VIP customer)
3. **Suggest response** (draft for human to review/edit)
4. **Notify human** (Slack, email)
5. **Track** (SLA timer starts)

Escalation reasons:
- Complexity score >= {{escalation_threshold}}
- Very negative sentiment (angry, threatening)
- Legal/compliance questions
- Request for refund/cancellation
- Bug reports (need engineering team)
- Custom/enterprise requests
- VIP customer (high LTV)

Notification format (Slack):
```
🚨 **P1 Escalation** 🚨

Customer: John Doe (@johndoe on Twitter)
Plan: Enterprise ($5K/mo LTV)
Issue: [Summary]
Sentiment: 😡 Very Negative
Complexity: 8/10

Message:
> [Original message]

Suggested response:
> [Draft response]

[Take ownership button] [View full context]
```

Output:
```json
{
  "escalations": [
    {
      "message_id": "...",
      "ticket_id": "TICKET-12345",
      "assigned_to": "human_agent_slack_id",
      "notification_sent": true,
      "suggested_response": "Hi John, I'm so sorry to hear...",
      "sla_deadline": "2025-11-17T18:00:00Z",
      "escalation_reason": "VIP customer + very negative sentiment"
    }
  ]
}
```
```

---

## Wait for Conditional Completion
- Auto-respond agents run in parallel (for applicable messages)
- Escalator agent runs separately (for escalated messages)

## Hook: Response Quality Check

After all responses generated, run validation:

```bash
# Hook: response-quality.sh
# Check grammar, tone, links, sensitive info

for response in responses:
  - Grammar check (LanguageTool API)
  - Tone analysis (professional + friendly)
  - Link validation (all links work)
  - Sensitive info check (no API keys, passwords, internal info)
  - If fails → regenerate or escalate
```

## Output Format
```json
{
  "auto_responses": {
    "total": 140,
    "faq": 60,
    "support": 50,
    "sales": 30,
    "sent": 140,
    "failed": 0
  },
  "escalations": {
    "total": 60,
    "P0": 2,
    "P1": 25,
    "P2": 33,
    "notifications_sent": 60,
    "avg_response_time_target": "4 hours"
  },
  "summary": {
    "total_processed": 200,
    "auto_resolve_rate": 0.70,
    "escalation_rate": 0.30,
    "estimated_time_saved": "6.5 hours"
  }
}
```
```

---

## 🛠️ Skills Requis

### 1. FAQ-Database Skill

`.claude/skills/faq-database.md` :

```markdown
# FAQ Database Skill

Common questions and approved answers.

## Account & Billing

**Q**: How do I reset my password?
**A**: Click "Forgot Password" on login page → Enter email → Check inbox for reset link → Create new password.
**Links**: [Password Reset Guide](https://docs.../reset)

**Q**: How do I upgrade my plan?
**A**: Go to Settings → Billing → Choose plan → Confirm. Changes take effect immediately.
**Links**: [Upgrade Guide](https://docs.../upgrade)

**Q**: Can I get a refund?
**A**: Yes! We offer 30-day money-back guarantee. Email support@company.com with your account details.
**Links**: [Refund Policy](https://company.com/refund-policy)

## Technical Support

**Q**: Why isn't [feature] working?
**A**: Try these steps:
1. Clear browser cache
2. Logout and login
3. Try different browser
If still not working, reply with browser version and screenshot.
**Links**: [Troubleshooting Guide](https://docs.../troubleshooting)

## Product Features

**Q**: Do you support [integration]?
**A**: Check our integrations page: [link]. If not listed, submit feature request at [link].

## Sales

**Q**: Is there a free trial?
**A**: Yes! 14-day free trial, no credit card required. Start here: [signup link]

**Q**: What's included in [plan]?
**A**: [Plan] includes:
- Feature 1
- Feature 2
- Feature 3
Compare all plans: [pricing page]
```

### 2. Customer-Context Skill

`.claude/skills/customer-context.md` :

```markdown
# Customer Context Skill

Check customer information for personalized responses.

## Customer Lookup
Use CRM/database to fetch:
- Name, email
- Current plan (free, pro, enterprise)
- Account status (active, trial, cancelled)
- Lifetime value (LTV)
- Sign-up date (tenure)
- Usage level (active, inactive)
- Past support tickets
- Churn risk score

## Context for Prioritization

### VIP Customers (high priority)
- Enterprise plan
- LTV > $5,000
- Influencer/public figure
- At-risk of churning

### Standard Customers (medium priority)
- Pro plan
- Active usage
- Paying for 3+ months

### Trial/Free (lower priority, but still important)
- Free plan
- Trial period
- Recently signed up

## Personalization

Use context to personalize response:
- Thank long-term customers ("Thanks for being with us for 2 years!")
- Acknowledge plan level ("As a Pro customer, you have access to...")
- Reference past interactions ("I see you contacted us about X last month...")
```

---

## 🪝 Hooks Implémentés

### 1. Spam Filter Hook

`.claude/hooks/spam-filter.sh` :

```bash
#!/bin/bash
# Hook: Filter spam before processing

MESSAGES_FILE="$1"

echo "🪝 Running Spam Filter..."

FILTERED=0

# Parse messages JSON
MESSAGES=$(jq -c '.all_messages[]' "$MESSAGES_FILE")

FILTERED_MESSAGES=()

while IFS= read -r MESSAGE; do
  CONTENT=$(echo "$MESSAGE" | jq -r '.content')
  AUTHOR=$(echo "$MESSAGE" | jq -r '.author.username')

  SPAM=false

  # Check for spam keywords
  SPAM_KEYWORDS=("buy now" "click here" "limited time" "get rich" "free money" "viagra")
  for KEYWORD in "${SPAM_KEYWORDS[@]}"; do
    if echo "$CONTENT" | grep -qi "$KEYWORD"; then
      SPAM=true
      echo "🚫 Spam detected (keyword: $KEYWORD): $CONTENT"
      ((FILTERED++))
      break
    fi
  done

  # Check for excessive links (>3 links = likely spam)
  LINK_COUNT=$(echo "$CONTENT" | grep -o 'http' | wc -l)
  if (( LINK_COUNT > 3 )); then
    SPAM=true
    echo "🚫 Spam detected (excessive links): $CONTENT"
    ((FILTERED++))
  fi

  # Check for known spam accounts (maintain blocklist)
  BLOCKLIST=("spammer123" "bot_account" "phishing_user")
  for BLOCKED in "${BLOCKLIST[@]}"; do
    if [[ "$AUTHOR" == "$BLOCKED" ]]; then
      SPAM=true
      echo "🚫 Blocked user: $AUTHOR"
      ((FILTERED++))
      break
    fi
  done

  if [[ "$SPAM" == false ]]; then
    FILTERED_MESSAGES+=("$MESSAGE")
  fi

done <<< "$MESSAGES"

# Write filtered messages back
jq -n --argjson msgs "$(printf '%s\n' "${FILTERED_MESSAGES[@]}" | jq -s .)" \
  '{all_messages: $msgs, filtered_count: '$(($FILTERED))'}' > "$MESSAGES_FILE.filtered"

echo "✅ Spam filter complete. Filtered $FILTERED spam messages."
exit 0
```

### 2. Sentiment Check Hook

`.claude/hooks/sentiment-check.sh` :

```bash
#!/bin/bash
# Hook: Analyze sentiment and flag negative messages

TRIAGED_FILE="$1"

echo "🪝 Running Sentiment Check..."

# Parse triaged messages
MESSAGES=$(jq -c '.triaged_messages[]' "$TRIAGED_FILE")

FLAGGED=0

while IFS= read -r MESSAGE; do
  SENTIMENT=$(echo "$MESSAGE" | jq -r '.sentiment')
  PRIORITY=$(echo "$MESSAGE" | jq -r '.priority')
  CONTENT=$(echo "$MESSAGE" | jq -r '.content')

  # Flag very negative sentiment
  if [[ "$SENTIMENT" == "very_negative" ]]; then
    echo "🚨 Very negative sentiment detected:"
    echo "   Content: $CONTENT"
    echo "   Priority: $PRIORITY → upgrading to P1"
    ((FLAGGED++))

    # Upgrade priority if not already P0/P1
    if [[ "$PRIORITY" != "P0" && "$PRIORITY" != "P1" ]]; then
      # Update priority in JSON (escalate to P1)
      # (In production, update the JSON file)
      echo "   Action: Escalating to P1 for immediate human review"
    fi
  fi

done <<< "$MESSAGES"

echo "✅ Sentiment check complete. Flagged $FLAGGED very negative messages."
exit 0
```

---

## 🔌 MCP Servers Utilisés

### 1. Social Media APIs MCP

```json
{
  "mcpServers": {
    "social-monitoring": {
      "command": "npx",
      "args": ["-y", "@social/mcp-monitoring"],
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

### 2. Support Ticket System MCP

```json
{
  "mcpServers": {
    "zendesk": {
      "command": "npx",
      "args": ["-y", "@zendesk/mcp-server"],
      "env": {
        "ZENDESK_DOMAIN": "yourcompany.zendesk.com",
        "ZENDESK_API_KEY": "from-1password"
      }
    }
  }
}
```

### 3. Communication MCP (Slack notifications)

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@slack/mcp-server"],
      "env": {
        "SLACK_BOT_TOKEN": "from-1password",
        "SLACK_CHANNEL_ID": "#community-escalations"
      }
    }
  }
}
```

---

## 📊 Benchmarks & ROI

### Avant Claude Code (Manuel)

```
Community manager manuel:
  ├─ 200 messages/jour × 2.5min = 8.3 heures/jour
  ├─ Salaire: $4,000/mois (temps plein)
  ├─ Disponibilité: 9am-5pm (8 heures/jour)
  ├─ Temps de réponse moyen: 2-4 heures
  └─ Burnout risk: High (répétitif)

─────────────────────────────────
TOTAL:                      $4,000/mois + 8.3h/jour
```

### Avec Claude Code (Automatisé)

```
Monitoring:                 5 minutes (automated 24/7)
Triage & Classification:    10 minutes (automated)
Auto-Responses (70%):       15 minutes (140 messages)
Human Escalation (30%):     1.5 hours (60 messages reviewed)

─────────────────────────────────
TOTAL par jour:             2 heures (vs 8.3 heures)
Par mois:                   60 heures (vs 249 heures)
Coût API:                   ~$150/mois
Coût humain (2h/jour):      ~$1,000/mois (part-time)

TOTAL:                      $1,150/mois (vs $4,000)
```

### ROI Détaillé

```
┌────────────────────────────────────────────────┐
│  Métrique           Manuel      Automatisé     │
├────────────────────────────────────────────────┤
│  Temps/jour         8.3h        2h             │
│  Coût/mois          $4,000      $1,150         │
│  Messages/jour      200         200            │
│  Auto-resolve%      0%          70%            │
│  Avg response time  2-4h        <30min (auto)  │
│  24/7 coverage      No          Yes            │
│  Sentiment tracking No          Yes            │
│  Burnout risk       High        Low            │
└────────────────────────────────────────────────┘

Gains:
✅ 76% réduction temps (8.3h → 2h par jour)
✅ 71% réduction coûts ($4,000 → $1,150/mois)
✅ 70% auto-resolution (FAQ, support commun, sales simple)
✅ <30min response time pour 70% des messages
✅ 24/7 monitoring (jamais offline)
✅ Sentiment tracking automatique
✅ Human focus sur 30% complexe/high-value
```

---

## 🚀 Quick Start

```bash
# Installation
mkdir -p .claude/commands/community
mkdir -p .claude/skills
mkdir -p .claude/hooks

# [Créer tous les fichiers .md et .sh listés ci-dessus]

# Configuration MCP
# [Ajouter social-monitoring, zendesk, slack dans config.json]

# Test du workflow
claude
/community-manage all respond 7

# Résultat attendu:
# - 200 messages collectés
# - 5 spam filtrés
# - 195 triaged (100 support, 40 sales, 30 feedback, 20 complaints, 5 compliments)
# - 140 auto-responded (70%)
# - 60 escalated to human (30%)
# Total: 2 hours (vs 8.3 hours manual)
```

---

## 🎓 Points Clés

### Architecture
✅ Multi-channel monitoring (social, email, chat)
✅ Intelligent triage avec complexity scoring
✅ Conditional logic (auto-respond vs escalate)
✅ Human-in-loop pour messages complexes/sensibles

### Automation
✅ 76% réduction temps (8.3h → 2h/jour)
✅ 70% auto-resolution rate
✅ <30min response time (automated)
✅ 24/7 monitoring sans human

### Intelligence
✅ Sentiment analysis automatique
✅ Priority escalation basée sur context
✅ Customer context integration (CRM data)
✅ Continuous learning (update FAQ from escalations)

---

## 📚 Ressources

### Documentation
- 📄 [Community Management Best Practices](https://www.zendesk.com/blog/community-management/)
- 📄 [Customer Support Automation](https://www.intercom.com/blog/customer-support-automation/)

### Workflows Associés
- 🔗 [Social Media Automation](./social-media-automation-startup.md) - Posting workflow
- 🔗 [Blog Automation](./blog-automation-startup.md) - Content creation

---

**Prochaine étape** : [Content Repurposing Pipeline →](./content-repurposing-startup.md)
