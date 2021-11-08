#!/bin/sh

# check GITHUB_TOKEN
if [ -z "${GITHUB_TOKEN}" ]; then
    echo "error: not found GITHUB_TOKEN"
    exit 1
fi

if [ -z "${BRANCH_NAME}" ]; then
   export BRANCH_NAME=main
fi

# initialize git
remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git config http.sslVerify false
git config user.name "simple-github-auto-push"
git config user.email "actions@users.noreply.github.com"
git remote add origin "${remote_repo}"
git show-ref # useful for debugging
git branch --verbose

# push to github
git checkout ${BRANCH_NAME}
git add -A
timestamp=$(date -u)
git commit -m "simple-github-auto-push: ${timestamp} ${GITHUB_SHA}" || exit 0
git pull --rebase origin ${BRANCH_NAME}
git push origin ${BRANCH_NAME}
