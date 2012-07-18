#!/usr/bin/env coffee
fs = require 'fs'
http = require 'http'
path = require 'path'

server = http.createServer( (req,res) ->
  res.writeHead(200, { 'Content-Type': 'text/html' })
  res.end("<html><head></head><body>hello</body></html>")
)
server.listen(3002)

io = require('socket.io').listen(server)
io.sockets.on('connection',(socket) ->
  console.log('connection')
)

setWatch = (target) ->
  fs.watchFile(target, {interval: 500}, (curr, prev) ->
    console.log("watch => #{target}")
    io.sockets.emit('change',target)
  )

findfile = (target) ->
  fs.stat(target, (err, stats) ->
    if err
      throw err
    if stats.isDirectory()
      fs.readdir(target, (error, files) ->
        if files
          for name in files
            findfile(path.join(target, name))
      )
    if stats.isFile()
      console.log("target file is #{target}")
      setWatch(target)
  )
target = process.argv[2]
console.log("target base is #{target}")
findfile(target)
