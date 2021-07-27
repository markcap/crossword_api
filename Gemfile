source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.5.0'
gem 'rails', '~> 5.2.1'
gem 'puma', '~> 3.11'
gem 'httparty'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'doorkeeper'
gem 'devise'
gem 'sentry-raven', '2.7.1'
gem 'dalli'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

gem 'mysql2', '0.5.3'
