#!/usr/bin/env coffee
fs = require 'fs'
http = require 'http'
path = require 'path'

html = '''
<!DOCTYPE html>
<html>
  <head>
    <title>kamina</title>
  </head>
  <body>
    <a href="/filecheck.user.js">userscript download</a>
  </body>
</html>
'''

server = http.createServer( (req,res) ->
  if req.url == '/filecheck.user.js'
    fs.readFile('client/filecheck.user.js', (error, content) ->
      res.writeHead(200, { 'Content-Type': 'text/javascript' })
      res.end(content, 'utf-8')
    )
  else
    res.writeHead(200, { 'Content-Type': 'text/html' })
    res.end(html)
)
server.listen(3002, 'localhost')

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
findfile(t) for t in target.split(",")
