# Visdom [![Build status](https://circleci.com/gh/hypnosapos/visdom-docker/tree/master.svg?style=svg "Build status")](https://circleci.com/gh/hypnosapos/visdom-docker/tree/master)

[![Docker image](http://dockeri.co/image/hypnosapos/visdom)](https://hub.docker.com/r/hypnosapos/visdom)

If you want to run [visdom server](https://github.com/facebookresearch/visdom) by a docker container this is for you.

## Build your own image

Not all versions of original project are released, so if you want to build a particular version (I mean "commit-ish") of sources
then add the COMMITISH build-arg when you're building the image:

```bash
$ docker build --build-arg COMMITISH=<commitish> -t hypnosapos/visdom:<tag>
```

> NOTE: Replace \<commitish\> and \<tag\> values with appropriate ones, both may be the same

## Play

```bash
$ docker run -p 8097:8097 hypnosapos/visdom:latest
```

You can use any of the following env variables ( `-e NAME=VALUE`):

|         Name         |        Default    |
|----------------------|-------------------|
| `PORT`               | 8097              |
| `ENV_PATH`           | $HOME/.visdom     |
| `LOGGING_LEVEL`      | INFO              |

In order to preserves data or sessions we recommend you attach a volume to persist them (obviously):

```bash
$ docker run -v <dest_path>:<env_path> -p 8097:8097 -e ENV_PATH=<env_path> hypnosapos/visdom:latest
```

> NOTE: Env variable argument for \<env_path\> is optional (-e ENV_PATH=<env_path>), in case this argument was not provided then the value for target directory on the container must be the default value <i>/root/.visdom/</i>
> (e.g. -v /tmp/visdom/:/root/.visdom/)

Using default values, server would be ready at http://localhost:8097

## Testing visdom server

The python script `visdom_connection_test.py` helps you to test visdom server connection,
 enter command below to see more options or details:

```bash
./visdom_connection_test.py --help
```

I'm using it, for example, in my CI builds with [CircleCI](.circleci/config.yml).

Finally, and the most important thing, i hope it helps :satisfied: !!
