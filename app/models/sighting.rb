require 'uri'

class Sighting < ActiveRecord::Base
  include ActionView::Helpers::DateHelper # for distance_of_time_in_words
  
  has_many :votes
  
  attr_accessible :url
  
  validates :url, :format => { :with => Regexp.new("^http://www.neopets.com/"), :message => 'needs to be from Neopets.com' }
  validates :ip, :presence => true
  
  before_validation do |sighting|
    unless sighting.url.blank?
      sighting.url = "http://#{url}" unless sighting.url.starts_with?('http://')
      uri = URI.parse(url)
      uri.host = "www.#{uri.host}" unless uri.host.starts_with?('www.')
      sighting.url = uri.to_s
    end
  end

  validate do |sighting|
    if sighting.new_record?
      a = Sighting.config[:allow_creation_by_ip_every]
      if a
        c = sighting.created_at || Time.now
        if Sighting.where('ip = ? AND created_at > ?', sighting.ip, c - a).count > 0
          time_in_words = distance_of_time_in_words(a)
          errors[:base] << "You can only submit one sighting every #{time_in_words}"
        end
      end
      if Sighting.config[:expires_after] && Sighting.recent.where('url = ?', sighting.url).count > 0
        errors[:url] << "has been submitted recently - but thanks!"
      end
    end
  end

  @config = {
    :allow_creation_by_ip_every => nil,
    :expires_after => nil,
    :duds => {
      :ban => {
        :duration => nil,
        :upon_streak => nil
      },
      :negative_vote_streak => nil
    }
  }

  def self.config
    @config
  end

  def self.config=(replacement)
    replacement.each do |key, value|
      raise ArgumentError, "#{key} not a valid config key" unless self.config.has_key?(key)
      self.config[key] = value
    end
  end
  
  def self.recent
    p @config
    e = @config[:expires_after]
    if e
      where('created_at >= ?', e.ago)
    else
      raise RuntimeError, "Can not find recent sightings unless config key expires_after exists"
    end
  end
end

# load and not require in case we're in development mode and reloading
load Rails.root.join('config', 'sightings.rb')
