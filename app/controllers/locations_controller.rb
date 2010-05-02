class LocationsController < ApplicationController
  layout 'sightings'
  
  def index
    @locations_by_world = Location.all_by_world
  end
end
