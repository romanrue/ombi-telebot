FROM python:3.9-alpine as base

RUN apk update \
  && apk add --no-cache \
    curl

RUN mkdir /app
WORKDIR /app


COPY requirements.txt requirements.txt

# RUN pip install --upgrade pip
RUN pip install --upgrade pip \
  && pip install -r requirements.txt

COPY . .

LABEL maintainer="Roman Rüttimann <roman.ruettimann@gmail.com>"

FROM scratch as user
COPY --from=base . .

ARG HOST_GID=${HOST_GID:-1000}
ARG HOST_GROUP=${HOST_GROUP:-docker}
ARG HOST_UID=${HOST_UID:-4000}
ARG HOST_USER=${HOST_USER:-nodummy}

RUN addgroup -Sg ${HOST_GID} ${HOST_GROUP} \
  && adduser -Su ${HOST_UID} -g ${HOST_GROUP} -s /bin/sh ${HOST_USER}

RUN [ "${HOST_USER}" == "root" ] || \
   chown -R "${HOST_UID}:${HOST_UID}" /app

USER ${HOST_USER}
WORKDIR /app

CMD gunicorn -c gunicorn.py "app.app:create_app()"
