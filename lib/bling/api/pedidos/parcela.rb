#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module Pedidos
      class Parcela

        attr_reader :valor, :dataVencimento, :obs
        
        def initialize(attributes)
          @valor = attributes["valor"]
          @dataVencimento = attributes["dataVencimento"]
          @obs = attributes["obs"]
        end

      end
    end
  end
end