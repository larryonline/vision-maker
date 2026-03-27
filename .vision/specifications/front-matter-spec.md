---
description: "文档 front-matter 规范 — 元数据字段定义、关系类型、Diataxis 分类"
type: reference
concepts: [front-matter, yaml, directed-graph, diataxis, document-type]
depends_on: [directory-structure.md]
children: []
referenced_by: [directory-structure.md]
last_verified: 2026-03-27
---

# Front-matter 规范

## 字段定义

每份文档（除 knowledge.md 外）通过 YAML front-matter 自描述和自导航：

```yaml
---
description: "一两句话摘要（< 100 tokens）"
type: explanation | reference | guide | context
concepts: [核心概念标签]
depends_on: [前置知识文档路径]
children: [更细粒度文档路径]
referenced_by: [横向关联文档路径]
last_verified: 2026-03-27
---
```

## 字段说明

### description

- 格式：一两句话，概括文档的核心内容和价值
- 长度：< 100 tokens
- 用途：Tier 1 加载的快速判断依据

### type（Diataxis 分类）

| 类型 | 消费场景 | 特征 |
|------|---------|------|
| **explanation** | 理解"为什么" | 设计决策、架构理念、背景知识 |
| **reference** | 查阅"是什么" | API 规范、配置说明、术语表 |
| **guide** | 学习"怎么做" | 教程、操作步骤、最佳实践 |
| **context** | 获取背景 | 项目概况、领域介绍、快速上手 |

### concepts

- 列出 2-5 个核心概念标签
- 使用领域术语，与项目代码和团队用语一致
- 粒度适中：不过于宽泛（如"系统"）也不过于细碎（如"变量 x"）
- 同一概念在不同文档中使用相同标签

### depends_on（向上）

列出理解本文档必须先了解的文档路径。通常是：
- 父层的概览文档
- 直接依赖的模块文档
- 基础概念文档

### children（向下）

本文档的更细粒度展开。通常由系统自动填充（当子文档的 depends_on 包含本文档时）。

### referenced_by（横向）

列出引用本文档内容的文档。

## 三种关系类型

```
depends_on（向上）— "我需要先了解 X 才能理解本文档"
children（向下）   — "本文档的更细粒度展开"
referenced_by（横向）— "X 文档引用了本文档的内容"
```

## 关系规则

1. **depends_on 和 children 是互逆关系**
   - A 的 children 含 B → B 的 depends_on 必须含 A

2. **referenced_by 是单向的**
   - A 的 referenced_by 含 B → A 的正文中引用了 B 的概念
   - B 无需反向标记，除非 B 的正文也引用了 A

3. **depends_on 避免循环依赖**

4. **所有路径相对于 .vision/ 目录**

## 关系校验

在文档创建/修改后，必须校验：
1. 所有指向的文件是否存在
2. depends_on / children 互逆关系是否一致
3. 是否有孤立文档（无任何关系连接）
4. depends_on 是否有循环
