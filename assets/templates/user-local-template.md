---
last_updated:
---

# 用户画像

## 知识面画像

### 已确认的知识领域

<!-- 用户主动输入的知识作为证据 -->

### 已识别的知识盲区

<!-- 用户提出的问题作为证据 -->

### 详略调整策略

<!-- 哪些领域需要详尽解释，哪些可以简略 -->

## 沟通偏好

<!-- 用户偏好的沟通风格、详略程度、工作习惯 -->

## 交互记录摘要

<!-- 关键讨论结论的简要索引，帮助跨会话恢复上下文 -->

## 智能体配置

<!-- 当智能体作为使用者时的配置信息 -->

```yaml
agent:
  platform: ""          # Claude Code / Cursor / Copilot 等
  capabilities: []      # 支持的能力：sub-agent, hooks, CI 等
  preferences:
    auto_audit: false   # 是否在提交时自动审计
    brief_depth: full   # BRIEF 默认深度：minimal / standard / full
```
