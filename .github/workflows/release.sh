#!/bin/bash
set -x

TAG=${GITHUB_REF##*/}
GITHUB_ACCESS_TOKEN=$1

zip -9 test-windows_amd64.zip README.md
tar czvf test-linux_amd64.tar.gz README.md

echo Token len: ${#1} - ${GITHUB_ACCESS_TOKEN:2}

curl -H "Authorization: token $GITHUB_ACCESS_TOKEN" https://api.github.com/users/codertocat

curl -v \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token $GITHUB_ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  https://api.github.com/repos/reznikmm/test/releases \
  -d "{\"tag_name\":\"$TAG\",\"name\":\"$TAG\",\"body\":\"Next release\"}"

upload_url=$( curl \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token $GITHUB_ACCESS_TOKEN" \
  https://api.github.com/repos/reznikmm/test/releases/tags/$TAG | \
  jq .upload_url | sed -e 's/"//g' -e 's/{.*}//' )

echo "upload_url=$upload_url"

for J in *.zip *.gz; do
curl \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: token $GITHUB_ACCESS_TOKEN" \
  -H 'Content-Type: application/zip' \
  --data-binary @$J \
  $upload_url?name=$J
done
