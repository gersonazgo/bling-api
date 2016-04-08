#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module NotasFiscais
      class CodigoRastreamento < Bling::Api::Base

        attr_reader :codigoRastreamento
        
        def initialize(attributes)
          @codigoRastreamento = attributes["codigoRastreamento"]
        end

      end
    end
  end
end