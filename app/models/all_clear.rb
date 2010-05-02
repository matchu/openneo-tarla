class AllClear < ActiveRecord::Base
  attr_accessible :location
  
  validates :ip, :presence => true
  validates :location, :inclusion => {:in => Location.all}
end
