# 文档工程方法论

本文件定义 vision-maker 如何组织和维护 `.vision/` 文档体系的结构、关系和质量标准。

## 文档结构标准

### Diataxis 分类

每份文档应明确其类型（front-matter `type` 字段）：

| 类型 | 消费场景 | 特征 |
|------|---------|------|
| **explanation** | 理解"为什么" | 设计决策、架构理念、背景知识 |
| **reference** | 查阅"是什么" | API 规范、配置说明、术语表 |
| **guide** | 学习"怎么做" | 教程、操作步骤、最佳实践 |
| **context** | 获取背景 | 项目概况、领域介绍、快速上手 |

### 文档粒度

由 `.vision/.meta/knowledge.md` 中的"文档粒度定义"控制：

```
层级 1：领域级（如 architecture/、modules/）
层级 2：模块级（如 modules/auth/、modules/payment/）
层级 3：主题级（如 modules/auth/login-flow.md）
```

每个层级应有语义化的目录名，反映该层级的认知粒度。

## 文档大小控制

### Token 预算

| 文档部位 | 建议大小 | 说明 |
|---------|---------|------|
| front-matter | 10-20 行 | 元数据和关系 |
| description | < 100 tokens | 一两句话摘要 |
| 正文 | < 5000 tokens | 核心内容 |
| 附属资源 | 按需 | 图表、schema 等，放在 Tier 3 |

### 拆分策略

当文档超过 token 预算时：

1. **按关注面拆分**：将不同维度的内容拆为独立文档
2. **按粒度拆分**：概览文档 → 详细文档
3. **提取附属资源**：图表、schema 移到 `references/` 子目录

拆分后需重建关系字段。

## 关系建立规则

### 三种关系类型

```
depends_on（向上）— "我需要先了解 X 才能理解本文档"
children（向下）   — "本文档的更细粒度展开"
referenced_by（横向）— "X 文档引用了本文档的内容"
```

### 关系建立原则

1. **depends_on 和 children 是互逆关系**
   - A 的 `children` 含 B → B 的 `depends_on` 必须含 A
   - 反之亦然

2. **referenced_by 是双向的**
   - A 的 `referenced_by` 含 B → B 的 `referenced_by` 应含 A（除非 B 不存在）

3. **避免循环依赖**
   - `depends_on` 不应形成环
   - `referenced_by` 允许环（表示概念间的强关联）

4. **最小关系原则**
   - 只建立真正有导航价值的关系
   - 不要为了"完整性"而建立无用关系

### 关系校验

在文档创建/修改后，必须校验：

```
1. 所有指向的文件是否存在？
2. 双向关系是否一致？
3. 是否有孤立文档（无任何关系连接）？
4. depends_on 是否有循环？
```

## Concepts 标签规范

### 标签选择原则

1. **反映核心概念**：文档讨论的主要主题
2. **使用领域术语**：与项目代码和团队用语一致
3. **粒度适中**：不过于宽泛（如"系统"）也不过于细碎（如"变量 x"）
4. **可搜索**：便于 grep 定位

### 标签格式

```yaml
concepts:
  - authentication        # 核心概念
  - JWT                   # 具体技术
  - session-management    # 复合概念用连字符
```

### 标签复用

- 同一概念在不同文档中使用相同标签
- 标签列表是项目的受控词汇表
- INIT 阶段应建立初始标签表

## 层级结构原则

### 顶层结构

```
.vision/
├── .meta/           # 元信息（不面向消费者）
├── VISION.md        # 文档图根节点
└── <layer>/         # 语义化层级
```

### 层级定义

由 `knowledge.md` 中的"文档粒度定义"决定：

```yaml
# 示例：三层结构
粒度:
  - layer: architecture    # 层级名
    语义: 架构设计          # 该层的语义
    消费者: 架构师、Tech Lead
  - layer: modules
    语义: 功能模块
    消费者: 开发者
  - layer: specifications
    语义: 技术规范
    消费者: 开发者、QA
```

### 目录命名

- 使用小写 + 连字符：`auth-system/`、`api-design/`
- 名称应反映语义，而非技术实现
- 避免过深的嵌套（建议 ≤ 3 层）

## Front-matter 填充指南

### description

```
格式：一两句话，概括文档的核心内容和价值
长度：< 100 tokens
示例："本文档描述了认证模块的架构设计，包括 JWT 令牌管理、会话处理和安全控制。"
```

### type

选择最匹配的 Diataxis 类型。如果难以选择，默认 `explanation`。

### concepts

列出 2-5 个核心概念标签。优先选择能区分本文档与其他文档的标签。

### depends_on

列出理解本文档必须先了解的文档路径。通常是：
- 父层的概览文档
- 直接依赖的模块文档
- 基础概念文档

### children

本文档的更细粒度展开。通常由系统自动填充（当子文档的 `depends_on` 包含本文档时）。

### referenced_by

列出引用本文档内容的文档。注意双向一致性。

### last_verified

最后验证本文档与项目内容一致的日期。格式：`YYYY-MM-DD`。
