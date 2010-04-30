require 'test_helper'

class SightingTest < ActiveSupport::TestCase
  test "only url accessible" do
    s = Sighting.new :url => 'http://www.neopets.com/',
      :ip => '1.2.3.4', :votes_count => 1337
    assert_equal 'http://www.neopets.com/', s.url
    assert s.ip.nil?
    assert_equal 0, s.votes_count
  end
  
  test "require url" do
    s = Factory.build :sighting
    assert s.valid?, 'before'
    s.url = nil
    assert !s.valid?, 'after'
  end
  
  test "require ip" do
    s = Factory.build :sighting
    assert s.valid?, 'before'
    s.ip = nil
    assert !s.valid?, 'after'
  end
  
  test "only neopets URLs" do
    s = Factory.build :sighting, :url => 'http://www.neopets.com/lab.phtml'
    assert s.valid?, 'www.neopets.com lab valid'
    s.url = 'http://neopets.com/lab.phtml'
    assert s.valid?, 'neopets.com lab valid'
    assert_equal 'http://www.neopets.com/lab.phtml', s.url, 'www added'
    s.url = 'http://www.example.com/lab.phtml'
    assert !s.valid?, 'example.com lab invalid'
  end
end
