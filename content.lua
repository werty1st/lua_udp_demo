#!/usr/bin/env lua5.2
--
-- apt install lua5.2 lua-socket
-- test ab -n 10000 -c 100 https://sofa.zdf.de/lua

local socket = require("socket")
local udp = assert(socket.udp())
local data

udp:settimeout(0)
assert(udp:setsockname("*",0))
assert(udp:setpeername("127.0.0.1", 3004))
assert(udp:send("ping from " .. ngx.req.get_headers()["User-Agent"]))

data = udp:receive()

--[[
if data == nil then
  ngx.say("timeout")
else
  ngx.say(data)
  ngx.say("Host: ", ngx.req.get_headers()["User-Agent"])
end
]]--
