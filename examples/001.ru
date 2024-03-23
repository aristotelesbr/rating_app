# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rack'
end

require 'rack'

app =
  proc do |_env|
    [200, { 'content-type' => 'text/html' }, ['Hello, World!']]
  end

run app

# curl -i "http://localhost:9292"
