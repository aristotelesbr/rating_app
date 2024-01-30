# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rack'
gem 'rackup'
gem 'sqlite3'

gem 'debug'

group :development, :test do
  gem 'rspec', '~> 3.12'
  gem 'rack-test'
end
