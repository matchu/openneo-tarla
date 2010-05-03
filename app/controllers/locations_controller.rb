class LocationsController < ApplicationController
  layout 'sightings'
  
  def index
    @locations_by_world = Location.all_by_world
    all_clears = AllClear.select('all_clears.url, all_clears.created_at').
      joins('LEFT JOIN all_clears ac2 ON (all_clears.url = ac2.url AND all_clears.created_at < ac2.created_at)').
      where('ac2.id IS NULL').all
    @all_clears_by_location = all_clears.inject({}) do |hash, all_clear|
      hash[all_clear.url] = all_clear
      hash
    end
    render :layout => false if request.xhr?
  end
end
