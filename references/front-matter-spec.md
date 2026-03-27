# 文档 Front-matter 规范

## 完整字段定义

每份 `.vision/` 文档（除 `.meta/knowledge.md` 和 `.meta/user.local.md` 外）遵循以下 front-matter 规范：

```yaml
---
description: "用一两句话摘要本文档的内容和用途（< 100 tokens）"
type: explanation | reference | guide | context
concepts: [本文档涉及的核心概念列表]
depends_on:
  - path/to/prerequisite-doc.md
children:
  - path/to/more-detailed-doc.md
referenced_by:
  - path/to/related-doc.md
last_verified: 2026-03-26
---
```

## 字段说明

| 字段 | 必须 | 用途 |
|------|:----:|------|
| `description` | 是 | Tier 1 发现层：轻量摘要，供 grep 快速定位。应能让读者不打开文档就判断是否与当前任务相关。 |
| `type` | 是 | 文档分类。决定文档的结构和写作风格。 |
| `concepts` | 是 | 核心概念标签列表。用于 BRIEF 模式的概念定位和 MAINTAIN 模式的变更影响分析。 |
| `depends_on` | 否 | 知识的上下级关系（向上）。列出理解本文档需要的前置知识文档。 |
| `children` | 否 | 知识的上下级关系（向下）。列出本文档展开的更细粒度文档。 |
| `referenced_by` | 否 | 引用关系（横向）。列出非上下级但存在概念关联的文档。 |
| `last_verified` | 是 | 最后验证日期（YYYY-MM-DD）。供 REVIEW 模式的时效性检查。 |

## 文档类型（type）

借鉴 Diataxis 框架：

| 类型 | 语义 | 写作风格 | 示例 |
|------|------|---------|------|
| `explanation` | 解释概念和原因（为什么） | 叙述性，注重上下文和动机 | 架构决策记录、设计理由 |
| `reference` | 精确的事实查阅（是什么） | 结构化，注重准确和完整 | API 定义、数据模型、配置项 |
| `guide` | 完成特定任务的步骤（怎么做） | 步骤化，注重可操作性 | 本地环境搭建、部署流程 |
| `context` | 智能体专用的任务上下文 | 精炼，面向机器消费 | BRIEF 模式组装的上下文包 |

## 三种关系类型

```
         depends_on（向上）
              ↑
              │
referenced_by ←── 当前文档 ──→ referenced_by（横向）
              │
              ↓
         children（向下）
```

| 关系 | 方向 | 语义 | 使用场景 |
|------|------|------|---------|
| `depends_on` | 向上 | 理解本文档的前置知识 | BRIEF 上溯加载完整知识链 |
| `children` | 向下 | 本文档展开的更细粒度内容 | 自顶向下遍历、影响面分析 |
| `referenced_by` | 横向 | 非上下级的概念关联 | 补充关联知识、影响面扩散 |

### 路径规范

所有路径均为**相对于 `.vision/` 目录的相对路径**。

```yaml
# 正确
depends_on:
  - VISION.md
  - architecture/system-overview.md

# 错误 — 不使用绝对路径或相对于项目根的路径
depends_on:
  - .vision/architecture/system-overview.md
  - /Users/xxx/.vision/architecture/system-overview.md
```

### 双向一致性

关系字段必须保持双向一致：

- A 的 `children` 含 B → B 的 `depends_on` 必须含 A
- A 的 `depends_on` 含 B → B 的 `children` 必须含 A
- `referenced_by` 是双向的：A 的 `referenced_by` 含 B → B 的 `referenced_by` 必须含 A

MAINTAIN 模式在执行修正时校验，REVIEW 模式在评审时检测。

## description 写作指南

好的 description 应满足：
- < 100 tokens
- 不打开文档就能判断相关性
- 包含关键概念词（与 concepts 字段呼应）

```yaml
# 好
description: "用户认证模块的会话生命周期管理，包括创建、刷新、过期和撤销机制"

# 差 — 太模糊
description: "认证相关的文档"

# 差 — 太长，把正文内容搬到了 description
description: "本文档详细描述了用户认证模块中会话的完整生命周期，从用户首次登录时..."
```

## concepts 标签指南

- 使用 `knowledge.md` 中"领域概念体系"定义的术语
- 保持一致性：同一概念在所有文档中使用相同标签
- 粒度适中：太粗（如 `backend`）则匹配过多，太细（如 `jwt-token-refresh-on-tuesday`）则难以匹配

```yaml
# 好
concepts: [authentication, session, token-refresh]

# 差 — 太粗
concepts: [backend]

# 差 — 不一致（有的文档用 auth，有的用 authentication）
concepts: [auth, session]
```
