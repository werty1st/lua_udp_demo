FROM ficusio/openresty:latest

RUN apk update
RUN apk add lua-socket
RUN apk add lua-md5

#RUN ln -s /usr/share/lua/5.1/md5.lua /usr/local/lib/lua/5.1/md5.so

COPY content.lua /opt/openresty/lualib/content.lua
#COPY nginx.conf /opt/openresty/nginx/conf/nginx.conf

#build
#docker build -t luaudpsender2 .

# rebuild
#docker rmi -f luaudpsender2 && docker build -t luaudpsender2 .

# run debug
#docker run -it --rm --entrypoint=/bin/bash luaudpsender2

#run
#docker run -it --rm  -p 8282:80 -e RECEIVER_IP="172.29.40.8" -e RECEIVER_PORT=3004 luaudpsender2

#poc
#docker run -it --rm  -p 80 -e RECEIVER_IP="172.23.61.5" -e RECEIVER_PORT=3004 luaudpsender2