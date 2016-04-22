#lib/bling/api/nota_fiscal.rb
require 'faraday'
require 'json'

module Bling
  module Api
    class Transporte

      attr_accessor :transportadora, :tipo_frete, :servico_correios, :enderecoEntrega, :peso_bruto, :volumes
      
      def initialize (attributes={})
        attributes = attributes.deep_stringify_keys
        
        @transportadora = attributes["transportadora"]
        @tipo_frete = attributes["tipo_frete"]
        @peso_bruto = attributes["peso_bruto"]
        @servico_correios = attributes["servico_correios"]

        # Objects
        if attributes["enderecoEntrega"].is_a? Hash
          @enderecoEntrega = Bling::Api::Transportes::EnderecoEntrega.new(attributes["enderecoEntrega"])
        else
          @enderecoEntrega = nil
        end
        
        if attributes["volumes"].is_a? Array
          @volumes = []
          attributes["volumes"].each do |volume|
            @volumes << Bling::Api::Transportes::Volume.new(volume)
          end
        else
          @volumes = nil
        end
        
      end

    end
  end
end