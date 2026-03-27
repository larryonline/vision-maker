# Vision Maker

[中文](./README.md)

**A cognitive framework for building, navigating, maintaining, and reviewing documentation systems for any software project.**

Vision Maker is an AgentSkill following the [Agent Skills open specification](https://github.com/anthropics/agent-skills). It is not a template generator — it is a complete cognitive methodology that builds high-quality documentation systems for projects through human-agent dialogue.

## Core Philosophy

Traditional documentation suffers from four key problems: scattered content without a coherent system, divergence from code leading to static decay, poor consumability by AI agents, and difficulty for developers to navigate knowledge quickly. Vision Maker addresses these systematically through its three-pillar architecture: **Cognitive Framework = Mental Model + Methodology + Project Meta-Knowledge**.

## Four Operating Modes

| Mode | Trigger | Core Responsibility |
|------|---------|-------------------|
| **INIT** | New project / new module / meta-knowledge update | Collect project information, establish `.vision/` documentation system |
| **BRIEF** | Development / debugging / review requiring project understanding | Assemble and expose complete knowledge chains based on task requirements |
| **MAINTAIN** | After project content changes | Detect change impact scope, synchronize documentation |
| **REVIEW** | Periodic or on-demand review | Multi-dimensional documentation quality review with improvement suggestions |

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

## Project Structure

```
vision-maker/
├── SKILL.md                    # AgentSkill main entry point
├── references/                 # Detailed reference guides for each mode
│   ├── init-mode.md
│   ├── brief-mode.md
│   ├── maintain-mode.md
│   ├── review-mode.md
│   ├── front-matter-spec.md
│   └── user-adaptation.md
├── assets/templates/           # Document templates
│   ├── document-template.md
│   ├── knowledge-template.md
│   ├── vision-template.md
│   └── user-local-template.md
└── .vision/                    # Skill's own documentation system (dogfood)
```

## Technical Highlights

- **Zero code dependencies** — Pure Markdown + YAML, technology-stack agnostic
- **Self-documenting** — Vision Maker uses its own methodology to build its documentation system
- **Open specification** — Follows the Agent Skills open specification, usable across agent platforms

## License

Please refer to the license information in the project repository.
