class Location
  # Locations will be loaded in as an unordered hash; sort the keys and pass
  # the values in that order to the OrderedHash
  
  AllByWorld = ActiveSupport::OrderedHash.new
  locations = YAML::load_file(Rails.root.join('config', 'locations.yml'))
  locations.keys.sort.each { |key| AllByWorld[key] = locations[key] }
  All = AllByWorld.values.flatten
  
  def self.all_by_world
    AllByWorld
  end
  
  def self.all
    All
  end
end
