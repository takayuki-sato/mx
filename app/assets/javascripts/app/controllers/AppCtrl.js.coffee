@mx.controller 'AppCtrl', ['$scope', 'Transaction', ($scope, Transaction) ->
  $scope.map = {
    center: {
      latitude: 45,
      longitude: -73
    },
    zoom: 8
  }

  $scope.foo = 'xxx'

  $scope.cube = Transaction.get()
]