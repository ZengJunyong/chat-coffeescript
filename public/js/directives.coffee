# angular is not support ngBlur until 1.2.
angular.module('directive',[])
.directive('ngBlur',['$parse', ($parse) ->
	(scope, elm, attr) ->
		fn = $parse(attr.ngBlur)
		elm.bind 'blur', (event) ->
			scope.$apply -> fn scope, {$event: event}])
.directive('ngKeyup',['$parse', ($parse) ->
	(scope, elm, attr) ->
		fn = $parse(attr.ngKeyup)
		elm.bind 'keyup', (event) ->
			scope.$apply -> fn scope, {$event: event}])