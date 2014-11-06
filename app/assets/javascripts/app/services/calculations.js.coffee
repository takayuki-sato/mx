@mx.service 'Calculation', ['$http', ($http) ->
  @value = ->
    $http
    .get('/calculations/value.json')
    .then (response) ->
      # add scope or rootscope
      console.log response.data

  @quality = ->
    $http
    .get('/calculations/quality.json')
    .then (response) ->
      # add scope or rootscope
      console.log response.data

  @quality = ->
    $http
    .get('/calculations/young.json')
    .then (response) ->
      # add scope or rootscope
      console.log response.data

  @quality = ->
    $http
    .get('/calculations/matured.json')
    .then (response) ->
      # add scope or rootscope
      console.log response.data

  return
]