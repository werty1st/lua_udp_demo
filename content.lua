#!/usr/bin/env lua5.2
--[[

  apt-get install lua5.2 lua-socket lua-md5 nginx-extras
  test ab -n 10000 -c 100 http://test.zdf.de/lua
  curl "http://test.zdf.de/lua?start=2017-04-12T11%3A57%3A55%2B02%3A00&asset=SCMS_98920390-08d1-42aa-a7d2-051f5d76c85f&user=22f5f987-4b49-454e-a45b-808d970f281c&eventType=view"

server {
	listen 443 ssl;

  ssl_certificate /etc/nginx/ssl/nginx.crt;
  ssl_certificate_key /etc/nginx/ssl/nginx.key;

	server_name test.zdf.de;

    location /lua {
      access_log /var/log/nginx/access_lua.log;
	    #rewrite_by_lua_file /etc/nginx/lua/rewrite.lua;
	    access_by_lua_file /etc/nginx/lua/content.lua;
	    #content_by_lua_file /etc/nginx/lua/content.lua;
      #resume normale operation

	}
}

]]--
local md5 = require("md5")
local socket = require("socket")
local udp = assert(socket.udp())
local data

udp:settimeout(0)
assert(udp:setsockname("*",0))
assert(udp:setpeername("127.0.0.1", 3004))

local hex_to_char = function(x)
  return string.char(tonumber(x, 16))
end

local unescape = function(url)
  return url:gsub("%%(%x%x)", hex_to_char)
end


ua = ngx.req.get_headers()["User-Agent"]
et = ngx.var.arg_eventType or "undefined"
st = ngx.var.arg_start or "undefined"
at = ngx.var.arg_asset or "undefined"
ur = ngx.var.arg_user or "undefined"

st = unescape(st)
ur = md5.sumhexa(ur)

Event = "{"
Event = Event .. 'User-Agent: "' .. ngx.req.get_headers()["User-Agent"] .. '",'
Event = Event .. 'eventType: "' .. et .. '",'
Event = Event .. 'start: "' .. st .. '",'
Event = Event .. 'asset: "' .. at .. '",'
Event = Event .. 'user: "' .. ur .. '"'
Event = Event .. '}'


assert(udp:send( Event ))



