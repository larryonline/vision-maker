---
description: "vision-maker 是一个 AgentSkill，为任意软件项目构建和维护对人和智能体都友好的文档体系。"
concepts: [AgentSkill, 文档体系, 认知框架, 元知识, 文档图]
children:
  - skill-design/core-model.md
  - skill-design/user-adaptation.md
  - skill-design/design-decisions.md
  - modes/init-mode.md
  - modes/brief-mode.md
  - modes/maintain-mode.md
  - modes/review-mode.md
  - specifications/front-matter-spec.md
  - specifications/directory-structure.md
  - specifications/three-tier-protocol.md
---

# Vision Maker

## 项目是什么

vision-maker 是一个遵循 Agent Skills 开放规范的技能（AgentSkill），可被 Claude Code、Gemini CLI、Cursor 等多种智能体产品加载执行。它提供一套认知框架（思维模型 + 方法论），帮助人和智能体为任意软件项目建立、导航、维护和评审文档体系，使消费者能从顶层视角到实现细节建立完整认知。

## 为什么存在

软件项目的文档普遍存在以下问题：

- **缺乏体系**：文档零散分布，没有从全局到细节的认知路径
- **人机不友好**：要么只适合人类阅读（冗长叙述），要么只适合机器消费（纯结构化数据）
- **静态腐化**：文档写完后迅速过时，与代码脱节
- **无法导航**：开发者/智能体无法从一个知识点快速找到相关知识

vision-maker 通过提供一套可复用的方法论来解决这些问题，而非绑定特定领域或技术栈。

## 目标与成功标准

| 目标 | 成功标准 |
|------|---------|
| 为任意项目建立文档体系 | 通过 INIT 模式，能在对话引导下产出完整的 `.vision/` 文档结构 |
| 支撑日常开发 | BRIEF 模式能按任务需求组装完整知识链，无需人工查找 |
| 文档与代码保持一致 | MAINTAIN 模式能检测变更影响并提出同步建议 |
| 文档质量可度量 | REVIEW 模式按多维度（含项目特定维度）输出可操作的评审报告 |
| 适配不同认知水平 | 用户画像机制能动态调整交互详略 |

## 核心概念

- **认知框架** = 思维模型（如何思考文档）+ 方法论（如何操作文档），技能本身不包含领域知识
- **元知识**（`.meta/knowledge.md`）：项目的行业、领域、场景、概念体系等上下文，驱动框架的具体化
- **文档图**：文档通过 front-matter 的 `depends_on` / `children` / `referenced_by` 构成有向图，自描述、自导航
- **三级加载协议**：控制单文档加载粒度（description → 正文 → 附属资源），适配上下文窗口
- **四种运行模式**：INIT（建立认知）→ BRIEF（支撑开发）→ MAINTAIN（同步认知）→ REVIEW（评审质量）

## 文档体系导览

本项目的文档体系位于 `.vision/` 目录，结构如下：

| 目录 | 内容 | 适合谁看 |
|------|------|---------|
| `skill-design/` | Skill 的设计理念、核心模型、架构决策 | 需要理解"为什么这样设计"的贡献者和使用者 |
| `modes/` | 四种运行模式的详细说明和使用指南 | 使用 Skill 的智能体和开发者 |
| `specifications/` | 技术规范（front-matter、目录结构、三级加载协议） | 需要精确查阅规范细节的智能体和开发者 |

### 如何使用

- **首次接触**：从本文档开始，沿 `children` 逐层展开
- **开发特定功能**：通过 concepts 搜索定位目标文档，沿 `depends_on` 上溯获取前置知识
- **Code Review**：从变更文件反查相关文档，沿 `depends_on` 获取设计理由
