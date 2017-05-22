FROM mzollneritsch/nginx_lua-alpine

RUN apk update
RUN apk add lua5.1-socket \
    lua5.1-md5 


COPY content.lua /nginx/content.lua
COPY nginx.conf /nginx/nginx.conf


#build
#docker build -t luaudpsender2 .

# rebuild
#docker rmi -f luaudpsender2 && docker build -t luaudpsender2 .

# run debug
#docker run -it --rm --entrypoint=/bin/bash luaudpsender2

# run
#docker run -it --rm -p 8282:80 -e RECEIVER_IP="172.29.40.8" -e RECEIVER_PORT=3004 luaudpsender2

# debug run
#docker run -it --rm -p 8282:80 -e DEBUG=true -e RECEIVER_IP="172.29.40.8" -e RECEIVER_PORT=3004 luaudpsender2

#poc
#docker run -it --rm  -p 80 -e RECEIVER_IP="172.23.61.5" -e RECEIVER_PORT=3009 luaudpsender2


# export image
#docker save luaudpsender2 | gzip -c > luaudpsender2.tar.gz

# import image
#gunzip -c luaudpsender2.tar.gz | docker load
