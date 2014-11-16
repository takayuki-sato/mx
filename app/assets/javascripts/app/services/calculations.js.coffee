@mx.service 'Calculation', ['$http', ($http) ->
  @query = (name) ->
    $http
    .get('/calculations/' + name + '.json')
    .then (response) ->
      response.data

  return
]