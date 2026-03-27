---
project_name: vision-maker
last_updated: 2026-03-27
---

# 自动化集成配置

## Git Hooks

```yaml
pre_commit:
  enabled: false
  mode: audit
  scope: changed
  fail_on_error: true
```

## CI 集成

```yaml
ci:
  platform: ""
  workflow_file: ""
  triggers:
    - push_main
    - pull_request
  actions:
    - audit
    - report
```

## 自定义检测规则

| 规则 | 检查内容 | 失败时动作 |
|------|---------|-----------|
| 自洽性检查 | .vision/ 文档是否遵循 vision-maker 自己的方法论 | 警告 |
| 模板一致性 | 文档 front-matter 是否匹配 assets/templates/ 结构 | 警告 |
| references 同步 | references/ 中的文件是否与 SKILL.md 中的引用一致 | 错误 |

## 一致性标记配置

```yaml
commit_footer:
  enabled: true
  format: emoji
  template: ""
```
