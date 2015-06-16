FROM        gcr.io/adaptive-jenkins/jvm-tools
MAINTAINER  tdeheurles@gmail.com

EXPOSE      9000
ADD         ./stage     /service

RUN         chmod 777 /service/bin/kubeui.sh
ENTRYPOINT  /service/bin/kubeui.sh


# TODO: ADD artifact to some PATH
# TODO: ENTRYPOINT command to run the artifact
