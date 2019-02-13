# docker

a **container** is an instance of an image and an **image** is an executable
package that includes everything needed to run an application. an image can have many running containers.

`docker --version` shows the docker version, and `docker version` or `docker
info` shows detailed information.

## images

* `docker pull openanalytics/r-base` - pulls a new image.
* `docker images` lists the images available now.
* `docker rmi ef8caddd49cb` - `e4a158184cc5` is image id
* `docker save` saves an existing docker image for backup, and `docker load` loads a backup image.

        docker save verse_gapminder > verse_gapminder.tar
        docker load --input verse_gapminder

* `docker network create sp-example-net`
    * `--subnet=192.168.187.0/24`
* `docker network rm sp-example-net`
* `docker run` runs an docker image.
    * `it` - run in the foreground
    * `-d` - run in the background
    * `-p 3838:3838` - port for visit
    * `--rm` - delete container when quiting the container. otherwise, that container will be saved to the local computer
    * `-v local_path:container_path` - link a volume to a docker container to access data and save files
    
            docker run -it --rm r-base /usr/bin/bash
            docker run -it --rm  --net sp-example-net -p 3838:3838 shinyproxy_test3
    
the following stages are used to push an exsiting image to docker hub:
    
* `docker login --username=yourhubusername --email=youremail@company.com` - log
  into hub from the command line
* `docker tag image_id yourhubusername/verse_gapminder:firsttry` - tag an
  image, and the `:firsttry` is the tag
* `docker push yourhubusername/verse_gapminder` - push the image to the
  repository you created

## containers

* `docker start container-id` - starts an stopped container
* `docker stop container-id or $(docker ps -a -q)` - stops containers
* `docker rm $(docker ps -a -q)` - removes containers
* `docker ps` lists the running containers.
    * `-a` - lists all containers
    * `-q` - lists all containers' id

            docker ps -a -q

* `docker exec -it <container-id> bash` starts a bash shell in the specified
container.
* `docker exec d2c027ea0d37 curl http://localhost:20000` - checks whether the container is working
* `docker commit` saves the modified container as an new image
    * `4a6a528b35da` - the hash for the version of the container
    * `verse_gapminder` - the new name for the image
    * `-m` - commit message

            docker commit -m "verse + gapminder" 4a6a528b35da verse_gapminder

## Dockerfile

`Dockerfile` is a set of instructions on how to add things to a base image.
they build custom images up in a series of layers.

the available commands are:

* `FROM` - must always be the **first** thing in the `Dockerfile`
* `MAINTAINER` - image maintainer info
* `ARG` - define arguments, `ARG ODBCINI`
* `RUN` - execute shell commands to build up the image
* `WORKDIR` - set the working directory
* `COPY`- copy files inside the docker image
* `ADD` - add some files inside the docker image, similar to `COPY`, but can
  add remote files 
* `EXPOSE` - document where a service is available, but not create any mapping to the host
* `ENV` - define environment variable
* `CMD` - command when container launches, `CMD ["R", "-e", "shiny::runApp('/root/test')"]`
* `docker build -t shinyproxy/shiny_base_xz .` builds an image, and all the
resources needed are in the current path when using `.`.
    * `--build-arg` - pass parameter to `ARG` variable, --build-arg ODBCINI=odbc_prd.ini`

## references:

* [r_docker_tutorial](https://ropenscilabs.github.io/r-docker-tutorial/)
* [get started with docker](https://docs.docker.com/get-started/)
* [containarized-shinyproxy](https://stackoverflow.com/questions/52278328/containarized-shinyproxy-very-slow)
