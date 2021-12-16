# frozen_string_literal: true

require_relative 'app'
require_relative 'time_format'

ROUTES = {
  '/time' => App.new
}

run Rack::URLMap.new(ROUTES)
run App.new
