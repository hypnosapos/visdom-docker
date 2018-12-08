ARG PY_VERSION=3.6
ARG DIST=slim-stretch

FROM python:${PY_VERSION}-${DIST}

RUN apt-get update && apt-get install git -y

RUN git clone https://github.com/facebookresearch/visdom.git /root/visdom

ADD ./commitish ./root/

RUN cd /root/visdom && \
    git checkout $(cat /root/commitish)

FROM python:${PY_VERSION}-${DIST}

MAINTAINER Enrique Garcia <engapa@gmail.com>

LABEL io.k8s.description="Visdom server" \
      io.k8s.display-name="Visdom server"

COPY --from=0 /root/visdom /root/visdom

ENV HOSTNAME='localhost'
ENV PORT=8097
ENV ENV_PATH="~/.visdom/"
ENV LOGGING_LEVEL=INFO

RUN cd /root/visdom && pip install .

EXPOSE $PORT

CMD python -m visdom.server -port ${PORT} -env_path ${ENV_PATH} -logging_level ${LOGGING_LEVEL}
