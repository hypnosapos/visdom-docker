# Visdom
[![Docker image](http://dockeri.co/image/hypnosapos/visdom)](https://hub.docker.com/r/hypnosapos/visdom)


If you want to run [visdom server](https://github.com/facebookresearch/visdom) by a docker container this is for you.

## Build your own image

Not all versions of original project are released, so if you want to build a particular version (i mean "commit-ish") of sources
then add the suitable arg value in build time on this way:

```sh
$ docker build --build-arg COMMITISH=<commitish> -t hypnosapos/visdom:<tag>
```

> NOTE: Replace <commitish> and <tag> with appropriate values, both two may be the same

## Play

```sh
$ docker run -p 8097:8097 hypnosapos/visdom:latest
```

You can use any of the following env variables ( `-e NAME=VALUE`):

|         Name         |        Default    |
|----------------------|-------------------|
| `PORT`               | 8097              |
| `ENV_PATH`           | $HOME/.visdom     |
| `LOGGING_LEVEL`      | INFO              |


Using default values server would be ready at http://localhost:8097

