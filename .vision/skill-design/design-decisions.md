---
description: "Vision Maker 的关键设计决策及其理由 — 为什么选择 Markdown+YAML、为什么分离元信息层、为什么用有向图"
type: explanation
concepts: [design-decision, markdown, yaml, directed-graph, meta-layer]
depends_on: [core-model.md]
children: []
referenced_by: [../VISION.md]
last_verified: 2026-03-27
---

# 设计决策

## 决策 1：纯 Markdown + YAML

**决策**：不使用任何代码依赖，所有文档格式为 Markdown，元数据用 YAML front-matter。

**理由**：
- 零依赖意味着任何技术栈都能使用
- Markdown 是开发者最熟悉的文档格式
- YAML front-matter 被广泛支持（Jekyll、Hugo、Astro 等）
- 智能体可以原生解析，无需额外工具

## 决策 2：元信息层与文档体系分离

**决策**：`.meta/` 目录存放指导性信息，文档体系面向消费者。

**理由**：
- knowledge.md 是"如何生成文档"的配方，不是文档本身
- user.local.md 是工作状态，不应暴露给文档消费者
- integration.md 是配置，不应混入文档内容
- 清晰的关注点分离降低认知负担

## 决策 3：有向图关系而非树形结构

**决策**：通过 depends_on / children / referenced_by 构建有向图，而非维护全局树形索引。

**理由**：
- 现实中的知识关系不是纯树形 — 概念间存在横向关联
- 自描述关系意味着每个文档独立可理解
- 无需维护全局索引，降低维护成本
- 支持多路径导航，适应不同使用场景

## 决策 4：三级加载协议

**决策**：Tier 1（description + concepts）→ Tier 2（正文）→ Tier 3（附属资源）。

**理由**：
- 智能体的上下文窗口有限，必须控制加载粒度
- description 是"是否值得加载"的快速判断
- 正文 < 5000 tokens 保证单文档可一次加载
- Tier 3 按需加载，避免无用信息占用上下文

## 决策 5：模式与任务规格分离

**决策**：INIT/BRIEF/AUDIT 是认知框架，doc-tasks.md 是执行指南。

**理由**：
- 模式回答"怎么想"，任务规格回答"怎么做"
- 分离使得方法论可以独立演进
- 任务规格可以作为 sub-agent 的系统提示词派发执行
