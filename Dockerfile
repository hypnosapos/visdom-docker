FROM python:3.6-jessie

ARG COMMITISH=3e99bb0

ENV HOSTNAME='localhost'
ENV PORT=8097
ENV ENV_PATH="~/.visdom/"
ENV LOGGING_LEVEL=INFO

RUN apt-get install git

RUN git clone https://github.com/facebookresearch/visdom.git /usr/share/visdom
RUN cd /usr/share/visdom &&\
    git reset --hard $COMMITISH &&\
    pip install -U pip &&\
    pip install .

EXPOSE $PORT

CMD python -m visdom.server -port ${PORT} -env_path ${ENV_PATH} -logging_level ${LOGGING_LEVEL}
