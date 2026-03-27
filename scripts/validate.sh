#!/bin/bash
# Vision Maker 结构性快检脚本
# 用于验证 .vision/ 文档体系的基本完整性

set -e

VISION_DIR=".vision"
ERRORS=0
WARNINGS=0

# 颜色输出
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "=== Vision Maker 结构性快检 ==="
echo ""

# 检查 1: .vision/ 目录存在
if [ ! -d "$VISION_DIR" ]; then
    echo -e "${RED}[ERROR]${NC} .vision/ 目录不存在"
    echo "  建议：运行 vision-maker INIT 模式建立文档体系"
    ERRORS=$((ERRORS + 1))
    exit 1
fi
echo -e "${GREEN}[OK]${NC} .vision/ 目录存在"

# 检查 2: .meta/knowledge.md 存在且非空
KNOWLEDGE_FILE="$VISION_DIR/.meta/knowledge.md"
if [ ! -f "$KNOWLEDGE_FILE" ]; then
    echo -e "${RED}[ERROR]${NC} .meta/knowledge.md 不存在"
    ERRORS=$((ERRORS + 1))
elif [ ! -s "$KNOWLEDGE_FILE" ]; then
    echo -e "${RED}[ERROR]${NC} .meta/knowledge.md 存在但为空"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}[OK]${NC} .meta/knowledge.md 存在且非空"
fi

# 检查 3: .meta/integration.md 存在
INTEGRATION_FILE="$VISION_DIR/.meta/integration.md"
if [ ! -f "$INTEGRATION_FILE" ]; then
    echo -e "${YELLOW}[WARN]${NC} .meta/integration.md 不存在（自动化集成未配置）"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${GREEN}[OK]${NC} .meta/integration.md 存在"
fi

# 检查 4: VISION.md 存在
VISION_FILE="$VISION_DIR/VISION.md"
if [ ! -f "$VISION_FILE" ]; then
    echo -e "${RED}[ERROR]${NC} VISION.md（文档图根节点）不存在"
    ERRORS=$((ERRORS + 1))
else
    echo -e "${GREEN}[OK]${NC} VISION.md 存在"
fi

# 检查 5: user.local.md 存在
USER_FILE="$VISION_DIR/.meta/user.local.md"
if [ ! -f "$USER_FILE" ]; then
    echo -e "${YELLOW}[WARN]${NC} .meta/user.local.md 不存在（用户画像未初始化）"
    WARNINGS=$((WARNINGS + 1))
else
    echo -e "${GREEN}[OK]${NC} .meta/user.local.md 存在"
fi

# 检查 6: 基本关系完整性（检查 front-matter 中的引用是否指向存在的文件）
echo ""
echo "--- 关系完整性检查 ---"
RELATION_ERRORS=0

for md_file in $(find "$VISION_DIR" -name "*.md" -type f); do
    # 提取 depends_on, children, referenced_by 中引用的文件
    for field in "depends_on" "children" "referenced_by"; do
        # 使用 grep 提取该字段的值（支持多行 YAML 数组）
        # || true 防止管道中 grep 无匹配时 set -e 终止脚本
        refs=$(sed -n "/^${field}:/,/^[a-z]/p" "$md_file" | grep -E "^\s*-\s" | sed 's/^[[:space:]]*-[[:space:]]*//' | tr -d ' ' | grep -v '^$' || true)
        for ref in $refs; do
            if [ -n "$ref" ] && [ "$ref" != "[]" ]; then
                # 路径相对于 .vision/
                target="$VISION_DIR/$ref"
                if [ ! -f "$target" ]; then
                    echo -e "${RED}[ERROR]${NC} $(basename $md_file) 的 ${field} 引用了不存在的文件: $ref"
                    RELATION_ERRORS=$((RELATION_ERRORS + 1))
                fi
            fi
        done
    done
done

if [ $RELATION_ERRORS -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 所有关系引用指向存在的文件"
else
    ERRORS=$((ERRORS + RELATION_ERRORS))
fi

# 总结
echo ""
echo "=== 检查完成 ==="
echo -e "错误: ${RED}${ERRORS}${NC}, 警告: ${YELLOW}${WARNINGS}${NC}"

if [ $ERRORS -gt 0 ]; then
    echo -e "${RED}存在错误，建议运行 vision-maker 修复。${NC}"
    exit 1
elif [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}存在警告，建议补充配置。${NC}"
    exit 0
else
    echo -e "${GREEN}所有检查通过！${NC}"
    exit 0
fi
