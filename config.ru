require './app'

use Rack::Static, root: 'public', urls: ['/css', '/js']

run App.new
