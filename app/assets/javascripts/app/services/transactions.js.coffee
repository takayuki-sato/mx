@mx.service 'Transaction', ['$http', ($http) ->
  @get = ->
    $http
      .get('/transactions.json')
      .then (response) ->
        # add scope or rootscope
        console.log response.data

  return
]