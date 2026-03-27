---
description: "Vision Maker 的核心认知模型 — 思维模型 + 方法论 + 项目元知识如何组合驱动文档体系"
type: explanation
concepts: [cognitive-framework, meta-knowledge, methodology, thinking-model]
depends_on: [../VISION.md]
children: [design-decisions.md, user-adaptation.md]
referenced_by: [../VISION.md]
last_verified: 2026-03-27
---

# 核心认知模型

## 架构公式

```
vision-maker = 思维模型 + 方法论（本技能，不变）
             + 项目元知识（.vision/.meta/knowledge.md，项目特定）
             → 驱动文档体系的建立、维护、评审
```

这个公式的关键在于**分离变与不变**：

- **不变的部分**：思维模型和方法论 — 编码在 SKILL.md 和 references/ 中，适用于所有项目
- **变化的部分**：项目元知识 — 存储在 .vision/.meta/knowledge.md，每个项目不同
- **产出**：由元知识驱动的文档体系 — 结构、内容、关系都源于项目特定知识

## 为什么不直接用模板

传统模板方法的问题：

1. **模板是静态的** — 无法适应不同规模和类型的项目
2. **内容与结构耦合** — 换个领域就得换模板
3. **缺乏认知引导** — 告诉你"写什么"，不告诉你"怎么想"

Vision Maker 的方法：

1. **方法论是动态的** — 提供思维框架，内容由元知识填充
2. **元知识与文档分离** — .meta/ 指导工作，文档体系面向消费者
3. **认知引导优先** — 先建立顶层认知，再逐层展开

## 三要素详解

### 思维模型

- 文档即图（有向图关系）
- 三级加载控制上下文
- Diataxis 分类法
- 人机协作模型

### 方法论

- 知识获取策略（研究、追溯、置信度）
- 文档工程标准（结构、大小、关系、concepts）
- 运行模式协议（INIT / BRIEF / AUDIT）
- 文档操作规格（创建 / 修复 / 删除 / 重组）

### 项目元知识

- 行业与领域
- 核心场景
- 领域概念体系
- 文档粒度定义
- 评审维度
- 领域文档标准
