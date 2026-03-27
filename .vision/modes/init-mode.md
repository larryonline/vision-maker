---
description: "INIT 模式的设计与使用：5 种场景（元知识采集、冷启动、补建、新模块、REINIT）的触发条件、流程和产出。"
type: guide
concepts: [INIT, 元知识, 冷启动, 补建, 新模块, REINIT, 对话引导]
depends_on:
  - VISION.md
children: []
referenced_by:
  - skill-design/core-model.md
  - skill-design/user-adaptation.md
  - modes/maintain-mode.md
last_verified: 2026-03-27
---

# INIT 模式 — 建立认知

## 触发条件

- 新项目首次使用 vision-maker（无 `.vision/` 目录）
- 已有项目首次接入
- 新模块加入现有文档体系
- 元知识需要更新（REINIT）

## 5 种场景

| 场景 | 前置条件 | 产出 |
|------|---------|------|
| **1.1 元知识采集** | 无 `.vision/` | `knowledge.md` + `VISION.md` |
| **1.2 新项目冷启动** | 已完成 1.1 | 完整目录结构 + 文档蓝图 + 逐份文档 |
| **1.3 已有项目补建** | 已完成 1.1 | 基于现有代码/文档的增量补建 |
| **1.4 新模块接入** | 已有 `.vision/` | 新模块文档 + 关系更新 |
| **1.5 REINIT** | 已有 `.vision/` | 更新后的 `knowledge.md` + 级联影响处理 |

## 核心流程

**场景 1.1（元知识采集）**是所有新项目的起点：
1. 通过对话采集项目信息（行业、领域、场景、概念、约束）
2. 确定文档分层方案（语义化目录名称）
3. 确定评审维度（基础 + 项目特定）
4. 产出 knowledge.md → 人审批
5. 产出 VISION.md → 人审批

**场景 1.2（冷启动）**基于元知识展开完整文档体系：
1. 创建目录结构
2. 确定文档蓝图 → 人审批
3. 逐份生成文档 → 每份人审批
4. 建立文档间关系（校验双向一致性）
5. 运行 REVIEW 模式检查初始质量

## 对话引导策略

INIT 阶段遵循用户适配原则：每次只问一个问题、优先多选题、给出明确推荐和理由、将散碎回答组织为结构化内容、主动识别未提及但可能重要的方面。

## 详细流程

完整的场景细节和步骤定义参见 Skill 的 `references/init-mode.md`。
