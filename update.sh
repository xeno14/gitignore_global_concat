#!/bin/bash

git config --global user.name "xeno14"
git config --global user.email "integral14.dev@gmail.com"

git remote set-url origin https://xeno14:${GITHUB_TOKEN}@github.com/xeno14/gitignore_global_concat

git submodule update --init
git submodule foreach git fetch
git submodule foreach git rebase origin/master

bash concat.sh

if [ -z "$(git status --porcelain)"  ]; then
    # Working directory clean
    echo "Working directory is clean. No need to commit."
  else
    # Uncommitted changes
    echo "Detected upstream changes. The latest commit=${GITIGNORE_HASH}."

    cd gitignore
    GITIGNORE_HASH=$(git rev-parse --short HEAD)
    cd ..

    git commit -a -m"[updater] gitignore ${GITIGNORE_HASH}"
    git push origin HEAD

    echo "Done."
fi
