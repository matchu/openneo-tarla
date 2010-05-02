class AllClear < ActiveRecord::Base
  attr_accessible :url
  
  validates :ip, :presence => true
  validates :url, :inclusion => {:in => Location.all}
end
