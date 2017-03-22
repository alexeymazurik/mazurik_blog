source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'pg', '~> 0.18.4'
gem 'sidekiq'
gem 'redis-rails'

# Layout
gem 'slim-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

gem 'therubyracer'

# Scripts
gem 'jquery-rails'
gem 'turbolinks'
gem 'uglifier'
gem 'coffee-rails'

# Utilities
gem 'puma', '~>3.1.0'
gem 'web-console', group: :development
gem 'simple_form'
gem 'devise'
gem 'nokogiri'
gem 'select2-rails'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'ransack'
gem 'dotenv'

# Recommender system
gem 'recommendable'

group :development, :test do
  gem 'byebug'
  gem 'rubocop'
end

group :development do
  gem 'capistrano',                   require: false
  gem 'capistrano-rvm',               require: false
  gem 'capistrano-rails',             require: false
  gem 'capistrano-bundler',           require: false
  gem 'capistrano-rails-collection',  require: false
  gem 'capistrano3-puma',             require: false
  gem 'capistrano-sidekiq',           require: false
end

group :test do
  gem 'rspec'
end
