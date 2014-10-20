@mx = angular.module('mx', [
  'ngRoute'
])

@mx.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/app', {
      templateUrl: '../templates/app.html',
      controller: 'AppCtrl'
    }).
    otherwise({
      templateUrl: '../templates/home.html',
      controller: 'HomeCtrl'
    })
])