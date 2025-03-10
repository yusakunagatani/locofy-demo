#!/bin/bash

# このスクリプトは使用されていない画像ファイルを検出して削除します

# 作業ディレクトリを設定
cd /Users/nagatani/Desktop/Projects/locofy-demo

# HTMLファイルから使用されている画像のリストを作成
USED_IMAGES=$(grep -o "src=\"./public/[^\"]*\"" Homepage.html | sed 's/src="\.\///' | sed 's/"//' | sort | uniq)

# パブリックディレクトリ内の全画像ファイルのリストを作成
ALL_IMAGES=$(find public -type f \( -name "*.svg" -o -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" \) | sort)

echo "使用されている画像ファイル："
echo "$USED_IMAGES"
echo ""
echo "削除対象の画像ファイル："

# 使用されていない画像を検出して削除
for img in $ALL_IMAGES; do
  if ! echo "$USED_IMAGES" | grep -q "$img"; then
    echo "削除: $img"
    # 実際に削除する
    rm "$img"
  fi
done

echo ""
echo "スクリプト完了。すべての未使用画像を削除しました。"
