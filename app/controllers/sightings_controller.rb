class SightingsController < ApplicationController
  def index
    @sightings = Sighting.includes(:votes).all
  end

  def new
    @sighting = Sighting.new
  end

  def create
    @sighting = Sighting.new(params[:sighting])
    @sighting.ip = request.remote_ip

    if @sighting.save
      redirect_to(sightings_path, :notice => 'Well spotted! Thanks for your help!')
    else
      render :action => "new"
    end
  end
end
