express = require 'express'
http = require 'http'
path = require 'path'

app = express()
app.use express.static path.join __dirname, 'public'

server = http.createServer app
server.listen 80, -> console.log "Browse to http://localhost to play"

usersMap = {}	#save the client connection .

io = require('socket.io').listen server
io.sockets.on 'connection', (client) ->	# tigger this event when user open your site 
	client.on 'user', (who) ->	# tigger this event when user join a group chat
		usersMap[client.id] = {who, client}
		users = (v.who for p, v of usersMap)
		v.client.emit('user', users) for p, v of usersMap	# push all users's name to all users inorder to update users list
	client.on 'msg', (msg) ->	# tigger this event when user send a message to other people .
		m = {who, msg} = {who: usersMap[client.id].who, msg}	
		v.client.emit('msg', m) for p, v of usersMap		# push message to all users
	client.on 'disconnect' , ->	# tigger this event when user left room
		delete usersMap[client.id]
