---
name: vision-maker
description: >
  A skill for building, navigating, auditing, or maintaining a project's .vision/ documentation system.
  Trigger keywords: initialize docs, set up .vision, acquire project knowledge, search .vision resources,
  review doc quality, check consistency, doc audit, create/modify/delete documents,
  use vision-maker, vision-maker INIT/BRIEF/AUDIT.
  Use cases: new projects needing doc structure, onboarding existing projects, doc sync after code changes, doc quality assessment.
---

# Vision Maker

为项目构建和维护文档体系的认知框架。帮助人/智能体对项目从顶层视角（概念、目标、问题、成功标准）到实现细节（代码、数据、产出）建立完整认知。

## 核心模型

```
vision-maker = 思维模型 + 方法论（本技能，不变）
             + 项目元知识（.vision/.meta/knowledge.md，项目特定）
             → 驱动文档体系的建立、维护、评审
```

本技能不包含任何行业/领域的具体知识。它是一个认知框架——告诉智能体"如何为项目构建和维护文档体系"，而非"该写什么内容"。具体内容由项目元知识驱动。

## 路由表

```
用户意图                              路由目标
──────────────────────────────────    ──────────────
建立文档体系 / 初始化 / 接入          → INIT  (references/init-mode.md)
获取知识 / .vision 查找资料            → BRIEF (references/brief-mode.md)
评审质量 / 检查一致性 / 审计           → AUDIT (references/audit-mode.md)
创建/修改/删除/重组文档                → doc-tasks.md（对应任务规格）
意图不明确                             → 自检 → 状态诊断 → 推荐模式
```

## 模式概览

| 模式 | 触发关键词示例 | 核心职责 | 详细流程 |
|------|--------------|---------|---------|
| **INIT** | "初始化文档"、"建立 .vision"、"用 vision-maker 初始化" | 采集项目元知识，建立文档体系，配置自动化集成 | [init-mode.md](references/init-mode.md) |
| **BRIEF** | "获取 XX 知识"、"去 .vision 找 XX"、"理解项目" | 按任务需求暴露完整知识链，即时补充盲区 | [brief-mode.md](references/brief-mode.md) |
| **AUDIT** | "评审文档质量"、"检查一致性"、"对 .vision 做体检" | 评估文档体系的准确性、完整性、一致性等多维度质量 | [audit-mode.md](references/audit-mode.md) |

> 文档操作（创建/修改/删除/重组）不是独立模式，而是由 [doc-tasks.md](references/doc-tasks.md) 定义的任务规格。模式是认知框架（教你怎么想），任务规格是执行指南（教你怎么做）。

## 项目侧配置自检

**任何模式启动前执行**，通过智能体能力 + `scripts/validate.sh` 完成：

1. `.vision/` 目录存在？
2. `.meta/knowledge.md` 存在且非空？
3. `.meta/integration.md` 存在？（自动化集成配置）
4. 自动化集成就绪？（hooks / CI workflow）
5. `user.local.md` 中智能体配置完整？

项目可在 `integration.md` 中注册自定义检测规则。如自检发现问题，引导用户先解决。

## 通用前置步骤：文档加载

**执行任何模式操作前，必须遵循三级加载协议。这是行为指令，不是建议。**

### 加载流程

```
[Step 1] Tier 1 — 发现（必须先执行）
  工具：Grep / Glob / 读取 front-matter 前 10 行
  目标：通过 description + concepts 判断相关性
  规则：禁止在完成 Tier 1 前直接 Read 全文

[Step 2] Tier 2 — 加载（仅限相关文档）
  工具：Read 全文
  条件：仅对 Tier 1 确认相关的文档执行
  约束：正文建议 < 5000 tokens

[Step 3] Tier 3 — 深入（按需）
  工具：Read references/ 子目录资源 / 沿 depends_on 追溯依赖
  条件：仅当 Tier 2 正文信息不足时触发
  规则：追溯前先确认依赖关系，避免无差别遍历
```

### Read 前自检清单

**每次调用 Read 工具加载 .vision/ 文档前，逐项确认：**

- [ ] 我已通过 Tier 1（front-matter 的 description + concepts / Grep 关键词 / 目录结构）确认此文档与当前任务相关
- [ ] 我没有因为"方便"或"顺手"加载未经筛选的文档
- [ ] 我已检查此文档的 depends_on 关系，确认需要追溯的依赖链条

**以上任何一项未满足 → 先完成 Tier 1，再继续。**

---

## 响应协议摘要

每个模式定义了完整的交互契约：

| 项 | INIT | BRIEF | AUDIT |
|---|------|-------|-------|
| **触发方式** | 人工 / 自检发现无 .vision/ | 人工 / 智能体研究阶段 | 自动（pre-commit）/ 人工 |
| **输入** | 项目代码 + 对话采集的领域知识 | 任务描述 + 关联文件 | git diff + 追溯 / 用户指定范围 |
| **输出** | .vision/ 体系 + integration.md + hooks | 知识链（来源+置信度）+ 盲区标注 | 诊断报告 / pass 标记 |
| **衔接** | 推荐 AUDIT 验证 + 告知 BRIEF 用法 | 交还控制权 + 盲区行动建议 | 修复提示词 / 下次审计时机 |

详细响应协议见各模式的 reference 文件。

## 衔接协议

每个模式完成后：
1. 推荐下一步行动
2. 提供与本次任务相关的 .vision 提示词示例
3. 如检测到 CLAUDE.md / AGENTS.md 存在，询问用户是否写入 .vision 使用建议（需明确许可）

## 一致性标记

品牌化 commit message footer：

| 场景 | 标记 |
|------|------|
| 发现偏差并已对齐 | 🎯 vision-maker 检测到本次提交影响了 {N} 份文档，已帮您完成对齐。 |
| 审计通过，无需变更 | ✅ vision-maker 已仔细审计本次提交，文档与项目内容完全一致。 |
| 无受影响文档 | 👁 vision-maker 扫描了本次变更，未发现需要更新的文档。 |
| 全量审计通过 | 🔍 vision-maker 对本次提交进行了全量审计，所有文档均已与项目保持同步。 |
| 没有审计的提交 | 无内容, 隐含未审计的情况. 在下次提交审计时自动将未审计的变更纳入审计范围 |

## 用户适配原则

本技能服务的用户（人类侧）具有典型认知局限。Skill 必须据此调整交互方式：

| 特征 | 适配策略 |
|------|---------|
| **知识面有限** | 默认视为新手，通过对话动态刻画知识面，决定详略 |
| **思维散点化** | 主动将零散想法组织为结构化认知面 |
| **方法论有限** | 主动上升到方法论层面解释和引导 |
| **记忆有限** | 输出始终包含完整上下文，跨会话帮助恢复 |
| **决策疲劳** | 精简选项 + 明确推荐 + 推荐理由 |
| **锚定偏差** | 主动暴露盲区和替代视角 |
| **领域专家 ≠ 文档专家** | 引导隐性知识外化为结构化文档 |

详见 [knowledge-acquisition.md §对话获取策略](references/knowledge-acquisition.md)

## `.vision/` 目录结构

```
.vision/
├── .meta/                          # 元信息层
│   ├── knowledge.md                # 项目元知识（纳入版本控制）
│   ├── integration.md              # 自动化集成配置
│   └── user.local.md               # 用户个人画像（不纳入版本控制）
├── VISION.md                       # 项目顶层文档（文档图根节点）
└── <layer-name>/                   # 语义化层级目录（由元知识定义）
    ├── <topic>.md
    ├── adr/                        # 架构决策记录
    └── <topic>/
        ├── <document>.md
        └── references/             # 附属资源（Tier 3）
```

- 层级目录名称由 `knowledge.md` 中的文档粒度定义决定，必须具有语义
- 版本控制：`.vision/.meta/*.local.md` 应加入 `.gitignore`

## 文档 Front-matter 规范

每份文档（除 `knowledge.md` 外）通过 front-matter 自描述和自导航：

```yaml
---
description: "一两句话摘要（< 100 tokens）"
type: explanation | reference | guide | context
concepts: [核心概念标签]
depends_on: [前置知识文档路径]
children: [更细粒度文档路径]
referenced_by: [横向关联文档路径]
last_verified: 2026-03-26
---
```

三种关系类型构成文档**有向图**：
- `depends_on`（向上）— 知识的前置依赖
- `children`（向下）— 知识的细粒度展开
- `referenced_by`（横向）— 非上下级的概念关联

所有路径相对于 `.vision/` 目录。详见 [front-matter-spec.md](references/front-matter-spec.md)

## 三级加载协议

三级加载控制**智能体消费项目文档时的上下文开销**，包含两个维度：

### 维度一：SKILL.md 自身的分层加载

| 层级 | 内容 | 位置 |
|------|------|------|
| Tier 1 | 模式概览 + 触发关键词 | SKILL.md description |
| Tier 2 | 模式路由 + 响应协议摘要 + 自检流程 + doc-tasks 路由入口 | SKILL.md body（< 500 行） |
| Tier 3 | 模式详细流程、方法论、任务规格 | references/ 或 项目文件 |

### 维度二：项目文档的渐进加载

| 层级 | 内容 | 上下文开销 |
|------|------|-----------|
| **Tier 1 — 发现** | front-matter 的 `description` + `concepts` | 每文档 ~1-2 行 |
| **Tier 2 — 加载** | 文档正文（建议 < 5000 tokens） | 受控 |
| **Tier 3 — 深入** | 正文引用的附属资源（图表、schema 等） | 按需 |

**执行方式见上方「通用前置步骤：文档加载」中的加载流程和 Read 前自检清单。**

**BRIEF 模式下文档间的关系遍历不设深度限制。** 沿 `depends_on` 完整上溯获取知识链，加载范围由任务需求决定。

## 人机协作模型

智能体主导执行，人在关键节点审查和补充：

- **INIT**：智能体引导对话采集信息 → 人确认元知识和文档蓝图
- **BRIEF**：智能体自主组装上下文 → 人/智能体消费
- **AUDIT**：智能体执行评估 → 人确认结论和修复措施

## 设计原则

| 原则 | 说明 |
|------|------|
| **方法论，不是模板** | 提供思维框架，具体内容由元知识驱动 |
| **元信息层与文档体系分离** | `.meta/` 指导工作，文档体系面向消费者 |
| **适配用户认知水平** | 动态刻画知识面，调整详略，主动暴露盲区 |
| **散点组织成面** | 将零散想法组织为结构化认知 |
| **文档自描述、自导航** | front-matter 携带元数据和关系，无需外部索引 |
| **三级加载控制上下文** | description → 正文 → 附属资源 |
| **关系遍历不设深度限制** | 按任务需求完整加载知识链 |
| **语义化组织** | 目录名由元知识定义，反映项目认知粒度 |
| **思考与执行分离** | 模式是认知框架，任务规格是执行指南 |
| **文档与项目始终一致** | AUDIT 确保文档是活的 |

## 方法论引用文件

| 文件 | 职责 |
|------|------|
| [knowledge-acquisition.md](references/knowledge-acquisition.md) | 知识获取与管理方法论：研究策略、追溯策略、置信度框架、对话获取、知识回流 |
| [doc-methodology.md](references/doc-methodology.md) | 文档工程方法论：结构标准、大小控制、关系建立、concepts 规范、层级原则 |
| [doc-tasks.md](references/doc-tasks.md) | 文档操作任务规格：创建文档、修复文档等可执行单元 |
