@mx.service 'Cities', ['$http', ($http) ->
  cities = [
    {name: 'México, D.F.', latLng: new google.maps.LatLng(19.4326077, -99.13320799999997), zoom: 11},
    {name: 'Monterrey', latLng: new google.maps.LatLng(25.6866142, -100.3161126), zoom: 12},
    {name: 'Guadalajara', latLng: new google.maps.LatLng(20.6596988, -103.34960920000003), zoom: 12},
  ]
  myCity = cities[0]

  getCities = ->
    cities

  cityDict = _.indexBy(cities, 'name');

  getCity = (name) ->
    cityDict[name]

  setMyCity = (obj) ->
    myCity = obj

  getMyCity = ->
    myCity

  return {
    getCities: getCities,
    getCity: getCity,
    setMyCity: setMyCity,
    getMyCity: getMyCity
  }
]