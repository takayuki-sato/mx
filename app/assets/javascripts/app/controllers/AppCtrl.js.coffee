@mx.controller 'AppCtrl', ['$rootScope', '$scope', 'Transaction','AreasResources', 'Geocoder',
  ($rootScope, $scope, Transaction, AreasResources, Geocoder) ->
    $rootScope.map = {
      center: {
        latitude: 19.4326077,
        longitude: -99.13320799999997
      },
      zoom: 11
    }

    $scope.cities = [
      {name: 'México, D.F.'},
      {name: 'Monterrey'},
      {name: 'Guadalajara'},
    ]
    $scope.myCity = $scope.cities[0]

    $scope.cube = Transaction.get()

    $scope.areas = AreasResources.query ->
      console.log $scope.areas

    $scope.move = ->
      latLng = Geocoder.geocode $scope.myCity.name + ', Mexico'
      if latLng? and latLng.length > 0
        $rootScope.map.center = latLng

    $scope.refresh = ->
      # ToDo move the Geocoder service to Directive
      $rootScope.map

]