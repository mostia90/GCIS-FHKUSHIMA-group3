---
name: advise
description: Review a Google Document (research plan, survey design, discussion draft) as the research advisor for the 福島学探究3G project, grading it against docs/reference/ materials. Use when the user runs /advise followed by a Google Docs URL or file ID.
---

# /advise — 研究アドバイザーレビュー

`/advise <GoogleドキュメントのURLまたはファイルID>` の形で呼び出される。
生徒が新たにアップロード・更新したGoogleドキュメント（研究計画書、アンケート案、考察など）を、
`docs/reference/` 内の参考資料（教授面談記録・講義要約・リサーチクエスチョンのチェックリスト等）
に基づいてレビューする。

## 手順

1. **引数の解析**: コマンドに続くURL/ファイルIDからGoogle DriveのfileIdを抽出する
   （`https://docs.google.com/document/d/<fileId>/edit...` 形式、または生のID）。
2. **参考資料の読み込み**: まだ読み込んでいなければ `docs/reference/` 内のPDF6点を読む
   （CLAUDE.mdの「参考資料」セクションに各ファイルの要点が記載されている）。
3. **対象ドキュメントの読み込み**: `mcp__Google_Drive__read_file_content`（または
   `download_file_content` + `exportMimeType: text/plain`）でドキュメント本文を取得する。
   - アクセス権エラーが出た場合は、ユーザーに共有設定の確認を依頼する。
4. **レビュー観点での評価**（CLAUDE.mdの「レビューの進め方」に準拠）:
   - リサーチクエスチョンが疑問文として明確か、絞られているか（`04`のチェックリスト）
   - 先行研究・既知の整理ができているか
   - 調査方法（アンケート設計、変数の分類）に必然性があるか、要素を入れすぎていないか（`01`・`06`）
   - 「福島で調査する必然性」が説明されているか（`06`の指摘）
   - 研究計画書のフォーマット（対象・先行研究・理論・方法・分析・結論）に沿っているか（`05`）
5. **レビュー記事の作成**: `reviews/<対象文書名>-review.md` として保存する。各観点ごとに
   「良い点」「引っかかる点」「改善案」を具体的に（参考資料の該当箇所を引用しつつ）記述する。
   Googleドキュメントへの直接コメント投稿は現行ツールセットでは未対応のため行わない。
6. **報告**: レビューを保存したファイルパスを伝え、特に重要な指摘を2〜3点要約してチャットに出す。

## 注意

- ファイルIDが渡されない、または抽出できない場合はユーザーに再度リンクを求める。
- 同名のレビューファイルが既に存在する場合は上書きせず、ユーザーに再レビューか別名保存かを確認する。
