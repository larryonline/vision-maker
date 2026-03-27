---
description: ".vision/ 目录结构规范 — 层级定义、命名约定、版本控制策略"
type: reference
concepts: [directory-structure, semantic-layers, naming-convention, version-control]
depends_on: [../VISION.md]
children: [front-matter-spec.md, three-tier-protocol.md]
referenced_by: [../VISION.md]
last_verified: 2026-03-27
---

# 目录结构规范

## 顶层结构

```
.vision/
├── .meta/                          # 元信息层
│   ├── knowledge.md                # 项目元知识（纳入版本控制）
│   ├── integration.md              # 自动化集成配置
│   └── user.local.md               # 用户个人画像（不纳入版本控制）
├── VISION.md                       # 项目顶层文档（文档图根节点）
└── <layer-name>/                   # 语义化层级目录（由元知识定义）
    ├── <topic>.md
    ├── adr/                        # 架构决策记录
    └── <topic>/
        ├── <document>.md
        └── references/             # 附属资源（Tier 3）
```

## 设计原则

- **层级目录名称由 knowledge.md 中的文档粒度定义决定**，必须具有语义
- **版本控制**：`.vision/.meta/*.local.md` 应加入 `.gitignore`
- **目录命名**：使用小写 + 连字符（如 `auth-system/`）
- **嵌套深度**：建议不超过 3 层

## .meta/ 层

| 文件 | 职责 | 版本控制 |
|------|------|---------|
| knowledge.md | 项目元知识 — 行业、领域、概念体系、文档粒度 | 纳入 |
| integration.md | 自动化集成配置 — hooks、CI、自定义检测规则 | 纳入 |
| user.local.md | 用户画像 — 知识面、沟通偏好、交互记录 | 不纳入 |

## VISION.md

文档图的根节点。所有文档的关系最终都直接或间接指向 VISION.md。

功能：
- 项目概述（是什么、为什么存在、目标与成功标准）
- 核心概念列表
- 文档体系导览（各层目录的职责和消费者）
- 使用指南

## 语义化层级目录

层级目录的名称和职责由 knowledge.md 中的"文档粒度定义"决定。

每个层级应：
- 有明确的语义（如 `architecture/`、`modules/`、`specifications/`）
- 有明确的消费者（面向谁）
- 有明确的认知目标（读者看完应该理解什么）

## ADR 目录

各层级下可包含 `adr/` 目录存放架构决策记录。

命名规范：`NNN-decision-title.md`（如 `001-use-markdown-as-format.md`）
