source 'http://rubygems.org'

ruby '2.1.1'

gem 'rails', '4.0.3'

gem 'rails_admin'

group :development do
  gem 'pry'
  gem 'annotate'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'mocha', :require => false
  gem "database_cleaner"
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end



gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem "twitter-bootstrap-rails"

gem 'jquery-rails'
gem 'devise'
gem 'heroku'
gem 'haml'
gem 'omniauth'
gem 'omniauth-github'
gem 'newrelic_rpm'
gem "airbrake"
gem 'unicorn'
gem 'sentry-raven' #for sentry error logging
