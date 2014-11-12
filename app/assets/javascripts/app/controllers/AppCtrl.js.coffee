@mx.controller 'AppCtrl', ['$scope', '$location', 'Calculation', 'Cities',
  ($scope, $location, Calculation, Cities) ->
    $scope.myCity = Cities.getMyCity()
    $scope.cities = Cities.getCities()

    $scope.pickMyCity = ->
      Cities.setMyCity($scope.myCity)

    $scope.heatData = [
      new google.maps.LatLng(19.4326077, -99.13320799999997),
      new google.maps.LatLng(25.6866142, -100.3161126),
      new google.maps.LatLng(20.6596988, -103.34960920000003)
    ]

    $scope.getHeatData = ->
      $scope.heatData

    $scope.$on 'mapInitialized'
    , (event, map) ->
      $scope.map = map
      $scope.move()
      #$scope.heatMap = map.heatmapLayers.heat

    $scope.move = ->
      $scope.map.setCenter Cities.getMyCity().latLng
      $scope.map.setZoom Cities.getMyCity().zoom

    $scope.setAffordability = (id) ->
      switch id
        when "value"
          data = Calculation.value()
          another_id = "quality"
        when "quality"
          data = Calculation.quality()
          another_id = "value"

      console.log data
      $scope.heatData = data
      return true

    $scope.setAge = (id) ->
      switch id
        when "young"
          data = Calculation.young()
          another_id = "matured"
        when "matured"
          data = Calculation.matured()
          another_id = "young"

      console.log data
      return true

    $scope.path = $location.path()
]