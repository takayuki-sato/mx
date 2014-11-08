@mx.controller 'AppCtrl', ['$scope', 'Calculation',
  ($scope, Calculation) ->
    $scope.cities = [
      {name: 'México, D.F.', latLng: new google.maps.LatLng(19.4326077, -99.13320799999997), zoom: 11},
      {name: 'Monterrey', latLng: new google.maps.LatLng(25.6866142, -100.3161126), zoom: 12},
      {name: 'Guadalajara', latLng: new google.maps.LatLng(20.6596988, -103.34960920000003), zoom: 12},
    ]
    cityDict = _.indexBy($scope.cities, 'name');
    $scope.myCity = $scope.cities[0]

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
      $scope.map.setCenter cityDict[$scope.myCity.name].latLng
      $scope.map.setZoom cityDict[$scope.myCity.name].zoom

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

]