@mx.controller 'AppCtrl', ['$scope', 'Transaction','AreasResources', ($scope, Transaction, AreasResources) ->
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

  $scope.areas = AreasResources.query ->
    console.log $scope.areas
]