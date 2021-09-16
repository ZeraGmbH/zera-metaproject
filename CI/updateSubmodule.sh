#!/bin/bash

submodule=${1}
workroot=$(pwd)
submodulepath=$(grep path .gitmodules | sed 's/.* //' | grep $submodule)
branch=$(grep branch .gitmodules | sed 's/.* //' | grep $submodule)
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
git -c "user.name=gitbot" -c "user.email=gitbot" submodule update --init --remote --rebase -- $submodulepath
git add $submodulepath
cd $submodulepath
reflogmsg=$(git log --pretty=format:"%h %s" $currentid..)
cd $workroot
git -c "user.name=gitbot" -c "user.email=gitbot@noreply.de"  commit -s -m "update $submodule" -m "$reflogmsg"
