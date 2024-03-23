# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rack'
end

require 'rack'

class MyApp
  def call(env)
    request = Rack::Request.new(env)

    case [request.request_method, request.path]
    in ['GET', '/']
      [200, { 'content-type' => 'text/plain' }, ['Home page']]
    in ['POST', '/books']
      [201, { 'content-type' => 'text/plain' }, ['The book was created']]
    else [404, { 'content-type' => 'text/html' }, ['Not Found']]
    end
  end
end

run MyApp.new

# curl -i -X POST http://localhost:9292/books
