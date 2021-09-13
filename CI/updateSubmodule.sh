#!/bin/bash

submodule=${1}
workroot=$(pwd)
submodulepath=$(grep path .gitmodules | sed 's/.* //' | grep $submodule)
branch=$(grep branch .gitmodules | sed 's/.* //' | grep $submodule)
if [ -z "$branch" ]
then
      branch="master"
fi
cd $submodulepath
git checkout $branch
cd $workroot
currentid=$(git rev-parse HEAD:$submodulepath)
git -c "user.name=Your Name" -c "user.email=Your email" submodule update --init --remote --rebase -- $submodulepath
git add $submodulepath
cd $submodulepath
reflogmsg=$(git log --pretty=format:"%h %s" $currentid..)
cd $workroot
git -c "user.name=gitbot" -c "user.email=gitbot@noreply.de"  commit -s -m "ugrade $submodule" -m "$reflogmsg"
