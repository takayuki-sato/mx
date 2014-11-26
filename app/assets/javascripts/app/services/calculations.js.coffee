@mx.service 'Calculation', ['$http', ($http) ->
  @query = (name, city) ->
    $http
    .get('/calculations/' + name + '.json/?city=' + city)
    .then (response) ->
      response.data

  return
]