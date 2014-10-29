class AreasController < ApplicationController
  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all
    render :json => @areas
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])
    render :json => @area
  end
end
