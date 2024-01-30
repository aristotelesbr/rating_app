# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rack'
gem 'rackup'
gem 'sqlite3'

group :development, :test do
  gem 'rack-test'
  gem 'rspec', '~> 3.12'
end

