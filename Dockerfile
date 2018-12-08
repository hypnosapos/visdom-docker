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
ENV LOGGING_LEVEL='INFO'
ENV READONLY="True"
ENV ENABLE_LOGIN="False"
ENV FORCE_NEW_COOKIE="False"
ENV BASE_URL="/"

RUN cd /root/visdom && pip install .

ADD ./visdom_connection_test.py /root/

EXPOSE $PORT

CMD python -m visdom.server \
    --hostname ${HOSTNAME} \
    -port ${PORT} \
    -base_url ${BASE_URL} \
    -env_path ${ENV_PATH} \
    -logging_level ${LOGGING_LEVEL} \
    $(if [ "${READONLY}" == "True" ];then echo "-readonly";fi) \
    $(if [ "${FORCE_NEW_COOKIE}" == "True" ];then echo "-force_new_cookie";fi) \
    $(if [ "${ENABLE_LOGIN}" == "True" ];then echo "-enable_login";fi)

