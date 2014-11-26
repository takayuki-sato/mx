class Calculation < ActiveRecord::Base
  belongs_to :area

  ENGEL_VALUE = 0.5
  ENGEL_QUALITY = 0.9
  AGE_YOUNG = 0.3
  AGE_MATURED = 0.6
  LIMIT = 5
  scope :top, -> { limit(LIMIT) }
  scope :value, -> { where("engel < ?", ENGEL_VALUE).where("engel > 0").order('engel asc') }
  scope :quality, -> { where("engel > ?", ENGEL_QUALITY).order('engel desc') }
  scope :young, -> { where("young < ?", AGE_YOUNG).where("young > 0").order('young asc') }
  scope :matured, -> { where("young > ?", AGE_MATURED).order('young desc') }
end
