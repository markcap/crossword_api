require 'raven'

Raven.configure do |config|
  config.ssl_verification = false
  config.environments = %w[ production, staging ]
end
