---
project_name: ""
last_updated:
---

# 自动化集成配置

> 本文件由 INIT 阶段创建，定义项目如何将 vision-maker 集成到开发工作流中。

## Git Hooks

```yaml
pre_commit:
  enabled: false
  mode: audit          # audit: 仅审计 / audit-fix: 审计+自动修复
  scope: changed       # changed: 仅变更文件 / full: 全量
  fail_on_error: true  # 发现问题时是否阻止提交
```

## CI 集成

```yaml
ci:
  platform: ""         # github-actions / gitlab-ci / jenkins
  workflow_file: ""    # CI workflow 文件路径
  triggers:
    - push_main        # 推送到主分支时
    - pull_request     # PR 时
  actions:
    - audit            # 执行审计
    - report           # 生成报告
```

## 自定义检测规则

<!-- 项目可在此注册自定义的自检规则 -->

| 规则 | 检查内容 | 失败时动作 |
|------|---------|-----------|
| | | |

## 一致性标记配置

```yaml
commit_footer:
  enabled: true
  format: emoji        # emoji / text
  template: ""         # 自定义模板（可选）
```
