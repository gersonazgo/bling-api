#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    class CodigoRastreamento

      attr_reader :codigoRastreamento
      
      def initialize(attributes)
        @codigoRastreamento = attributes["codigoRastreamento"]
      end

    end
  end
end