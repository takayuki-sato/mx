@mx = angular.module('mx', [
  'ngRoute',
  'google-maps'.ns(),
  'ui.bootstrap',
  'ngResource'
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

@mx.config(['GoogleMapApiProvider'.ns(),(GoogleMapApi) ->
  GoogleMapApi.configure({
    key: 'AIzaSyAryvACHmDs-nJMzl581vctZypgpHsukio',
    v:   '3.17',
    libraries: 'weather,geometry,visualization'
  })
])