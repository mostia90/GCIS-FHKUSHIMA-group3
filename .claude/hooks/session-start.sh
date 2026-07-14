#!/bin/bash
set -euo pipefail

DOC_FILE_ID="1nQfsSNw2x1iUskOO5Lw_Au4fy4f0zx3cG9z0ONnF1C0"
DOC_URL="https://docs.google.com/document/d/${DOC_FILE_ID}/edit"
REPO_FILE="docs/team/研究計画書_3G.md"

CONTEXT=$(cat <<EOF
チームが編集中のGoogleドキュメント「福島学探究：研究計画書（３G）」のスナップショットが
${REPO_FILE} に保存されています。このドキュメントは現在も編集され続けているため、
他の作業に着手する前に、一度だけ最新版との同期を行ってください。

手順:
1. Google Drive の read_file_content ツールを fileId=${DOC_FILE_ID} で呼び出し、
   ドキュメントの最新内容を取得する（URL: ${DOC_URL}）。
2. 取得した本文を ${REPO_FILE} 内の既存本文（冒頭のヘッダーコメントを除く部分）と比較する。
3. 差分がある場合のみ、ヘッダーコメント内の「取得日時」を本日の日付に更新した上で
   本文を最新内容に置き換え、コミットして現在のブランチにプッシュする。差分がなければ
   ファイルには一切手を加えない。
4. 同期を実行したこと（更新の有無）をユーザーに一言で報告する。ユーザーから明示的な
   依頼がなくても、セッション開始時に自律的に行ってよい。

Google Drive のツールが利用できない場合（MCPサーバー未接続など）は、無理に同期を試みず、
接続後にあらためて行う旨をユーザーに伝えてください。
EOF
)

python3 - "$CONTEXT" <<'PY'
import json
import sys

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "SessionStart",
        "additionalContext": sys.argv[1],
    }
}))
PY
