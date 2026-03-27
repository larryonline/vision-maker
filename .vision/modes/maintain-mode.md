---
description: "MAINTAIN 模式的设计与使用：变更检测、影响评估、修正执行、人审批的四步流程，以及4种维护场景。"
type: guide
concepts: [MAINTAIN, 变更检测, 影响评估, 双向一致性, 级联影响]
depends_on:
  - VISION.md
children: []
referenced_by:
  - modes/init-mode.md
last_verified: 2026-03-27
---

# MAINTAIN 模式 — 同步认知

## 核心职责

项目内容变更后，审慎检查变更对文档体系的影响，同步受影响文档，使文档与代码始终一致。

## 四步流程

1. **识别变更范围**：分析变更涉及的 concepts，grep 匹配受影响文档
2. **评估影响**：逐份判断影响级别（内容更新 / 关系调整 / 文档重组 / 需新增）
3. **执行修正**：更新内容和关系，校验双向一致性，更新 last_verified
4. **人审批**：呈现所有修改建议（内容、理由、范围）

## 四种维护场景

| 场景 | 触发 | 特点 |
|------|------|------|
| **3.1 代码变更同步** | 代码提交/功能合并 | 最常见，聚焦内容准确性 |
| **3.2 架构重组** | 模块拆分/合并/重命名 | 可能涉及文档拆分合并 |
| **3.3 新增决策记录** | 重要技术决策 | 创建 ADR + 更新 referenced_by |
| **3.4 元知识级联** | knowledge.md 更新（REINIT） | 可能影响目录结构、评审标准、concepts 体系 |

## 双向一致性校验

每次修正关系字段时必须校验：
- A 的 `children` 含 B → B 的 `depends_on` 须含 A
- `referenced_by` 是双向的

## 详细流程

完整的场景细节和步骤定义参见 Skill 的 `references/maintain-mode.md`。
