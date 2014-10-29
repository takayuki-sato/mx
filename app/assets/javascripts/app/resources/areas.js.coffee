@mx.factory 'AreasResources', ['$resource', ($resource) ->
  return $resource '/areas/:id'
]