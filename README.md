# Vision Maker

[English](./README.EN.md)

**为任意软件项目建立、导航、维护和评审文档体系的认知框架。**

Vision Maker 是一个遵循 [Agent Skills 开放规范](https://github.com/anthropics/agent-skills) 的 AgentSkill，它不是模板生成器——而是一套完整的认知方法论，通过人机对话为项目构建高质量的文档体系。

## 核心理念

传统文档面临四大困境：零散分布缺乏体系、与代码脱节静态腐化、难以被智能体消费、开发者无法快速导航知识。Vision Maker 通过「认知框架 = 思维模型 + 方法论 + 项目元知识」的三要素架构来系统性地解决这些问题。

## 四种运行模式

| 模式 | 触发条件 | 核心职责 |
|------|---------|---------|
| **INIT** | 新项目 / 新模块 / 元知识更新 | 采集项目信息，建立 `.vision/` 文档体系 |
| **BRIEF** | 开发/调试/审查需要理解项目 | 按任务需求组装知识链并暴露完整上下文 |
| **MAINTAIN** | 项目内容变更后 | 检测变更影响范围，同步更新文档 |
| **REVIEW** | 定期或按需评审 | 多维度评审文档质量，输出改进建议 |

## 快速开始

### 1. 安装

将本项目克隆到你的 Agent Skills 目录：

```bash
git clone https://github.com/larryonline/vision-maker.git
```

### 2. 在智能体中加载

Vision Maker 可被多种智能体产品加载执行：

- **Claude Code** — 通过 `.claude/` 配置集成
- **Gemini CLI** — 通过 Agent Skills 规范加载
- **Cursor** — 通过对应的配置方式集成

### 3. 初始化文档体系

在你的目标项目中，通过智能体调用 Vision Maker 的 INIT 模式：

```
请使用 vision-maker 为当前项目建立文档体系
```

Skill 会通过对话采集项目的元知识（行业、领域、概念体系等），并在项目根目录下生成 `.vision/` 文档体系。

## 产出结构

```
your-project/
└── .vision/
    ├── .meta/
    │   ├── knowledge.md        # 项目元知识（行业/领域/概念体系）
    │   └── user.local.md       # 用户画像（不纳入版本控制）
    ├── VISION.md               # 文档体系根节点
    ├── architecture/           # 架构相关文档
    ├── guides/                 # 操作指南
    └── ...                     # 按项目需求组织的语义化目录
```

## 关键设计

### 文档即图

每份文档通过 YAML front-matter 中的 `depends_on` / `children` / `referenced_by` 字段自描述关系，形成有向图结构，无需维护全局索引。

```yaml
---
description: "简洁摘要（< 100 tokens）"
type: explanation | reference | guide | context
concepts: [核心概念标签]
depends_on: [前置知识路径]
children: [细粒度文档路径]
---
```

### 三级加载协议

| 层级 | 内容 | 用途 |
|------|------|------|
| Tier 1 — 发现 | description + concepts | 概念定位，决定是否继续加载 |
| Tier 2 — 加载 | 文档正文（< 5000 tokens） | 获取核心知识 |
| Tier 3 — 深入 | 附属资源（图表、schema 等） | 需要详细信息时按需加载 |

### 用户适配

Skill 针对 7 个认知特征（知识面有限、思维散点化、方法论有限、记忆有限、决策疲劳、锚定偏差、领域专家 ≠ 文档专家）进行动态适配，确保不同背景的用户都能高效协作。

## 项目结构

```
vision-maker/
├── SKILL.md                    # AgentSkill 主入口
├── references/                 # 各模式的详细参考指南
│   ├── init-mode.md
│   ├── brief-mode.md
│   ├── maintain-mode.md
│   ├── review-mode.md
│   ├── front-matter-spec.md
│   └── user-adaptation.md
├── assets/templates/           # 文档模板
│   ├── document-template.md
│   ├── knowledge-template.md
│   ├── vision-template.md
│   └── user-local-template.md
└── .vision/                    # Skill 自身的文档体系（dogfood）
```

## 技术特点

- **零代码依赖** — 纯 Markdown + YAML，与技术栈无关
- **自证明** — Vision Maker 自身采用自己的方法论构建文档体系
- **开放规范** — 遵循 Agent Skills 开放规范，可跨智能体平台使用

## 许可证

请参阅项目仓库中的许可证信息。
