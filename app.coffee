#!/usr/bin/env coffee
fs = require 'fs'
http = require 'http'

server = http.createServer( (req,res) ->
  res.writeHead(200, { 'Content-Type': 'text/html' })
  res.end("<html><head></head><body>hello</body></html>")
)
server.listen(3002)

io = require('socket.io').listen(server)
io.sockets.on('connection',(socket) ->
  console.log('connection')
)