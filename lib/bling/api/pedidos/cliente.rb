#lib/bling/api/nota_fiscal.rb
require 'byebug'
require 'faraday'
require 'json'

module Bling
  module Api
    module Pedidos
      class Cliente

        attr_reader :nome, :cnpj, :ie, :endereco, :numero, :complemento, :cidade, :bairro, :cep, :uf, :email     
           
        def initialize(attributes)
          @nome = attributes["nome"]
          @cnpj = attributes["cnpj"]
          @ie = attributes["ie"]
          @endereco = attributes["endereco"]
          @numero = attributes["numero"]
          @complemento = attributes["complemento"]
          @cidade = attributes["cidade"]
          @bairro = attributes["bairro"]
          @cep = attributes["cep"]
          @uf = attributes["uf"]
          @email = attributes["email"]
        end
      end
    end
  end
end