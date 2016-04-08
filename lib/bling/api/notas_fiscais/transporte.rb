#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module NotasFiscais
      class Transporte < Bling::Api::Base

        attr_reader :transportadora, :tipo_frete, :servico_correios, :enderecoEntrega, :volumes
        
        def initialize(attributes)
          @transportadora = attributes["transportadora"]
          @tipo_frete = attributes["tipo_frete"]
          @servico_correios = attributes["servico_correios"]

          # Objects
          if attributes["enderecoEntrega"].is_a? Hash
            @enderecoEntrega = Bling::Api::NotasFiscais::Transportes::EnderecoEntrega.new(attributes["enderecoEntrega"])
          else
            @enderecoEntrega = nil
          end
          
          if attributes["volumes"].is_a? Array
            @volumes = []
            attributes["volumes"].each do |volume|
              @volumes << Bling::Api::NotasFiscais::Transportes::Volume.new(volume)
            end
          else
            @volumes = nil
          end
          
        end

      end
    end
  end
end