FROM        gcr.io/epsilon-jenkins/jvm-tools:latest
MAINTAINER  tdeheurles@gmail.com

EXPOSE      9000
ADD         ./stage     /service

RUN         chmod 777 /service/bin/kubeui
ENTRYPOINT  /service/bin/kubeui


# TODO: ADD artifact to some PATH
# TODO: ENTRYPOINT command to run the artifact
