#!/usr/bin/env lua5.1

local md5 = require("md5")
local socket = require("socket")
local udp = assert(socket.udp())
local data

local target = os.getenv("RECEIVER_IP")
local port = os.getenv("RECEIVER_PORT")
local debug = os.getenv("DEBUG")

udp:settimeout(0)
assert(udp:setsockname("*",0))
assert(udp:setpeername(target, port))

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
Event = Event .. '"User-Agent": "' .. ngx.req.get_headers()["User-Agent"] .. '",'
Event = Event .. '"eventType": "' .. et .. '",'
Event = Event .. '"start": "' .. st .. '",'
Event = Event .. '"asset": "' .. at .. '",'
Event = Event .. '"user": "' .. ur .. '"'
Event = Event .. "}"

--send to remote
assert(udp:send( Event ))

if debug ~= nil then
  --send to localhost (debugging)
  assert(udp:setpeername("127.0.0.1", port))
  assert(udp:send( Event ))

  --responde with env settings
  ngx.say("target: " .. target)
  ngx.say("port: " .. port)
end


