require 'test_helper'

class SightingTest < ActiveSupport::TestCase
  test "only url accessible" do
    s = Sighting.new :url => 'http://www.neopets.com/',
      :ip => '1.2.3.4', :score => 1337
    assert_equal 'http://www.neopets.com/', s.url
    assert s.ip.nil?
    assert_equal 0, s.score
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
  
  test "has many votes" do
    sighting = Factory.build :sighting
    5.times { sighting.votes << Factory.build(:vote) }
    assert_equal 5, sighting.votes.size
  end

  test "setting config hash" do
    new_config = {
      :allow_creation_by_ip_every => 5.minutes,
      :duds => {
        :ban => {
          :duration => 48.hours,
          :upon_streak => 2
        },
        :negative_vote_streak => 5
      }
    }
    with_sighting_config new_config do
      assert_equal 5.minutes, Sighting.config[:allow_creation_by_ip_every]
      assert_equal 48.hours, Sighting.config[:duds][:ban][:duration]
      assert_equal 2, Sighting.config[:duds][:ban][:upon_streak]
      assert_equal 5, Sighting.config[:duds][:negative_vote_streak]
    end
    assert_raise ArgumentError do
      Sighting.config = {
        :foo => :bar
      }
    end
  end

  test "can not submit sightings more than configured interval" do
    with_sighting_config :allow_creation_by_ip_every => 5.minutes do
      ips = ['127.0.0.1', '127.0.0.2']
      sighting = Factory.build :sighting, :ip => ips[0]
      assert sighting.save, 'initial sighting'
      sighting = Factory.build :sighting, :ip => ips[0]
      assert !sighting.valid?, 'same ip, same time'
      sighting = Factory.build :sighting, :ip => ips[1]
      assert sighting.valid?, 'different ip, same time'
      Timecop.freeze(4.minutes.from_now) do
        sighting = Factory.build :sighting, :ip => ips[0]
        assert !sighting.valid?, 'same ip, within interval'
      end
      Timecop.freeze(6.minutes.from_now) do
        sighting = Factory.build :sighting, :ip => ips[0]
        assert sighting.valid?, 'same ip, after interval'
      end
    end
  end

  private

  def with_sighting_config(config)
    old_config = Sighting.config.clone
    Sighting.config = config
    yield
    Sighting.config = old_config
  end
end
