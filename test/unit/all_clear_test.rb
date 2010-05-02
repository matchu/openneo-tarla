require 'test_helper'

class AllClearTest < ActiveSupport::TestCase
  test "ip required" do
    ac = Factory.build :all_clear
    assert ac.valid?, 'before'
    ac.ip = nil
    assert !ac.valid?, 'after'
  end
  
  test "location in locations list" do
    ac = Factory.build :all_clear
    assert ac.valid?, 'before'
    ac.location = 'http://www.neopets.com/faerieland/index.phtml'
    assert ac.valid?, 'after pass'
    ac.location = 'http://www.neopets.com/fakeworld/index.phtml'
    assert !ac.valid?, 'after fail'
  end
end
