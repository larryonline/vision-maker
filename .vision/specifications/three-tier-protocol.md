---
description: "三级加载协议的完整定义：Tier 1 发现（description+concepts）→ Tier 2 加载（正文）→ Tier 3 深入（附属资源），以及与关系遍历的职责分离。"
type: reference
concepts: [三级加载协议, 渐进式暴露, Tier 1, Tier 2, Tier 3, 上下文管理]
depends_on:
  - VISION.md
children: []
referenced_by:
  - skill-design/design-decisions.md
last_verified: 2026-03-27
---

# 三级加载协议

## 协议定义

控制**单文档内部**的加载粒度：

| 层级 | 内容 | 上下文开销 | 何时加载 |
|------|------|-----------|---------|
| **Tier 1 — 发现** | front-matter 的 `description` + `concepts` | ~1-2 行/文档 | BRIEF 策略 B 的概念定位阶段 |
| **Tier 2 — 加载** | 文档正文（建议 < 5000 tokens） | 受控 | 确定文档与任务相关后 |
| **Tier 3 — 深入** | 正文引用的附属资源（图表、schema 等） | 按需 | 判断需要详细信息时 |

## 与关系遍历的职责分离

这是一个关键的设计区分：

- **三级加载协议**：控制一份文档从"知道它存在"到"深入了解细节"的粒度
- **关系遍历**（`depends_on` / `children` / `referenced_by`）：控制文档间的导航路径

两者是正交的。BRIEF 模式下：
- 沿 `depends_on` 的链路遍历**不设深度限制**（由任务需求决定）
- 每份被遍历到的文档按三级协议控制其内部加载粒度

## 设计理由

AgentSkill 的渐进式暴露是为小规模技能设计的。项目文档体系可能有大量文档，开发任务需要完整知识链。三级协议在单文档层面已经控制了上下文开销，链路遍历的总开销由任务需求自然决定。
