sudo docker images
sudo docker pull openanalytics/r-base
sudo docker build -t shinyproxy/shiny_base_xz .
sudo docker network create sp-example-net
sudo docker run -ti --rm r-base /usr/bin/bash
sudo docker rmi ef8caddd49cb
sudo docker run -lt --rm  --net sp-example-net -p 3838:3838 shinyproxy_test3
sudo docker ps -a -q
sudo docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
