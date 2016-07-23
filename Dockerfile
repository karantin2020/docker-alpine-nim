FROM alpine:3.3

RUN apk update && apk upgrade \
  && apk add g++ git \
  && rm -rf /var/cache/apk/* \
  && apk add --no-cache --virtual=build-dependencies ca-certificates && \
  \
  mkdir -p "/opt" && \
  cd "/opt" && \
  git clone -b devel --depth 1 https://github.com/nim-lang/nim Nim && \
  cd Nim && \
  git clone -b devel --depth 1 https://github.com/nim-lang/csources csources && \
  cd csources && \
  sh build.sh && \
  cd .. &&\
  rm -rf "./csources" "./tests" && \
  bin/nim c koch && \
  ./koch boot -d:release && \
  ln -s "/opt/Nim/bin/nim" "/usr/local/bin/nim" && \
  \
  export NIMBLE_VERSION=0.7.4 && \
  cd "/opt" && \
  wget "https://github.com/nim-lang/nimble/archive/v$NIMBLE_VERSION.tar.gz" -O - | tar xz && \
  cd "nimble-$NIMBLE_VERSION" && \
  nim compile --run "src/nimble" build && \
  mv nimble "/usr/local/bin/" && \
  rm -rf "/opt/nimble-$NIMBLE_VERSION" && \
  \
  apk del build-dependencies

COPY ./nim-update.sh /opt/nim-update.sh
