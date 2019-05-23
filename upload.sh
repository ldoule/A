#!/bin/bash

VersionString=`grep -E 's.version.*=' A.podspec`
# VersionNumber=`tr -cd 0-9 <<<"$VersionString"`
VersionNumber=`<<<"$VersionString"`
# NewVersionNumber=$(($VersionNumber + 1))
NewVersionNumber=$(date +%Y%m%d%H%M%S)
LineNumber=`grep -nE 's.version.*=' A.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" A.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
pod repo push dlrepo A.podspec --verbose --allow-warnings --use-libraries --use-modular-headers

