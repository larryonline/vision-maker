---
description: "BRIEF 模式的设计与使用：3 种导航策略（自顶向下、概念定位+遍历、反向追溯）及其适用场景。"
type: guide
concepts: [BRIEF, 导航策略, 概念定位, 关系遍历, 知识链]
depends_on:
  - VISION.md
children: []
referenced_by: []
last_verified: 2026-03-27
---

# BRIEF 模式 — 支撑开发

## 核心职责

按任务需求，向开发者（人/智能体）暴露完整的项目知识链。

## 三种导航策略

| 策略 | 适用场景 | 遍历方式 |
|------|---------|---------|
| **A：自顶向下** | 项目 Onboarding，首次接触 | 从 VISION.md 沿 children 广度优先 |
| **B：概念定位 + 关系遍历** | 开发功能、修 Bug、架构评估 | grep concepts 定位 → 沿 depends_on 完整上溯 |
| **C：反向追溯** | Code Review、影响面分析 | 从变更文件定位文档 → 上溯 + 扩散 |

## 策略 B 详解（最高频）

1. **Tier 1 发现**：grep `.vision/` 所有文档 front-matter 的 concepts/description，匹配任务关键词
2. **Tier 2 加载**：读取目标文档正文
3. **沿 depends_on 完整上溯**：获取前置知识链，**不设深度限制**
4. **沿 referenced_by 补充**：获取横向关联知识
5. **Tier 3 按需**：仅在需要时加载附属资源

## 关键原则

- **完整链路加载**：开发任务需要从设计理由到接口定义到实现约束的完整知识链，不人为限制遍历深度
- **三级协议控制单文档粒度**：这控制的是每份文档内部的加载粒度，不是文档间的遍历深度
- **用户上下文补全**：输出始终包含完整上下文，不假设用户记得之前的内容

## 详细流程

完整的策略定义和场景映射参见 Skill 的 `references/brief-mode.md`。
