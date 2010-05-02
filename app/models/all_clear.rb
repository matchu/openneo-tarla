class AllClear < ActiveRecord::Base
  validates :ip, :presence => true
  validates :location, :inclusion => {:in => Location.all}
end
