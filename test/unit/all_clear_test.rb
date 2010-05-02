require 'test_helper'

class AllClearTest < ActiveSupport::TestCase
  test "ip required" do
    ac = Factory.build :all_clear
    assert ac.valid?, 'before'
    ac.ip = nil
    assert !ac.valid?, 'after'
  end
  
  test "url in locations list" do
    ac = Factory.build :all_clear
    assert ac.valid?, 'before'
    ac.url = 'http://www.neopets.com/faerieland/index.phtml'
    assert ac.valid?, 'after pass'
    ac.url = 'http://www.neopets.com/fakeworld/index.phtml'
    assert !ac.valid?, 'after fail'
  end
  
  test "only url accessible" do
    ac = AllClear.new :url => 'foo', :ip => 'bar'
    assert_equal 'foo', ac.url, 'url'
    assert ac.ip.nil?, 'ip'
  end
end
