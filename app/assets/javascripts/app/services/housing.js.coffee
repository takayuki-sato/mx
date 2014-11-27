@mx.service 'Housings', ['$http', ($http) ->
  @query = (name) ->
    url = 'https://api.roomorama.com/v1.0/rooms.json?destination=' + encodeURI(name) + '&callback=http://vamosa.herokuapp.com/oauth2/callback' + '&access_code=kEERWoDdUzeI0hpLbgMYG9rQ6WtINedSlXwwboP14E'
    req = {
      method: 'GET',
      url: url
      headers: {
        'Access-Control-Allow-Origin': "*"
      }
    }
    config = { headers: {
        'Access-Control-Allow-Origin': "*",
        'Accept': 'application/json;odata=verbose',
        'X-Testing': "testing"
      }
    }

    $http.get(url, config).then (response) ->
      console.log response.data

  return
]