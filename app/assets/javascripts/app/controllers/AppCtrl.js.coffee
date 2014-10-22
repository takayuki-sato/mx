@mx.controller 'AppCtrl', ['$scope', 'Transaction', ($scope, Transaction) ->
  $scope.foo = 'xxx'

  $scope.cube = Transaction.get()
]