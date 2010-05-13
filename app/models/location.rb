class Hash
  def sort_keys
    ordered_hash = ActiveSupport::OrderedHash.new
    # natural sorting from http://www.bofh.org.uk/2007/12/16/comprehensible-sorting-in-ruby, block 1
    keys.sort_by { |key| key.split(/(\d+)/).map { |v| v =~ /\d/ ? v.to_i : v } }.
      each { |key| ordered_hash[key] = self[key] }
    ordered_hash
  end
  
  def sort_child_keys!
    each { |key, value| self[key] = value.sort_keys }
  end
end

class Location
  # Locations will be loaded in as an unordered hash; sort the keys and pass
  # the values in that order to the OrderedHash
  
  locations = YAML::load_file(Rails.root.join('config', 'locations.yml'))
  AllByWorld = locations.sort_keys
  AllByWorld.sort_child_keys!
  All = AllByWorld.values.map { |hash| hash.values }.flatten
  
  def self.all_by_world
    AllByWorld
  end
  
  def self.all
    All
  end
end
