#!/bin/bash

sudo docker stop bd
sudo docker rm bd
sudo docker run --name bd -e MYSQL_ROOT_PASSWORD=teste -d mysql:8.0
sudo docker inspect bd | grep "IPAddress"
sudo docker exec -it bd bash

