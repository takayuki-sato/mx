class CalculationsController < ApplicationController
  ENGEL_VALUE = 0.5
  ENGEL_QUALITY = 0.9
  AGE_YOUNG = 0.3
  AGE_MATURED = 0.6

  def value
    @calculations = Calculation.where("engel < ?", ENGEL_VALUE).where("engel > 0")
    render :json => @calculations
  end

  def quality
    @calculations = Calculation.where("engel > ?", ENGEL_QUALITY)
    render :json => @calculations
  end

  def young
    @calculations = Calculation.where("engel < ?", AGE_YOUNG).where("engel > 0")
    render :json => @calculations
  end

  def matured
    @calculations = Calculation.where("engel > ?", AGE_MATURED)
    render :json => @calculations
  end
end
