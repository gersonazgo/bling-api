#lib/bling/api/nota_fiscal.rb
require 'faraday'
require 'json'

module Bling
  module Api
    class CodigoRastreamento

      attr_accessor :codigoRastreamento
      
      def initialize(attributes={})
        attributes = attributes.deep_stringify_keys
        @codigoRastreamento = attributes["codigoRastreamento"]
      end

    end
  end
end