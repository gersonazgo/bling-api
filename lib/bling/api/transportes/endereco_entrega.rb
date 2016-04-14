#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module Transportes
      class EnderecoEntrega

        attr_accessor :nome, :endereco, :numero, :complemento, :cidade, :bairro, :cep, :uf
        
        def initialize(attributes={})
          attributes = attributes.deep_stringify_keys
          
          @nome = attributes["nome"]
          @endereco = attributes["endereco"]
          @numero = attributes["numero"]
          @complemento = attributes["complemento"]
          @cidade = attributes["cidade"]
          @bairro = attributes["bairro"]
          @cep = attributes["cep"]
          @uf = attributes["uf"]
        end

      end
    end
  end
end