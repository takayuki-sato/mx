class CalculationsController < ApplicationController

  def value
    query Calculation.value
  end

  def quality
    query Calculation.quality
  end

  def young
    query Calculation.young
  end

  def matured
    query Calculation.matured
  end

  private
    def query (condition)
      @calculations = condition.joins(:area).merge(Area.located(params[:city])).top
      render :json => @calculations
    end
end
