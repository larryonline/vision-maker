---
description: "三级加载协议 — 如何通过 Tier 1/2/3 控制智能体的上下文开销"
type: reference
concepts: [three-tier-loading, context-window, token-budget, tier-protocol]
depends_on: [directory-structure.md]
children: []
referenced_by: [directory-structure.md]
last_verified: 2026-03-27
---

# 三级加载协议

## 设计目标

控制智能体在消费文档时的上下文开销，避免超出 token 限制。

## 两级加载粒度

### 文档内部的三级加载

| 层级 | 内容 | 上下文开销 | 用途 |
|------|------|-----------|------|
| **Tier 1 — 发现** | front-matter 的 description + concepts | 每文档 ~1-2 行 | 概念定位，决定是否继续加载 |
| **Tier 2 — 加载** | 文档正文 | < 5000 tokens | 获取核心知识 |
| **Tier 3 — 深入** | 正文引用的附属资源（图表、schema 等） | 按需 | 需要详细信息时按需加载 |

### SKILL.md 内部的三级加载

| 层级 | 内容 | 位置 |
|------|------|------|
| Tier 1 | 模式概览 + 触发关键词 | SKILL.md description |
| Tier 2 | 模式路由 + 响应协议摘要 + 自检流程 + doc-tasks 路由入口 | SKILL.md body（< 500 行） |
| Tier 3 | 模式详细流程、方法论、任务规格 | references/ 或 项目文件 |

## 加载策略

### 发现阶段（Tier 1）

智能体扫描所有文档的 front-matter，通过 description 和 concepts 识别与当前任务相关的文档。

成本极低 — 每文档仅需 ~1-2 行。

### 加载阶段（Tier 2）

加载被识别为相关的文档正文。正文应控制在 < 5000 tokens 以内。

### 深入阶段（Tier 3）

当正文信息不够时，按需加载附属资源（如图表、schema、详细流程图）。

附属资源放在文档同目录下的 references/ 子目录。

## 深度限制

- **BRIEF 模式**：文档间的关系遍历不设深度限制。沿 depends_on 完整上溯获取知识链，加载范围由任务需求决定。
- **INIT / AUDIT 模式**：按需加载，由模式的响应协议控制。

## Token 预算

| 文档部位 | 建议大小 | 说明 |
|---------|---------|------|
| front-matter | 10-20 行 | 元数据和关系 |
| description | < 100 tokens | 一两句话摘要 |
| 正文 | < 5000 tokens | 核心内容 |
| 附属资源 | 按需 | 图表、schema 等，放在 Tier 3 |

## 拆分策略

当文档超过 token 预算时：
1. 按关注面拆分：将不同维度的内容拆为独立文档
2. 按粒度拆分：概览文档 → 详细文档
3. 提取附属资源：图表、schema 移到 references/ 子目录

拆分后需重建关系字段。
