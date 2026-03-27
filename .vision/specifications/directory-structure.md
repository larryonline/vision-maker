---
description: ".vision/ 目录的组织规范：元信息层（.meta/）、文档图根节点（VISION.md）、语义化层级目录的命名和职责划分。"
type: reference
concepts: [目录结构, 语义化目录, 元信息层, VISION.md, knowledge.md, user.local.md]
depends_on:
  - VISION.md
children: []
referenced_by:
  - skill-design/design-decisions.md
  - specifications/front-matter-spec.md
last_verified: 2026-03-27
---

# 目录结构规范

## 标准结构

```
.vision/
├── .meta/                          # 元信息层
│   ├── knowledge.md                # 项目元知识（纳入版本控制）
│   └── user.local.md               # 用户个人画像（不纳入版本控制）
├── VISION.md                       # 项目顶层文档（文档图根节点）
└── <layer-name>/                   # 语义化层级目录（由元知识定义）
    ├── <topic>.md
    ├── adr/                        # 架构决策记录
    └── <topic>/
        ├── <document>.md
        └── references/             # 附属资源（Tier 3）
```

## 关键约定

### 元信息层（`.meta/`）

- `knowledge.md`：项目元知识，驱动 Skill 工作，**纳入版本控制**
- `user.local.md`：用户画像，**不纳入版本控制**（`.gitignore` 中配置 `.vision/.meta/*.local.md`）

### 文档图根节点（VISION.md）

- 文档体系的入口，位于 `.vision/` 根目录
- front-matter 的 `children` 指向所有顶层文档
- 消费者从此处开始自顶向下遍历

### 语义化层级目录

- 目录名称由 `knowledge.md` 中的"文档粒度定义"决定
- 必须具有语义（如 `architecture/`、`modules/`），拒绝无语义命名（如 `L0/`、`L1/`）
- 不同项目的分层方案不同，由元知识驱动

### 附属资源（references/）

- 存放文档引用的重型内容（图表、schema、长代码示例等）
- 对应 Tier 3 加载——仅在需要时才读取
- 位于对应文档的子目录下
