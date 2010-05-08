config = Sighting.config

if Rails.env.production?
  config[:allow_creation_by_ip_every] = 5.minutes
end
