@mx.controller 'AppCtrl', ['$rootScope', '$scope', 'Transaction', 'Calculation', 'AreasResources', 'Geocoder',
  ($rootScope, $scope, Transaction, Calculation, AreasResources, Geocoder) ->
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

    $scope.initial_data = ->
      return new google.maps.MVCArray([new google.maps.LatLng(19.4326077, -99.13320799999997)])

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