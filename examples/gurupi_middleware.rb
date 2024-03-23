# frozen_string_literal: true

class GurupiMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    headers['x-gurupi'] = 'Gurupi'

    [status, headers, body]
  end
end
