FROM supersandro2000/base-alpine:3.12

RUN apk add --no-cache --no-progress \
    abuild \
    g++ \
    git \
    make \
    vim

RUN adduser root abuild \
  && abuild-keygen -ain

COPY  [ "files/abuild-alias.sh", "/etc/profile.d/" ]

WORKDIR /git
CMD [ "bash", "--login" ]
