config = Sighting.config

if Rails.env.production?
  config[:allow_creation_by_ip_every] = 5.minutes
  config[:expires_after] = 15.minutes
end
