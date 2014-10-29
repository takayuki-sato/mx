class Area < ActiveRecord::Base
  belongs_to :municipality
  has_one :calculation
end
