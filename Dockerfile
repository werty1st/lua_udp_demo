FROM ubuntu:14.04

RUN apt-get update -y && \
    apt-get install nginx-extras curl lua-socket lua-md5 -y

#RUN apk update \
#    apk add lua-socket lua5.1-md5

#RUN ln -s /usr/share/lua/5.1/md5.lua /usr/local/lib/lua/5.1/md5.so

COPY content.lua /etc/nginx/conf.d/content.lua
COPY nginx.conf /etc/nginx/nginx.conf


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

#build
#docker build -t luaudpsender .

# rebuild
#docker rmi -f luaudpsender && docker build -t luaudpsender .

# run debug
#docker run -it --rm --entrypoint=/bin/bash luaudpsender

#run
#docker run -it --rm  -p 8082:80 -e RECEIVER_IP="172.29.40.8" -e RECEIVER_PORT=3004 luaudpsender

#poc
#docker run -it --rm  -p 80 -e RECEIVER_IP="172.23.61.5" -e RECEIVER_PORT=3004 luaudpsender