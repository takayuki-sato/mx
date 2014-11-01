@mx.service 'Geocoder', ['$rootScope', ($rootScope) ->
  @geocode = (name) ->
    geocoder = new google.maps.Geocoder
    geocoder.geocode
      address: name
    , (result, status) ->
      if status is google.maps.GeocoderStatus.OK
        console.log result
        console.log status
        $rootScope.map.center = {
          latitude: result[0].geometry.location.lat(),
          longitude: result[0].geometry.location.lng()
        }
      else
        # ToDo error message
        #$rootScope.map.center = {
        #  latitude: 19.20
        #  longitude: -99.10
        #}

  return
]