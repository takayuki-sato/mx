@mx.controller 'AppCtrl', ['$scope', '$location', '$timeout', 'Calculation', 'Cities', 'growl', 'Housings'
  ($scope, $location, $timeout, Calculation, Cities, growl, Housings) ->
    $scope.myCity = Cities.getMyCity()
    $scope.cities = Cities.getCities()
    $scope.myTown = ''
    $scope.ranking = {}
    $scope.myPreference = ''

    $scope.pickMyCity = (city) ->
      Cities.setMyCity(city)

    $scope.heatData = []

    $scope.$on 'mapInitialized'
    , (event, map) ->
      $scope.map = map
      $scope.heatMap = map.heatmapLayers.heat
      $scope.map.marker = [19.4326077, -99.13320799999997]

      $timeout ->
        $scope.move()
      , 500

    $scope.move = ->
      $scope.map.setCenter Cities.getMyCity().latLng
      # The opacity of the heatmap, expressed as a number between 0 and 1. Defaults to 0.6.
      $scope.heatMap.set 'opacity', 1

      $timeout ->
        $scope.map.setZoom Cities.getMyCity().zoom

      return true

    updateHeat = (id, names, label) ->
      #another_id = names.filter(word) -> word isnt id
      $scope.myPreference = id

      Calculation.query(id, Cities.getMyCity().name).then (data) ->
        #console.log data
        growl.info "Pick a marker in the map"
        $scope.myTown = ''

        if data? && data.length > 0
          $scope.heatData = []
          $scope.heatData.push new google.maps.LatLng(area.latitude, area.longitude) for area in data
          $scope.heatMap.setData $scope.heatData

          clearMarkers()
          $scope.markers = []
          i = 1
          for area in data
            marker = new google.maps.Marker({
              position: new google.maps.LatLng(area.latitude, area.longitude),
              map: $scope.map,
              animation: google.maps.Animation.DROP,
              title: data.formatted_address
            })
            marker.set "class", "mx-marker"

            content = "<div class='info'>"+
              "<h4>#{area.formatted_address.split(",",1)}</h4>" +
              "<img src='http://maps.googleapis.com/maps/api/streetview?size=200x200&location=#{area.latitude},%20#{area.longitude}&sensor=false&key=AIzaSyAryvACHmDs-nJMzl581vctZypgpHsukio' />"

            setInfoWindow marker, content, area, i, label
            $scope.markers.push marker

            prepareResource area, i, label if i == 1
            i++
        else
          clearMarkers()
          $scope.markers = []
          growl.error 'No recommendations found'

      return true

    $scope.setAffordability = (id, label) ->
      updateHeat id, ["value", "quality"], label
      return true

    $scope.setAge = (id, label) ->
      updateHeat id, ["young", "matured"], label
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

    clearMarkers = ->
      if $scope.markers? && $scope.markers.length > 0
        marker.setMap null for marker in $scope.markers

    setInfoWindow = (marker, content, area, i, label) ->
      google.maps.event.addListener marker, 'click', ->
        prepareInfoWindow marker, content
        prepareResource area, i, label
        #Housings.query area.formatted_address
        $scope.$apply()

    prepareInfoWindow = (marker, content) ->
      infowindow = new google.maps.InfoWindow {content: content}
      infowindow.open $scope.map, marker

    prepareResource = (area, i, label) ->
      $scope.myTown = area
      $scope.ranking = {rank: i, label: label}

    $scope.primaryCar = ->
      ($scope.myTown.auto > 100000)

    $scope.proposeInsurance = (id) ->
      switch id
        when 'car'
          ($scope.primaryCar())
        when 'family'
          ($scope.myPreference == 'matured')
        else
          (!$scope.primaryCar() && $scope.myPreference != 'matured')
]