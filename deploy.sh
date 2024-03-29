#!/usr/bin/env sh
# 确保脚本抛出遇到的错误
set -e
npm run build # 生成静态文件
cd docs/.vuepress/dist # 进入生成的文件夹

# deploy to github
if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:${GITHUB_REPOSITORY}.git
else
  msg='来自github action的自动部署'
  githubUrl=https://user:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
fi

git config --global user.name "zephyru"
git config --global user.email "zephyru@163.com"


git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github

cd -
rm -rf docs/.vuepress/dist