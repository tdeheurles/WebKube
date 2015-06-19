#! /bin/bash
# Generate manifests for v1beta3
newfile=./deploy/kubernetes/$servicename\_$versiontag\_rc.json
versiontag=$servicemajor.$serviceminor.$BUILD_NUMBER

sed "s/__RCNAME__/$servicename-m$servicemajor\m$serviceminor\m$BUILD_NUMBER/g" \
    ./deploy/kubernetes/v1beta3/rc.template.yml > $newfile
sed -i "s/__MAJOR__/$servicemajor/g" $newfile
sed -i "s/__MINOR__/$serviceminor/g" $newfile
sed -i "s/__BUILD__/$BUILD_NUMBER/g" $newfile
sed -i "s/__IMAGE__/$artifact_tag/g" $newfile
sed -i "s/__REPLICAS__/0/g" $newfile
sed -i "s/__CONTAINERREGISTRY__/0/g" $newfile
