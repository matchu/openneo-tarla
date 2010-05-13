config = Sighting.config

# Global configuration

config[:expires_after] = 15.minutes

# Production configuration

if Rails.env.production?
  config[:allow_creation_by_ip_every] = 5.minutes
end
