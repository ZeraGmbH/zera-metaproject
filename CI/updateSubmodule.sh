#!/bin/bash

git submodule update --init
git -c "user.name=gitbot" -c "user.email=gitbot" submodule update --init --remote --rebase --
newCommits="$(git status | grep 'new commits')"
echo "$newCommits"
workroot=$(pwd)
while read -r path
do
    submodulepath=$(echo $path | sed -re 's/^\s*(\S*)\s*(\S*).*/\2/g')
    submodule=${submodulepath##*/} 
    branch=$(git config --file=.gitmodules -l | grep branch | grep $submodule | sed -r 's/.*branch=(.*)/\1/')
    if [ -z "$branch" ]
    then
      branch="master"
    fi
    if [ -z "$submodulepath" ]
    then
        exit 1
    fi
    cd $submodulepath
    git checkout $branch
    cd $workroot
    currentid=$(git rev-parse HEAD:$submodulepath)
    git add $submodulepath
    cd $submodulepath
    reflogmsg=$(git log --pretty=format:"%h %s" $currentid..)
    cd $workroot
    git -c "user.name=gitbot" -c "user.email=gitbot@noreply.de"  commit -s -m "update $submodule" -m "$reflogmsg"
done < <(echo "$newCommits")