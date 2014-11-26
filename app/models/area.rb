class Area < ActiveRecord::Base
  belongs_to :municipality
  has_one :calculation
  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      if obj.calculation
        obj.calculation.formatted_address = geo.formatted_address
        obj.calculation.latitude = geo.latitude
        obj.calculation.longitude = geo.longitude
        obj.calculation.northeast_lat = geo.geometry['viewport']['northeast']['lat']
        obj.calculation.northeast_lng = geo.geometry['viewport']['northeast']['lng']
        obj.calculation.southwest_lat = geo.geometry['viewport']['southwest']['lat']
        obj.calculation.southwest_lng = geo.geometry['viewport']['southwest']['lng']
      end
    end
  end
  def address
    [town, city, zipcode].compact.join(', ') + ', Mexico'
  end
  #after_validation :geocode

  scope :located, ->(name) { where(city: name) }
end
