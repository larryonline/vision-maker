---
description: "Vision Maker 项目顶层文档 — 一个为软件项目建立、导航和维护文档体系的 AgentSkill 认知框架"
type: context
concepts: [vision-maker, cognitive-framework, documentation-system, agent-skill]
children: [skill-design/core-model.md, specifications/directory-structure.md, modes/init-mode.md]
---

# Vision Maker

## 项目是什么

Vision Maker 是一个遵循 Agent Skills 开放规范的 AgentSkill，为任意软件项目建立、导航、维护和评审文档体系。它不是模板生成器，而是一套完整的认知方法论——通过人机对话为项目构建高质量的文档体系。

## 为什么存在

传统文档面临四大困境：零散分布缺乏体系、与代码脱节静态腐化、难以被智能体消费、开发者无法快速导航知识。Vision Maker 通过「认知框架 = 思维模型 + 方法论 + 项目元知识」的三要素架构来系统性地解决这些问题。

## 目标与成功标准

| 目标 | 成功标准 |
|------|---------|
| 为任意项目建立文档体系 | INIT 模式可成功为新项目生成 .vision/ 目录和初始文档 |
| 文档与代码始终一致 | AUDIT 模式能自动检测并修复偏差 |
| 智能体可高效消费文档 | BRIEF 模式能按需组装完整知识链 |
| 跨平台通用 | 遵循 Agent Skills 开放规范，支持 Claude Code / Gemini CLI / Cursor |

## 核心概念

- **认知框架**：思维模型 + 方法论 + 项目元知识，是 Vision Maker 的核心架构
- **元知识**：项目特定的知识（行业、领域、概念体系），驱动文档内容生成
- **文档图**：通过 front-matter 关系字段构建的有向图，实现自描述和自导航
- **三级加载**：Tier 1（发现）→ Tier 2（加载）→ Tier 3（深入），控制上下文开销

## 文档体系导览

本项目的文档体系位于 `.vision/` 目录，结构如下：

| 目录 | 内容 | 适合谁看 |
|------|------|---------|
| skill-design/ | 技能架构设计 — 核心模型、设计决策、用户适配原则 | 技能设计者、贡献者 |
| specifications/ | 技术规格 — 目录结构、front-matter 规范、三级加载协议 | 实现者、集成者 |
| modes/ | 运行模式详细流程 — INIT/BRIEF/AUDIT 的完整响应协议 | 使用者、开发者 |

### 如何使用

- **首次接触**：从本文档开始，沿 `children` 逐层展开
- **开发特定功能**：通过 concepts 搜索定位目标文档，沿 `depends_on` 上溯获取前置知识
- **Code Review**：从变更文件反查相关文档，沿 `depends_on` 获取设计理由
