@mx.controller 'HomeCtrl', ['$scope', '$location', '$anchorScroll', ($scope, $location, $anchorScroll) ->
  $scope.cities = [
    {name: 'México, D.F.', latLng: new google.maps.LatLng(19.4326077, -99.13320799999997), zoom: 11},
    {name: 'Monterrey', latLng: new google.maps.LatLng(25.6866142, -100.3161126), zoom: 12},
    {name: 'Guadalajara', latLng: new google.maps.LatLng(20.6596988, -103.34960920000003), zoom: 12},
  ]
  $scope.myCity = $scope.cities[0]

  $scope.superslidesOptions =
    play: 3000
    inherit_height_from: '.summary-section'
    animation_speed: 'normal'
    pagination: false

  angular.element('#slides').superslides($scope.superslidesOptions);

  $scope.move = ->

  $scope.goToProblem = ->
    $location.hash('section2')
    $anchorScroll()
]