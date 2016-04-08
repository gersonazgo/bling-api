#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module NotasFiscais
      module Transportes
        class Volume < Bling::Api::Base

          attr_reader :idServico, :servico, :codigoRastreamento, :dataSaida, :prazoEntregaPrevisto, :valorFretePrevisto
          
          def initialize(attributes)
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
end