source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.5.0-preview1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '8.1.0.beta1'

# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'bootstrap', '~> 5.3.5'
gem 'dartsass-rails'

# Turbo makes navigating your web application faster. Read more: https://turbo.hotwired.dev
gem "turbo-rails"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'will_paginate', '~> 4.0'

gem "sprockets-rails"


# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :windows]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'sqlite3'
end

gem 'dotenv-rails'

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'brakeman'
  gem 'bundler-audit'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
  gem 'shoulda-matchers'
  gem 'database_cleaner-active_record'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [ :windows, :jruby]

#for recaptcha
gem "recaptcha"

gem 'devise'

gem 'devise-bootstrap-views', '~> 1.0'

gem 'devise-two-factor'

gem 'rqrcode'

gem 'simple_form'

gem 'jsbundling-rails'
gem "image_processing", "~> 1.13"

gem "mcp", "~> 0.3.0"
