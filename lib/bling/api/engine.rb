#lib/bling/api/engine.rb
require 'faraday'
require 'json'
require 'rails'

module Bling
  module Api
    class Engine < ::Rails::Engine
      isolate_namespace Bling

      config.generators do |g|
        g.test_framework :rspec
      end
    end
  end
end