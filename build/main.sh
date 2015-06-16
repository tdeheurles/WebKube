#!/usr/bin/env bash
# Jenkins Entrypoint

# We share Epsilon-Bootstrap for maven container acces
# we share .m2 in jenkins-agent for settings
# import names

. ./build/release.cfg

artifact_version="$servicemajor.$serviceminor.$BUILD_NUMBER"
artifactname="gcr.io/$projectid/$servicename"
echo "artifactname=\"$artifactname:$artifact_version\"" > ./build/containername.cfg


# Build binaries
workspace="workspace"
docker run \
  --rm \
  -v "$(pwd):/$workspace" \
  -v "/home/$(whoami)/.ivy2:/root/.ivy2" \
  -v "/home/$(whoami)/.sbt:/root/.sbt" \
  gcr.io/adaptive-jenkins/jvm-tools:latest "/$workspace/build/kubui.sh"


# Prepare container
cp ./target/universal/stage   ./build/container/stage
gcloud preview docker -- build -t $artifactname ./build/container/
docker tag $artifactname $artifactname:$artifact_version

# Push to Google Cloud Engine
gcloud preview docker push $artifactname
gcloud preview docker push $artifactname:$artifact_version
