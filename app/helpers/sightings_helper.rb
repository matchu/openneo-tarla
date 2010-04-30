module SightingsHelper
  def current_user_has_voted_on?(sighting)
    for vote in sighting.votes
      return true if vote.ip == request.remote_ip
    end
    return false
  end
  
  def fresh_votes_for_sighting(sighting)
    votes = []
    votes << [:positive, "She's here", Vote.new(:is_positive => true)]
    votes << [:negative, "She's gone", Vote.new(:is_positive => false)]
    votes.each { |v| v.last.sighting = sighting }
  end
end
