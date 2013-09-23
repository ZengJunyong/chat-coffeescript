ChatCtrl = ($scope) ->
	client = io.connect 'http://127.0.0.1'
	client.emit 'user', "user#{(new Date()).getTime()}"	# Give a random name when the first. 
	client.on 'user', (users) ->	# receive the users list and update on view
		$scope.users = users
		$scope.$apply()
	client.on 'msg', (msg) ->	# receive a message and update on view
		$scope.msgs.push msg
		$scope.$apply()
	$scope.msgs = []
	$scope.sendMsg = ->		# send message to other people
		msg = $scope.msg
		if msg?.length > 0
			client.emit 'msg', msg
			$scope.msg = ''
	$scope.sendMsgWhenReturn = (e) -> $scope.sendMsg() if e.keyCode is 13	# send message to other people when enter key is pressed
	$scope.changeName = -> client.emit 'user', $scope.me			# change name and send to other people

angular.module('chat',['directive']).controller 'ChatCtrl',['$scope', ChatCtrl]
