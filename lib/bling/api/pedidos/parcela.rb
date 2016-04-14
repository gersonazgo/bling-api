#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module Pedidos
      class Parcela

        attr_accessor :valor, :dataVencimento, :obs, :dias
        
        def initialize(attributes={})
          attributes = attributes.deep_stringify_keys
          
          @valor = attributes["valor"]
          @dataVencimento = attributes["dataVencimento"]
          @obs = attributes["obs"]
          @dias = attributes["dias"]
        end

      end
    end
  end
end