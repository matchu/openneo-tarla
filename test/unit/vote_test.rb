require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "belongs to sighting" do
    sighting = Factory.build :sighting
    vote = Factory.build :vote, :sighting => sighting
    assert_equal sighting, vote.sighting
  end
  
  test "ip required" do
    v = Factory.build :vote
    assert v.valid?, 'before'
    v.ip = nil
    assert !v.valid?, 'after'
  end
  
  test "sighting required" do
    v = Factory.build :vote, :sighting_id => 1337
    assert !v.valid?, 'before'
    s = Factory.create :sighting
    v.sighting_id = s.id
    assert v.valid?, 'after'
  end
  
  test "only sighting_id, is_positive accessible" do
    v = Vote.new :sighting_id => 1337, :is_positive => false, :ip => '127.0.0.2'
    assert_equal 1337, v.sighting_id, 'sighting id'
    assert !v.is_positive?, 'is positive'
    assert v.ip.nil?, 'ip'
  end
  
  test "one vote per sighting per ip" do
    sightings = Array.new(2) { Factory.build :sighting }
    ips = ['127.0.0.2', '127.0.0.3']
    # each ip should be able to save a first vote for each sighting
    ips.each do |ip|
      sightings.each do |sighting|
        vote = Factory.build :vote, :sighting => sighting, :ip => ip
        assert vote.save, 'first save'
      end
    end
    # neither ip should be able to save a second vote for either sighting
    ips.each do |ip|
      sightings.each do |sighting|
        vote = Factory.build :vote, :sighting => sighting, :ip => ip
        assert !vote.save, 'second save'
      end
    end
  end
  
  test "sighting scoring" do
    sighting = Factory.create :sighting
    vote = Proc.new { |up, ip|
      Factory.create :vote, :is_positive => up, :ip => ip,
        :sighting => sighting
    }
    assert_equal 0, sighting.score
    vote.call false, '127.0.0.2'
    assert_equal -1, sighting.score
    vote.call true, '127.0.0.3'
    assert_equal 0, sighting.score
    vote.call true, '127.0.0.4'
    assert_equal 1, sighting.score
    vote.call true, '127.0.0.5'
    assert_equal 2, sighting.score
  end

  test "can not vote on own sightings" do
    sighting = Factory.create :sighting, :ip => '127.0.0.1'
    votes = Array.new(2) { |i|
      Factory.build :vote, :ip => "127.0.0.#{i+1}", :sighting => sighting
    }
    assert !votes[0].valid?, 'same ip'
    assert votes[1].valid?, 'different ip'
  end
end
