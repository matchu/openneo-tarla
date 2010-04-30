Factory.define :vote do |v|
  v.sighting { Sighting.new }
  v.ip '127.0.0.1'
  v.is_positive true
end
