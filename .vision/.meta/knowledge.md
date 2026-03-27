---
project_name: "vision-maker"
industry: "开发者工具 / AI Agent 生态"
domain: "项目文档工程"
---

# 项目元知识

> front-matter 字段供机器快速读取，正文供人/智能体深度理解。两者存在语义重叠时，正文为源头，front-matter 为摘要。

## 行业与领域

- **所属行业**：开发者工具，具体在 AI Agent 生态中。vision-maker 是一个 AgentSkill——遵循开放的 Agent Skills 规范，可被 Claude Code、Gemini CLI、Cursor 等多种智能体产品加载和执行。
- **核心问题领域**：项目文档工程。解决的核心问题是：如何为任意软件项目建立一套对人和智能体都友好的文档体系，使消费者能从顶层视角到实现细节建立完整认知。
- **行业约束**：
  - 必须遵循 AgentSkill 规范（SKILL.md + references/ + assets/）
  - 文档体系需要适配智能体的上下文窗口限制
  - 技能本身需要渐进式暴露（Tier 1 发现 → Tier 2 激活 → Tier 3 按需加载）

## 核心场景

| # | 场景 | 描述 |
|---|------|------|
| 1 | 新项目建立文档体系 | 从零开始，通过对话采集元知识，设计并生成完整文档体系 |
| 2 | 已有项目补建文档 | 分析现有代码和文档，逆向识别缺失部分并补建 |
| 3 | 日常开发中获取项目知识 | 开发者/智能体按任务需求加载相关文档链 |
| 4 | 代码变更后审计文档 | 检测变更对文档体系的影响并评估质量 |
| 5 | 配置自动化集成 | 将 vision-maker 集成到 git hooks / CI 工作流 |

## 领域概念体系

| 概念 | 定义 | 关联概念 |
|------|------|---------|
| AgentSkill | 遵循 Agent Skills 开放规范的技能包，可被多种智能体产品加载执行 | SKILL.md, 渐进式暴露 |
| 文档体系 | 项目 `.vision/` 目录下的所有文档，通过 front-matter 关系字段构成有向图 | 文档图, front-matter |
| 元知识 | 项目行业、领域、场景、概念体系、文档粒度等上下文信息，指导 Skill 工作 | knowledge.md |
| 文档图 | 文档间通过 depends_on / children / referenced_by 构成的有向图 | front-matter, 关系遍历 |
| 三级加载协议 | 控制单文档加载粒度：description(Tier1) → 正文(Tier2) → 附属资源(Tier3) | 渐进式暴露, 上下文管理 |
| 运行模式 | Skill 的三种工作模式：INIT / BRIEF / AUDIT | 认知循环 |
| 响应协议 | 每个模式的交互契约：触发/输入/输出/衔接 | 模式定义 |
| 方法论引用 | knowledge-acquisition.md / doc-methodology.md / doc-tasks.md | 共享知识 |
| 用户画像 | Skill 对用户知识面的动态刻画，用于适配交互详略 | user.local.md |

## 文档粒度定义

| 层级目录 | 职责 | 面向 |
|---------|------|------|
| `skill-design/` | Skill 的设计理念、核心模型、架构决策 | 需要理解"为什么这样设计"的贡献者和使用者 |
| `modes/` | 三种运行模式的详细说明和使用指南 | 使用 Skill 的智能体和开发者 |
| `specifications/` | 技术规范（front-matter 规范、目录结构规范等） | 需要精确查阅规范细节的智能体和开发者 |

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
| **AgentSkill 规范合规性** | 是否遵循 Agent Skills 规范（SKILL.md 结构、front-matter 约束、文件组织） |
| **上下文效率** | 文档大小是否控制在智能体上下文友好的范围内（< 5000 tokens） |
| **渐进式暴露** | 信息是否按 Tier 1/2/3 合理分层，避免一次性加载过多内容 |

## 项目特定约束

- 技术栈：纯 Markdown + YAML front-matter，无代码依赖
- AgentSkill 规范要求 SKILL.md < 500 行
- 目标用户的知识面参差，Skill 需要适配从新手到专家的不同水平
- Skill 本身是方法论，不包含行业/领域具体知识
- 模式是认知框架，文档操作由 doc-tasks.md 任务规格执行

## 领域文档标准

| 关注面 | 来源 | 说明 |
|--------|------|------|
| AgentSkill 规范 | 行业要求 | SKILL.md 结构、references/、assets/ 组织 |
| 渐进式暴露 | 技术约束 | Tier 1/2/3 加载协议，SKILL.md < 500 行 |
| 文档图关系 | 方法论 | front-matter 关系字段的双向一致性 |
