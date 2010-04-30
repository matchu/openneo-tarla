class Vote < ActiveRecord::Base
  belongs_to :sighting
  
  validates :sighting, :presence => true
  validates :ip, :presence => true, :uniqueness => {:scope => :sighting_id}
  
  before_create do
    sighting.score += value
    sighting.save
  end
  
  private
  
  def value
    is_positive? ? 1 : -1
  end
end