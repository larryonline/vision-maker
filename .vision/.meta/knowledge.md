---
project_name: vision-maker
industry: 软件工程工具
domain: AI 智能体技能 / 文档工程
---

# 项目元知识

## 行业与领域

- 项目所属行业：AI 智能体工具生态
- 项目解决的核心问题领域：软件项目文档体系的建立、维护和消费
- 行业内的关键约束和规范要求：遵循 [Agent Skills 开放规范](https://github.com/anthropics/agent-skills)，零代码依赖（纯 Markdown + YAML），与技术栈无关

## 核心场景

| # | 场景 | 描述 |
|---|------|------|
| 1 | 新项目冷启动 | 为新项目从零建立系统化的文档体系 |
| 2 | 已有项目补建 | 项目已有代码但缺乏文档，需补建 |
| 3 | 文档质量审计 | 检查文档是否与代码保持一致 |
| 4 | 知识导航 | 智能体/开发者在开发时快速获取项目上下文 |

## 领域概念体系

| 概念 | 定义 | 关联概念 |
|------|------|---------|
| 认知框架 | 思维模型 + 方法论 + 项目元知识的组合，驱动文档体系的建立 | 元知识、方法论 |
| 元知识 | 项目特定的知识（行业、领域、概念体系），存储在 .meta/knowledge.md | 认知框架、文档粒度 |
| 文档图 | 通过 depends_on / children / referenced_by 构建的有向图结构 | front-matter、三级加载 |
| 三级加载 | Tier 1（发现）→ Tier 2（加载）→ Tier 3（深入）的上下文控制协议 | 文档图、front-matter |
| Diataxis 分类 | explanation / reference / guide / context 四种文档类型 | 文档工程方法论 |
| 文档粒度 | 文档体系的分层定义，由 knowledge.md 控制 | 元知识、语义化目录 |
| 运行模式 | INIT（建立）/ BRIEF（导航）/ AUDIT（审计）三种工作模式 | 响应协议 |
| 项目侧自检 | 启动前通过 validate.sh 检查 .vision 配置完整性 | integration.md |
| 一致性标记 | commit message 中的品牌化审计标记 | AUDIT 模式 |

## 文档粒度定义

| 层级目录 | 职责 | 面向 |
|---------|------|------|
| skill-design/ | 技能架构设计 — 核心模型、设计决策、用户适配原则 | 技能设计者、贡献者 |
| specifications/ | 技术规格 — 目录结构、front-matter 规范、三级加载协议 | 实现者、集成者 |
| modes/ | 运行模式详细流程 — INIT/BRIEF/AUDIT 的完整响应协议 | 使用者、开发者 |

## 评审维度

### 基础维度（Skill 内置）

- 必要性
- 完整性
- 准确性
- 可参考性
- 关系完整性

### 项目特定维度

| 维度 | 检查标准 |
|------|---------|
| 自洽性 | Vision Maker 的文档体系是否遵循自己的方法论 |
| 规范一致性 | 是否遵循 Agent Skills 开放规范 |
| 模板一致性 | 文档是否与 assets/templates/ 中的模板结构一致 |

## 项目特定约束

- 遵循 Agent Skills 开放规范
- 零代码依赖（纯 Markdown + YAML）
- 与技术栈无关
- 可跨智能体平台使用（Claude Code / Gemini CLI / Cursor）
- 自证明（dogfood）：Vision Maker 自身采用自己的方法论构建文档

## 领域文档标准

| 关注面 | 来源 | 说明 |
|--------|------|------|
| 技能规范 | Agent Skills 开放规范 | SKILL.md 的结构和描述字段要求 |
| 模板结构 | assets/templates/ | 所有文档模板的 front-matter 和章节结构 |
| 方法论引用 | references/ | 各模式引用的方法论文件关系 |
| 跨平台兼容 | README | 不同智能体平台的集成方式 |
