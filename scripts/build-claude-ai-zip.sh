#!/usr/bin/env bash
# claude.ai 업로드용 zip 생성
# claude.ai는 disable-model-invocation 키를 거부하므로 빌드본에서만 그 줄을 뺀다
set -euo pipefail
cd "$(dirname "$0")/.."
name=korean-humanizer-plus
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
cp -R "skills/$name" "$tmp/$name"
rm -rf "$tmp/$name/agents"
sed -i.bak '/^disable-model-invocation:/d' "$tmp/$name/SKILL.md" && rm "$tmp/$name/SKILL.md.bak"
mkdir -p dist
rm -f "dist/$name.zip"
(cd "$tmp" && zip -rq - "$name" -x '*.DS_Store') > "dist/$name.zip"
echo "dist/$name.zip"
