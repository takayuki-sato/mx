@mx.controller 'AppCtrl', ['$rootScope', '$scope', 'Transaction', 'Calculation', 'AreasResources', 'Geocoder',
  ($rootScope, $scope, Transaction, Calculation, AreasResources, Geocoder) ->
    $scope.cities = [
      {name: 'México, D.F.', latLng: new google.maps.LatLng(19.4326077, -99.13320799999997), zoom: 11},
      {name: 'Monterrey', latLng: new google.maps.LatLng(25.6866142, -100.3161126), zoom: 12},
      {name: 'Guadalajara', latLng: new google.maps.LatLng(20.6596988, -103.34960920000003), zoom: 12},
    ]
    cityDict = _.indexBy($scope.cities, 'name');
    $scope.myCity = $scope.cities[0]

    $scope.$on 'mapInitialized'
    , (event, map) ->
      $scope.map = map
      $scope.move()

    $scope.cube = Transaction.get()

    $scope.areas = AreasResources.query ->
      console.log $scope.areas

    $scope.move = ->
      $scope.map.setCenter cityDict[$scope.myCity.name].latLng
      $scope.map.setZoom cityDict[$scope.myCity.name].zoom

      # Geocoder.geocode($scope.myCity.name + ', Mexico').then ->
      #   if latLng? and latLng.length > 0
      #    $scope.map.setCenter new google.maps.LatLng(latLng)
      # , ->
      #   console.log 'failed to move'

    $scope.setAffordability = (id) ->
      switch id
        when "value"
          Calculation.value()
          another_id = "quality"
        when "quality"
          Calculation.quality()
          another_id = "value"

      return true

    $scope.setAge = (id) ->
      switch id
        when "young"
          Calculation.young()
          another_id = "matured"
        when "matured"
          Calculation.matured()
          another_id = "young"

      return true

]