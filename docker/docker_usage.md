# docker

a **container** is launched by running an image. an **image** is an executable package that includes everything needed to run an application.

references:

* [r_docker_tutorial](https://ropenscilabs.github.io/r-docker-tutorial/)
* [get started with docker](https://docs.docker.com/get-started/)

## commands

`docker --version` shows the docker version, and `docker version` or `docker info` shows detailed information.

`docker images` lists the images available now.

the following stages are used to push an exsiting image to docker hub:

* `docker login --username=yourhubusername --email=youremail@company.com` - log into hub from the command line
* `docker tag image_id yourhubusername/verse_gapminder:firsttry` - tag an image, and the `:firsttry` is the tag
* `docker push yourhubusername/verse_gapminder` - push the image to the repository you created

`docker build -t shinyproxy/shiny_base_xz .` builds an image, and all the resources needed are in the current path.

`docker pull openanalytics/r-base` - pulls a new image.

`docker save` saves a docker image, and `docker load` loads an image.

    docker save verse_gapminder > verse_gapminder.tar
    docker load --input verse_gapminder

`docker run` runs an docker image.

    docker run -it --rm r-base /usr/bin/bash
    docker run -it --rm  --net sp-example-net -p 3838:3838 shinyproxy_test3

options:

* `it` - run in the foreground
* `-d` - run in the background
* `-p 3838:3838` - port for visit
* `--rm` - delete container when quit the container. otherwise, that container will be saved to the local computer
* `-v local_path:container_path` - link a volume to a docker container to access data and save files

`docker ps` lists the running containers.

    docker ps -a -q

`docker exec -it <container-id> bash` starts a bash shell in the specified container.

`docker commit` saves the modified container as an new image.

    docker commit -m "verse + gapminder" 4a6a528b35da verse_gapminder

* `4a6a528b35da` - the hash for the version of the container
* `verse_gapminder` - the new name for the image
* `-m` - commit message

`docker stop` stops containers.

    docker stop $(docker ps -a -q)

* `docker network create sp-example-net`
* `docker rm $(docker ps -a -q)`
* `docker rmi ef8caddd49cb` - `e4a158184cc5` is image id 

## Dockerfile

`Dockerfile` is a set of instructions on how to add things to a base image. they build custom images up in a series of layers.

the available commands are:

* `from` - must always be the **first** thing in the `Dockerfile`
* `MAINTAINER` - image maintainer info
* `RUN` - execute shell commands to build up the image
* `WORKDIR` - set the working directory
* `COPY`- copy files inside the docker image
* `ADD` - add some files inside the docker image, similar to `COPY`, but can add remote files
* `EXPOSE` - document where a service is available, but not create any mapping to the host
* `ENV` - define environment variable
* `CMD` - command when container launches
