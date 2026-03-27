---
description: "vision-maker 的关键设计决策及其理由：为什么选择文档图而非索引、为什么分离元信息层、为什么不限制遍历深度等。"
type: explanation
concepts: [文档图, 元信息层, 渐进式暴露, 三级加载协议, 语义化目录]
depends_on:
  - VISION.md
children: []
referenced_by:
  - skill-design/core-model.md
  - skill-design/user-adaptation.md
  - specifications/front-matter-spec.md
  - specifications/directory-structure.md
  - specifications/three-tier-protocol.md
last_verified: 2026-03-27
---

# 关键设计决策

## 决策 1：文档图 vs 全局索引

**选择**：文档通过 front-matter 的 `depends_on` / `children` / `referenced_by` 自组织为有向图，不维护全局索引文件。

**理由**：
- 全局索引（如 index.yaml）随文档增长会变成巨型文件，对智能体上下文不友好
- 索引与文档内容之间存在同步问题——两个 source of truth
- front-matter 让每份文档自描述、自导航，无需外部依赖

**代价**：没有"一览全局"的快捷方式。通过 VISION.md 作为根节点 + grep 搜索 concepts 弥补。

## 决策 2：元信息层与文档体系分离

**选择**：`.vision/.meta/` 存放指导 Skill 工作的元信息（knowledge.md、user.local.md），与面向消费者的文档体系分开。

**理由**：
- 元知识（行业、领域、概念体系）是 Skill 的"工作手册"，不是项目文档的一部分
- 用户画像是个人文件，不应纳入版本控制
- 分离后消费者浏览文档体系时不会被元信息干扰

## 决策 3：三级加载协议控制粒度，关系遍历不设深度限制

**选择**：三级加载协议（description → 正文 → 附属资源）只控制单文档内部的加载粒度；BRIEF 模式下沿 `depends_on` 的链路遍历不设深度限制。

**理由**：
- AgentSkill 的渐进式暴露机制是为小规模技能设计的——几个文件即可覆盖全部功能
- 项目文档体系可能有数十甚至上百份文档，开发任务需要从设计理由到接口定义到实现约束的**完整知识链**
- 如果限制遍历深度（如 ≤1），智能体可能拿到接口定义但缺失设计理由，产出质量下降
- 三级协议已经在单文档层面控制了上下文开销，链路遍历的总开销由任务需求自然决定

## 决策 4：语义化目录命名

**选择**：层级目录由 knowledge.md 中的文档粒度定义决定，名称必须有语义（如 `architecture/`、`modules/`），拒绝无语义命名（如 `L0/`、`L1/`）。

**理由**：
- 目录名是人和智能体导航的第一线索
- `L0/L1` 需要查表才知道含义，语义名称即见即知
- 不同项目的分层方案不同，由元知识驱动命名更灵活

## 决策 5：Skill 是认知框架，不是文档生成器

**选择**：vision-maker 定位为"帮助人/智能体理解和维护项目的助手"，文档体系是手段而非目的。

**理由**：
- 如果定位为文档生成器，Skill 会倾向于批量生成模板化文档
- 实际上高质量文档需要对话采集、知识面刻画、散点组织等认知过程
- "助手"定位确保 Skill 在每个环节都以人的认知需求为中心
