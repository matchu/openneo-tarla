class Vote < ActiveRecord::Base
  belongs_to :sighting
  
  attr_accessible :sighting_id, :is_positive
  
  validates :sighting, :presence => true
  validates :ip, :presence => true, :uniqueness => {:scope => :sighting_id}
  
  before_create do |vote|
    vote.sighting.score += value
    vote.sighting.save
  end

  validate do |vote|
    if sighting && vote.ip == vote.sighting.ip
      vote.errors[:base] << 'Users can not vote on their own sightings'
    end
  end
  
  private
  
  def value
    is_positive? ? 1 : -1
  end
end
