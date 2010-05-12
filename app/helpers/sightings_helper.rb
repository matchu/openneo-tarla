module SightingsHelper
  def can_vote_on?(sighting)
    if sighting.ip == request.remote_ip
      false
    else
      for vote in sighting.votes
        return false if vote.ip == request.remote_ip
      end
      true
    end
  end
  
  def fresh_votes_for_sighting(sighting)
    votes = []
    votes << [:positive, "She's here", Vote.new(:is_positive => true)]
    votes << [:negative, "She's gone", Vote.new(:is_positive => false)]
    votes.each { |v| v.last.sighting = sighting }
  end
  
  def no_sightings_message(sightings, &block)
    options = {
      :id => 'no-sightings'
    }
    options[:class] = 'hidden' unless sightings.empty?
    content_tag :div, options, &block
  end
end
