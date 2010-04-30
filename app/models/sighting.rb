require 'uri'

class Sighting < ActiveRecord::Base
  attr_accessible :url
  
  validates :url, :format => { :with => Regexp.new("^http://www.neopets.com/"), :message => 'needs to be from Neopets.com' }
  validates :ip, :presence => true
  
  before_validation do
    unless url.blank?
      self.url = "http://#{url}" unless self.url.starts_with?('http://')
      uri = URI.parse(url)
      uri.host = "www.#{uri.host}" unless uri.host.starts_with?('www.')
      self.url = uri.to_s
    end
  end
end
