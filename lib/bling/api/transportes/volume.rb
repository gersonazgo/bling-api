#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module Transportes
      class Volume

        attr_accessor :idServico, :servico, :codigoRastreamento, :dataSaida, :prazoEntregaPrevisto, :valorFretePrevisto
        
        def initialize(attributes={})
          attributes = attributes.deep_stringify_keys
          
          @idServico = attributes["idServico"]
          @servico = attributes["servico"]
          @codigoRastreamento = attributes["codigoRastreamento"]
          @dataSaida = attributes["dataSaida"]
          @prazoEntregaPrevisto = attributes["prazoEntregaPrevisto"]
          @valorFretePrevisto = attributes["valorFretePrevisto"]
        end

      end
    end
  end
end