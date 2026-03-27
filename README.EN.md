# Vision Maker

[中文](./README.md)

**A cognitive framework for building, navigating, maintaining, and reviewing documentation systems for any software project.**

Vision Maker is an AgentSkill following the [Agent Skills open specification](https://github.com/anthropics/agent-skills). It is not a template generator — it is a complete cognitive methodology that builds high-quality documentation systems for projects through human-agent dialogue.

## Core Philosophy

Traditional documentation suffers from four key problems: scattered content without a coherent system, divergence from code leading to static decay, poor consumability by AI agents, and difficulty for developers to navigate knowledge quickly. Vision Maker addresses these systematically through its three-pillar architecture: **Cognitive Framework = Mental Model + Methodology + Project Meta-Knowledge**.

## Operating Modes

| Mode | Example Trigger Keywords | Core Responsibility |
|------|------------------------|-------------------|
| **INIT** | "initialize docs", "build .vision", "use vision-maker to initialize" | Collect project meta-knowledge, establish documentation system, configure automated integration |
| **BRIEF** | "get knowledge about XX", "find XX in .vision", "understand the project" | Expose complete knowledge chains based on task requirements, fill knowledge gaps on demand |
| **AUDIT** | "review doc quality", "check consistency", "audit .vision" | Evaluate documentation quality across accuracy, completeness, consistency and other dimensions |

> Documentation operations (create/modify/delete/reorganize) are handled by task specifications defined in `references/doc-tasks.md`, not as independent modes. Modes are cognitive frameworks (how to think), task specifications are execution guides (how to act).

## Getting Started

### 1. Installation

Clone this project to your Agent Skills directory:

```bash
git clone https://github.com/larryonline/vision-maker.git
```

### 2. Load in Your Agent

Vision Maker can be loaded and executed by multiple agent products:

- **Claude Code** — Integrated via `.claude/` configuration
- **Gemini CLI** — Loaded via Agent Skills specification
- **Cursor** — Integrated via corresponding configuration

### 3. Initialize Documentation System

In your target project, invoke Vision Maker's INIT mode through your agent:

```
Please use vision-maker to build a documentation system for the current project
```

The Skill will collect project meta-knowledge (industry, domain, concept taxonomy, etc.) through dialogue, and generate a `.vision/` documentation system in the project root.

## Output Structure

```
your-project/
└── .vision/
    ├── .meta/
    │   ├── knowledge.md        # Project meta-knowledge (industry/domain/concepts)
    │   └── user.local.md       # User profile (not version-controlled)
    ├── VISION.md               # Documentation system root node
    ├── architecture/           # Architecture documentation
    ├── guides/                 # How-to guides
    └── ...                     # Semantically organized directories per project needs
```

## Key Design Decisions

### Documents as a Graph

Each document self-describes its relationships through `depends_on` / `children` / `referenced_by` fields in YAML front-matter, forming a directed graph — no global index required.

```yaml
---
description: "Concise summary (< 100 tokens)"
type: explanation | reference | guide | context
concepts: [core concept tags]
depends_on: [prerequisite knowledge paths]
children: [fine-grained document paths]
---
```

### Three-Tier Loading Protocol

| Tier | Content | Purpose |
|------|---------|---------|
| Tier 1 — Discovery | description + concepts | Concept positioning; decide whether to load further |
| Tier 2 — Loading | Document body (< 5000 tokens) | Acquire core knowledge |
| Tier 3 — Deep Dive | Attached resources (diagrams, schemas, etc.) | On-demand when detailed information is needed |

### User Adaptation

The Skill dynamically adapts to 7 cognitive traits (limited knowledge scope, scattered thinking, limited methodology, limited memory, decision fatigue, anchoring bias, domain expert ≠ documentation expert), ensuring effective collaboration regardless of user background.

### Project Configuration Self-Check

Before any mode starts, `scripts/validate.sh` automatically checks project configuration to ensure the `.vision/` documentation system stays in sync with code.

## Project Structure

```
vision-maker/
├── SKILL.md                        # AgentSkill main entry point
├── references/                     # Detailed reference guides for each mode
│   ├── init-mode.md                # INIT mode workflow
│   ├── brief-mode.md               # BRIEF mode workflow
│   ├── audit-mode.md               # AUDIT mode workflow (includes doc maintenance)
│   ├── doc-tasks.md                # Documentation task specifications
│   ├── doc-methodology.md          # Documentation methodology
│   ├── knowledge-acquisition.md    # Meta-knowledge acquisition guide
│   └── front-matter-spec.md        # Front-matter specification
├── assets/templates/               # Document templates
│   ├── document-template.md        # General document template
│   ├── knowledge-template.md       # Meta-knowledge template
│   ├── vision-template.md          # VISION.md template
│   ├── user-local-template.md      # User profile template
│   └── integration-template.md     # Integration template
├── scripts/
│   └── validate.sh                 # Project configuration validation script
└── .vision/                        # Skill's own documentation system (dogfood)
```

## Technical Highlights

- **Zero code dependencies** — Pure Markdown + YAML, technology-stack agnostic
- **Self-documenting** — Vision Maker uses its own methodology to build its documentation system
- **Open specification** — Follows the Agent Skills open specification, usable across agent platforms

## License

Please refer to the license information in the project repository.
