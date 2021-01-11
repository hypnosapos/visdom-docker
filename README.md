# Visdom [![Build status](https://circleci.com/gh/hypnosapos/visdom-docker/tree/master.svg?style=svg "Build status")](https://circleci.com/gh/hypnosapos/visdom-docker/tree/master)![We love open source](https://badges.frapsoft.com/os/v1/open-source.svg?v=103 "We love open source")

[![Docker image](http://dockeri.co/image/hypnosapos/visdom)](https://hub.docker.com/r/hypnosapos/visdom)

If you want to run [visdom server](https://github.com/facebookresearch/visdom) by a docker container this is for you.

## Build your own image

Not all versions of original project are released, so if you want to build a particular version (I mean "commit-ish") of sources
then update the **commitish** file:

```bash
$ docker build -t hypnosapos/visdom:$(cat commitish) .
```

Default version of python is **3.9** (build arg PY_VERSION) and distribution is **slim** (build arg DIST),
 thus add your custom values if your want other base docker image, here an example:

```bash
$ docker build --build-arg PY_VERSION=3.9 --build-arg DIST=slim -t hypnosapos/visdom:3.9-slim-$(cat commitish) .
```

## Play

Before running the container take a look at the following env variables  ( `-e NAME=VALUE`):

|         Name         |        Default    |
|----------------------|-------------------|
| `PORT`               | 8097              |
| `ENV_PATH`           | $HOME/.visdom     |
| `LOGGING_LEVEL`      | INFO              |
| `HOSTNAME`           | localhost         |
| `BASE_URL`           | /                 |
| `READONLY`           | True              |
| `ENABLE_LOGIN`       | False             |
| `FORCE_NEW_COOKIE`   | False             |

Now we're ready to run the container

```bash
$ docker run -it -p 8097:8097 [-e NAME=VALUE] --name visdom hypnosapos/visdom:$(cat commitish)
```

In order to preserve data or sessions we recommend you attach a volume to persist them (obviously):

```bash
$ docker run -it -v <path>:<env_path> -p 8097:8097 -e ENV_PATH=<env_path> --name visdom hypnosapos/visdom:$(cat commitish)
```

Using default values server would be ready at http://localhost:8097

## Trying visdom 

To play with some examples once our docker container is running we recommend you try:

```bash
docker exec -it visdom bash -c "python /root/visdom/example/demo.py"
```

And then check out examples at: http://localhost:8097


I hope it helps :satisfied: !!
