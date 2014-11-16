@mx.controller 'AppCtrl', ['$scope', '$location', '$timeout', 'Calculation', 'Cities',
  ($scope, $location, $timeout, Calculation, Cities) ->
    $scope.myCity = Cities.getMyCity()
    $scope.cities = Cities.getCities()

    $scope.pickMyCity = (city) ->
      Cities.setMyCity(city)

    $scope.heatData = []

    $scope.$on 'mapInitialized'
    , (event, map) ->
      $scope.map = map
      $scope.heatMap = map.heatmapLayers.heat

      $timeout ->
        $scope.move()
      , 500

    $scope.move = ->
      $scope.map.setCenter Cities.getMyCity().latLng
      $scope.map.setZoom Cities.getMyCity().zoom

    updateHeat = (id, names) ->
      console.log id
      #another_id = names.filter(word) -> word isnt id

      Calculation.query(id).then (data) ->
        $scope.heatData = []
        $scope.heatData.push new google.maps.LatLng(area.latitude, area.longitude) for area in data
        $scope.heatMap.setData $scope.heatData

      return true

    $scope.setAffordability = (id) ->
      updateHeat id, ["value", "quality"]
      return true

    $scope.setAge = (id) ->
      updateHeat id, ["young", "matured"]
      return true

    $scope.path = $location.path()

    $scope.zoomChanged = ->
      if $scope.map? && $scope.heatMap?
        zoom = $scope.map.getZoom()
        radius = null
        if zoom < 11
          radius = 10
        else if zoom >= 11 && zoom < 15
          radius = 10 + (zoom-10) * 6
        else if zoom >= 15 && zoom < 20
          radius = 40 + (zoom-15) * 12
        else
          radius = 120

        $scope.heatMap.set 'radius', radius
]