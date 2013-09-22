ChatCtrl = ($scope) ->
	client = io.connect 'http://127.0.0.1'
	client.emit 'user', "user#{(new Date()).getTime()}"
	client.on 'user', (users) ->
		$scope.users = users
		$scope.$apply()
	client.on 'msg', (msg) ->
		$scope.msgs.push msg
		$scope.$apply()
	$scope.msgs = []
	$scope.sendMsg = ->
		msg = $scope.msg
		if msg?.length > 0
			client.emit 'msg', msg
			$scope.msg = ''
	$scope.sendMsgWhenReturn = (e) -> $scope.sendMsg() if e.keyCode is 13
	$scope.changeName = -> client.emit 'user', $scope.me

angular.module('chat',['directive']).controller 'ChatCtrl',['$scope', ChatCtrl]
