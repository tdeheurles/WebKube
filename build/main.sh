#!/usr/bin/env bash
# Jenkins Entrypoint

# We share Epsilon-Bootstrap for maven container acces
# we share .m2 in jenkins-agent for settings
# import names


# Name it
. ./build/release.cfg
artifact_name="gcr.io/$projectid/$servicename"
artifact_tag="$artifact_name:$servicemajor.$serviceminor.$BUILD_NUMBER"
echo "artifactname=\"$artifac_tag\"" > ./build/containername.cfg


# Build binaries
workspace="workspace"
docker run \
  --rm \
  -v "$(pwd):/$workspace" \
  -v "/home/$(whoami)/.ivy2:/root/.ivy2" \
  -v "/home/$(whoami)/.sbt:/root/.sbt" \
  gcr.io/adaptive-jenkins/jvm-tools:latest "/$workspace/build/kubui.sh"


# Prepare container
cp -r ./target/universal/stage   ./build/container/stage
gcloud preview docker -- build -t $artifact_name ./build/container/
docker tag $artifact_name $artifact_tag


# Push to Google Cloud Engine
gcloud preview docker push $artifact_name
gcloud preview docker push $artifact_tag
