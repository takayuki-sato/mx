@mx.controller 'HomeCtrl', ['$rootScope', '$scope', '$location', '$anchorScroll', 'Cities',
  ($rootScope, $scope, $location, $anchorScroll, Cities) ->
    $scope.myCity = Cities.getMyCity()
    $scope.cities = Cities.getCities()

    $scope.superslidesOptions =
      play: 3000
      inherit_height_from: '.summary-section'
      animation_speed: 'normal'
      pagination: false

    angular.element('#slides').superslides($scope.superslidesOptions);

    $scope.pickMyCity = ->
      Cities.setMyCity($scope.myCity)

    $scope.start = ->
      $location.path('/app')
      $rootScope.$apply()

    $scope.goToProblem = ->
      $location.hash('section2')
      $anchorScroll()

    $scope.path = $location.path()
]