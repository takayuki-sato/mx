@mx.service 'Geocoder', ['$rootScope', ($rootScope) ->
  @geocode = (name) ->
    latLng = {}

    geocoder = new google.maps.Geocoder
    geocoder.geocode
      address: name
    , (result, status) ->
      if status is google.maps.GeocoderStatus.OK
        console.log result
        console.log status
        latLng = {
          lat: result[0].geometry.location.lat(),
          lng: result[0].geometry.location.lng()
        }
      else
        # ToDo error message
        console.log 'Failed to get geocoding'
        latLng = {
          lat: result[0].geometry.location.lat(),
          lng: result[0].geometry.location.lng()
        }
    return latLng

  return
]