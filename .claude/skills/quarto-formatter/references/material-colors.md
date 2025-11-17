# Material Design 3 Color Palette

## Primary Colors

### Indigo (Primary)
- **Hex**: #6366F1
- **RGB**: rgb(99, 102, 241)
- **Usage**: Primary actions, main elements, headers

### Pink (Secondary)
- **Hex**: #EC4899
- **RGB**: rgb(236, 72, 153)
- **Usage**: Secondary actions, accents, highlights

### Green (Success/Accent)
- **Hex**: #10B981
- **RGB**: rgb(16, 185, 129)
- **Usage**: Success states, confirmations, positive actions

### Amber (Warning)
- **Hex**: #F59E0B
- **RGB**: rgb(245, 158, 11)
- **Usage**: Warnings, caution states, pending actions

### Red (Error)
- **Hex**: #EF4444
- **RGB**: rgb(239, 68, 68)
- **Usage**: Errors, destructive actions, critical states

### Blue (Info)
- **Hex**: #3B82F6
- **RGB**: rgb(59, 130, 246)
- **Usage**: Information, help states, neutral actions

## Gradients

### Primary Gradient
```css
linear-gradient(135deg, #667eea 0%, #764ba2 100%)
```

### Secondary Gradient
```css
linear-gradient(135deg, #f093fb 0%, #f5576c 100%)
```

### Accent Gradient
```css
linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)
```

## Mermaid Color Classes

Use these in Mermaid diagrams:

```mermaid
classDef primaryClass fill:#6366F1,stroke:#6366F1,stroke-width:2px,color:#fff
classDef secondaryClass fill:#EC4899,stroke:#EC4899,stroke-width:2px,color:#fff
classDef accentClass fill:#10B981,stroke:#10B981,stroke-width:2px,color:#fff
classDef warningClass fill:#F59E0B,stroke:#F59E0B,stroke-width:2px,color:#fff
classDef errorClass fill:#EF4444,stroke:#EF4444,stroke-width:2px,color:#fff
classDef infoClass fill:#3B82F6,stroke:#3B82F6,stroke-width:2px,color:#fff
```

## Semantic Usage

| State | Color | When to Use |
|-------|-------|-------------|
| **Success** | Green #10B981 | Successful operations, confirmations |
| **Warning** | Amber #F59E0B | Warnings, deprecations, caution |
| **Error** | Red #EF4444 | Errors, failures, destructive actions |
| **Info** | Blue #3B82F6 | Information, tips, neutral messages |
| **Primary** | Indigo #6366F1 | Main actions, important elements |
| **Secondary** | Pink #EC4899 | Alternative actions, highlights |

## Accessibility

All colors meet WCAG 2.1 Level AA contrast requirements when used with white text.

- Primary on white: 4.5:1 ✅
- Success on white: 3.5:1 ⚠️ (use with caution)
- Warning on white: 3.0:1 ⚠️ (use with caution)
- Error on white: 4.5:1 ✅
