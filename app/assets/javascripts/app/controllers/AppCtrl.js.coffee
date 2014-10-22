@mx.controller 'AppCtrl', ['$scope', 'Transaction', ($scope, Transaction) ->
  $scope.map = {
    center: {
      latitude: 45,
      longitude: -73
    },
    zoom: 8
  }

  $scope.cube = Transaction.get()

  $scope.move = ->
    $scope.map.center.latitude = 19;
    $scope.map.center.longitude = 99;

]