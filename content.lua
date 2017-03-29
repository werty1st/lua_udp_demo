#!/usr/bin/env lua5.2
--
-- apt install lua5.2 lua-socket
--

local socket = require("socket")
local udp = assert(socket.udp())
local data

udp:settimeout(1)
assert(udp:setsockname("*",0))
assert(udp:setpeername("127.0.0.1", 3004))


assert(udp:send("ping"))
data = udp:receive()


if data == nil then
  ngx.say("timeout")
else
  ngx.say(data)
end
