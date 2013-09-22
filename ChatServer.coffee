express = require 'express'
http = require 'http'
path = require 'path'

app = express()
app.use express.static path.join __dirname, 'public'

server = http.createServer app
server.listen 80, -> console.log "Browse to http://localhost to play"

usersMap = {}

io = require('socket.io').listen server
io.sockets.on 'connection', (client) ->
	client.on 'user', (who) ->
		usersMap[client.id] = {who, client}
		users = (v.who for p, v of usersMap)
		v.client.emit('user', users) for p, v of usersMap
	client.on 'msg', (msg) ->
		m = {who, msg} = {who: usersMap[client.id].who, msg}
		v.client.emit('msg', m) for p, v of usersMap
	client.on 'disconnect' , ->
		delete usersMap[client.id]
