#!/usr/bin/env bash
# Jenkins Entrypoint

# We share Epsilon-Bootstrap for maven container acces
# we share .m2 in jenkins-agent for settings
# import names
. ./build/release.cfg
artifactname="gcr.io/$projectid/$servicename:$servicemajor.$serviceminor.$BUILD_NUMBER"
echo "artifactname=\"$artifactname\"" > ./build/containername.cfg


# Build binaries
workspace="workspace"
docker run \
  --rm \
  -v "$(pwd):/$workspace" \
  gcr.io/adaptive-jenkins/jvm-tools:latest "/$workspace/build/kubui.sh"


# Prepare container
cp ./target/universal/stage   ./build/container/stage
gcloud preview docker -- build -t $artifactname ./build/container/


# Push to Google Cloud Engine
gcloud preview docker push $artifactname
