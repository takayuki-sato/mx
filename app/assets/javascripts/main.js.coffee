@mx = angular.module('mx', [
  'ngRoute',
  'google-maps'.ns(),
  'ui.bootstrap',
  'ngResource',
  'templates',
  'ngMap',
  'angular-growl'
])

@mx.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.
    when('/app', {
      templateUrl: 'app.html',
      controller: 'AppCtrl'
    }).
    otherwise({
      templateUrl: 'home.html',
      controller: 'HomeCtrl'
    })
])