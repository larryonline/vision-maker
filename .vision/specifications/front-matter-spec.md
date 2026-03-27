---
description: "文档 front-matter 的完整规范：7 个字段定义、4 种文档类型、3 种关系类型、路径规范和双向一致性规则。"
type: reference
concepts: [front-matter, description, type, concepts, depends_on, children, referenced_by, last_verified, 文档类型, 双向一致性]
depends_on:
  - VISION.md
children: []
referenced_by:
  - skill-design/design-decisions.md
  - specifications/directory-structure.md
last_verified: 2026-03-27
---

# 文档 Front-matter 规范

## 完整字段

```yaml
---
description: "一两句话摘要（< 100 tokens）"
type: explanation | reference | guide | context
concepts: [核心概念标签列表]
depends_on: [前置知识文档路径]
children: [更细粒度文档路径]
referenced_by: [横向关联文档路径]
last_verified: 2026-03-26
---
```

| 字段 | 必须 | 用途 |
|------|:----:|------|
| `description` | 是 | Tier 1 发现层，供 grep 快速定位 |
| `type` | 是 | 文档分类，决定写作风格 |
| `concepts` | 是 | 核心概念标签，用于概念定位和变更影响分析 |
| `depends_on` | 否 | 知识前置依赖（向上） |
| `children` | 否 | 细粒度展开（向下） |
| `referenced_by` | 否 | 非上下级的概念关联（横向） |
| `last_verified` | 是 | 最后验证日期，供时效性检查 |

## 文档类型（Diataxis 框架）

| 类型 | 语义 | 写作风格 |
|------|------|---------|
| `explanation` | 解释概念和原因（为什么） | 叙述性，注重上下文和动机 |
| `reference` | 精确的事实查阅（是什么） | 结构化，注重准确和完整 |
| `guide` | 完成特定任务的步骤（怎么做） | 步骤化，注重可操作性 |
| `context` | 智能体专用的任务上下文 | 精炼，面向机器消费 |

## 路径规范

所有路径均为**相对于 `.vision/` 目录的相对路径**。

## 双向一致性规则

- A 的 `children` 含 B → B 的 `depends_on` 必须含 A
- A 的 `depends_on` 含 B → B 的 `children` 必须含 A
- A 的 `referenced_by` 含 B → B 的 `referenced_by` 必须含 A

## 写作指南

**description**：< 100 tokens，不打开文档就能判断相关性，包含关键概念词。

**concepts**：使用 knowledge.md 中定义的术语，保持跨文档一致性，粒度适中。

完整规范参见 Skill 的 `references/front-matter-spec.md`。
