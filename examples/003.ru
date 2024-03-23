# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'rack'
end

require 'rack'

class MyApp
  def call(env)
    request   = Rack::Request.new(env)
    @response = Rack::Response.new

    case [request.request_method, request.path]
    in ['GET', '/']
      @response.status = 200
      @response['content-type'] = 'text/plain'
      @response.write('Home page')

      response.finish
    in ['POST', '/books']
      @response.status = 201
      @response['content-type'] = 'text/plain'
      @response.write('The book was created')

      @response.finish
    else not_found
    end
  end

  def not_found
    @response.status = 404
    @response['content-type'] = 'text/plain'
    @response.write('Not Found')

    @response.finish
  end
end

run MyApp.new

# curl -i http://localhost:9292/
# curl -i -X POST http://localhost:9292/books
